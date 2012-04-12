--******************************************************************************************
--* Functions Library - Scenario Design, by Paul Nylander
--* include "C:/Scenario/WireWorks3D/3DS Max/Library.ms"
--* include "U:/WireWorks3D/3DS Max/Library.ms"
--******************************************************************************************

global Library (

--******************************************************************************************
--* General Functions
--******************************************************************************************

 escapeEnable=true; --maybe this does work (I thought it only worked with progressbar)
 --SilentErrors:true
 global degree=pi/180;
 global version=maxVersion(); --#(7000,15,0) --release number, API number, revision number

 --Times Functions
--sleep(1.0); --pauses for 1.0 second
 global clock0=0.0;
 global timer2; fn timer2=(local t1=clock0; clock0=0.001*timeStamp(); return clock0-t1;)
 global getdate; fn getdate cdate=(
  local month=int(mod (cdate/100) 1.0);
  local day=int(mod cdate 1.0);
  local year=int(mod (cdate/100000) 1.0);
  return (itoa(month)+"/"+itoa(day)+"/"+itoa(mod year 100));
 )
 global ComputerSpeed;
 global EstimateComputerSpeed; fn EstimateComputerSpeed=(timer2(); --sysInfo.cpucount
  for i=1 to 1000000 do ();
  ComputerSpeed=timer2();
 )

--******************************************************************************************
--* Boolean Functions
--******************************************************************************************

--classOf(ent)!=SplineShape

 global if_; fn if_ test x1 x2=(if(test) then return x1; else return x2;) --merge
 global IsString; fn IsString x=(classOf(x)==String;)
 global IsNumber; fn IsNumber x=(local t1=classOf(x); (t1==Integer or t1==Float or t1==Double);)
 global IsList; fn IsList x=(findItem #(Array,Point2,Point3,Point4,Color,Matrix3,BigMatrix,BigMatrixRowArray) (classOf x))!=0;
 global IsDefined; fn IsDefined x=(classOf(x)!=UndefinedClass;)
 global length2; fn length2 x=( --SafeCount
  case classOf(x) of (
   Array: return x.count;
   Point2: return 2;
   Point3: return 3;
   Point4: return 4;
   Color: return 4; --(if_ (x.a==255.0) 3 4);
   Matrix3: return 4;
   BigMatrix: x.rows; --columns
   BigMatrixRowArray: (local str=(x as string); local n=1; --this is inefficient, need a better code for this
    for i=0 to str.count do if(str[i]==",") then n+=1;
    return n;
   )
   ObjectSet: return x.count;
   default: return 0;
  )
 )
 global approx2; fn approx2 x1 x2 dx=(if(classOf(x1)!=classOf(x2)) then false; else (
  case of(
   (IsNumber(x1)): return (abs(x2-x1) as float)<dx; --see also close_enough function
   (IsList(x1)): (local n=length2(x1); local i=1; local same=(n==length2(x2));
    while(same and i<=n) do (same=approx x1[i] x2[i]; i+=1;)
    return same;
   )
   default: return x1==x2;
  )
 ))
 global approx; fn approx x1 x2=(approx2 x1 x2 1.0e-5); --1.0e-6
 global approxLT; fn approxLT x1 x2=(not(approx x1 x2) and (x1<x2));
 global approxGT; fn approxGT x1 x2=(not(approx x1 x2) and (x1>x2));
 global approxLE; fn approxLE x1 x2=((approx x1 x2) or (x1<x2));
 global approxGE; fn approxGE x1 x2=((approx x1 x2) or (x1>x2));

--******************************************************************************************
--* Debugging
--******************************************************************************************

 --Debugging
 global DebugFile=sysInfo.tempdir+"WireWorks3D Output.txt";
 wf=(openFile DebugFile mode:"w"); if(classOf(wf)==FileStream) then close(wf); --initializes debug file
 global print2; fn print2 str=(print(str); --DebugPrint
  local af=(openFile DebugFile mode:"a");
  if(not(IsDefined(af))) then (
   local wf=(openFile DebugFile mode:"w"); close(wf);
   af=(openFile DebugFile mode:"a");
  )
  (format "%\n" str to:af);
  flush(af); close(af);
 )

 global StopScript; fn StopScript=(print2("MaxScript interrupted."); 1/0;)

--******************************************************************************************
--* Math Functions
--******************************************************************************************

--seed 0.0; x=(random 0.0 1.0);
--log10

 global MinLong=-2147483648, MaxLong=2147483647; --range: -2^31 to 2^31-1
--global MinFloat=-2.0^128, MaxFloat=2.0^128;
 global infinity=2.0^128; --3.40282e+038
 global sign; fn sign x=(if_(x<0) -1 1;) --what if x==0? see xsort
 global min2; fn min2 x1 x2=(if_(x1<x2) x1 x2;)
 global max2; fn max2 x1 x2=(if_(x1>x2) x1 x2;)
 global min3; fn min3 x1 x2 x3=(local x=x1; if(x2<x) then x=x2; if(x3<x) then x=x3; return x;)
 global max3; fn max3 x1 x2 x3=(local x=x1; if(x2>x) then x=x2; if(x3>x) then x=x3; return x;)
 global mod2; fn mod2 a b=(local c=(mod a b); if_(c<0) (c+b) c;) --well-behaved (always returns positive)
 global sqr; fn sqr x=(x*x;)
 global ave; fn ave x1 x2=(0.5*(x1+x2);)
 global AveW; fn AveW w x1 x2=(x1+w*(x2-x1);)
 global floor2; fn floor2 x=( --also works on Point3
  if(classOf(x)==Point3) then return [floor(x.x),floor(x.y),floor(x.z)]; else return floor(x);
 )
 global round; fn round x dx=(dx*floor(x/dx+0.5);)
 global rounddn; fn rounddn x dx=(dx*floor2(x/dx);) --also works on Point3
 global roundup; fn roundup x dx=(dx*ceil(x/dx);)
--global chop; fn chop x=(if_(approx x 0.0) 0.0 x;) --already used?

 --Trigonometric Functions
 global sin2; fn sin2 theta=sin(radToDeg(theta));
 global cos2; fn cos2 theta=cos(radToDeg(theta));
 global tan2; fn tan2 theta=tan(radToDeg(theta));
 global ArcSin; fn ArcSin x=degToRad(asin(x));
 global ArcCos; fn ArcCos x=degToRad(acos(x));
 global ArcTan; fn ArcTan x=degToRad(atan(x));
 global ArcTan2; fn ArcTan2 y x=degToRad(atan2 y x); --range: -pi to pi

--******************************************************************************************
--* String Functions
--******************************************************************************************

--toUpper, toLower
--replace "That is not good" 9 3 "very" -> "That is very good"
--substring
--append --in-place concatenation

--global rtos; fn rtos x n=(local str="" as StringStream;
-- format "%" x format:("."+itoa(n)+"f") to:str; --formattedPrint
-- return (str as string);
--)
 global rtos; fn rtos x1 n=(local x2=(mod (abs x1) 1);
  local i1=int(x1);
  local str=(if_ (i1==0 and x1<0.0) "-" "")+(i1 as string)+".";
  for i=1 to n do (x2=10*(mod x2 1);
   if(i==n) then x2=(round x2 1); --round the last number
   str+=itoa(int(x2));
  )
  return str;
 )
 global atoi; fn atoi x=(x as integer;) --execute(x)
 global itoa; fn itoa x=(x as string;)
 --http://www.cguu.com/3dsmax/3dsMAX8/maxscript/maxscript_class_hierarchy.htm
 global MaxFormat; fn MaxFormat x=(local t1=classOf(x); local str;
  case of(
   (t1==Float or t1==Double): return (rtos x 12); --IsNumber x
   (t1==String): return "\""+x+"\"";
   (t1==Array): (str="#(";
    for x1 in x do str=str+MaxFormat(x1)+",";
    if(x.count==0) then str=str+")"; else str[str.count]=")";
    return str;
   )
   (t1==Point2 or t1==Point3 or t1==Point4): (local n=length2(x); str="["; --IsList x
    for i=1 to n-1 do str=str+MaxFormat(x[i])+",";
    str=str+MaxFormat(x[n])+"]";
    return str;
   )
   (t1==Matrix3): (local n=length2(x); str="(Matrix3 ";
    for i=1 to n do str=str+MaxFormat(x[i]);
    return str+")";
   )
   (t1==BigMatrix): (local ni=x.rows; local nj=x.columns; str="#BigMatrix(";
    for i=1 to ni-1 do (local xlist=x[i]; str=str+"[";
     for j=1 to nj do str=str+MaxFormat(xlist[j])+",";
     str[str.count]="]";
     str=str+",";
    )
    xlist=x[ni]; str=str+"[";
    for j=1 to nj do str=str+MaxFormat(xlist[j])+",";
    str[str.count]="]";
    return str+")";
   )
   (t1==BigMatrixRowArray): (local n=length2(x); str="#("; --this uses an inefficent length2 function
    for i=1 to n-1 do str=str+MaxFormat(x[i])+",";
    str=str+MaxFormat(x[n])+")";
    return str;
   )
   default: return x as string;
  )
 )
 global MaxView; fn MaxView x=(
  local file=sysInfo.tempdir+"Temp.txt", wf=(openFile file mode:"w");
  format "%" (MaxFormat x) to:wf;
  flush(wf); close(wf); notepad(file);
 )

 --automatically rounds to nearest 2 time measurements
 --FormatRuntime(60*(60*(24*(7*(52+1)+1)+1)+1)+1+0.1); -> "1 year and 1 week"
 global FormatRuntime; fn FormatRuntime dt=(local strs=#();
  local years=int(dt/(52*7*24*60*60));
  local weeks=int(mod (dt/(7*24*60*60)) 52); --there are 30.4375 days in a month
  local days=int(mod (dt/(24*60*60)) 7);
  local hours=int(mod (dt/(60*60)) 24);
  local minutes=int(mod (dt/60) 60);
  local seconds=int(round (mod dt 60) 1.0);
  if(years>0) then (append strs (itoa(years)+" year"+(if_ (years==1) "" "s")));
  if(weeks>0) then (append strs (itoa(weeks)+" week"+(if_ (weeks==1) "" "s"))); --and dt<100.0*52*7*24*60*60
  if(days>0 and strs.count<2) then (append strs (itoa(days)+" day"+(if_ (days==1) "" "s")));
  if(hours>0 and strs.count<2) then (append strs (itoa(hours)+" hour"+(if_ (hours==1) "" "s")));
  if(minutes>0 and strs.count<2) then (append strs (itoa(minutes)+" minute"+(if_ (minutes==1) "" "s")));
  if(seconds>0 and strs.count<2) then (append strs (itoa(seconds)+" second"+(if_ (seconds==1) "" "s")));
  return (untokenize " and " strs);
 )

 global interpret; fn interpret str=(execute str;) --eliminate

 global MakeStr; fn MakeStr char n=(local str="";
  for i=1 to n do str+=char;
  str
 )
 global zero2; fn zero2 x n=(local str;
  if(IsString(x)) then str=x; else str=MaxFormat(x);
  (MakeStr "0" (n-str.count))+str;
 )
 global cspc; fn cspc x n=(local str;
  if(IsString(x)) then str=x; else str=MaxFormat(x);
  local n2=(max2 0 (n-str.count));
  for i=1 to n2 do str=str+" ";
  str
 )
--fn FindStr str char=(matchPattern str pattern:("*"+char+"*") ignoreCase:false;)
 global PositionStr; fn PositionStr char str=(findString str char;) --returns undefined if not found, try to eliminate this function
 global RPositionStr; fn RPositionStr char str=(local i=str.count+1; local found=false;
  while(i>1 and not found) do (i-=1;
   found=((substring str i 1)==char);
  )
  if(found) then return i; else return undefined;
 )

--global ascii; fn ascii char=bit.charAsInt(char); --ToCharacterCode
--global chr; fn chr i=bit.intAsChar(i); --FromCharacterCode
 global alphabet; fn alphabet i=bit.intAsChar(96+i); --alphabet[j]
 global IsInt; fn IsInt char=(local i=bit.charAsInt(char); return(i>=48 and i<=57);)
 global IsLetter; fn IsLetter char=(local i=bit.charAsInt(char); return((i>=65 and i<=90) or (i>=97 and i<=122));)
 global StrReplace; fn StrReplace char2 char1 str1=(
  if(version[1]>=8000) then (substituteString str1 char1 char2); else (
   local str2=""; local n=str1.count, n1=char1.count; local i=1;
   while(i<=n) do (
    if((substring str1 i n1)==char1) then (str2+=char2; i+=n1;)
    else (str2+=(substring str1 i 1); i+=1;)
   )
   return str2;
  )
 )
 global tokenize; fn tokenize char str=(filterString str char splitEmptyTokens:true;) --returns unwanted empty tokens at end: tokenize " " "123456789 0"
 global tokenize2; fn tokenize2 char str=(filterString str char;) --splitEmptyTokens:false;
 global untokenize; fn untokenize char strs=(local str=""; local n=strs.count;
  for i=1 to n do str=str+strs[i]+(if_ (i<n) char "");
  return str;
 )
 global UntokenizeFormat; fn UntokenizeFormat char xlist=(local str=""; local n=xlist.count;
  for i=1 to n do str=str+MaxFormat(xlist[i])+(if_ (i<n) char "");
  return str;
 )

--******************************************************************************************
--* Complex Functions
--******************************************************************************************

--global complex; fn complex x y=[x,y]; --eliminate
 global complexI=[0.0,1.0];
 global re; fn re z=(z.x;)
 global im; fn im z=(z.y;)
 global CAbs; fn CAbs z=(length(z);)
 global arg; fn arg z=(ArcTan2 (im z) (re z));
 global CSqr; fn CSqr z=[sqr(re(z))-sqr(im(z)),2*re(z)*im(z)];
 global CPow; fn CPow z n=(local r=CAbs(z); --ComplexPow
  if(r==0.0) then local z2=[0.0,0.0]; else (local theta=n*arg(z); local z2=(r^n)*[cos2(theta),sin2(theta)];)
  return z2;
 )
 global CSqrt; fn CSqrt z=(CPow z 0.5);
 global CMult; fn CMult z1 z2=[re(z1)*re(z2)-im(z1)*im(z2),im(z1)*re(z2)+re(z1)*im(z2)];
 global CDiv; fn CDiv z1 z2=(CMult z1 (CPow z2 -1.0));
 global CExp; fn CExp z=exp(re(z))*[cos2(im(z)),sin2(im(z))];

--******************************************************************************************
--* Color Functions
--******************************************************************************************

--classOf(c)==Color

 --Red, Green, Blue (RGB)
 global rgb2; fn rgb2 c=(color (255*c.x) (255*c.y) (255*c.z)); --already defined
 global IlluminaPlotColor; fn IlluminaPlotColor h0 intensity=(
  local h=(max2 0.0 (min2 0.999999 h0));
  local x1=(min2 1.0 (2.0*intensity)), x2=(max2 0.0 (2.0*intensity-1.0));
  local x=(x1-x2)*(mod (4.0*h) 1.0);
  case int(mod (floor(4.0*h)) 6) of (
   0: return rgb2[x2,x2+x,x1];
   1: return rgb2[x2,x1,x1-x];
   2: return rgb2[x2+x,x1,x2];
   default: return rgb2[x1,x1-x,x2];
  )
 )
 global PlotColor; fn PlotColor h=(IlluminaPlotColor h 0.5);
 global illumination2; fn illumination2 h intensity=( --Illumination__lume
  local x2=(max2 0.0 (2.0*intensity-1.0)), x1=(min2 1.0 (2.0*intensity));
  local x=(x1-x2)*(mod (6.0*h) 1.0);
  case int(mod (floor(6.0*h)) 6) of (
   0: return rgb2[x1,x2+x,x2];
   1: return rgb2[x1-x,x1,x2];
   2: return rgb2[x2,x1,x2+x];
   3: return rgb2[x2,x1-x,x1];
   4: return rgb2[x2+x,x2,x1];
   default: return rgb2[x1,x2,x1-x];
  )
 )
 global hue; fn hue h=(illumination2 h 0.5);
 global findhue; fn findhue c0=(local c=c0/255.0;
  local c1=(min3 c.r c.g c.b), c2=(max3 c.r c.g c.b); local d=c2-c1, h;
  case of (
   (c2==c.r): h=(c.g-c.b)/d;
   (c2==c.g): h=2.0+(c.b-c.r)/d;
   default: h=4.0+(c.r-c.g)/d; --(c2==c.b)
  )
  return (mod (h/6.0) 1.0);
 )
--global mean; fn mean c=(c.r+c.g+c.b)/3.0;

 global ExtractColor; fn ExtractColor c=rgb2[c[2],c[3],c[4]]; --rgb2[c.y,c.z,c.w];
 --gradient2 0.5 #([0,1,0,0],[1,0,0,1])
 global gradient2; fn gradient2 grad x=(local n=grad.count, i=1;
  while(i<=n and grad[i].x<x) do i+=1;
  if(i>1 and i<=n) then (local x1=grad[i-1].x, x2=grad[i].x;
   return (AveW ((x-x1)/(x2-x1)) (ExtractColor grad[i-1]) (ExtractColor grad[i]));
  )
  else return ExtractColor(grad[(min2 (n-1) i)]);
 )
--global illumination3; fn illumination3 c intensity=(
-- if(intensity<0.5) then return 2.0*intensity*c;
-- else return (AveW (2.0*intensity-1.0) c (rgb2[1,1,1]));
--)
--global IlluminaGradient; fn IlluminaGradient x intensity grad=(local i=1;
-- while(i<=n and grad[i].x<x) do i++;
-- if(i>1 and i<=n) then (local x1=grad[i-1].x, x2=grad[i].x;
--  local c=((x2-x)*ExtractColor(grad[i-1])+(x-x1)*ExtractColor(grad[i]))/(x2-x1);
-- )
-- else c=ExtractColor(grad[(min2 (n-1) i)]);
-- return (illumination2 c intensity);
--)

 --MaxView(GetColors(objects)); --ToArray($)
 global GetColors; fn GetColors ents=(local data=#();
  for ent in ents do (append data #(ent.name, ent.wirecolor));
  return data;
 )
 --global MonsterData=#(#("Sphere173_xbar08",(color 155 138 118)));
 --SetColors(MonsterData);
 global SetColors; fn SetColors data=(
  for t1 in data do (local name1=t1[1], ent;
   if(not(IsDefined(PositionStr " " name1))) then ent=execute("$obj"+name1); else ent=undefined;
   if(IsDefined(ent)) then (ent.wirecolor=t1[2]; ent.name=name1;)
   else print2("Warning: "+name1+" not found.");
  )
 )

--******************************************************************************************
--* Point Functions
--******************************************************************************************

--types of vectors: [1,2], [1,2,3], p=[1,2,3,4] -> p.x=1, p.y=2, p.z=3, p.w=4
--already defined: dot, length, normalize

--struct pt(x,y,z)

 global mult; fn mult A x=(x*transpose3(A);) --matrix*vector (need to add logic for matrix*scalar)
 global div; fn div A x=(mult A (1.0/x);) --matrix/scalar
 global minimum; fn minimum xlist=(local x,xmin=xlist[1];
  for i=1 to length2(xlist) do (x=xlist[i]; if(x<xmin) then xmin=x;)
  return xmin;
 )
 global maximum; fn maximum xlist=(local x,xmax=xlist[1];
  for i=1 to length2(xlist) do (x=xlist[i]; if(x>xmax) then xmax=x;)
  return xmax;
 )
 global norm; fn norm p=(if(classOf(p)==Point2) then return sqr(p.x)+sqr(p.y); else return (dot p p);) --dot is not defined for Point2
 global angle1; fn angle1 p1 p2=(ArcTan2 (p2.y-p1.y) (p2.x-p1.x);) --angle is already defined
 global polar; fn polar p theta r=(p+[r*cos2(theta),r*sin2(theta),0];)
 global angle2; fn angle2 x1 x2=(local r=sqrt(norm(x1)*norm(x2)); --angle between 2 vectors
  if(r==0.0) then return 0.0; else return ArcCos((dot x1 x2)/r);
 )
 global angle3; fn angle3 p1 p2 p3=(angle2 (p1-p2) (p3-p2);) --angle between 3 points
 global FixAngle; fn FixAngle theta=((mod2 (theta+pi) (2*pi))-pi;) --returns -pi<=theta<pi (try to make this_-pi<theta<=pi)
 global PlaneNormal; fn PlaneNormal p1 p2 p3=(cross (p1-p2) (p3-p2);) --normal of plane defined by 3 points
 global DistanceToPlane; fn DistanceToPlane p p0 normal=(dot normal (p-p0)); --http://mathworld.wolfram.com/Point-PlaneDistance.html
 global InPlane; fn InPlane p1 p2 p3 p4=(approx (DistanceToPlane p4 p2 (PlaneNormal p1 p2 p3)) 0.0;) --tests if 4 points are in same plane
 global TriangleArea; fn TriangleArea p1 p2 p3=length(cross (p2-p1) (p3-p1))/2.0; --ATriangle
 global PolygonArea; fn PolygonArea plist=(local n=plist.count;
  if(n<3) then return 0.0; else (local A=0.0; local p0=plist[1], p1=plist[2];
   for i=3 to n do (local p2=plist[i]; A+=(TriangleArea p1 p0 p2); p1=p2;)
   return A;
  )
 )
 --subtracts concave areas from polygon area (this is only accurate for in-plane polygons)
 --PolygonArea2(#([0,0,0],[1,0,0],[1,1,0],[1,0,0])) -> 0.0
--global PolygonArea2; fn PolygonArea2 plist=(local n=plist.count;
-- if(n<3) then return 0.0; else (local p0=plist[1]; local p1=plist[2], p2=plist[3];
--  local normal0=(cross (p1-p0) (p2-p0)); local A=length(normal0)/2.0; p1=p2;
--  for i=4 to n do (p2=plist[i];
--   local normal=(cross (p1-p0) (p2-p0));
--   A+=sign(dot normal normal0)*length(normal)/2.0;
--   p1=p2;
--  )
--  return abs(A);
-- )
--)

 --Line Intersection of Plane: http://www.netcomuk.co.uk/~jenolive/vect18c.html
 global IntersectPlane; fn IntersectPlane p1 p2 p0 normal=(local d=(dot normal (p2-p1));
  if(d==0.0) then return undefined; --line is parallel to plane
  local u=(dot normal (p0-p1))/d;
  if(u<0.0 or u>1.0) then return undefined;
  return (AveW u p1 p2);
 )
 global IntersectPlane2; fn IntersectPlane2 p1 p2 p0 normal=(local d=(dot normal (p2-p1));
  if(d==0.0) then ( --line is parallel to plane
   if(approx (DistanceToPlane p1 p0 normal) 0.0) then return p1; else return undefined;
  )
  local u=(dot normal (p0-p1))/d;
  if((approxLT u 0.0) or (approxGT u 1.0)) then return undefined;
  return (AveW u p1 p2);
 )

 --Distance from a Line Segment: http://www.topcoder.com/tc?module=Static&d1=tutorials&d2=geometry1
 --http://mathworld.wolfram.com/Point-LineDistance3-Dimensional.html
 global DistanceToLine; fn DistanceToLine p p1 p2=(local p12=p2-p1; local d=norm(p12);
  if(d==0.0) then return distance p p1; else return sqrt(norm(cross p12 (p1-p))/d);
 )

 --Conversions
 global ToPoint; fn ToPoint xlist=(
  case xlist.count of (
   2: return [xlist[1],xlist[2]];
   3: return [xlist[1],xlist[2],xlist[3]];
   4: return [xlist[1],xlist[2],xlist[3],xlist[4]];
   default: return xlist;
  )
 );
 global ToMatrix3; fn ToMatrix3 A=(local a1=A[1]; local a2=A[2]; local a3=A[3]; --supports: +,-,*,Inverse; unsupported: /,transpose
  Matrix3 [a1[1],a1[2],a1[3]] [a2[1],a2[2],a2[3]] [a3[1],a3[2],a3[3]] [0.0,0.0,0.0];
 )
 --largest allowable: (bigMatrix 250 200);
 global ToBigMatrix; fn ToBigMatrix A1=(local t1=classOf(A1); --supports: +,transpose,invert; unsupported: -,*,/
  case of (
   (t1==Matrix3): (local A2=(bigMatrix 3 3);
    for i=1 to 4 do (for j=1 to 3 do (A2[i][j]=A1[i][j];))
    return A2;
   )
   (t1==Array): (local nj=(length2 A1[1]); local A2=(bigMatrix A1.count nj); local i=1;
    for xlist in A1 do (
     if(classOf(xlist)==Array) then (j=1; for x in xlist do (A2[i][j]=x; j+=1;))
     else (for j=1 to nj do (A2[i][j]=xlist[j];))
     i+=1;
    )
    return A2;
   )
   default: return A1;
  )
 )
 --xlist=#(); for i=1 to 1000000 do (append xlist (random 0.0 1.0));
 global ToBigMatrixRowArray; fn ToBigMatrixRowArray xlist=(ToBigMatrix #(xlist))[1];
 --select one or multiple entities and then try this: ents=ToArray($);
 global ToArray; fn ToArray x=(local t1=classOf(x);
  case of(
   (t1==Array): return x;
   (t1==Point2 or t1==Point3 or t1==Point4 or t1==BigMatrixRowArray): (local n=length2(x); local x2=#();
    for i=1 to n do (append x2 x[i]);
    return x2;
   )
   (t1==Color): return #(x.r,x.g,x.b,x.a);
   (t1==Matrix3): (local n=length2(x); local x2=#();
    for i=1 to n do (append x2 (ToArray x[i]));
    return x2;
   )
   (t1==BigMatrix): (local ni=x.rows; local nj=x.columns; local x2=#(); --don't want BigMatrixRowArray
    for i=1 to ni do (local xlist1=x[i]; local xlist2=#();
     for j=1 to nj do (append xlist2 xlist1[j]);
     append x2 xlist2;
    )
    return x2;
   )
   (t1==ObjectSet): return x as Array;
   default: return #(x); --Editable_Poly, etc.
  )
 )

 --Linear Algebra (Matrix Manipulation)
 global det; fn det A=(local a1=A[1]; local a2=A[2]; local a3=A[3]; --determinant
  -a1.z*a2.y*a3.x+a1.y*a2.z*a3.x+a1.z*a2.x*a3.y-a1.x*a2.z*a3.y-a1.y*a2.x*a3.z+a1.x*a2.y*a3.z;
 )
 global transpose3; fn transpose3 A=(local a1=A[1]; local a2=A[2]; local a3=A[3]; --the built-in transpose function only works on BigMatrix, it doesn't work on Matrix3 for some reason
  Matrix3[a1.x,a2.x,a3.x][a1.y,a2.y,a3.y][a1.z,a2.z,a3.z] A[4];
 )

 --Rotational Matrices
 global Rx; fn Rx theta=(local s=sin2(theta); local c=cos2(theta); Matrix3[1.0,0.0,0.0][0.0,c,-s][0.0,s,c][0.0,0.0,0.0];) --#(#(1.0,0.0,0.0),#(0.0,c,-s),#(0.0,s,c))
 global Ry; fn Ry theta=(local s=sin2(theta); local c=cos2(theta); Matrix3[c,0.0,s][0.0,1.0,0.0][-s,0.0,c][0.0,0.0,0.0];)
 global Rz; fn Rz theta=(local s=sin2(theta); local c=cos2(theta); Matrix3[c,-s,0.0][s,c,0.0][0.0,0.0,1.0][0.0,0.0,0.0];)

 global Raxis; fn Raxis axis theta=(local p=normalize(axis);
  local x=p.z; local y=p.y; local z=p.z; local r=sqrt(sqr(y)+sqr(z));
  if(r==0.0) then return Rx((if_(x==0.0) 1.0 (sign(x)))*theta); --singular axis
  local RRx=Matrix3[1.0,0.0,0.0][0.0,z/r,-y/r][0.0,y/r,z/r][0.0,0.0,0.0];
  local RRy=Matrix3[r,0.0,-x][0.0,1.0,0.0][x,0.0,r][0.0,0.0,0.0];
  transpose(RRx)*transpose(RRy)*Rz(theta)*RRy*RRx; --could also use Inverse here
 )
 global PerpendicularVector; fn PerpendicularVector x=(local y=(cross x [1.0,0.0,0.0]);
  if(norm(y)>0.0) then return y; else return cross x [0.0,1.0,0.0];
 )
 global RAlignAxis; fn RAlignAxis axis axis0=(local x=normalize(axis); local x0=normalize(axis0);
  local y=normalize(cross x0 x); local z=normalize(cross x y); local z0=normalize(cross x0 y);
  if(norm(y)<=0.0) then (
   if(norm(x0-x)<=0.0) then Matrix3[1.0,0.0,0.0][0.0,1.0,0.0][0.0,0.0,1.0][0.0,0.0,0.0]; --identity matrix
   else Raxis(PerpendicularVector(x) pi);
  )
  else transpose3(Matrix3 x0 y z0 [0.0,0.0,0.0])*(Matrix3 x y z [0.0,0.0,0.0]);
 )
--global AlignAxis; fn AlignAxis p axis axis0=(mult (RAlignAxis axis axis0) p;)
--global Align; fn Align plist plist0=()
 global Ralign; fn Ralign p1 p2 p3 p01 p02 p03=(local R=(RAlignAxis (p2-p1) (p02-p01));
  local p=(mult R (p3-p1)); local p0=p03-p01;
  (Raxis (p02-p01) ((atan2 p0.y p0.x)-(atan2 p.y p.x)))*R
 )

 --p=getPoint2();
 global pglobal;
 global getPointTool; tool getPointTool(
  on mousePoint clickno do (pglobal=worldPoint; #stop;)
 )
 global getPoint2; fn getPoint2=(
--local t1=snapMode.active;
--snapMode.active=true; --max snap toggle;
  (startTool getPointTool snap:#3D numPoints:1);
--snapMode.active=t1;
  return pglobal;
 )

--******************************************************************************************
--* List Functions
--******************************************************************************************

 if(version[1]<8000) then (
  global deepcopy; fn deepcopy xlist1=(local n=xlist1.count;
   local xlist2=#(); xlist2.count=n;
   for i=1 to n do (xlist2[i]=xlist1[i];)
   return xlist2;
  )
 )

 --declare a bit array: blist=#{};

 global last; fn last xlist=(local n=xlist.count;
  if(n>0) then return xlist[n]; else return undefined;
 )
 global take; fn take xlist1 i1 i2=(local n=xlist1.count;
--if(not(IsDefined(i2))) then i2=n;
  if(i1>i2 or i1>n or i2<0) then return #(); else (local xlist2=#();
   for i=(max2 1 i1) to (min2 n i2) do append xlist2 xlist1[i];
   return xlist2;
  )
 )
 global cdr; fn cdr xlist=(take xlist 2 xlist.count;)
 global join2; fn join2 xlist1 xlist2=(local xlist=deepcopy(xlist1); join xlist xlist2; return xlist;)
 global prepend; fn prepend xlist x=(join #(x) xlist); --join2
 global reverse2; fn reverse2 xlist1=(n=xlist1.count; local xlist2=#(); xlist2.count=n; i=n;
  for x in xlist1 do (xlist2[i]=x; i-=1;)
  return xlist2;
 )
 global position; fn position x xlist=(local n=length2(xlist),i=1; local found=false;
  while(i<=n and not found) do (
   if(approx xlist[i] x) then found=true; else i+=1;
  )
  if(found) then return i; else return undefined; -- -1
 )
 global find; fn find x xlist=(local n=xlist.count; local i=1; local found=false; --member
  while(i<=n and not found) do (
   if(approx xlist[i] x) then found=true;
   i=i+1; --i+=1;
  )
  return found;
 )
 --Intersection of Two Line Segments: http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/
 global inters; fn inters p1 p2 p3 p4=( --optimized for speed
  local x1=p1.x,y1=p1.y; local x2=p2.x,y2=p2.y; local x3=p3.x,y3=p3.y; local x4=p4.x,y4=p4.y;
  d=(y4-y3)*(x2-x1)-(x4-x3)*(y2-y1);
  if(d==0) then return undefined; --lines are parallel
  u1=((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/d;
  if(u1<0.0 or u1>1.0) then return undefined; --segment1 not along segment2
  u2=((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/d;
  if(u2<0.0 or u2>1.0) then return undefined; --segment2 not along segment1
  p=[(AveW u1 x1 x2), (AveW u1 y1 y2)];
  if(classOf(p1)==Point2) then return p; else return [p.x,p.y,p1.z]; --could use average for z coordinate: (ave (p1.z+(p2.z-p1.z)*u1) (p3.z+(p4.z-p3.z)*u2))
 )
 global RemNth; fn RemNth xlist1 i=(local xlist2=deepcopy(xlist1); --eliminate?
  return (deleteItem xlist2 i);
 )
 global remove; fn remove x xlist=(RemNth xlist (position x xlist));
 global remlist; fn remlist xlist1 xlist2=(local xlist=xlist2; --difference
  for x in xlist1 do xlist=(remove x xlist);
  return xlist;
 )
 global assoc; fn assoc x data=(local n=length2(data),i=1; local t1;
  while(i<=n and not(IsDefined(t1))) do (
   if(approx data[i][1] x) then t1=data[i]; else i+=1;
  )
  return t1;
 )
 global union; fn union xlist=(makeUniqueArray xlist;) --use approx instead here
--in-place sort, plist=#([1,2,3],[0,5,6]); xsort plist; plist
 fn xcompare p1 p2=sign(p1[1]-p2[1]); global xsort; fn xsort plist=(qsort plist xcompare; plist;)
 fn ycompare p1 p2=sign(p1[2]-p2[2]); global ysort; fn ysort plist=(qsort plist ycompare; plist;)
 fn zcompare p1 p2=sign(p1[3]-p2[3]); global zsort; fn zsort plist=(qsort plist zcompare; plist;)
 global sum; fn sum xlist=(local xsum=0.0;
  for x in xlist do xsum+=x;
  return xsum;
 )
 global mean; fn mean xlist=(sum(xlist)/xlist.count;)
--global closelist; fn closelist=(append plist plist[0];)
--global RotateIndices; fn RotateIndices
 --flatten(#(#(1),#(2))) -> #(1,2)
 global flatten; fn flatten xlist1=(local xlist2=#();
  for xlist in xlist1 do (join xlist2 xlist);
  return xlist2;
 )

 global FilterClass; fn FilterClass types xlist1=(local xlist2=#();
  for x in xlist1 do (if(find (classOf x) types) then (append xlist2 x);)
  return(xlist2);
 )
--global FilterClassExclude; fn FilterClassExclude types xlist1=(local xlist2=#();
-- for x in xlist1 do (if(not(find (classOf x) types)) then (append xlist2 x);)
-- return(xlist2);
--)

--******************************************************************************************
--* Point List Functions
--******************************************************************************************

 global rect; fn rect p1 p2=#(p1, [p1.x,p2.y,p1.z], p2, [p2.x,p1.y,p2.z], p1);
 global GetLength; fn GetLength plist=(local s=0.0; local p1=plist[1], p2;
  for i=2 to plist.count do (p2=plist[i]; s+=(distance p1 p2); p1=p2;)
  return s;
 )
 global GetPlists; fn GetPlists ent=(local plists=#(); --returns multiple plists (a single entity can contain multiple spline sections)
  for i=1 to numSplines(ent) do (local plist=#();
   --this might be faster: plist.count=numKnots ent i;
   for j=1 to (numKnots ent i) do append plist (getKnotPoint ent i j);
   append plists plist;
  )
  return plists; --deepcopy(plists); --deepcopy prevents output from being dependant on entity (this is espcially important if you delete(ent), eg: MeshContour2)
 )
 global BoundingBox1; fn BoundingBox1 plist=(
  local p1=plist[1], p2=p1; local ndim=length2(p1);
  for p in plist do (
   for idim=1 to ndim do (local x=p[idim];
    if(x<p1[idim]) then (
--   p1[idim]=x; --this also changes p2! why?
     case idim of (
      1: p1=[x,p1.y,p1.z];
      2: p1=[p1.x,x,p1.z];
      3: p1=[p1.x,p1.y,x];
     )
    )
    if(x>p2[idim]) then (
--   p2[idim]=x; --this also changes the plist itself! why?
     case idim of (
      1: p2=[x,p2.y,p2.z];
      2: p2=[p2.x,x,p2.z];
      3: p2=[p2.x,p2.y,x];
     )
    )
   )
  )
  return #(p1,p2);
 )
 global BoundingBox2; fn BoundingBox2 ent=#(ent.min,ent.max);
--global BoundingBox2; fn BoundingBox2 ent=(local t1=classOf(ent);
-- if(t1!=Editable_Poly and t1!=Editable_Mesh) then return #();
-- local op=(if_ (t1==Editable_Poly) polyop meshop);
-- local nnode=op.getNumVerts(ent);
-- local p1=(op.getVert ent 1), p2=p1;
-- for i=1 to nnode do (local p=(op.getVert ent i);
--  for idim=1 to 3 do (local x=p[idim];
--   if(x<p1[idim]) then p1[idim]=x;
--   if(x>p2[idim]) then p2[idim]=x;
--  )
-- )
-- return #(p1,p2);
--)
 fn QRotate idim p=[(if_ (idim==1) p.y p.x),(if_ (idim==3) p.y p.z)];
 --(ThetaRange 3 [0,0,0] #([1,1,1],[2,2,2]))
 global ThetaRange; fn ThetaRange idim p0 plist=(local thetalist=#();
  local straddle1=false, straddle2=false; --this is not the most reliable way to test if plist straddles theta=0.0 or theta=pi, but it will do for now
  for p in plist do (
   local theta=(angle1 (QRotate idim p0) (QRotate idim p));
   if(approx2 theta 0.0 degree) then straddle1=true;
   if(approx2 theta pi degree) then straddle2=true;
   (append thetalist theta);
  )
  if(straddle1 and straddle2) then print2("Warning: questionable theta range found.");
  if(straddle2 and not(straddle1)) then (
   for i=1 to plist.count do thetalist[i]=(mod2 thetalist[i] (2*pi)); --transformation
   local theta1=2*pi, theta2=0.0;
  )
  else (local theta1=pi, theta2=-pi;)
  for theta in thetalist do (
   if(theta<theta1) then theta1=theta;
   if(theta>theta2) then theta2=theta;
  )
  if(straddle2 and not(straddle1)) then (theta1=FixAngle(theta1); theta2=FixAngle(theta2);)
  return #(theta1,theta2);
 )

 --2D Offset Function
 --plist2=(offset2D 0.025 false plist1);
 global offset2D; fn offset2D r right plist1=(local n=plist1.count; local plist2=#(); local p1,p3; local t1,t2;
  local closed=(approx plist1[1] (last plist1)); local theta=(if_ right 1 -1)*pi/2; local i=2;
  if(closed) then (p1=plist1[plist1.count-1]; t1=(mod2 (angle1 p1 p2) (2*pi));) --2nd to last point
  else (p1=undefined; t1=undefined;)
  for p2 in plist1 do (
   if(i>n) then p3=undefined; else p3=plist1[i];
   if(IsDefined(p3)) then t2=(mod2 (angle1 p2 p3) (2*pi)); else t2=undefined;
   if(IsDefined(t1) and IsDefined(t2)) then p=(polar p2 ((ave t1 t2)+theta) (r/cos2((t1-t2)/2)));
   else p=(polar p2 ((if_ (IsDefined t1) t1 (if_ (IsDefined t2) t2 0.0))+theta) r);
   append plist2 p; p1=p2; t1=t2; i+=1;
  )
  if(closed) then return (plist2); else return plist2; --closelist(ldr(plist2))
 )

 --return index of Cartesian dimension for plane that best fits plist
 global FlattestDim; fn FlattestDim plist=(
  if(plist.count==0) then return 1; --undefined
  local t1=BoundingBox1(plist); local p1=t1[1], p2=t1[2];
  local p=p2-p1; p=[abs(p.x),abs(p.y),abs(p.z)];
  return (position (minimum p) p);
 )
 --returns normal for plane that best fits plist
 global FlattestPlane; fn FlattestPlane plist=(local n=plist.count;
  local p0=plist[(1+n)/2];
  local normal=(PlaneNormal plist[1] p0 plist[n]);
  return #(p0,normal);
 )

 --returns the longest plist in plists
 global GetLongest; fn GetLongest plists=(local plist0=plist[1]; local smax=0.0;
  for plist in plists do (local s=GetLength(plist);
   if(s>smax) then (plist0=plist; smax=s;)
  )
  return plist0;
 )

 --trims off intersecting lines (to be used with 2D offset function)
 --AutoTrim2D(#([0,0,0],[2,0,0],[1,1,0],[1,-1,0])) -> #([0,0,0],[1,0,0],[1,-1,0])
 global AutoTrim2D; fn AutoTrim2D plist1=(local plist2=plist1; local n=plist2.count;
  local p1=plist2[1]; local i1=2;
  while(i1<=n) do (local p2=plist2[i1]; local i2=i1+1; local q1=plist2[i2]; i2+=1;
   local p=undefined;
   while(not(IsDefined p) and i2<=n) do (q2=plist2[i2]; p=(inters p1 p2 q1 q2); q1=q2; i2+=1;)
   if(IsDefined(p)) then ( --removes trimmed section
--  plist2=(join2
--   (take plist2 1 (i1-1))
--   (if_ ((approx p p2) or (approx p q1)) #(p) #())
--   (take plist2 (i2-1) plist2.count)
--  );
    plist3=(take plist2 1 (i1-1));
    if(not(approx p p2) and not(approx p q1)) then (append plist3 p);
    join plist3 (take plist2 (i2-1) plist2.count);
    plist2=plist3;
--  for i=0 to (i2-i1) do (deleteItem plist2 i1); --see if this is slower or faster
--  insertItem plist2 p i1;
    n=plist2.count;
   )
   p1=p2; i1+=1;
  )
  return plist2;
 )
 --AutoTrim3D(#([0,0,0],[2,0,0],[1,0,1],[1,0,-1])) -> #([0,0,0],[1,0,0],[1,0,-1])
 --AutoTrim3D(#([0,0,0],[0,2,0],[0,1,1],[0,1,-1])) -> #([0,0,0],[0,1,0],[0,1,-1])
 global AutoTrim3D; fn AutoTrim3D plist1=(local n=plist1.count;
  if(n==0) then return #(); else (local idim=FlattestDim(plist1); --FlattestPlane
   if(idim==3) then return AutoTrim2D(plist1); else (
    local plist2=#(); plist2.count=n;
    for i=1 to n do (local p=plist1[i]; plist2[i]=(if_ (idim==1) [p.y,p.z,p.x] [p.x,p.z,p.y]);) --forward transformation
    plist2=AutoTrim2D(plist2);
    for i=1 to plist2.count do (p=plist2[i]; plist2[i]=(if_ (idim==1) [p.z,p.x,p.y] [p.x,p.z,p.y]);) --reverse transformation
    return plist2;
   )
  )
 )

 --see also makeFacesPlanar
 global planarize1; fn planarize1 plist1=( --flatten
  local p0=mean(plist1), idim=FlattestDim(plist1); --FlattestPlane is more general
  local plist2=#();
  for p in plist1 do (p[idim]=p0[idim]; append plist2 p;)
  return plist2;
 )
 global ProjectToPlane; fn ProjectToPlane p p0 normal=(
  return p+(dot normal (p-p0))*normal/norm(normal);
 )
 global planarize2; fn planarize2 plist1=(local plist2=#(); --flatten
  local t1=FlattestPlane(plist1); local p0=t1[1], normal=t1[2];
  for p in plist1 do (append plist2 (ProjectToPlane p p0 normal));
  return plist2;
 )

 --Joins together exploded 3D polylines (see also Paolo Hilario's autoweld function: V:/MAXnet/MAX 2008/scripts/CGsoldier/CGS-ModelingTools/AutoWeld.ms)
 --AutoJoin1(#(#([0,0,0],[1,0,0]),#([1,0,0],[2,0,0])));
 global AutoJoin1; fn AutoJoin1 plists0=(local plists=deepcopy(plists0);
  local n=plists.count; local i1=1;
  local i0=0; local n0=0; --why did I add this line of code? I think it's to test for changing?
  while(i1<plists.count and (i1!=i0 or plists.count!=n0)) do ( --cannot use n here because plists.count does not remain constant during this process
   i0=i1; n0=plists.count;
   local plist1=plists[i1]; local p1=plist1[1]; local p2=last(plist1);
   local f1=0, f2=0; local i2=i1+1;
   while(f1==0 and i2<=plists.count) do (
    local plist2=plists[i2]; local q1=plist2[1]; local q2=last(plist2);
    case of (
     (approx p1 q1): (f1=1; f2=1;)
     (approx p1 q2): (f1=1; f2=2;)
     (approx p2 q1): (f1=2; f2=1;)
     (approx p2 q2): (f1=2; f2=2;)
    )
    if(f1==0) then i2+=1;
   )
   if(f1==0) then i1+=1; else (
    if(f1==1) then plist1=reverse2(plist1);
    if(f2==2) then plist2=reverse2(plist2);
    local plist=plist1; (join plist (cdr plist2));
    plists[i1]=plist; (deleteItem plists i2);
   )
  )
  return plists;
 )

 --based on entities (Paolo Hilario, about ?× faster)
 --AutoJoin2(#(#([0,0,0],[1,0,0]),#([1,0,0],[2,0,0])));
 global AutoJoin2; fn AutoJoin2 plists1=(local ent=splineShape();
  for plist in plists1 do (
   addNewSpline(ent);
   for p in plist do (addKnot ent 1 #corner #line p);
   updateShape(ent); --do I need this?
  )
  ent.wirecolor=rgb2[1.0,0.0,0.0];
  max modify mode;
  modPanel.setCurrentObject ents.baseObject;
  subobjectLevel=1;
  max select all;
  (weldSpline ent 1.0e-5); --0.001
  modPanel.setCurrentObject ent.baseObject;
  subobjectLevel=0;
  local plists2=GetPlists(ent);
  delete(ent);
  return plists2;
 )
 global AutoJoin2; fn AutoJoin2 plists1=(local ent=splineShape();
  for plist in plists1 do (
   addNewSpline(ent);
   for p in plist do (addKnot ent 1 #corner #line p);
   updateShape(ent); --do I need this?
  )
  ent.wirecolor=rgb2[1.0,0.0,0.0];
 )

 --Joins nearest ends of all polylines, slow if there are many segments
 --problem: need to handle islands and unwanted leftovers
 --(SuperJoin infinity #(#([0,0,0],[1,0,0]),#([2,0,0],[1,0,0]),#([2,0,0],[3,0,0]))) -> #([0,0,0],[1,0,0],[2,0,0],[3,0,0])
 --(SuperJoin infinity #(#([0,0,0],[1,0,0]),#([1,0,0],[2,0,0]),#([1,0,0],[1,1,0]))) -> ambiguous: #([2,0,0],[1,0,0],[0,0,0],[1,0,0],[1,1,0])
 --(SuperJoin 1.0 #(#([0,0,0],[1,0,0]),#([2,0,0],[3,0,0]))) -> #([0,0,0],[1,0,0],[2,0,0],[3,0,0])
 --(SuperJoin 0.5 #(#([0,0,0],[1,0,0]),#([2,0,0],[3,0,0]))) -> #(#([0,0,0],[1,0,0]),#([2,0,0],[3,0,0]))
 --QView(SuperJoin infinity plists)
 global SuperJoin; fn SuperJoin tolerance plists0=(local plists=deepcopy(plists0);
  if(plists0.count==0) then return #();
  local n=plists.count; local i1=1, i2;
  while(i1<plists.count) do ( --cannot use n here because plists.count does not remain constant during this process
   local plist1=plists[i1]; local p1=plist1[1]; local p2=last(plist1);
   local dmin=infinity; local imin=i; local f1=0, f2=0;
   for i2=i1+1 to plists.count do (
    local plist2=plists[i2]; local q1=plist2[1]; local q2=last(plist2);
    local d1=(distance p1 q1), d2=(distance p1 q2); local d3=(distance p2 q1), d4=(distance p2 q2);
    if(d1<=tolerance and d1<dmin) then (dmin=d1; imin=i2; f1=1; f2=1;)
    if(d2<=tolerance and d2<dmin) then (dmin=d2; imin=i2; f1=1; f2=2;)
    if(d3<=tolerance and d3<dmin) then (dmin=d3; imin=i2; f1=2; f2=1;)
    if(d4<=tolerance and d4<dmin) then (dmin=d4; imin=i2; f1=2; f2=2;)
    i2+=1;
   )
   if(f1==0) then i1+=1; else (
    i2=imin; plist2=plists[i2];
    if(f1==1) then plist1=reverse2(plist1);
    if(f2==2) then plist2=reverse2(plist2);
    if(approx (last plist1) plist2[1]) then deleteItem plist2 1;
    (join plist1 plist2);
    plists[i1]=plist1; (deleteItem plists i2);
   )
  )
  return plists;
 )

 --removes little polylines from the contour
 --(RemoveScraps 6.0 plists)
 global RemoveScraps; fn RemoveScraps smin plists1=(local plists2=#();
  for plist in plists1 do (
   if(GetLength(plist)>=smin) then (append plists2 plist);
  )
  return plists2;
 )

 --removes isolated islands and pools from the contour
 global RemoveIslands; fn RemoveIslands plists1=(local plists2=#();
  for plist in plists1 do (local p1=plist[1], p2=last(plist);
   if(not (approx p1 p2)) then (append plists2 plist); --do I need to use deepcopy here?
  )
  return plists2;
 )

 --plist=ImportXYZ("C:/Scenario/WireWorks3D/Sample XYZ Files/Golden Reference-xbar.xyz");
 --QView(simplify 0.125 plist);
 global simplify; fn simplify tolerance plist1=(local n=plist1.count; local plist2=#();
  if(n>=1) then (local p1=plist1[1]; append plist2 p1;)
  if(n>=2) then local p2=plist1[2];
  i=3;
  while(i<=n) do (local p3=plist1[i]; --cannot use a for loop here because i increments within loop
   while(i<=n and (DistanceToLine p2 p1 p3)<=tolerance) do ( --should this be i<n?
    i+=1; p2=p3; p3=plist1[(min2 n i)]
   )
   append plist2 p2; p1=p2; p2=p3; i+=1;
  )
  if(n>=2) then append plist2 p2;
  return plist2;
 )

 --forces bends to 1.0" minimum spacing
 --(SuperSimplify 1.0 #([0,0,0],[1.1,0,0],[1.9,0,0],[3,0,0])); -> #([0,0,0],[1.5,0,0],[3,0,0])
 global SuperSimplify; fn SuperSimplify tolerance plist1=(
  local n=plist1.count; local p1=plist1[1]; local plist2=#(p1);
  for i=2 to n do (local p2=plist1[i];
   if((distance p1 p2)>=tolerance) then (append plist2 p2); else (
    case i of(
     2: plist2[plist2.count]=p1;
     n: plist2[plist2.count]=p2;
     default: plist2[plist2.count]=(ave p1 p2); --averages last point
    )
   )
   p1=p2;
  )
  return plist2;
 )

 --used with MeshContour1 & MeshContour2
 global iProcessingSort;
 fn ProcessingSort plist1 plist2=sign(plist1[1][iProcessingSort]-plist2[1][iProcessingSort]);
 global StandardProcessing; fn StandardProcessing idim0 contours1=(
  local idim1,idim2; local contours2=#(); local plist;
  for i=1 to contours1.count do (local plists=contours1[i];
   print2("Processing contour "+(zero2 i 2));
   if(plists.count==0) then plist=undefined; else (
    if(IsDefined(idim0)) then idim1=idim0; else idim1=FlattestDim(flatten(plists));
    idim2=(if_ (idim1==3) 1 3); --used to determine when to reverse direction of contours
--  local plist=AutoTrim3D(GetLongest(SuperJoin 1.0 (AutoJoin1 plists))); --(SuperJoin 1.0 (RemoveIslands (AutoJoin1 plists)))
    plists=(RemoveScraps 6.0 (SuperJoin 1.0 (AutoJoin1 plists)));
    for j=1 to plists.count do (
     local plist=AutoTrim3D(plists[j]);
     local p1=plist[1], p2=last(plist); --ensures orientation is in correct direction
     if(p1[idim2]>p2[idim2]) then plist=reverse2(plist);
     plists[j]=(SuperSimplify 1.0 (simplify 0.125 plist));
    )
    iProcessingSort=idim2; (qsort plists ProcessingSort); --example: "xbar01a","xbar01b","xbar01c"
   )
   (append contours2 plists); --plist
  )
  return contours2;
 )

--******************************************************************************************
--* File System
--******************************************************************************************

 --deleteFile --DOSCommand ("delete "+file) --(StrReplace "/" "\\" file)
 --renameFile
 --copyFile
 --getFileSize
 --getFileModDate
 --getFileCreateDate
 --sysInfo.currentdir --dwgprefix
 --bit.intAsChar(ReadByte rf) --for binary files

 global LastSlash; fn LastSlash file=(
  local i1=(RPositionStr "/" file), i2=(RPositionStr "\\" file);
  if(IsDefined(i1) and IsDefined(i2)) then return (max2 i1 i2); else (
   if(IsDefined(i1)) then return i1; else return i2;
  )
 )
 global FileName; fn FileName file=(local i=LastSlash(file);
  if(not(IsDefined(i))) then i=0;
  return(substring file (i+1) file.count);
 )
 global FolderName; fn FolderName file=(local i=LastSlash(file);
  if(not(IsDefined(i))) then i=file.count;
  return(substring file 1 i);
 )
--global DriveLetter; fn DriveLetter
 global RemoveExtension; fn RemoveExtension file=(local i=(PositionStr "." file);
  if(IsDefined(i)) then return (substring file 1 (i-1)); else return file;
 )
--global extension; fn extension
 global RemoveSlash; fn RemoveSlash file=(
  local n=file.count, char=(substring file n -1);
  if(char=="/" or char=="\\") then return(substring file 1 (n-1)); else return(file);
 )
 global FindFile; fn FindFile file=((getFiles file).count>0);
--Findfiles "*.xyz" "C:/Scenario/WireWorks3D/Models/Everest/XYZ Files/"
 global FindFiles; fn FindFiles ext folder=getFiles(folder+ext); --see V:/MAXnet/MAX 2008/scripts/CGsoldier/functions/CGS_func.ms
 --(FindFilesRecursive "*.xyz" "C:/Scenario/Models/Tree Faces/XYZ Files/");
 global FindFilesRecursive; fn FindFilesRecursive ext folder0=(
  local files=(FindFiles ext folder0);
  for folder in getDirectories(folder0+"*") do (join files (FindFilesRecursive ext folder));
  return files;
 )
 global CreateFolder; fn CreateFolder folder=(makeDir (StrReplace "\\" "/" folder) all:true);
 global LaunchInternet; fn LaunchInternet URL=ShellLaunch URL "";
 global navigate; fn navigate folder=ShellLaunch "explorer" (StrReplace "\\" "/" folder);
 global notepad; fn notepad file=ShellLaunch file "";
--(browse "Find It" "C:/g.txt" "Data(*.dat)|*.dat|Excel(*.csv)|*.csv|All|*.*|")
 global browse; fn browse caption0 file0 types0=(
  getOpenFileName caption:caption0 filename:file0 types:types0 --getSaveFileName
 )
 global BrowseFolder; fn BrowseFolder caption0 folder0=( --eliminate
  return (getSavePath caption:caption0 initialDir:folder0); --RemoveSlash(*)+"\\";
 )
--global ExportCSV; fn ExportCSV

 --Hard drive binary filing system for handling large arrays
 --file="C:/Scenario/WireWorks3D/3DS Max/Trash.txt";
 --(SetFileData 4 file 1 123);
 --(GetFileData 4 file 1);
 global SetFileData; fn SetFileData size file ifloat x=(
  if(classOf(x)==String) then x=execute(x); --not sure why sometimes x is a string
--if(not(FindFile(file)) then (local wf=createFile(file); close(wf);)
  local wf=(fopen file "rb+");
  local ibyte=size*(ifloat-1);
  (fseek wf 0 #seek_end); local nbyte=ftell(wf); --local nbyte=getFileSize(file);
  if(ibyte<=nbyte) then (fseek wf ibyte #seek_set); else (
   (fseek wf 0 #seek_end);
   for i=nbyte/size+1 to ifloat-1 do (WriteLong wf MinLong); --undefined
  )
  (WriteLong wf x);
  fclose(wf);
--notepad(file);
 )
 global GetFileData; fn GetFileData size file ifloat=(local x;
  local rf=(fopen file "rbS"); --File not open. No I/O allowed
  local ibyte=size*(ifloat-1);
  (fseek rf 0 #seek_end); local nbyte=ftell(rf); --local nbyte=getFileSize(file);
  if(ibyte>nbyte) then x=undefined; else ( --infinity
   (fseek rf ibyte #seek_set); --base off start of file
   x=ReadLong(rf);
  )
  fclose(rf);
  if(x==MinLong) then return undefined; else return x;
 )

--******************************************************************************************
--* 3D Studio Max Functions
--******************************************************************************************

--getUserPropBuffer(ent);
--(setUserProp ent "x" pi)
--(getUserProp ent "x")

 --sysInfo.computername="VOSTRO";
 --dual core: sysInfo.cpucount=2;
 --sysinfo.getSystemMemoryInfo()=#(52,937398272,442372096,-2022436864,1548328960,2147352576,1643024384)
 --sysInfo.desktopSize=[1280,800]; sysInfo.desktopBPP=32;

--objects --superclass
--ents=(geometry as array);
--max vpt front --actionMan.executeAction 0 "40060"
--selectmore ent

--GetSelectedObjects
--select(ents)
--SelectName names
--max select invert
 global GetNames; fn GetNames=(local names=#();
  for ent in objects do (append names ent.name); --$objects
  return names;
 )
--global AvailableName; fn AvailableName name1=( --uniqueName "Object" --AutoName
-- local names=GetEntNames(); local i=2;
-- if(find name1 names) then return name1; else (
--  while(find (name1+"-"+MaxFormat(i)) names) do i+=1;
--  return (name1+"-"+itoa(i));
-- )
-- return name1;
--)

 --ent=SelectObject("Select object");
--global GlobalObject;
--global getObjectTool; tool getObjectTool(
-- on mousePoint clickno do (GlobalObject=$; #stop;) --clickno doesn't work, try something else
--)
--global SelectObject; fn SelectObject str=(print2(str);
-- (startTool getObjectTool snap:#3D numPoints:1);
-- return GlobalObject;
--)
 --ents=GetObjects();
--global GetObjects; fn GetObjects=(local ent,ents=#(); --gets ordered ents
-- while(IsDefined(ent=SelectObject("Select object"))) do (append ents ent);
-- return(ents);
--)

--global point; fn point p
--line p1 p2
 global draw; fn draw plist=(local ent=splineShape();
  addNewSpline(ent);
  for p in plist do (addKnot ent 1 #corner #line p);
--updateShape(ent);
  return(ent);
 )
--circle p r
--arc p r theta1 theta2
--ellipse p Rx Ry theta
--spline plist
 global text2; fn text2 p str=(
  local ent=text(); ent.text=str; ent.size=10; --you can set as many properties as you want that are specific to the "text" object
--classOf(ent)==text;
 )

 --3D Primatives
--box
--sphere
--cylinder
--cone

 --Messages
 global message; fn message str=(MessageBox str title:"WireWorks3D" beep:true); --warning
 global confirm; fn confirm str=(queryBox str title:"WireWorks3D" beep:true);

--DrawingScale

--NewDrawing
--OpenDrawing file
--SaveDrawing
--CloseDrawing

--******************************************************************************************
--*  Mesh Functions
--******************************************************************************************

--struct PaulMesh(nodes,elems)

 --mesh1=GetMesh($); --nodes & elems must be defined ahead of time
 --must stay with PolyMesh for now
 global GetNodes2; fn GetNodes2 ent=(local nodes=#(); local t1=classOf(ent);
  if(t1!=Editable_Poly and t1!=Editable_Mesh) then return #();
  local op=(if_ (t1==Editable_Poly) polyop meshop);
  local nnode=op.getNumVerts(ent); --GetTriMeshFaceCount
  for i=1 to nnode do (append nodes (op.getVert ent i)); --getElementsUsingFace
  return nodes;
 )
 global GetElems; fn GetElems ent=(local elems=#();
  if(classOf(ent)==Editable_Mesh) then (select(ent); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  local nelem=polyop.GetNumFaces(ent);
  for i=1 to nelem do (append elems (polyop.getFaceVerts ent i)); --getVertsUsingFace --getFaceDeg ent ielem
  return elems;
 )
 --GetEdges($); --why is this so slow?
 global GetEdges; fn GetEdges ent=(local segs=#(); --returns the indices of all the edges --GetSegs
  if(classOf(ent)==Editable_Mesh) then (select(ent); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  local nseg=polyop.getNumEdges(ent);
  for i=1 to nseg do (
   local i1=(ent.getEdgeVertex i 1), i2=(ent.getEdgeVertex i 2);
   (append segs #(i1,i2)); --getVertsUsingEdge
   if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
  )
  return segs;
 )
 global GetMesh; fn GetMesh ent=#(GetNodes2(ent),GetElems(ent));
 --GetNeighbors(GetMesh($));
 global GetNeighbors; fn GetNeighbors mesh1=(local nodes=mesh1[1], elems=mesh1[2];
  local nnode=nodes.count;
  local neighbors=#(); neighbors.count=nnode;
  for i=1 to nnode do neighbors[i]=#();
  for elem in elems do (local i1=last(elem);
   for i2 in elem do (
    appendIfUnique neighbors[i1] i2;
    appendIfUnique neighbors[i2] i1;
   )
  )
  return neighbors;
 )

--global RemoveUnusedNodes; fn RemoveUnusedNodes nodes elems=() --ent.EditablePoly.deleteIsoVerts(); --ent.deleteIsolatedverts=on;

 --mesh1=GetMesh($); delete($); (CreateMesh true mesh);
 global CreateMesh; fn CreateMesh PolyMode mesh1=(local ent; local nodes=mesh1[1], elems=mesh1[2];
  local nnode=nodes.count; local nelem=elems.count; local op=(if_ false polyop meshop); --PolyMode 
  if(nelem==0) then return undefined; else (
   undo on(
    ent=(mesh numverts:nnode numfaces:nelem);
    undo off(
     for i=1 to nnode do (meshop.setVert ent i nodes[i]); --there is no setVert for polyop
     for i=1 to nelem-1 do (local elem=elems[i]; --(ToPoint elems[i])
      if(elem.count<3) then ( --avoids system exception
       print2("Warning: degenerate element encountered.");
--     for j=elem.count+1 to 3 do (append elem elem[1]);
      )
      else (meshop.createPolygon ent elem);
     )
    )
    (meshop.createPolygon ent elems[nelem]); --ToPoint(elems[nelem]) --sometimes this throws a system exception
    update(ent);

    --Paolo Hilario's suggestion:
    clearSelection(); select(ent);
    subobjectLevel=1; max select all;
    meshop.weldVertsByThreshold ent (getVertSelection ent) 1e-5;
    subobjectLevel=0;
--  if(PolyMode) then (clearSelection(); select(ent); macros.run "Modifier Stack" "Convert_to_Poly";) --is this causing it to crash?
   )
   return(ent);
  )
 )

 --Import Mesh from Binary File (used for C++)
 --folder="C:/Scenario/WireWorks3D/C++/Meshes/";
 --mesh1=(ImportMesh1 (folder+"Nodes.txt") (folder+"Elements.txt")); (CreateMesh true mesh1);
 global ImportMesh1; fn ImportMesh1 NodeFile ElemFile=(local nodes=#(), elems=#();
  local rf=(fopen NodeFile "rbS"); --Read Nodes
  if(not(IsDefined(rf))) then (print2("Could not read from mesh file."); return();)
  local nnode=ReadLong(rf);
  for i=1 to nnode do (local p=[0.0,0.0,0.0];
   for j=1 to 3 do p[j]=ReadFloat(rf);
   (append nodes p);
  )
  fclose(rf);
  local rf=(fopen ElemFile "rbS"); --Read Elements
  if(not(IsDefined(rf))) then (print2("Could not read from mesh file."); return();)
  local nelem=ReadLong(rf);
  for i=1 to nelem do (local elem=#(), n=ReadLong(rf);
   for j=1 to n do (append elem (ReadLong rf));
   (append elems elem);
  )
  fclose(rf);
  return #(nodes,elems);
 )

 --Import Mesh Entity from Binary File (used for C++)
 --folder="C:/Scenario/WireWorks3D/C++/Meshes/";
 --(ImportMesh2 (folder+"PanelNodes.txt") (folder+"PanelElements.txt"));
 --Single Panel from Everest: 6.01563 ms
 --Everest: 1.20296+ hrs. (my guess is 5 hours)
 global ImportMesh2; fn ImportMesh2 NodeFile ElemFile=(undo off(
  local rf1=(fopen NodeFile "rbS"), rf2=(fopen ElemFile "rbS");
  if(not(IsDefined(rf1)) or not(IsDefined(rf2))) then (print2("Could not read from mesh file."); return();)
  local nnode=ReadLong(rf1), nelem=ReadLong(rf2);
  if(nnode==0) then (print2("Warning: tried to create mesh with 0 nodes"); return();) --prevents 3DS Max from crashing
  local ent=(mesh numverts:nnode numfaces:nelem), p=[0,0,0];
  print2("Creating mesh vertices");
  for i=1 to nnode do ( --Read Nodes --while(not eof(rf1))
   for j=1 to 3 do p[j]=ReadFloat(rf1);
   (meshop.setVert ent i p);
   if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
  )
  print2("Creating mesh faces");
  for i=1 to nelem do (local elem=#(), n=ReadLong(rf2); --Read Elements
   for j=1 to n do elem[j]=ReadLong(rf2);
   (meshop.createPolygon ent elem);
   if((mod i 1000)==0) then print2((rtos (100.0*i/nelem) 1)+"% of mesh faces complete.");
   if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
  )
  update(ent);
  fclose(rf1); fclose(rf2);
  return(ent);
 ))

 --Export Mesh to Binary File (not used), 3522 nodes took 22.7813 s
 --folder="C:/Scenario/WireWorks3D/C++/"; (ExportMesh1 (folder+"Nodes.txt") (folder+"Elements.txt") (GetMesh $)); --"Mesh.dat"
 global ExportMesh1; fn ExportMesh1 NodeFile ElemFile mesh1=(local wf;
  local nodes=mesh1[1], elems=mesh1[2];
  wf=(fopen NodeFile "wbS"); --Write Nodes
  (WriteLong wf nodes.count);
  for p in nodes do (
   for j=1 to 3 do (WriteFloat wf p[j]);
  )
  fclose(wf);
  wf=(fopen ElemFile "wbS"); --Write Elements
  (WriteLong wf elems.count);
  for elem in elems do (local n=elem.count;
   (WriteLong wf n);
   for j=1 to n do (WriteLong wf elem[j]);
  )
  fclose(wf);
 )

 --Export Mesh Entity to Binary File (this can handle much larger meshes than ExportMesh1)
 --Everest: 19.0469 s
 -- folder="C:/Scenario/Models/Everest/";
 --Single Panel from Everest: ? ms
 -- folder="C:/Scenario/WireWorks3D/C++/Meshes/";
 --(ExportMesh2 (folder+"Nodes.txt") (folder+"Elements.txt") $);
 global ExportMesh2; fn ExportMesh2 NodeFile ElemFile ent=(
  local t1=classOf(ent); local n; local wf;
  if(classOf(ent)==Editable_Mesh) then (select(ent); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  local nnode=polyop.getNumVerts(ent);
  local nelem1=polyop.GetNumFaces(ent), nelem2=0;
  wf=(fopen NodeFile "wbS"); --Write Nodes
  (WriteLong wf nnode);
  for i=1 to nnode do (local p=(polyop.getVert ent i);
   for j=1 to 3 do (WriteFloat wf p[j]);
  )
  fclose(wf);
--notepad(NodeFile);
  wf=(fopen ElemFile "wbS"); --Write Elements
  (WriteLong wf nelem1); --must specify number of elements
  for i=1 to nelem1 do (local elem=(polyop.getFaceVerts ent i); if(IsDefined(elem)) then (
   n=elem.count;
   (WriteLong wf n); --must specify number of nodes for each element
   for j=1 to n do (WriteLong wf elem[j]);
   nelem2+=1;
  ))
  fclose(wf);
--print("nnode="+itoa(nnode)+", nelem="+itoa(nelem2));
  n=nelem1-nelem2;
  if(n>0) then (
   print2("Warning: "+itoa(n)+" element"+(if_ (n==1) "" "s")+" are missing in mesh "+ent.name);
-- wf=(fopen ElemFile "w+bS"); (WriteLong wf nelem2); fclose(wf); --not sure if this will work
  )
--notepad(ElemFile);
 )

 --Surface Mesh Area, result is 0.1% different from MeshArea2, runtime: 78 ms
 --MeshArea1(GetMesh($));
 global MeshArea1; fn MeshArea1 mesh1=(local nodes=mesh1[1], elems=mesh1[2]; local A=0.0;
  for elem in elems do (local plist=#();
   for i in elem do (append plist nodes[i]);
   A+=(PolygonArea plist); --PolygonArea2 --(op.getFaceArea ent ielem);
  )
  return A;
 )

 --Surface Mesh Entity Area, runtime: 66 ms
 --MeshArea2($);
 global MeshArea2; fn MeshArea2 ent=(local t1=classOf(ent); local A=0.0;
  if(t1!=Editable_Poly and t1!=Editable_Mesh) then return 0.0;
  local op=(if_ (t1==Editable_Poly) polyop meshop);
  for i=1 to op.GetNumFaces(ent) do A+=(op.getFaceArea ent i);
  return A;
 )

 --Surface Mesh Boundary, needs work
 --MeshBoundary1(GetMesh($));
 global MeshBoundary1; fn MeshBoundary1 mesh1=(local nodes=mesh1[1], elems=mesh1[2];
  local segs=#(); --edges
  for elem in elems do (local i1=last(elem);
   for i2 in elem do append segs (if_ (i1>i2) #(i2,i1) #(i1,i2));
  )
  local nseg=segs.count; local bsegs=#();
  for i1=1 to nseg do (local seg1=segs[i1]; local unique=true; local i2=i1+1; --too slow!
   while(i2<=nseg and unique) do (local seg2=segs[i2];
    if(seg1[1]==seg2[1] and seg1[2]==seg2[2]) then unique=false; --(approx seg2 seg1)
    i2+=1;
   )
   if(unique) then (append bsegs seg); --boundary segments are unique
  )
  plist=#();
  for i in AutoJoin1(bsegs)[1] do (append plist nodes[i]);
  return plist;
 )

 --Surface Mesh Entity Boundary (Paolo Hilario, only accurate method so far, about 50× faster)
 --manually create boundary: select mesh > comand side panel > Modify tab
 -- Selection: Border icon > select all (control-a) > ???Create Shape (bottom left?)
 --boundaries=MeshBoundary2($); n=boundaries.count;
 --for i=1 to n do (ent=draw(boundaries[i]); ent.wirecolor=PlotColor((i-1.0)/(n-1.0));)
 global MeshBoundary2; fn MeshBoundary2 ent1=(local t1=classOf(ent1); --eliminate
--ent1.EditablePoly.deleteIsoVerts();
  if(t1!=Editable_Poly and t1!=Editable_Mesh) then return(); --for some reason, it wasn't crashing with this: return;
--local ent0=$; --remember original selection (not working)
  clearSelection(); select(ent1);
  max modify mode;
  subobjectLevel=3;
  max select all; --ent1.SelectEdgeLoop();
  local name1=uniqueName("Object");
  polyop.createShape ent1 (polyop.getEdgeSelection(ent1)) name:name1;
  subobjectLevel=0;
  local ent2=execute("$"+name1);
  local plists=GetPlists(ent2);
  delete(ent2);
--subobjectLevel=0; max create mode; clearSelection(); select(ent0); --restore original selection (not working)
  return plists;
 )

 --Surface Mesh Contour: calculates contour polyline along surface mesh, runtime: ~30 s per contour
 --mesh1=GetMesh($); p0=$.center; plists=(MeshContour1 p0 [0,0,1] mesh1);
 global MeshContour1; fn MeshContour1 p0 normal mesh1=(local segments=#();
  local nodes=mesh1[1], elems=mesh1[2];
  for elem in elems do (local n=elem.count; if(n>0) then (
   local segment=#(); local p1=nodes[last(elem)]; local i=1;
   while(i<=n and segment.count!=2) do (p2=nodes[elem[i]];
    local p=(IntersectPlane2 p1 p2 p0 normal);
    if(IsDefined(p)) then (append segment p);
    p1=p2; i+=1;
   )
   n=segment.count;
   if(n!=0 and n!=2) then print2("Warning: unclosed element encountered.");
   if(n==2) then (append segments segment);
  ))
  return segments; --there could be more than one contour
 )

 --Surface Mesh Entity Contour (Paolo Hilario, about 19× faster)
 --p0=$.center; plists=(MeshContour2 p0 [0,0,1] $);
 global MeshContour2; fn MeshContour2 p0 normal ent1=(local t1=classOf(ent1);
  if(t1!=Editable_Poly and t1!=Editable_Mesh) then return #(); else (
   local ents=ToArray(objects); local tlist=#();
   for ent in ents do (
    (append tlist ent.isHidden); --remember visibility
    if(ent!=ent1) then ent.isHidden=true; --hide all other objects
   )
-- ent1.isHidden=false; --this shouldn't be necessary
   local R=(RAlignAxis normal [0.0,0.0,1.0]);
   clearSelection(); select(ent1);
   local ent2=(section pos:p0 transform:R); --classOf(ent2)==section
   max views redraw; --necessary when section is called within a function
   for i=1 to ents.count do (ents[i].isHidden=tlist[i];) --restore visibility
   convertToSplineShape(ent2); --classOf(ent2)==SplineShape
   local segments=GetPlists(ent2);
   delete(ent2); --it is not really useful to return an entity because contours must always be processed (simplified, autotrimmed, planarized, etc.)
   return segments;
  )
 )

 --plists=(JoinMeshContour $.center [0,0,1] $);
 global JoinMeshContour; fn JoinMeshContour p0 normal ent1=(local t1=classOf(ent1);
  if(t1!=Editable_Poly and t1!=Editable_Mesh) then return #(); else (
   local ents=ToArray(objects); local tlist=#();
   for ent in ents do (
    (append tlist ent.isHidden); --remember visibility
    if(ent!=ent1) then ent.isHidden=true; --hide all other objects
   )
-- ent1.isHidden=false; --this shouldn't be necessary
   local R=(RAlignAxis normal [0.0,0.0,1.0]);
   clearSelection(); select(ent1);
   local ent2=(section pos:p0 transform:R); --classOf(ent2)==section
   max views redraw; --necessary when section is called within a function
   for i=1 to ents.count do (ents[i].isHidden=tlist[i];) --restore visibility
   convertToSplineShape(ent2); --classOf(ent2)==SplineShape
   if(version[1]<8000) then (
--  message("Error: weldSpline is not defined in this version of 3DS Max");
   )
   else (
    select(ent2);
    max modify mode;
    modPanel.setCurrentObject ent2.baseObject;
    subobjectLevel=1;
    max select all;
    (weldSpline ent2 1.0e-5); --0.001 --version[1]>=2008
    modPanel.setCurrentObject ent2.baseObject;
    subobjectLevel=0;
   )
   local segments=GetPlists(ent2);
   delete(ent2); --it is not really useful to return an entity because contours must always be processed (simplified, autotrimmed, planarized, etc.)
   return segments;
  )
 )

 --Surface Mesh Contours
 --contours=(MeshContours1 3 6.0 undefined (GetMesh $)); n=contours.count;
 --for i=1 to n do (for plist in contours[i] do (ent=draw(plist); ent.wirecolor=PlotColor((i-1.0)/(n-1.0));))
 global MeshContours1; fn MeshContours1 idim dx p0 mesh1=(local contours=#();
  local t1=BoundingBox1(mesh1[1]); local p1=t1[1], p2=t1[2];
  if(IsDefined(p0)) then p1=(rounddn (p1-p0) dx)+p0; --(rounddnshift p0 dx p1)
  local normal=[0.0,0.0,0.0]; normal[idim]=1.0;
  local p=(ave p1 p2); x1=p1[idim]; x2=p2[idim];
  for x=x1 to x2+dx/2.0 by dx do (
   p[idim]=(max2 (x1+1.0e-3) (min2 (x2-1.0e-3) x)); --tolerance, 0.02*dx
   (append contours (MeshContour1 p normal mesh1));
  )
  return contours;
 )

 --Stagger (Powers of 10 Scale Zoom, functions for MeshContours2)
 global TryContour; fn TryContour x idim p1 normal ent=(local p2=p1; p2[idim]=x;
  return(SuperJoin 1.0 (JoinMeshContour p2 normal ent)); --added SuperJoin for good measure
 )
 global GoodContour; fn GoodContour contour idim x1 x2=(
  local plist=contour[1];
  return((contour.count==1) and (approxGE plist[1][idim] x1) and (approxLE (last plist)[idim] x2));
 )
 global goodx; fn f x idim p1 normal ent=(
  (GoodContour (TryContour x1 idim p normal ent) idim2 y1 y2)
 )

 --Surface Mesh Entity Contours, could change this to return entities instead
 --contours=(MeshContours2 3 6.0 1.0e-3 undefined $); n=contours.count;
 --for i=1 to n do (for plist in contours[i] do (ent=draw(plist); ent.wirecolor=PlotColor((i-1.0)/(n-1.0));))
 global MeshContours2; fn MeshContours2 idim dx tolerance p0 ent=(local contours=#();
  local t1=BoundingBox2(ent); local p1=t1[1], p2=t1[2];
  if(IsDefined(p0)) then p1=(rounddn (p1-p0) dx)+p0; --(rounddnshift p0 dx p1)
  local normal=[0.0,0.0,0.0]; normal[idim]=1.0;
  local p=(ave p1 p2); x1=p1[idim]; x2=p2[idim];

--use stagger approach for better borders

  for x=x1 to x2+0.5*dx by dx do (
   p[idim]=(max2 (x1+tolerance) (min2 (x2-tolerance) x)); --0.02*dx
   contour=(JoinMeshContour p normal ent);
   for i=1 to contour.count do ( --ensure contour is on x (this should only be necessary for borders)
    for j=1 to contour[i].count do contour[i][j][idim]=x;
   )
   (append contours contour); --MeshContour2
  )
  return contours;
 )

 --idim=3; p0=[-54.0,0,0]; theta1=0.0; theta2=2*pi/8; dtheta=2*pi/64; ent=$;
 --contours=(CylindricalMeshContours 3 [-54.0,0,0] 0.0 (2*pi/8) (2*pi/64) $);
 --for plists in contours do (for plist in plists do (draw plist))
 global CylindricalMeshContours; fn CylindricalMeshContours idim p0 theta1 theta2 dtheta ent1=(
  local dims=#(1,2,3); (deleteItem dims idim); local idim1=dims[1], idim2=dims[2];
  if(not(IsDefined(p0))) then (
   local t1=BoundingBox2(ent1); local p1=t1[1], p2=t1[2]; --GetNodes2(ent1)
   p0=(ave p1 p2);
-- p0[idim]=p1[idim]; --unnecessary
  )
  ncontour=int(round ((theta2-theta1)/dtheta) 1.0)+1;
  local contours=#(); local thetatol=0.25*degree; --2*pi*1.0e-3
  for icontour=1 to ncontour do (
   local w=(icontour-1.0)/(ncontour-1);
   local theta=(max2 (theta1+thetatol) (min2 (theta2-thetatol) (AveW w theta1 theta2)));
   local normal=[0.0,0.0,0.0]; normal[idim1]=-sin2(theta); normal[idim2]=cos2(theta);
   local contour=(JoinMeshContour p0 normal ent2); --MeshContour2 --(MeshContour1 p0 normal mesh1)
   (append contours contour);
  )
  return contours;
 )

 --edge detection (proof of concept)
 --plists=(DetectEdges (degToRad 45) $);
 --for plist in plists do draw(plist);
 global DetectEdges; fn DetectEdges threshold ent=(local plists=#();
  local nodes=GetNodes2(ent), elems=GetElems(ent);
  local segs=GetEdges(ent); --slow
  for i=1 to segs.count do (
   local seg=segs[i]; local p1=nodes[seg[1]], p2=nodes[seg[2]];
   local elems2=(polyop.getEdgeFaces ent i) as array;
   if(elems2.count>=2) then ( --not sure why sometimes elems2 only has one element
    local elem1=elems[elems2[1]], elem2=elems[elems2[2]]; --(polyop.getFaceEdges ent iface)
    local q1=nodes[(remlist seg elem1)[1]], q2=nodes[(remlist seg elem2)[1]];
    if((angle2 (PlaneNormal p1 p2 q1) (PlaneNormal p2 p1 q2))>threshold) then (
     (append plists #(p1,p2));
    )
   )
  )
  return AutoJoin1(plists);
 )

 --(ScaleMesh 3 $);
 global ScaleMesh; fn ScaleMesh n ent=(local mesh1=GetMesh(ent);
  for i=1 to mesh1[1].count do mesh1[1][i]*=n;
  (CreateMesh true mesh1);
 )

 --Surface Mesh 3D Offset (needs work, will be 2× faster)
 --(CreateMesh true (OffsetMesh1 3.0 (GetMesh $)));
 global OffsetMesh1; fn OffsetMesh1 r mesh1=(local neighbors=GetNeighbors(mesh1); --can create inverted triangles
  local nodes1=mesh1[1]; local elems=mesh1[2]; local nodes2=#();
  for i=1 to nodes1.count do (local p0=nodes1[i]; local ilist=neighbors[i];
   if(ilist.count<3) then (
--  message("Error in OffsetMesh1.");
--  return undefined;
    nodes2[i]=p0;
   )
   else (
    local p1=nodes1[ilist[1]]; local p2=nodes1[ilist[2]]; local p3=nodes1[ilist[3]];
    local n1=(PlaneNormal p1 p0 p2); local n2=(PlaneNormal p2 p0 p3); local n3=(PlaneNormal p3 p0 p1);
    if(norm(n1)==0.0 or norm(n2)==0.0 or norm(n3)==0.0) then nodes2[i]=p0; else (
     n1=normalize(n1); n2=normalize(n2); n3=normalize(n3);
     local d=det(Matrix3 n1 n2 n3 [0.0,0.0,0.0]);
     if(d==0.0) then nodes2[i]=p0+r*(n1+n2+n3)/3.0; else (
      local g=[(dot n1 (p0+r*n1)), (dot n2 (p0+r*n2)), (dot n3 (p0+r*n3))];
      local nx=[n1.x,n2.x,n3.x]; local ny=[n1.y,n2.y,n3.y]; local nz=[n1.z,n2.z,n3.z];
      nodes2[i]=[det(Matrix3 g ny nz [0.0,0.0,0.0]), -det(Matrix3 g nx nz [0.0,0.0,0.0]), det(Matrix3 g nx ny [0.0,0.0,0.0])]/d;
     )
    )
   )
   if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
  )
  return #(nodes2,elems);
 )

 --Surface Mesh Entity 3D Offset (only accurate method so far, about 2× slower)
 --(OffsetMesh2 -3.0 $);
 global OffsetMesh2; fn OffsetMesh2 r ent=(
  local t1=classOf(ent);
  if(classOf(ent)==Editable_Mesh) then (select(ent); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  select(ent);
  modPanel.addModToSelection(Shell()) ui:on flip:on;
  local t1=ent.modifiers[#Shell];
  t1.innerAmount=(if_ (r<0.0) -r 0.0);
  t1.outerAmount=(if_ (r>0.0) r 0.0);
  t1.straightenCorners=off;
  t1.selectInnerFaces=off;
  t1.selectOuterFaces=on;
  t1.selectEdgeFaces=on;
  modPanel.addModToSelection (DeleteMesh ()) ui:on;
  modPanel.addModToSelection (Mesh_Select ()) ui:on
  subobjectLevel = 4
  max select all
  subobjectLevel = 0
  modPanel.addModToSelection (Normalmodifier ()) ui:on;
  ent.modifiers[#Normal].flip = on
--ent.EditablePoly.deleteIsoVerts();
 )

 --Slice Surface Mesh: cuts mesh into two pieces (runtime 2.6 s)
 --timer2(); meshes=(SliceMesh1 $.center [0,0,1] (GetMesh $)); timer2(); --(getPoint2())
 --delete($); for mesh1 in meshes do (CreateMesh true mesh1);
 global SliceMesh1; fn SliceMesh1 p0 normal mesh1=(local nodes=mesh1[1], elems=mesh1[2];
  local nodes1=#(), elems1=#();
  local nodes2=#(), elems2=#();
  local dlist=#();
  for p in nodes do (append dlist (DistanceToPlane p p0 normal)); --precalculate distances to plane
  for elem in elems do (local n=elem.count; if(n>0) then (

   --the challenge: find the new elem2 & elem1 and add new nodes to nodes2 & nodes1 as needed
   local elem1=#(), elem2=#();
   local i=last(elem); local p1=nodes[i];
   local GetNode1=#(), GetNode2=#();
   for i in elem do (local p2=nodes[i];

    --slow part of the code
    local p=(IntersectPlane p1 p2 p0 normal); --this is calculated twice for every edge segment (can be made more efficient)
    if(IsDefined(p) and not(approx p p2)) then ( --add new intersection point to both meshes
     (append nodes1 p); (append elem1 nodes1.count);
     (append nodes2 p); (append elem2 nodes2.count);
    )

    local d=dlist[i];
    if(d<=0.0) then (local i1=GetNode1[i];
     if(not IsDefined(i1)) then ((append nodes1 p2); i1=nodes1.count; GetNode1[i]=i1;) --error sizing array when i=73629
     (append elem1 i1);
    )
    if(d>=0.0) then (local i2=GetNode2[i];
     if(not IsDefined(i2)) then ((append nodes2 p2); i2=nodes2.count; GetNode2[i]=i2;)
     (append elem2 i2);
    )

    p1=p2;
   )

   if(elem1.count>0) then (
    if(elem1.count<3) then print2("Warning: degenerate element1 encountered in SliceMesh1.");
    else (append elems1 elem1);
   )
   if(elem2.count>0) then (
    if(elem2.count<3) then print2("Warning: degenerate element2 encountered in SliceMesh1.");
    else (append elems2 elem2);
   )
   if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
  ))
  return #(#(nodes1,elems1),#(nodes2,elems2));
 )

 --Slice Surface Mesh Entity (Paolo Hilario)
 --timer2(); (SliceMesh2 $.center [0,0,1] $); timer2();
 global SliceMesh2; fn SliceMesh2 p0 normal ent1=(
  if(classOf(ent1)==Editable_Mesh) then (select(ent1); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent1)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  ent1.split=on;
--DisableSceneRedraw();
--ent1.EditablePoly.slice normal p0 flaggedFacesOnly:on;
--(polyop.slice ent1 (ent1.faces) (ray p0 normal)); --classOf(ray p0 normal)==Ray
  (ent1.slice normal p0);
  ent1.SetSelection #Face #{1}; --selects the first face
  ent1.SelectElement();
  local name1=uniqueName("Object");
  polyop.detachFaces ent1 (ent1.GetSelection #face) asNode:true name:name1; --why isn't this always working?
  local ent2=execute("$"+name1);
--EnableSceneRedraw();
  return(#(ent1,ent2));
 )

 --Super Slice Surface Mesh Entity
 --timer2(); (HardDriveSliceMesh $.center [0,0,1] (ToArray $)); timer2();
 global HardDriveSliceMesh; fn HardDriveSliceMesh p0 normal ents=(
  --Temp Folder: Customize > Configure System Paths... > System > Temp > Modify... > V:\MAXnet\MAX 2008\users\PaulN\enu-x86\temp
  local folder=sysInfo.tempdir; --(if_ home "C:/Scenario/WireWorks3D/3DS Max/Temp/" "U:/WireWorks3D/3DS Max/Temp/");
  local NodeFile1=folder+"Nodes1.txt", wfnode1=(fopen NodeFile1 "wbS"); (WriteLong wfnode1 0); --place-holders
  local NodeFile2=folder+"Nodes2.txt", wfnode2=(fopen NodeFile2 "wbS"); (WriteLong wfnode2 0);
  local ElemFile1=folder+"Elements1.txt", wfelem1=(fopen ElemFile1 "wbS"); (WriteLong wfelem1 0);
  local ElemFile2=folder+"Elements2.txt", wfelem2=(fopen ElemFile2 "wbS"); (WriteLong wfelem2 0);
  local GetNodeFile1=folder+"GetNode1.txt", wf1=createFile(GetNodeFile1); close(wf1);
  local GetNodeFile2=folder+"GetNode2.txt", wf2=createFile(GetNodeFile2); close(wf2);
  local nnode1=0, nnode2=0; local nelem1=0, nelem2=0; local n;
  for ent in ents do (
   if(classOf(ent)==Editable_Mesh) then (select(ent); macros.run "Modifier Stack" "Convert_to_Poly";)
   if(classOf(ent)!=Editable_Poly) then (print("Object is not a mesh."); return();)
   local nnode=polyop.getNumVerts(ent), nelem=polyop.GetNumFaces(ent);
   for ielem=1 to nelem do (
    local elem=(polyop.getFaceVerts ent ielem);
    if(elem.count>0) then (
     local p1=(polyop.getVert ent (last elem));
     local elem1=#(), elem2=#();
     for i in elem do (local p2=(polyop.getVert ent i);
      local p=(IntersectPlane p1 p2 p0 normal);
      if(IsDefined(p) and not(approx p p2)) then (
       for j=1 to 3 do (WriteFloat wfnode1 p[j]); nnode1+=1; (append elem1 nnode1); --(meshop.setVert ent1 i1 p);
       for j=1 to 3 do (WriteFloat wfnode2 p[j]); nnode2+=1; (append elem2 nnode2); --(meshop.setVert ent2 i1 p);
      )
      local d=(DistanceToPlane p2 p0 normal);
      if(d<=0.0) then (
       local i1=(GetFileData 4 GetNodeFile1 i); --local i1=GetNode1[i];
       if(not(IsDefined(i1))) then (
        for j=1 to 3 do (WriteFloat wfnode1 p2[j]); --(UntokenizeFormat "," p2) --(meshop.setVert ent1 i1 p2);
        nnode1+=1; i1=nnode1;
        (SetFileData 4 GetNodeFile1 i i1); --GetNode1[i]=i1;
       )
       (append elem1 i1);
      )
      if(d>=0.0) then (
       local i2=(GetFileData 4 GetNodeFile2 i); --local i2=GetNode2[i];
       if(not(IsDefined(i2))) then (
        for j=1 to 3 do (WriteFloat wfnode2 p2[j]); --(UntokenizeFormat "," p2) --(meshop.setVert ent2 i2 p2);
        nnode2+=1; i2=nnode2;
        (SetFileData 4 GetNodeFile2 i i2); --GetNode2[i]=i2;
       )
       (append elem2 i2);
      )
      p1=p2;
     )
     n=elem1.count;
     if(n>0) then (
      if(n<3) then print2("Warning: degenerate element1 encountered in HardDriveSliceMesh.");
      else ((WriteLong wfelem1 n); for j=1 to n do (WriteLong wfelem1 elem1[j]); nelem1+=1;) --(meshop.createPolygon ent1 elem1);
     )
     n=elem2.count;
     if(n>0) then (
      if(n<3) then print2("Warning: degenerate element2 encountered in HardDriveSliceMesh.");
      else ((WriteLong wfelem2 n); for j=1 to n do (WriteLong wfelem2 elem2[j]); nelem2+=1;) --(meshop.createPolygon ent2 elem2);
     )
     if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
    )
   )
   delete(ent);
  )
  print2("mesh1: "+itoa(nnode1)+" nodes, "+itoa(nelem1)+" elements");
  print2("mesh2: "+itoa(nnode2)+" nodes, "+itoa(nelem2)+" elements");
  fclose(wfnode1); fclose(wfelem1);
  fclose(wfnode2); fclose(wfelem2);
  --finally we can export nnode & nelem now that we know them
  wfnode1=(fopen NodeFile1 "rb+"); (WriteLong wfnode1 nnode1); fclose(wfnode1); --rb+, wb+
  wfelem1=(fopen ElemFile1 "rb+"); (WriteLong wfelem1 nelem1); fclose(wfelem1);
  wfnode2=(fopen NodeFile2 "rb+"); (WriteLong wfnode2 nnode2); fclose(wfnode2);
  wfelem2=(fopen ElemFile2 "rb+"); (WriteLong wfelem2 nelem2); fclose(wfelem2);
  local ent1=(ImportMesh2 NodeFile1 ElemFile1); --(mesh numverts:nnode1 numfaces:nelem1);
  local ent2=(ImportMesh2 NodeFile2 ElemFile2); --(mesh numverts:nnode2 numfaces:nelem2);
  return #(ent1,ent2);
 )

 --All-purpose Mesh Slicer
 --(SliceMesh $.center [0,0,1] $);
 --Everest slice: meshop.getNumVerts($) = 10616
 global SliceMesh; fn SliceMesh p0 normal ent1=(local ents;
  if(classOf(ent1)==Editable_Mesh) then (select(ent1); macros.run "Modifier Stack" "Convert_to_Poly";)
  if(classOf(ent1)!=Editable_Poly) then (print("Object is not a mesh."); return();)
  local op=(if_ (classOf(ent1)==Editable_Poly) polyop meshop);
  local nnode=op.getNumVerts(ent1); --not used: nelem=op.GetNumFaces(ent1);
  local nmax=(if_ (version[1]<2008) 15000 15000); --45255 --65536=2^16 --23000 took too long on Max8 --error occurs when nnode>=73629
  local LargeMesh=(nnode>=nmax); --52102

  --Store Original Mesh (in case 3DS Max fails to correctly slice mesh)
  if(LargeMesh) then (local folder=sysInfo.tempdir;
   local NodeFile=folder+"Nodes.txt", ElemFile=folder+"Elements.txt";
   (ExportMesh2 NodeFile ElemFile ent1); --true
  )
  else (
-- heapSize+=2000000; --2 MB --default heepSize: 5.5 MB
   local mesh1=(GetMesh ent1); --Runtime error: Out of scripter memory - use options to increase
  )

  --Check if 3DS Max can correctly slice mesh
  ents=(SliceMesh2 p0 normal ent1); --slice mesh using 3DS Max
  local tolerance=1.0; --1.0e-3
  local BadSlice1=false, BadSlice2=false; local dlist=#(); --checks to make sure the mesh slices aren't reversed
  for i=1 to 2 do (local ent=ents[i], dbar=0.0;
   if(not(IsDefined(ent))) then (append dlist undefined); else (
    local nnode2=(if_ (classOf(ent)==Editable_Poly) polyop meshop).getNumVerts(ent);
    for j=1 to nnode2 do (local p=(op.getVert ent j);
     local d=(DistanceToPlane p p0 normal); dbar+=d;
     if(not BadSlice1) then BadSlice1=(if_ (i==1) (d>tolerance) (d<-tolerance));
     if(not BadSlice2) then BadSlice2=(if_ (i==2) (d>tolerance) (d<-tolerance)); --calculates BadSlice assuming meshes will be swapped
    )
    (append dlist (dbar/nnode2));
   )
  )
  if(IsDefined(dlist[1]) and IsDefined(dlist[2]) and dlist[1]>dlist[2]) then (
   print2("3DS Max reversed the mesh slices. WireWorks3D will correct.");
   ents=reverse2(ents);
   BadSlice1=BadSlice2; --reverse definition of BadSlice
  )

--BadSlice1=false; --why is this returning BadSlice1=true when it is not?

  --Use WireWorks3D to calculate mesh slice (if 3DS Max failed to correctly slice mesh)
  if(BadSlice1) then (
   --MXS auto increased heap size to: 51195904
   if(LargeMesh) then (
    print2("3DS Max failed to correctly slice the mesh. WireWorks3D will use the hard drive to calculate the mesh slice because this is a large mesh ("+itoa(nnode)+" nodes). This may be slow.");
--  heapSize+=2000000; --2 MB --default heepSize: 5.5 MB
--  if(not(IsDefined(ComputerSpeed))) then ComputerSpeed=EstimateComputerSpeed();
    local runtime=0.5*863.941*nnode/28869; --213954.16406*nnode/283569; --ComputerSpeed --estimated runtime based on my Scenario desktop, might want to perform a runtime analysis to see if runtime goes as a*nnode^b+c
    print2("Estimated wait time: "+FormatRuntime(runtime)+".");
    for ent in ents do delete(ent);
    local ent=(ImportMesh2 NodeFile ElemFile); --restore original mesh
    ents=(HardDriveSliceMesh p0 normal #(ent)); --(CSliceMesh p normal NodeFile ElemFile)
   )
   else (
    print2("3DS Max failed to correctly slice the mesh. WireWorks3D will calculate the mesh slice ("+itoa(nnode)+" nodes). This may be slow.");
    local meshes=(SliceMesh1 p0 normal mesh1);
    for ent in ents do delete(ent);
    ents=#((CreateMesh true meshes[1]),(CreateMesh true meshes[2]));
   )
  )

  return(ents);
 )

 --Cartesian Surface Mesh Entity Slicer
 --m=100.0/2.54; ents=(MeshSlices 3 (2*m) undefined $);
 global MeshSlices; fn MeshSlices idim dx p0 ent0=(local ent=ent0; local ents=#();
  local t1=BoundingBox2(ent); local p1=t1[1], p2=t1[2];
  if(IsDefined(p0)) then p1=(rounddn (p1-p0) dx)+p0; --(rounddnshift p0 dx p1)
  local p=(ave p1 p2); local normal=[0.0,0.0,0.0]; normal[idim]=1.0;
  for x=p1[idim]+dx to p2[idim] by dx do (
   print2("Slicing mesh at "+#("x","y","z")[idim]+"="+MaxFormat(x));
   p[idim]=x;
   if(not(IsDefined(ent))) then (append ents undefined); else (
    local ents2=(SliceMesh p normal ent);
    (append ents ents2[1]);
    ent=ents2[2]; --redefines remaining ent (could be undefined)
   )
   if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
  )
--(gc light:false); --returns MAXScript heap free bytes --garbage collector
  (append ents ent);
  return(ents);
 )

--global PieSlice; fn PieSlice idim theta1 theta2 p0 ent0=(

 --Cylindrical Surface Mesh Entity Slices
 --dtheta=2*pi/20; --must be an even number
 --(CylindricalMeshSlices 3 [-54.0,0,0] 0.0 dtheta $);
 global CylindricalMeshSlices; fn CylindricalMeshSlices idim p0 theta0 dtheta ent0=(local ent=ent0; local ents=#();
  local dims=#(1,2,3); (deleteItem dims idim); local idim1=dims[1], idim2=dims[2];
  if(not IsDefined(p0)) then (
   local t1=BoundingBox2(ent); local p1=t1[1], p2=t1[2];
   p0=(ave p1 p2);
-- p0[idim]=p1[idim]; --unnecessary
  )
  local normal=[0.0,0.0,0.0]; normal[idim1]=-sin2(theta0); normal[idim2]=cos2(theta0); --master slice
  local ents0=(SliceMesh p0 normal ent);
  local n=int(round (pi/dtheta) 1.0); local theta=theta0;
  for i=1 to 2 do (ent=ents0[3-i];
   for j=1 to n-1 do (theta+=dtheta;
    normal[idim1]=-sin2(theta); normal[idim2]=cos2(theta);
    local ents2=(SliceMesh p0 normal ent);
    (append ents ents2[1]);
--  ents2[1].wirecolor=PlotColor((n*(i-1)+j-1.0)/(2*n-1));
    ent=ents2[2]; --redefines remaining ent
    if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
   )
   theta+=dtheta; (append ents ent);
   ent.wirecolor=PlotColor((ents.count-1.0)/(2*n-1));
  )
  return(ents);
 )

 --(ParametricPlot3D f 0.0 1.0 (1.0/10) 0.0 1.0 (1.0/10));
--global f; fn f u v=([u,v,0.0];)
--global SuperParametricPlot3D; fn SuperParametricPlot3D f u1 u2 du v1 v2 dv=( --uses binary hard drive
 global ParametricPlot3D; fn ParametricPlot3D f u1 u2 du v1 v2 dv=(
  local imax=int(round ((u2-u1)/du) 1.0); local jmax=int(round ((v2-v1)/dv) 1.0);
  local nodes=#(); local elems=#();
  for j=0 to jmax do (local v=v1+j*dv; --calculate nodes
   for i=0 to imax do (local u=u1+i*du; (append nodes (f u v));)
   if(keyboard.escPressed and confirm("Do you wish to terminate process?")) then StopScript();
  )
--for i=1 to imax-1 do ( --assemble quad elements, need to remove degenerate quads
-- for j=1 to jmax-1 do (local i0=j+(i-1)*jmax; (append elems #(i0,i0+1,i0+jmax+1,i0+jmax));)
--)
  for i=1 to imax do ( --assemble triangle elements
   for j=1 to jmax do (
    local i1=i+(j-1)*(imax+1); local i2=i1+1; local i3=i1+(imax+1)+1; local i4=i1+(imax+1);
    local p1=nodes[i1]; local p2=nodes[i2]; local p3=nodes[i3]; local p4=nodes[i4];
--  if(not(IsDefined(p3)) or not(IsDefined(p4))) then print2("Warning: undefined points in mesh");
    local d12=norm(p2-p1); local d13=norm(p3-p1); --slow: (distance p1 p2)
    local d14=norm(p4-p1); local d23=norm(p3-p2);
    local d24=norm(p4-p2); local d34=norm(p4-p3);
    if(d13<d24) then (
     if(d12>0.0 and d23>0.0 and d13>0.0) then (append elems #(i1,i2,i3)); --removes degenerate triangles
     if(d13>0.0 and d34>0.0 and d14>0.0) then (append elems #(i1,i3,i4));
    )
    else (
     if(d12>0.0 and d24>0.0 and d14>0.0) then (append elems #(i1,i2,i4));
     if(d23>0.0 and d34>0.0 and d24>0.0) then (append elems #(i2,i3,i4));
    )
   )
  )
  (CreateMesh true #(nodes,elems));
 )

--******************************************************************************************
--* POV-Ray Include Files (could move this to WireWorks3D.ms)
--******************************************************************************************

 global POVFormat; fn POVFormat x=(local t1=classOf(x);
  case of(
-- (IsNumber(x)): return MaxFormat(x);
-- (t1==String): return MaxFormat(x);
   (t1==Array): (local str="{";
    for x1 in x do str=(str+POVFormat(x1)+",");
    if(x.count==0) then str=str+"}"; else str[str.count]="}";
    return str;
   )
   (IsList(x) or t1==Color): (
    if(t1==Color) then x=ToArray(x); --3DS Max crashes if you do this?
    local n=length2(x);
    local IsVector=(t1==Point2 or t1==Point3 or t1==Point4); --(find n #(2,3,4))
    local str=(if_ IsVector "<" "{");
    for i=1 to n-1 do str=(str+POVFormat(x[i])+",");
    str=str+POVFormat(x[n])+(if_ IsVector ">" "}");
    return str;
   )
   (t1==BooleanClass): return (if_ x "1" "0");
   default: return MaxFormat(x);
  )
 )

 --Export Wire
 --(ExportPOV "C:/Scenario/WireWorks3D/POV-Ray/Test.inc" (GetPlists $)[1])
 global ExportPOV; fn ExportPOV file plist=(CreateFolder FolderName(file);
  local wf=(openFile file mode:"w");
  format "//%\n" (MakeStr "*" 90) to:wf;
  format "//* %\n" (FileName file) to:wf;
  format "//%\n\n" (MakeStr "*" 90) to:wf;
  format "#declare plist=array[%] %;\n" plist.count (POVFormat plist) to:wf;
  flush(wf); close(wf);
--notepad(file);
 )

 --Export Panel
 --(ExportPanelPOV "C:/Scenario/WireWorks3D/POV-Ray/Panel.inc" (ToArray $));
 --(ExportPanelPOV "//SDI-FS1/Design/Users/Paul Nylander/Tree Faces/POV-Ray/Panel.inc" (ToArray $));
 global ExportPanelPOV; fn ExportPanelPOV file ents=(local names=#();
  for i=1 to ents.count do (append names ents[i].name);
  local wf=(openFile file mode:"w");
  format "//%\n" (MakeStr "*" 90) to:wf;
  format "//* %\n" (FileName file) to:wf;
  format "//%\n\n" (MakeStr "*" 90) to:wf;
  format "#declare names=array[%] %;\n\n" names.count (POVFormat names) to:wf;
  for i=1 to ents.count do (local ent=ents[i]; --ent in ents
   if(classOf(ent)==SplineShape) then (
    plist=GetPlists(ent)[1];
    format "#declare plist%=array[%] %;\n" (zero2 i 2) plist.count (POVFormat plist) to:wf;
    ExportPOV (folder+ent.name+".inc") plist;
   )
  )
  flush(wf); close(wf);
--notepad(file);
 )

 --Export Mesh
 --(ExportMeshPOV "C:/Scenario/WireWorks3D/POV-Ray/Mesh.inc" (GetMesh $));
 global ExportMeshPOV; fn ExportMeshPOV file mesh1=(
  local nodes=mesh1[1], elems=mesh1[2]; local quads=#();
  for i=1 to elems.count do ( --separate elements into triangles & quads
   local elem=elems[i]; local n=elem.count; local quad=[0,0,0,0];
-- if(n>4) then print2("Warning: irregular element encountered: "+itoa(n)+" vertices");
   for j=1 to 4 do (if(j<=n) then quad[j]=elem[j]; else quad[j]=-1;)
   (append quads quad);
  )
  local wf=(openFile file mode:"w");
  format "//%\n" (MakeStr "*" 90) to:wf;
  format "//* %\n" (FileName file) to:wf;
  format "//%\n\n" (MakeStr "*" 90) to:wf;
  format "#declare nodes=array[%] %;\n\n" nodes.count (POVFormat nodes) to:wf;
  format "#declare elems=array[%] %;\n\n" quads.count (POVFormat quads) to:wf;
  flush(wf); close(wf);
--notepad(file);
 )
 --ExportMeshsPOV("C:/Scenario/Models/Tree Faces/POV-Ray/" (ToArray $));
 global ExportMeshsPOV; fn ExportMeshsPOV folder ents=(
  for ent in ents do (ExportMeshPOV (folder+ent.name+".inc") (GetMesh ent));
 )

--******************************************************************************************
--* AutoLisp Files
--******************************************************************************************

 --file="C:/Scenario/WireWorks3D/Test.lsp"; ExportLisp file plist; notepad(file);
 global LispFormat; fn LispFormat x=(local t1=classOf(x);
  case of(
-- (IsNumber(x)): return MaxFormat(x);
-- (t1==String): return MaxFormat(x);
   (t1==Array): (local str="(list ";
    for x1 in x do str=(str+LispFormat(x1)+" ");
    if(x.count==0) then str=str+")"; else str[str.count]=")";
    return str;
   )
   (IsList(x) or t1==Color): (
    if(t1==Color) then x=ToArray(x);
    local n=length2(x); local str="(list ";
    for i=1 to n-1 do str=(str+LispFormat(x[i])+" ");
    str=str+LispFormat(x[n])+")";
    return str;
   )
   (t1==BooleanClass): return (if_ x "T" "nil");
   (t1==UndefinedClass): return "nil";
   default: return MaxFormat(x);
  )
 )
 global ExportLisp; fn ExportLisp file x=(local wf=(openFile file mode:"w");
  format "%" (LispFormat x) to:wf;
  flush(wf); close(wf);
--notepad(file);
 )

--******************************************************************************************
--* Mathematica
--******************************************************************************************

 global MathematicaFormat; fn MathematicaFormat x=(local t1=classOf(x);
  case of(
-- (IsNumber(x)): return MaxFormat(x);
-- (t1==String): return MaxFormat(x);
   (t1==Array): (local str="{";
    for x1 in x do str=(str+MathematicaFormat(x1)+",");
    if(x.count==0) then str=str+"}"; else str[str.count]="}";
    return str;
   )
   (t1==BigMatrix): (local ni=x.rows; local nj=x.columns; local str="{"; --I added this to avoid the inefficiencies of length2(BigMatrixRowArray)
    for i=1 to ni-1 do (local xlist=x[i]; str=str+"{";
     for j=1 to nj do str=str+MaxFormat(xlist[j])+",";
     str[str.count]="}";
     str=str+",";
    )
    xlist=x[ni]; str=str+"{";
    for j=1 to nj do str=str+MaxFormat(xlist[j])+",";
    str[str.count]="}";
    return str+"}";
   )
   (IsList(x) or t1==Color): (
    if(t1==Color) then x=ToArray(x);
    local n=length2(x); local str="{";
    for i=1 to n-1 do str=(str+MathematicaFormat(x[i])+",");
    str=str+MathematicaFormat(x[n])+"}";
    return str;
   )
   (t1==BooleanClass): return (if_ x "True" "False");
   (t1==UndefinedClass): return "Null";
   default: return MaxFormat(x);
  )
 )
 global QView; fn QView x=( --MathematicaView
  local file=sysInfo.tempdir+"Temp.txt"; --(if_ home "C:/Scenario/WireWorks3D/Temp.txt" "U:/WireWorks3D/Temp.txt");
  local wf=(openFile file mode:"w");
  format "%" (MathematicaFormat x) to:wf;
  flush(wf); close(wf); notepad(file);
 )

--******************************************************************************************
--* Parametric Functions
--******************************************************************************************

 --Weierstrass' Surface
 --(PlotWeierstrass 10 5);
 --(PlotWeierstrass 100 50); --25 hrs
 global PlotWeierstrass; fn PlotWeierstrass n nplot=(
  for i=1 to nplot do (local x1=(i-1.0)/nplot, x2=float(i)/nplot;
   for j=1 to nplot do (local a1=(AveW ((j-1.0)/nplot) 2.0 3.0), a2=(AveW (float(j)/nplot) 2.0 3.0);
    print2(MaxFormat(100*(i-1.0+(j-1.0)/nplot)/nplot)+"% complete (section: "+itoa(i)+","+itoa(j)+")");
    (ParametricPlot3D Weierstrass x1 x2 (1.0/(n*nplot)) a1 a2 (1.0/(n*nplot)));
   )
  )
 )
 --100: 36.1094 s, 650: 25 min, 1000: 1 hr, 2500: 6 hrs, 5000: 25 hrs (50,000,000 triangles)
 --(ParametricPlot3D Weierstrass 0.0 1.0 (1.0/5000) 2.0 3.0 (1.0/5000));
 global Weierstrass; fn Weierstrass x a=(local z=0.0;
  for k=1 to 50 do (local b=pi*k^a; z+=sin2(b*x)/b;)
  return [x,a,z]; --(z-z1)/(z2-z1)
 )

 --Boy's Surface
 --(ParametricPlot3D BoysSurface 1e-6 1.0 ((1.0-1e-6)/20) -pi pi (2*pi/90));
 global BoysSurface; fn BoysSurface r theta=(local z=r*CExp(complexI*theta);
  local a=(CPow z 6.0)+sqrt(5.0)*(CPow z 3.0)-[1.0,0.0];
  local m=[im(CDiv ((CPow z 5.0)-z) a), re(CDiv ((CPow z 5.0)+z) a), im(CDiv ((CPow z 6.0)+[1.0,0.0]) (1.5*a))+0.5];
  return m/norm(m);
 )

--******************************************************************************************

 global userlog; fn userlog str=(
  local file="U:/WireWorks3D/3DS Max/User Log.txt"; --"C:/Scenario/WireWorks3D/User Log.txt";
  local af=(openFile file mode:"a");
  if(IsDefined(af)) then (
   local t1=timeStamp();
   local hour=t1/(24*60*1000); --0<=hour<24
   local minute=t1/(60*1000)-24*hour;
   local sec=int(round (t1/1000.0) 1.0)-60*(24*hour+minute);
   (format "%\t%\t%\t%\n" sysInfo.username "" (itoa(int(mod (hour-1) 12)+1)+":"+(zero2 minute 2)+":"+(zero2 sec 2)+" "+(if_ (hour<12) "am" "pm")) str to:af); --getdate(s)
   flush(af); close(af);
  )
 )
 userlog("Load WireWorks3D MaxScript.");

)
