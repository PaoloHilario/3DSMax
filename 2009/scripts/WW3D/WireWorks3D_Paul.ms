--******************************************************************************************
--* WireWorks3D - Scenario Design, by Paul Nylander
--******************************************************************************************

--local LibraryFile="Library.ms"; --"C:\Scenario\WireWorks3D\3DS Max\Library.ms"; --"U:\WireWorks3D\3DS Max\Library.ms";
FileIn("Library.ms"); FileIn("Library.ms"); FileIn("Library.ms");

global WireWorks3D (

--******************************************************************************************
--* Parametric Linear Interpolation of Guide Contours
--******************************************************************************************

 --guide contours with precomputed parametrizations (and ?...)
 global uguides; global ulists;
 global vguides; global vlists;

 --(DefineGuides 2 6.0 (GetMesh $));
 global DefineGuides; fn DefineGuides idim dx mesh1=(
  local dims=#(1,2,3); deleteItem dims idim;
  local t1=BoundingBox1(mesh1[1]); local p1=t1[1], p2=t1[2]; local p=p2-p1;
  local idim1=dims[1]; local x=p[idim1]; local nx=int(round (x/dx) 1.0); --ensures equal spacing
  local idim2=dims[2]; local y=p[idim2]; local ny=int(round (y/dx) 1.0);
  uguides=firsts(StandardProcessing idim1 (MeshContours1 idim1 (x/nx) undefined mesh1)); --ent --must be joined and oriented (slow)
  vguides=firsts(StandardProcessing idim2 (MeshContours1 idim2 (y/ny) undefined mesh1)); --ent
  local ulists=#(), su=0.0; --faster than using MeanGirth
  local vlists=#(), sv=0.0;
  for plist in uguides do (local ulist=#(); su=0.0;
   for i=0 to plist.count-2 do (
    su+=(distance plist[i] plist[i+1]);
    (append ulist su);
   )
   (append ulists ulist);
  )
  for plist in vguides do (sv+=GetLength(plist);)
  su/=uguides.count;
  sv/=vguides.count;
  for ulist in ulists do (for u in ulist do u/=su;)
  for vlist in vlists do (for v in vlist do v/=sv;)
 )

 fn StraddleSpecial u u1 u2=(
  if(u==u1) then return true;
  if(u1>u2) then return (u>u1 or u<u2); else return (u1>u)!=(u2>u);
 )
 --interpolate a single guide contour
--fn InterpolateGuide u iguide=(local uguide=uguides[iguide]; local ulist=ulists[iguide];
 --Try to implement a hopper method here as well for faster convergence
 global InterpolateGuides; fn InterpolateGuides u v=( --needs uguides,vguides
--if(u<0.0 or u>1.0 or v<0.0 or v>1.0) then (message("Error: bad u,v values"); return();)
  local i1=1, i2=i1+1; local v1=vlist[i1], v2=vlist[i2];
  while(i2<=uguides.count and (v<v1 or v>v2)) do (i1+=1; i2+=1; v1=vlist[i1]; v2=vlist[i2];)
--if(i2>nguide) then (message("Program error: v not found."); return();) --this should never happen
  p1=(InterpolateGuide u i1); p2=(InterpolateGuide u i2);
  local w;
  if(v1==v2) then w=0.0; else w=(v-v1)/(v2-v1);
  if(w<0.0 or w>1.0) then (message("Program error: interpolation out of bounds: "+MaxFormat(w)); return();) --this should never happen
  return (AveW w p1 p2);
 )

 --could precalculate overall grid for faster CurvilinearDistance
 global CurvilinearDistance; fn CurvilinearDistance uv1 uv2=( --needs uguides,vguides
  local u1=uv1.x,v1=uv1.y; local u2=uv2.x,v2=uv2.y;
  local p1=(InterpolateGuides u1 v1), p2; local s=0.0; local n=10;
  for i=1 to n do (local w=float(i)/n;
   local u=(AveW w u1 u2), v=(AveW w v1 v2);
   p2=(InterpolateGuides u v); s+=(distance p1 p2); p1=p2;
  )
--if(approx u1 u2) then --faster version
  return s;
 )

 --finds average curvilinear girth for range p1 to p2
 global MeanGirth; fn MeanGirth idim nsample p1 p2=( --needs uguides,vguides
  local u1=p1.x,v1=p1.y; local u2=p2.x,v2=p2.y; local s=0.0;
  local ninterval=nsample-1; --number of subinterval slices to integrate, must be even for Simpson's Rule
  for i=0 to ninterval do (
   if(idim==1) then local v=(AveW (float(i)/ninterval) v1 v2);
   else local u=(AveW (float(i)/ninterval) u1 u2);
-- w=(if_ (i==0 or i==ninterval) 1 2) --Trapezoid Rule: http://en.wikipedia.org/wiki/Trapezium_rule
   w=(if_ (i==0 or i==ninterval) 1 (if_ ((mod i 2)==0) 2 4)) --Simpson's Rule: http://en.wikipedia.org/wiki/Simpson's_rule
   if(idim==1) then s+=w*(CurvilinearDistance [u1,v] [u2,v]);
   else s+=w*(CurvilinearDistance [u,v1] [u,v2]);
  )
  return s/(3*ninterval); --Trapezoid Rule: 2*ninterval, Simpson's Rule: 3*ninterval
 )
 global QLength; fn QLength plists=(local s=0.0; --quick length (for unjoined plist)
  for plist in plists do s+=GetLength(plist);
  return s;
 )
 global QMeanGirth; fn QMeanGirth idim nsample mesh1=(local s=0.0;
  local normal=[0.0,0.0,0.0]; normal[idim]=1.0;
  local t1=BoundingBox1(mesh1[1]); local p1=t1[1], p2=t1[2];
  local p=(ave p1 p2);
  for i=1 to nsample do (
   p[idim]=(AveW ((i-1.0)/(nsample-1)) (p1[idim]+1.0e-3) (p2[idim]-1.0e-3));
   s+=QLength(MeshContour1 p normal mesh1); --MeshContour2
  )
  return s/nsample;
 )

 --Parametric Quadrification, for Paolo
 --(CreateMesh true (quadrify 2 6.0 (GetMesh $)));
 global quadrify; fn quadrify idim dx mesh1=(local nodes=#(), elems=#();
  DefineGuides();
--local su=(MeanGirth 1 5 [0,0] [1,1]); --slow
--local sv=(MeanGirth 2 5 [0,0] [1,1]);
  local su=0.0; for plist in uguides do (su+=GetLength(plist);); su/=uguides.count; --fast MeanGirth
  local sv=0.0; for plist in vguides do (sv+=GetLength(plist);); sv/=vguides.count;
  local nu=int(round su/dx 1.0), du=1.0/nu;
  local nv=int(round sv/dx 1.0), dv=1.0/nv;
  for i=1 to imax do (local u=(i-1)*du; --calculate nodes
   for j=1 to jmax do (local v=(j-1)*dv;
    (append nodes (InterpolateGuides [u,v]));
   )
  )
  for i=1 to imax-1 do ( --assemble quad elements
   for j=1 to jmax-1 do (local i0=j+(i-1)*jmax; (append elems #(i0,i0+1,i0+jmax+1,i0+jmax));)
  )
  return #(nodes,elems);
 )

--******************************************************************************************
--* XYZ Files
--******************************************************************************************

 --ExportXYZ "C:/Scenario/WireWorks3D/Sample XYZ Files/Test2.xyz" #([0,0,0],[1,1,1])
 fn formatXYZ x=(rtos x 3;) --need 3 decimal places
 global ExportXYZ; fn ExportXYZ file plist=(local wf=(openFile file mode:"w");
--if(wf==undefined) then (message("Unable to open \""+file+"\" for output."); return false;)
  format " %%%%Radius\n" (cspc "#" 14) (cspc "X" 14) (cspc "Y" 14) (cspc "Z" 13) to:wf; --I want to use commas!
  local i=0;
  for p in plist do (local x=p.x; local y=p.y; local z=p.z;
   format " %%%%%%%0\n" (cspc i 13) (if_ (x<0) "" " ") (cspc (formatXYZ x) (if_ (x<0) 14 13)) (if_ (y<0) "" " ") (cspc (formatXYZ y) (if_ (y<0) 14 13)) (if_ (z<0) "" " ") (cspc (formatXYZ z) (if_ (z<0) 14 13)) to:wf;
   i=i+1;
  )
  flush(wf); --ensure all output to file is on disk, flushes memory buffers
  close(wf); return true; --notepad(file);
 )

 --plist=ImportXYZ("C:/Scenario/WireWorks3D/Sample XYZ Files/Golden Reference-xbar.xyz")
 global ImportXYZ; fn ImportXYZ file=(local plist=#();
  local rf=(openFile file mode:"r"); skipToNextLine(rf);
  while(not eof(rf)) do (local t1=(tokenize2 " " (readLine rf));
--this seems to produce early sign changes
   local x=execute(t1[2]); local y=execute(t1[3]); local z=execute(t1[4]); --must specify that these are local
   if(IsNumber(x) and IsNumber(y) and IsNumber(z)) then append plist [x,y,z];
  )
  close(rf); return plist;
 )

 global XYZFiles; fn XYZFiles folder=(local files=(FindFiles "*.xyz" folder);
  local wf=(openFile (folder+"Files.txt") mode:"w");
  for file in files do (format "%\n" (FileName file) to:wf);
  flush(wf); close(wf);
 )

--******************************************************************************************
--* SmartEditor Position Data File (DT6) Files
--******************************************************************************************

 global DT6toXYZ; fn DT6toXYZ StepData=(local n1=StepData.count; local n2=0; local philist=#(); --use z-relative for philist
  local phi1=0.0; local phi2=0.0;
  for i1=0 to n1 do (local t1=StepData[i1]; local zaxis=find "Z" t1[2];
   if(zaxis) then phi2=t1[1]; else n2+=1;
   append philist (phi2-phi1); phi1=phi2;
  )
  local R=Rz(phi2); --final rotation matrix (determines orientation)
  local p=[0.0,0.0,0.0]; --final coordinate
  local plist=#(); plist[n2]=p; local i2=n2-1;
  for i1=n1 to 0 by -1 do (t1=StepData[i1]; local phi=philist[i1]; --must work backwards
   local ds=t1[0]+(if_ (i1==0) -5.51 0); --+(if_ (i1>0 and i1<(n1-1)) 0 (if_ (i1==0) -5.51 5.51))
   local theta=t1[1]; zaxis=find "Z" t1[2];
   if(zaxis) then (
    if(not(approx phi 0.0)) then R=(mult R Rz(-phi));
   )
   else (
    if(not(approx theta 0.0)) then R=(mult R Ry(-theta));
    p+=(mult R [0.0,0.0,-ds]); plist[i2]=p; i2-=1;
   )
  )
  plist
 )
--global DT6toXYZForward; fn DT6toXYZForward
 fn NextStep R0 p0 ds theta dphi=(zaxis=(dphi!=0.0);
  R=R0*Ry(theta);
  if(zaxis) then R=R*Rz(dphi);
  #(R,p0+(mult R [0.0,0.0,ds]) ds theta dphi)
 )
 fn QApprox p pref=(approx maximum(abs2(p-pref)) 0.0);
 global XYZtoDT6; fn XYZtoDT6 plist0=(
  local plist=(simplify 1e-6 plist0); local n=plist.count; --first must clean up plist (remove those nasty inline points), this may be redundant, but I can't stand to see this happen
  local ztol=1e-8; local dsmax=50.0; local plist2=#(); local failed=false; local suppress=false;
  local p=[0.0,0.0,0.0]; append plist2 p;
  local R=Rz(0.0) --identity matrix --Matrix3[1,0,0][0,1,0][0,0,1][0,0,0]
  local StepData=#(); local used=#(); local zaxis0=false; local sign1=1; local phi=0.0;
  if(n>=0) then local p1=plist[0];
  if(n>=1) then local p2=plist[1];
  if(n>=2) then local p3=plist[2];
  local n2=(PlaneNormal p1 p2 p3);
  local Rref=(Ralign p1 p2 p3 [0.0,0.0,0.0] [0.0,0.0,1.0] [1.0,0.0,1.0]); --reference rotational matrix
  local pref0=plist[0]; local plistref=#();
  for i=0 to n-1 do append plistref (mult Rref (plist[i]-pref0));
  local ds1=(distance p1 p2); local dphi0=0.0; p+=(mult R [0.0,0.0,ds1]); append plist2 p;
  for i=2 to n-1 do (
   if(i<n) then local p4=plist[i+1];
-- inline=approx (DistanceToLine p2 p1 p3) 0.0;
-- If(not suppress and inline and not failed) then message("Encountered 3 points exactly inline at i = "+itoa(i)+"!"); --can't find normal if inline
   n3=PlaneNormal p2 p3 p4; --At p3, the table plane's normal needs to be n3
   zdist=(DistanceToPlane p4 p2 n2);
   zaxis=not(approx zdist 0.0 ztol); --(InPlane p1 p2 p3 p4) tests to see if p4 will be in same table plane as p2
   if(zaxis0) then sign2=sign1; else (t1=sign(dot n1 n2); sign2=sign1*(if_ (t1==0) 1 t1);)
-- if(zaxis) then dphi=-sign(zdist)*(angle2 n2 n3); else dphi=0.0;
   dphi=-sign(zdist)*(angle2 n2 n3);
   zaxis=not(approx sin2(dphi) 0.0); --tried using sin here
-- if(abs(FixAngle(phi+dphi))>pi/2) then (sign2=-sign2; dphi+=pi;) --n3=-n3; --prevents table from going upside-down
   theta=sign2*(pi-(angle3 p1 p2 p3)) ---inline Or IsEmpty(p1)
   pref=plistref[i] --technically this should be i+1 --compare reference (error checking)
   ds2=distance p2 p3;
-- if(not suppress and ds2>dsmax) then message("Maximum spacing exceeded.");

   found=failed; --failed should always be false
   if(true) then ( --default case (based on my formulas)
    t1=NextStep r p ds2 theta dphi;
    if(QApprox t1[1] pref) then found=true;
--  if(not found and not failed) then message("Standard formula didn't work at i = "+itoa(i));
   )
   if(not found) then (
    t1=NextStep r p ds2 -theta dphi;
    if(QApprox t1[1] pref) then found=true;
    if(not failed) then (
--   if(found) then message("Success! Flipped theta sign at i = "+itoa(i));
--   if(not found) then message("Flipped bending direction but still didn't work at i = "+itoa(i));
    )
   )
   if(not found) then (
    if(not suppress and not failed) then message("DT6 data deviates from XYZ data at i = "+itoa(i)); --Nothing works!
    t1=NextStep r p ds2 theta dphi; failed=true; --restore first guess
   )
-- Sandy's goal: the wire should always stay above the table
   if(t1[3]*t1[4]>sqr(5*degree)) then (--dphi0 --anti-collision code, don't bother unless solid angle theta*dphi>(5°)²
    found=false;
    --This should always match up. Why doesn't this match up?
    theta=-t1[3]; dphi=t1[4]-(if_ (t1[4]<0.0) -1 1)*pi; --danger: Redefining theta & dphi here. Won't be able to go back anymore after this!
    t1=NextStep r p ds2 theta dphi;
    if(QApprox t1[1] pref) then found=true;
    if(not found) then (
     t1=NextStep r p ds2 -theta dphi;
     if(QApprox t1[1] pref) then found=true;
    )
    if(not found) then (
     if(not suppress and not failed) then message("DT6 data deviates from XYZ data at i = "+itoa(i)); --Nothing works!
     t1=NextStep r p ds2 theta dphi; failed=true; --restore first guess
    )
   )

   R=t1[0]; p=t1[1]; plist2[i]=p;
-- ds2=t1[2]; --ds2 doesn't change here
   theta=t1[3]; dphi=t1[4]; sign2=sign(theta); --use these values
   phi+=dphi; --FixAngle phi+dphi
   flags=#();
   if(i==2) then append flags "P1";
   if(i==2 or sign2!=sign1) then (
    BendTool=if_ (sign2==1) "T1" "T4";
    if(not (find BendTool used)) then (append flags BendTool; append used BendTool;) --only need to display each BendTool once
   )
   append StepData #(ds1+(if_ (i==2) 5.51 0), theta, flags);
   if(zaxis) then append StepData #(0.0, phi, #("Z"));
   zaxis0=zaxis; ds1=ds2; sign1=sign2; dphi0=dphi; p1=p2; p2=p3; p3=p4; n1=n2; n2=n3;
  )
  if(not suppress and not (QApprox p plistref[n-1])) then message("Error in DT6 conversion."); --plist2[n-1]
  flags=#("T0","K");
  append StepData #(ds1,theta,flags);
--minimum bar spacing: 4"
--nmax = 480 --manual claims 1200
--if(not suppress and n+1>nmax) then message("Warning: StepData contains "+itoa(n+1)+" bends (maximum allowable is "+itoa(nmax)+").");
  StepData
 )
--global ImportDT6; fn ImportDT6
--fn DT6Format
--fn DT6write
--fn DT6comment
--global ExportDT6; fn ExportDT6
 --according to Ryan Trinidad, bends over 45° should have 5% bend rate and 25% feed rate
 fn smoothify x x1 x2=(
  case of(
   (x<x1): return 0.0;
   (x<x2): return (1.0-cos2(pi*(x-x1)/(x2-x1)))/2.0;
   default: return 1.0;
  )
 )
--w=(smoothify theta (degToRad 22.5) (degToRad 50.0));
--thetaspeed=(AveW w 1.0 0.05);
--feedrate=(AveW w 1.0 0.25);
--add 2" hooks at first point
--if(ds<1.0) then --feed length cannot be less than 1"
--adds 6.567" to the beginning and subtracts 6.567" from the end if the beginning has a straight segment of less than 6.567"

--******************************************************************************************
--* Excel Spreadsheet Inventory (could move this to WireWorks3D.ms)
--******************************************************************************************



--******************************************************************************************
--* WireWorks3D Functions
--******************************************************************************************

 --Define Constants:
 --m=100.0/2.54; wpanel=2*m;
 --Cubical Method: ds=wpanel/int(round (wpanel/6.0) 1.0);
 --Cylindrical Method: ds=6.0;
 --Trophy Rock: p0=[-54.0,0,0];
 --Tree Faces: p0=[0,0,0];

 --Step 1: Offset Mesh: (OffsetMesh2 -3.0 $);

 --Step 2: Slice mesh into elevations (simple routine)
 --(PreviewElevations wpanel 0.0 $);
 global PreviewElevations; fn PreviewElevations dz z0 ent1=(timer2();
  local t1=BoundingBox2(ent1); local p1=t1[1], p2=t1[2];
  local z1=(rounddn (p1.z-z0) dz)+z0, z2=p2.z; local q1=p1, q2=p2;
  for z=z1 to z2 by dz do (q1.z=z; q2.z=z;
   local ent2=draw(#(q1,q2)); ent2.wirecolor=PlotColor((z-z1)/(z2-z1));
  )
 )

 --(SliceElevations wpanel 0.0 $);
 --t1=BoundingBox2($); z0=t1[1].z; --t1[1].z
 --(SliceElevations wpanel z0 $);
 global SliceElevations; fn SliceElevations dz z0 ent=(timer2();
  local ents=(MeshSlices 3 dz [0.0,0.0,z0] ent); local n=ents.count;
  for i=1 to n do (local ent=ents[i];
   if(IsDefined(ent)) then (
    ent.name=uniqueName(ent.name+(zero2 (2*(i-1)) 2)); --"Elevation" --int(round ((z0+i*dz)/m) 1.0)
    ent.wirecolor=PlotColor((i-1.0)/(n-1));
   )
  )
  print2("runtime: "+MaxFormat(timer2())+" s");
 )

 --Step 3, Cubical Method: Panelize, note that the elevations must be done separately in Step 1 (idim=3)
 --Trophy Rock: 1.2 minutes
 --Tree Faces: 9.7 seconds
 --Everest: t1=BoundingBox2($); z0=t1[1].z; p0=[0,0,z0];
 --(PanelizeCubical p0 wpanel $);
 --(max file saveas);
 global PanelizeCubical; fn PanelizeCubical p0 dx ent0=(timer2(); undo off(
  if(classOf(ent0)==Editable_Mesh) then (select(ent0); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent0)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  local ElevationName=ent0.name, hue0=findhue(ent0.wirecolor);
  ent0.EditablePoly.deleteIsoVerts();
  local t1=BoundingBox2(ent0); local p1=t1[1], p2=t1[2];
  if(IsDefined(p0)) then p1=(rounddn (p1-p0) dx)+p0; --(rounddnshift p0 dx p1)
  local nx=int(roundup ((p0.x-p1.x)/dx) 1.0)+int(roundup ((p2.x-p0.x)/dx) 1.0);
  local ny=int(roundup ((p0.y-p1.y)/dx) 1.0)+int(roundup ((p2.y-p0.y)/dx) 1.0);
  local ipanel=1, i=1;
  local ents1=(MeshSlices 1 dx p1 ent0); --2
  for ent1 in ents1 do (if(IsDefined(ent1)) then (
   local ents2=(MeshSlices 2 dx p1 ent1); local j=1;
   for ent2 in ents2 do (
    if(IsDefined(ent2)) then ( --I'm guessing ent2=undefined when there was nothing in the slice
     local PanelName="Panel_"+(zero2 j 2)+"_"+(zero2 i 2); --(zero2 ipanel 2)
     print2(PanelName);
     ent2.name=ElevationName+"_"+PanelName;
     ent2.wirecolor=hue((j+i-2.0)/12+hue0); --hue(random 0.0 1.0); --hue(((j-1)*nx+i-1.0)/(nx*ny-1)+hue0); --PlotColor
     ipanel+=1;
    )
    j+=1;
   )
   i+=1;
  ))
--delete(ent0); --Runtime error: Attempt to access deleted scene object
  print2("runtime: "+MaxFormat(timer2())+" s");
 ))

 --Step 3, Cylindrical Method: Panelize
 --Trophy Rock: 41 s
 --Tree Faces: 2.71 minutes
 --(PanelizeCylindrical p0 wpanel $);
 global PanelizeCylindrical; fn PanelizeCylindrical p0 wpanel ElevationName ent1=(timer2(); undo off(
  local ElevationName=ent1.name, hue0=findhue(ent1.wirecolor);
  local mesh1=GetMesh(ent1);
  local npanel=int(round ((QMeanGirth 3 5 mesh1)/wpanel) 2.0); --1.0 --npanel must be even (for now)
  print2("Dividing mesh into "+itoa(npanel)+" panels.");
  local dtheta=2*pi/npanel;
  local ents=(CylindricalMeshSlices 3 p0 0.0 dtheta ent1);
  for ipanel=1 to npanel do (
   local PanelName="Panel_"+(zero2 ipanel 2);
   local ent2=ents[ipanel]; --ents.count
   ent2.name=ElevationName+"_"+PanelName;
   ent2.wirecolor=hue((ipanel-1.0)/(npanel-1.0)+hue0); --PlotColor
-- (WirizeCylindrical p0 ds "C:/Scenario/Models/Trophy Rock/XYZ Files/" ent2);
  )
  print2("runtime: "+MaxFormat(timer2())+" s");
 ))

 --Repairs Border Bars (only works for CreateBarsCubical)
 --Note: this is not the most accurate way to handle this.
 --m=100.0/2.54; wpanel=2*m; ds=wpanel/int(round (wpanel/6.0) 1.0);
 --(CreateBarsCubical true undefined (wpanel/4) 1.0e-3 $);
 global RepairBorder; fn RepairBorder dims dx panel1=(
  local p1,p2; local autox1,autox2; local panel2=#();
  for i=1 to dims.count do (
   local border1=contours1[1]; --need to dither autoborder1 into border1
   local border2=last(contours1); --need to dither autoborder2 into border2
   local contours1=deepcopy(panel1[i]);
   local idim1=dims[i]; --slice plane direction
-- local idim2=(if_ (idim1==3) 1 3); --contour direction (not used)
   local x1=infinity, x2=-infinity; --find x1 & x2
   for contours in panel1 do (for contour in contours do (
    for plist in contour do (p1=plist[1]; p2=last(plist);
     x1=(min2 x1 p1[idim1]); x2=(max2 x2 p2[idim1]);
    )
   ))
   local autoborder1=#(), autoborder2=#(); --find autoborders

   local contours2=panel1[1]; local scoremax=-1; local t1=true; --find best choice for contours2
   for j=1 to dims.count do (if(j!=i) then (local score1=0, score2=0;
    for contour in panel1[j] do (for plist in contour do (
     if(approx2 plist[1][idim1] x1 1.0) then score1+=1;
     if(approx2 (last plist)[idim1] x1 1.0) then score2+=1;
    ))
    if(score1>scoremax) then (scoremax=score1; t1=true; contours2=panel1[j];)
    if(score2>scoremax) then (scoremax=score2; t1=false; contours2=panel1[j];)
   ))
   for contour in contours2 do (for plist in contour do (
    p1=(if_ t1 plist[1] (last plist));
    if(IsDefined(p1) and (approx2 p1[idim1] x1 1.0)) then (append autoborder1 p1);
   ))

   local contours2=panel1[1]; local scoremax=-1; local t2=true; --find best choice for contours2
   for j=1 to dims.count do (if(j!=i) then (local score1=0, score2=0;
    for contour in panel1[j] do (for plist in contour do (
     if(approx2 plist[1][idim1] x2 1.0) then score1+=1;
     if(approx2 (last plist)[idim1] x2 1.0) then score2+=1;
    ))
    if(score1>scoremax) then (scoremax=score1; t2=true; contours2=panel1[j];)
    if(score2>scoremax) then (scoremax=score2; t2=false; contours2=panel1[j];)
   ))
   for contour in contours2 do (for plist in contour do (
    p2=(if_ t2 plist[1] (last plist));
    if(IsDefined(p2) and (approx2 p2[idim1] x2 1.0)) then (append autoborder2 p2);
   ))

   for gg in #(true,false) do (local x=(if_ gg x1 x2), x0; --determine which autoborders to use
    local border=(if_ gg border1 border2), autoborder=(if_ gg autoborder1 autoborder2);
    if(border.count<1 or border[1].count<1) then x0=undefined; else x0=border[1][1][idim1]; --just uses the first point (good enough)
    if(IsDefined(x0)) then (
     if(abs(x0-x)<0.5*dx) then contours1[(if_ gg 1 contours1.count)]=#(autoborder); else (
      if(gg) then (prepend contours1 #(autoborder)); else (append contours1 #(autoborder)); --is it safe to do this?
     )
    )
   )
   (append panel2 contours1);
  )
  return panel2;
 )

 --renamer:
 --(for ent in ToArray($) do ent.name=(StrReplace "Elevation22" "objeverest_outside" ent.name));

 --Intermediate Step: reattach unwanted panel slices (collapse)
 --select first panel
 --Command Panel > Modify > Edit Geometry > Attach
 --select second panel
 --(max modify mode);

 --Step 4, Cubical Method: Create Bars
 --Everest Panel 3A: 48.1 s
 --Trophy Rock: desktop: 7.15 minutes, laptop with Max7: 3.06 hrs.
 --Tree Faces: 52.7 s
 --Everest Strip: p0=[0,0,869.170166015625]; 35.8 s
 --(for ent in ToArray($) do (CreateBarsCubical true p0 ds 1.0e-3 ent));
 --(for ent in ToArray($) do (if(classof(ent)==Editable_Poly) then delete(ent)));
 global CreateBarsCubical; fn CreateBarsCubical ThreeDim p0 ds tolerance ent1=(timer2(); undo off(
  local ents=#(); local t1,t2;
  if(classOf(ent1)==Editable_Mesh) then (select(ent1); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent1)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  ent1.EditablePoly.deleteIsoVerts();
  local nodes=GetNodes2(ent1); --eliminate this to avoid crashing for large panel meshes
  local PanelName=ent1.name;
  if(nodes.count==0) then (print2("Warning: empty mesh encountered: "+PanelName); return();)
  local t1=BoundingBox2(ent1); local p1=t1[1], p2=t1[2];
  if(IsDefined(p0)) then p1=(rounddn (p1-p0) ds)+p0; --(rounddnshift p0 ds p1)
  local c=ent1.wirecolor; --rgb2[1.0,1.0,1.0];
  local dims=#(1,2,3);
  if(not(ThreeDim)) then (deleteItem dims (FlattestDim nodes)); --find which 2 dimensions have the greatest box dimensions
  local panel=#();
  for idim in dims do (
   local contours=(StandardProcessing idim (MeshContours2 idim ds tolerance p0 ent1)); --(MeshContours1 idim ds p0 mesh1)
   (append panel contours);
  )
--panel=(RepairBorder dims ds panel);
  for i=1 to dims.count do (
   local contours=(StandardProcessing idim panel[i]); local idim=dims[i];
   for icontour=1 to contours.count do (
    local WireName=#("ybar","zbar","xbar")[idim]+(zero2 icontour 2); print2(WireName);
    local plists=contours[icontour];
    if(not(IsDefined(plists))) then print2("Warning: missing contour."); else (
     local jmax=plists.count;
     for j=1 to jmax do (
      local plist=planarize1(plists[j]); --don't planarize the boundaries unless the variation is relatively small!
--    (ExportXYZ (folder+PanelName+"/"+WireName+".xyz") plist);
      local ent2=draw(plist);
--    max views redraw; --does this work?
      ent2.wirecolor=c; --PlotColor((icontour-1.0)/(n-1.0));
      ent2.name=PanelName+"_"+WireName+(if_ (jmax>1) (alphabet j) "");
      (append ents ent2);
     )
    )
   )
  )
  (group ents name:(uniqueName PanelName));
--if(IsDefined(folder)) then navigate(folder);
  print2("runtime: "+MaxFormat(timer2())+" s");
  return(ents);
 ))

 --Step 4, Cylindrical Method: Create Bars
 --Trophy Rock: laptop: 19.25 minutes, desktop: 15.83 minutes
 --Tree Faces: 43.9 minutes
 --(for ent in ToArray($) do (CreateBarsCylindrical p0 ds ent));
 --(for ent in ToArray($) do (if(classof(ent)!=SplineShape) then delete(ent)));
 global CreateBarsCylindrical; fn CreateBarsCylindrical p0 ds ent1=(timer2(); undo off(
  local ents=#(); local t1,t2;
  if(classOf(ent1)==Editable_Mesh) then (select(ent1); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent1)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  ent1.EditablePoly.deleteIsoVerts();
  local mesh1=GetMesh(ent1); local PanelName=ent1.name;
  t1=(ThetaRange 3 p0 mesh1[1]); local theta1=t1[1], theta2=t1[2];
  if(theta1>theta2) then theta1+=2*pi;
  local c=ent1.wirecolor; --rgb2[1.0,1.0,1.0];

  --X-Bars (actually theta-bars)
  local contours=(StandardProcessing 3 (MeshContours2 3 ds 1.0e-3 p0 ent1)); --WRONG!!! needs to go in theta direction --(MeshContours1 3 ds p0 mesh1)
  for i=1 to contours.count do (
   local WireName="xbar"+(zero2 i 2); print2(WireName);
   local plists=contours[i];
   if(not(IsDefined(plists))) then print2("Warning: missing contour."); else (
    local jmax=plists.count;
    for j=1 to jmax do (local plist=plists[j];
     local ent2=draw(plist);
     ent2.wirecolor=c;
     ent2.name=PanelName+"_"+WireName+(if_ (jmax>1) (alphabet j) "");
     (append ents ent2);
    )
   )
  )

  --Y-Bars
  local ntheta=int(round ((QMeanGirth 3 5 mesh1)/ds) 1.0);
  local dtheta=(theta2-theta1)/(ntheta-1);
  local contours=(StandardProcessing 1 (CylindricalMeshContours 3 p0 theta1 theta2 dtheta ent1));
  for i=1 to ntheta do (
   local WireName="ybar"+(zero2 i 2); print2(WireName);
   local plists=contours[i];
   if(not(IsDefined(plists))) then print2("Warning: missing contour."); else (
    local jmax=plists.count;
    for j=1 to jmax do (local plist=plists[j];
     local ent2=draw(plist);
     ent2.wirecolor=c;
     ent2.name=PanelName+"_"+WireName+(if_ (jmax>1) (alphabet j) "");
     (append ents ent2);
    )
   )
  )

  (group ents name:(uniqueName PanelName));
  print2("runtime: "+MaxFormat(timer2())+" s");
  return(ents);
 ))

 --Combined Steps 3 & 4: Cubical Method
 --WholeShabangCubical();
 global WholeShabangCubical; fn WholeShabangCubical=(
  local m=100.0/2.54; local wpanel=2*m; local ds=wpanel/int(round (wpanel/6.0) 1.0); local p0=[0,0,0];
  (SliceElevations wpanel 0.0 (ToArray objects)[1]);
  for ent in ToArray(objects) do (
   local z=int(round ((BoundingBox2 ent)[1].z/m) 2.0);
   (PanelizeCubical p0 wpanel ("Elevation"+(zero2 z 2)) ent);
  )
  for ent in ToArray(objects) do (
   (CreateBarsCubical true p0 ds 1.0e-3 ent);
   delete(ent);
  )
--(ExportBars folder (ToArray objects));
 )

 --Combined Steps 3 & 4: Cylindrical Method
 --WholeShabangCylindrical([0,0,0]);
 global WholeShabangCylindrical; fn WholeShabangCylindrical p0=(
  local m=100.0/2.54; local wpanel=2*m; local ds=6.0;
  for ent in ToArray(objects) do (
   local z=int(round ((BoundingBox2 ent)[1].z/m) 2.0);
   (PanelizeCylindrical p0 wpanel ("Elevation"+(zero2 z 2)) ent);
  )
  for ent in ToArray(objects) do (
   (CreateBarsCylindrical p0 ds ent);
   delete(ent);
  )
--(ExportBars folder (ToArray objects));
 )

 --Intermediate Step: Delete the unwanted bars

 --Step 5: Export Bars (Batch Job), ents must be prenamed
 --Trophy Rock: ? s
 --Tree Faces: 22.1 s
 --(ExportBars "C:/Scenario/Models/Everest/XYZ Files/" (ToArray $)); --getCurrentSelection()
 --(ExportBars "//SDI-FS1/Design/Users/Paul Nylander/Tree Faces/XYZ Files/" (ToArray $));
 global ExportBars; fn ExportBars folder1 ents=(timer2(); --ExportWires
  local ElevationName; local PanelName; local WireName; local folder2, folder3;
  CreateFolder(folder1);
  for ent in ents do (
   if(classOf(ent)==SplineShape) then (
    local t1=ent.name; local i=(PositionStr "_" t1); --"Elevation00_Panel_01_01_xbar01"
    if(not(IsDefined(i))) then (WireName=t1; folder3=folder1;) else (
     ElevationName=(substring t1 1 (i-1));
     folder2=folder1+ElevationName+"/"; CreateFolder(folder2);
     t1=(substring t1 (i+1) -1); i=(RPositionStr "_" t1);
     if(not(IsDefined(i))) then (WireName=t1; folder3=folder2;) else (
      PanelName=(substring t1 1 (i-1)); WireName=(substring t1 (i+1) -1);
      folder3=folder2+PanelName+"/"; CreateFolder(folder3);
     )
    )
    local file=folder3+WireName+".xyz";
    print2("Exporting bar "+file);
    local plists=GetPlists(ent); --(StandardProcessing undefined #(GetPlists ent))[1];
    if(plists.count>1) then (
     message("Warning: Contour contains more than one piece. Only the first piece will be exported.");
    )
    (ExportXYZ file plists[1]);
   )
  )
  XYZFiles(folder1); --create all Files.txt files for SolidWorks
  for folder2 in getDirectories(folder1+"*") do (
   XYZFiles(folder2); --what if there are no XYZ Files in folder2?
   for folder3 in getDirectories(folder2+"*") do XYZFiles(folder3);
  )
  print2("runtime: "+MaxFormat(timer2())+" s");
 )

--******************************************************************************************
--* Graphical User Interface (GUI)
--******************************************************************************************

--progressBar

 global home=FindFile("C:/TEI/Master/Library.lsp");

 --Variables (could try to use the Registry for this)
 global iniFile="$UI/Macroscripts/WW3D.ini"; --"C:/Program Files/3dsmax7/UI/Macroscripts/WW3D.ini"
 global SetVar; fn SetVar key x=(SetINISetting iniFile "WireWorks" key (MaxFormat x));
 global GetVar; fn GetVar key=(
--local t1=(GetINISetting iniFile "WireWorks" key); --GetINISetting fails to return the quotes for strings!
  local rf=(openFile iniFile mode:"r"); local t1,found=false;
  if(IsDefined(rf)) then (
   skipToNextLine(rf);
   while(not(eof(rf)) and not(found)) do (
    t1=readLine(rf); local i=(PositionStr "=" t1);
    if(IsDefined(i) and (substring t1 1 (i-1))==key) then (t1=(substring t1 (i+1) -1); found=true;)
   )
   close(rf);
  )
  if(found) then return execute(t1); else (
   case key of (
    "FloaterX": return 0;
    "FloaterY": return 0;
    "FloaterW": return 350; --this is the standard size of the MainDialog
    "FloaterH": return 350;
    "offset": return -3.0; --Step 1.
    "dz": (local m=100.0/2.54; return 2*m;) --Step 2.
--  "cylindrical": return false; --Step 3.
    "wpanel": (local m=100.0/2.54; return 2*m;)
    "Origin": return [0.0,0.0,0.0];
    "threshhold": return 15000;
    "spacing": (local m=100.0/2.54, wpanel=2*m; return wpanel/int(round (wpanel/6.0) 1.0);) --Step 4.
    "ThreeDim": return true;
    "AutoJoin": return true;
    "JoinTolerance": return 1.0;
    "RemoveScraps": return true;
    "smin": return 6.0;
    "AutoTrim": return true;
    "Simplify1": return true;
    "SimplifyTolerance": return 0.125;
    "Simplify2": return true;
    "ds": return 1.0;
    "AutoRepair": return true;
    "BorderTolerance": return 0.001; --tolerance
--  "Name": return "Elevation"; --Step 5.
    "ExportXYZ": return true;
    "ExportDT6": return false;
    "ExportXLS": return false;
    "XYZFolder": return ((if_ home "C:/Scenario/" "U:/")+"WireWorks3D/Sample XYZ Files/");
    "DT6Folder": return ((if_ home "C:/Scenario/" "U:/")+"WireWorks3D/Sample DT6 Files/");
    "XLSFile": return ((if_ home "C:/Scenario/" "U:/")+"WireWorks3D/Inventory.xls");
    default: (message("Could not find default for "+key); return(undefined);) --print2
   )
  )
 )
 fn SaveDialogSettings dialog=(local p=GetDialogPos(dialog), size=getDialogSize(dialog);
  (SetVar "FloaterX" p.x); --xDialog
  (SetVar "FloaterY" p.y); --yDialog
  (SetVar "FloaterW" size.x);
  (SetVar "FloaterH" size.y);
  (SetVar "LastMenu" dialog.name);
 )
 fn DestroyDialogs=(
  for dialog in #(MainDialog,PanelDialog) do ( --TestDialog
   if(IsDefined(dialog)) then DestroyDialog(dialog); --not sure why sometimes dialog is undefined
  )
 )

 --Basic Parameters and Functions
 global DialogStyle=#(#style_titlebar, #style_sysmenu, #style_minimizebox, #style_maximizebox, #style_resizing);
 local xDialog, yDialog;
 RCMenu WireWorksMenu (
  menuItem t1 "Main";
  menuItem t2 "Create Panels";
  Submenu "Help" (
   menuItem t3 "User Manual (PDF File)";
   menuItem t4 "Help Notes (Text File)";
   menuItem t5 "About WireWorks3D";
  )
  on t1 picked do (DestroyDialogs();
   (CreateDialog MainDialog 350 350 xDialog yDialog menu:WireWorksMenu style:DialogStyle);
  )
  on t2 picked do (DestroyDialogs();
   (CreateDialog PanelDialog 656 603 xDialog yDialog menu:WireWorksMenu style:DialogStyle);
  )
  on t3 picked do (local folder;
   if(home) then folder="C:/Scenario/WireWorks3D/"; else folder="U:/WireWorks3D/";
   (ShellLaunch (folder+"Manual/Manual.pdf") ""); --(ShellLaunch "Acrobat" (folder+"Manual/Manual.pdf"));
-- LaunchInternet(folder+"Manual/Manual.html");
  )
  on t4 picked do (
   notepad((if_ home "C:/Scenario/WireWorks3D/3DS Max/" "U:/WireWorks3D/3DS Max/")+"Instructions.txt");
  )
  on t5 picked do (
   DestroyDialog(AboutDialog); --prevents duplicates
   (CreateDialog AboutDialog 350 350 0 0); --xDialog yDialog --style:?
  )
 )

 --WireWorks3D
 global WW; global WireWorks;
 fn WW=WireWorks(); --convenient shortcut
 fn WireWorks=(
  local t1=GetVar("LastMenu"), dialog0;
  if(IsDefined(t1)) then dialog0=execute(t1);
  if(not(IsDefined(dialog0)) or dialog0==0) then dialog0=MainDialog;
  xDialog=GetVar("FloaterX"); yDialog=GetVar("FloaterY");
  local xsize=GetVar("FloaterW"), ysize=GetVar("FloaterH");
  (CreateDialog dialog0 xsize ysize xDialog yDialog menu:WireWorksMenu style:DialogStyle)
 )

 --Main Menu
 global MainDialog; rollout MainDialog("WireWorks3D") (local folder;
  bitmap RMicon filename:((if_ home "C:/Scenario/WireWorks3D/3DS Max/" "$userscripts/WireWorks3D/")+"Splash.jpg") align:#center offset:[0,10]; --"$userscripts/WireWorks3D/Splash.jpg"
--on MainDialog open do ()
  on MainDialog moved position do (local p=GetDialogPos(MainDialog); xDialog=p.x; yDialog=p.y;)
  on MainDialog close do SaveDialogSettings(MainDialog);
 )

 --Create Panel Dialog
 local folder=(if_ home "C:/Scenario/WireWorks3D/3DS Max/" "U:/WireWorks3D/3DS Max/"); --(if_ home "C:/Files/3DS Max/MaxScript/Paolo Hilario/merge/UI Updater/" "$usericons/");
 local icon1=folder+"CGsoldier_16i.bmp", icon2=folder+"CGsoldier_16a.bmp";
 global PanelDialog; rollout PanelDialog("Create Panels") (

  --Reference Origin
  groupBox GetPointGroup "Reference Origin" pos:[8,8] width:272 height:92;
  label xLabel "X Reference" pos:[16,24] width:80 height:16;
  label yLabel "Y Reference" pos:[104,24] width:80 height:16;
  label zLabel "Z Reference" pos:[192,24] width:80 height:16;
  spinner xOrigin "" pos:[16,48] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner yOrigin "" pos:[104,48] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner zOrigin "" pos:[192,48] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  button GetPointButton "Get Reference Origin" pos:[16,72] width:256 height:20;
  on GetPointButton pressed do (local p=getPoint2();
   xOrigin.value=p.x; yOrigin.value=p.y; zOrigin.value=p.z;
  )

  --Step 1: Offset Mesh
  groupBox OffsetGroup "Step 1: Offset Mesh" pos:[8,102] width:272 height:68;
  label offsetLabel "Offset Distance (in):" pos:[16,118] width:168 height:16;
  spinner offset "" pos:[192,118] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  button OffsetButton "Offset Mesh" pos:[16,142] width:256 height:20;
  on OffsetButton pressed do (
   local ents=(FilterClass #(Editable_Poly, Editable_Mesh) (ToArray $));
   if(ents.count==0) then message("You must select at least one mesh object to offset."); else (
    for ent in ents do (OffsetMesh2 offset.value ent);
   )
  )

  --Step 2: Slice Mesh Into Elevations
  groupBox ElevationsGroup "Step 2: Slice Mesh Into Elevations" pos:[8,172] width:272 height:68;
  label dzLabel "Elevation Spacing (in):" pos:[16,188] width:168 height:16;
  spinner dz "" pos:[192,188] width:80 height:16 range:[0.0,infinity,0.0] type:#float scale:1;
  button ElevationsButton "Slice Elevations" pos:[16,212] width:256 height:20;
  on ElevationsButton pressed do (
   local ents=(FilterClass #(Editable_Poly, Editable_Mesh) (ToArray $));
   if(ents.count==0) then message("You must select at least one mesh object to slice."); else (
    for ent in ents do (SliceElevations dz.value zOrigin.value ent);
   )
  )

  --Step 3: Panelize
  groupBox PanelizeGroup "Step 3: Panelize" pos:[8,242] width:272 height:116;
  radioButtons cylindrical "" pos:[20,267] width:355 height:16 labels:#("Cubical", "Cylindrical") columns:2;
  label wpanelLabel "Panel Width (in):" pos:[16,282] width:168 height:16;
  spinner wpanel "" pos:[192,282] width:80 height:16 range:[0.0,infinity,0.0] type:#float scale:1;
  label threshholdLabel "Maximum Vertices for QuickSlice:" pos:[16,306] width:168 height:16;
  spinner threshhold "" pos:[192,306] width:80 height:16 range:[0,MaxLong-64,1] type:#integer scale:1;
  button PanelizeButton "Panelize" pos:[16,330] width:256 height:20;
  on PanelizeButton pressed do (
   local ents=(FilterClass #(Editable_Poly, Editable_Mesh) (ToArray $));
   if(ents.count==0) then message("You must select at least one mesh object to panelize."); else (
    for ent in ents do (PanelizeCubical [xOrigin.value,yOrigin.value,zOrigin.value] wpanel.value ent);
   )
  )

  --Step 4: Create Bars
  groupBox CreateBarsGroup "Step 4: Create Bars" pos:[8,360] width:272 height:235;
  label spacingLabel "Bar Spacing (in):" pos:[16,376] width:168 height:16;
  spinner spacing "" pos:[192,376] width:80 height:16 range:[0.0,infinity,0.0] type:#float scale:1;
  checkBox ThreeDim "Create Bars in all 3 Dimensions" pos:[16,400] width:168 height:16;
  checkBox AutoJoin "Max gap for joining polylines (in):" pos:[16,424] width:168 height:16;
  spinner JoinTolerance "" pos:[192,424] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  checkBox RemoveScraps "Remove Scraps Threshhold (in):" pos:[16,448] width:168 height:16;
  spinner smin "" pos:[192,448] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  checkBox AutoTrim "AutoTrim" pos:[16,472] width:168 height:16;
  checkBox Simplify1 "Max deviation for simplifying (in):" pos:[16,496] width:168 height:16;
  spinner SimplifyTolerance "" pos:[192,496] width:80 height:16 range:[0.0,infinity,0.0] type:#float scale:1;
  checkBox Simplify2 "Min bend spacing for simplifying (in):" pos:[16,520] width:168 height:16;
  spinner ds "" pos:[192,520] width:80 height:16 range:[0.0,infinity,0.0] type:#float scale:1;
  checkBox AutoRepair "AutoRepair borders tolerance (in)" pos:[16,543] width:168 height:16;
  spinner BorderTolerance "" pos:[192,544] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  button CreateBarsButton "Create Bars" pos:[16,567] width:256 height:20;
  on CreateBarsButton pressed do (
   local ents=(FilterClass #(Editable_Poly, Editable_Mesh) (ToArray $));
   if(ents.count==0) then message("You must select at least one mesh object to create bars."); else (
    local p0=[xOrigin.value,yOrigin.value,zOrigin.value];
    for ent in ents do (
     if(true) then ( --cylindrical.value
--need to incorporate these:
--(if_ AutoJoin JoinTolerance 0.0) --this is for SuperJoin
--(if_ RemoveScraps smin 0.0)
--AutoTrim
--(if_ Simplify1 SimplifyTolerance -1.0) --this is for regular Simplify
--(if_ Simplify2 ds 0.0) --this is for SuperSimplify
--(if_ AutoRepair BorderTolerance 0.0) --these inputs must be separated (I can get rid of BorderTolerance when I activate the exponential fitter)
      (CreateBarsCubical ThreeDim.checked p0 spacing.value BorderTolerance.value ent);
     )
     else (CreateBarsCylindrical p0 spacing.value ent);
    )
   )
  )

  --Step 5: Export Bars
  groupBox ExportBarsGroup "Step 5: Export Bars" pos:[288,8] width:360 height:188;
  editText XYZFolder "" pos:[296,48] width:318 height:16;
  checkBox ExportXYZ "Export XYZ Files" pos:[296,24] width:318 height:16;
  button BrowseXYZButton "" pos:[620,46] width:20 height:20 images:#(icon1, icon2, 11, 7, 7, 8, 8) tooltip:"Browse Folder";
  on ExportXYZ changed t1 do (local t2=ExportXYZ.checked;
   XYZFolder.enabled=t2; BrowseXYZButton.enabled=t2;
  )
  on BrowseXYZButton pressed do (
   local t1=(BrowseFolder "Select Folder to Export XYZ Files" XYZFolder.text);
   if(IsDefined(t1)) then XYZFolder.text=t1;
  )
  editText DT6Folder "" pos:[296,96] width:318 height:16;
  checkBox ExportDT6 "Export DT6 Files" pos:[296,72] width:318 height:16;
  button BrowseDT6Button "" pos:[620,94] width:20 height:20 images:#(icon1, icon2, 11, 7, 7, 8, 8) tooltip:"Browse Folder";
  on ExportDT6 changed t1 do (local t2=ExportDT6.checked;
   DT6Folder.enabled=t2; BrowseDT6Button.enabled=t2;
  )
  on BrowseDT6Button pressed do (
   local t1=(BrowseFolder "Select Folder to Export DT6 Files" DT6Folder.text);
   if(IsDefined(t1)) then DT6Folder.text=t1;
  )
  editText XLSFile "" pos:[296,144] width:318 height:16;
  checkBox ExportXLS "Export Excel Inventory" pos:[296,120] width:318 height:16;
  button BrowseXLSButton "" pos:[620,142] width:20 height:20 images:#(icon1, icon2, 11, 7, 7, 8, 8) tooltip:"Browse Folder";
  on ExportXLS changed t1 do (local t2=ExportXLS.checked;
   XLSFile.enabled=t2; BrowseXLSButton.enabled=t2;
  )
  on BrowseXLSButton pressed do (
   local t1=(browse "Enter Name of Excel Inventory to Export" XLSFile.text "Excel(*.xls)");
   if(IsDefined(t1)) then XLSFile.text=t1;
  )
  button ExportBarsButton "Export Bars" pos:[296,168] width:344 height:20;
  on ExportBarsButton pressed do (
   local ents=(FilterClass #(SplineShape) (ToArray $));
   if(ents.count==0) then message("You must select at least one spline shape to export."); else (
    (ExportBars XYZFolder.text ents);
--  if(ExportDT6.value) then (ExportBarsDT6 DT6Folder.text ents);
   )
  )

  --Slicer Utility
  groupBox SlicerGroup "Slicer Utility" pos:[288,198] width:360 height:140;
  button xButton "X" pos:[384,214] width:80 height:16;
--on xButton pressed do (***)
  button yButton "Y" pos:[472,214] width:80 height:16;
--on yButton pressed do (***)
  button zButton "Z" pos:[560,214] width:80 height:16;
--on zButton pressed do (***)
  button p1Button "Point 1:" pos:[296,238] width:80 height:16;
  on p1Button pressed do (local p=getPoint2();
   x1.value=p.x; y1.value=p.y; z1.value=p.z;
  )
  spinner x1 "" pos:[384,238] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner y1 "" pos:[472,238] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner z1 "" pos:[560,238] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  button p2Button "Point 2:" pos:[296,262] width:80 height:16;
  on p2Button pressed do (local p=getPoint2();
   x2.value=p.x; y2.value=p.y; z2.value=p.z;
  )
  spinner x2 "" pos:[384,262] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner y2 "" pos:[472,262] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner z2 "" pos:[560,262] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  button p3Button "Point 3:" pos:[296,286] width:80 height:16;
  on p3Button pressed do (local p=getPoint2();
   x3.value=p.x; y3.value=p.y; z3.value=p.z;
  )
  spinner x3 "" pos:[384,286] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner y3 "" pos:[472,286] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  spinner z3 "" pos:[560,286] width:80 height:16 range:[-infinity,infinity,0.0] type:#float scale:1;
  button SliceButton "Slice" pos:[296,310] width:344 height:20;
  on SliceButton pressed do (
   local ents=(FilterClass #(Editable_Poly, Editable_Mesh) (ToArray $));
   if(ents.count==0) then message("You must select at least one mesh object to slice."); else (
    local p1=[x1.value,y1.value,z1.value];
    local p2=[x2.value,y2.value,z2.value];
    local p3=[x3.value,y3.value,z3.value];
    local normal=normalize(PlaneNormal p1 p2 p3);
    for ent in ents do (SliceMesh p1 normal ent);
   )
  )

  --Exit & Cancel
  button ExitButton "Exit" pos:[340,348] width:80 height:20;
  on ExitButton pressed do (
   (SetVar "Origin" [xOrigin.value,yOrigin.value,zOrigin.value]);
   (SetVar "offset" offset.value);
   (SetVar "dz" dz.value);
   (SetVar "wpanel" wpanel.value);
   (SetVar "threshhold" threshhold.value);
   (SetVar "spacing" spacing.value);
   (SetVar "ThreeDim" ThreeDim.checked);
   (SetVar "AutoJoin" AutoJoin.checked);
   (SetVar "JoinTolerance" JoinTolerance.value);
   (SetVar "RemoveScraps" RemoveScraps.checked);
   (SetVar "smin" smin.value);
   (SetVar "AutoTrim" AutoTrim.checked);
   (SetVar "Simplify1" Simplify1.checked);
   (SetVar "SimplifyTolerance" SimplifyTolerance.value);
   (SetVar "Simplify2" Simplify2.checked);
   (SetVar "ds" ds.value);
   (SetVar "AutoRepair" AutoRepair.checked);
   (SetVar "BorderTolerance" BorderTolerance.value);
--  "Name": return "Elevation"; --Step 5.
   (SetVar "ExportXYZ" ExportXYZ.checked);
   (SetVar "XYZFolder" XYZFolder.text);
   (SetVar "ExportDT6" ExportDT6.checked);
   (SetVar "DT6Folder" DT6Folder.text);
   (SetVar "ExportXLS" ExportXLS.checked);
   (SetVar "XLSFile" XLSFile.text);
   DestroyDialogs(); --this will automatically call SaveDialogSettings
  )
  button CancelButton "Cancel" pos:[428,348] width:80 height:20;
  on CancelButton pressed do DestroyDialogs(); --this will automatically call SaveDialogSettings
  button HelpButton "Help" pos:[516,348] width:80 height:20;
  on HelpButton pressed do notepad((if_ home "C:/Scenario/WireWorks3D/3DS Max/" "U:/WireWorks3D/3DS Max/")+"Instructions.txt");

  --Initializations & Dialog Enablements
  on PanelDialog open do (local t1;
   local p=GetVar("Origin"); xOrigin.value=p.x; yOrigin.value=p.y; zOrigin.value=p.z;
   offset.value=GetVar("offset");
   dz.value=GetVar("dz");
   wpanel.value=GetVar("wpanel");
   threshhold.value=GetVar("threshhold");
   spacing.value=GetVar("spacing");
-- cylindrical.value=GetVar("cylindrical"); --Step 3.
   ThreeDim.checked=GetVar("ThreeDim");
   AutoJoin.checked=GetVar("AutoJoin");
   JoinTolerance.value=GetVar("JoinTolerance");
   RemoveScraps.checked=GetVar("RemoveScraps");
   smin.value=GetVar("smin");
   AutoTrim.checked=GetVar("AutoTrim");
   Simplify1.checked=GetVar("Simplify1");
   SimplifyTolerance.value=GetVar("SimplifyTolerance");
   Simplify2.checked=GetVar("Simplify2");
   ds.value=GetVar("ds");
   AutoRepair.checked=GetVar("AutoRepair");
   BorderTolerance.value=GetVar("BorderTolerance");
-- name.value=GetVar("Name"); --Step 4.
   XYZFolder.text=GetVar("XYZFolder");
   DT6Folder.text=GetVar("DT6Folder");
   XLSFile.text=GetVar("XLSFile");
   t1=GetVar("ExportXYZ"); ExportXYZ.checked=t1; XYZFolder.enabled=t1; BrowseXYZButton.enabled=t1;
   t1=GetVar("ExportDT6"); ExportDT6.checked=t1; DT6Folder.enabled=t1; BrowseDT6Button.enabled=t1;
   t1=GetVar("ExportXLS"); ExportXLS.checked=t1; XLSFile.enabled=t1; BrowseXLSButton.enabled=t1;
  )
  on PanelDialog close do SaveDialogSettings(PanelDialog);
  on PanelDialog moved position do (local p=GetDialogPos(PanelDialog); xDialog=p.x; yDialog=p.y;)
 )

 --About Dialog
 global AboutDialog; rollout AboutDialog("About WireWorks3D") (
  bitmap RMicon filename:((if_ home "C:/Scenario/WireWorks3D/3DS Max/" "$userscripts/WireWorks3D/")+"Splash.jpg") align:#center offset:[0,10];
 )

 WireWorks();

)
