--******************************************************************************************
--* Object Properties -> Custom File Properties
--******************************************************************************************

--FileIn("C:/Scenario/WireWorks3D/3DS Max/Library.ms");
--FileIn("C:/Scenario/IPDS/MaxScript Object Properties/ObjectProperties.ms");

 --Basic Functions, common Library.ms
 fn if_ test x1 x2=(if(test) then return x1; else return x2;) --merge
 fn round x dx=(dx*floor(x/dx+0.5);)
 fn IsDefined x=(classOf(x)!=UndefinedClass;)
 fn IsString x=(classOf(x)==String;)
 fn rtos x1 n=(local x2=(mod (abs x1) 1);
  local i1=int(x1);
  local str=(if_ (i1==0 and x1<0.0) "-" "")+(i1 as string)+".";
  for i=1 to n do (x2=10*(mod x2 1);
   if(i==n) then x2=(round x2 1); --round the last number
   str+=((int x2) as string);
  )
  return str;
 )
 fn ObjectFormat x=(local t1=classOf(x); local str;
  case of(
   (t1==Float or t1==Double): return (rtos x 12);
   (t1==String): return x;
   default: return x as string;
  )
 )

 --timer2(); SaveHeaderObjects(); timer2();
 --V:/Projects/8001 CHOC Hospital/MODELING/0000_PATIENT_ROOMS_IPDS01.max: 203 ms
 global SaveHeaderObjects; fn SaveHeaderObjects=(
  local props=#("Type","Scene","Element","Description","Material","Mat_Density","Mat_Units","Mat_Finish","Design_Duration(Days)","Engineering_Duration(Days)","Fabrication_Duration(Days)","Shipping_Duration(Days)","Installation_Duration(Days)","Vendor","Vendor_Part","Vendor_Units","Vendor_Price","LinearMeasurement","SurfaceArea","Weight","Volume","OverallDimensions");
  local ObjectProperties=""; --#();
  for ent in objects do (local t1="";
   for i=1 to props.count do (local prop=props[i], x=(getUserProp ent prop);
    if(IsDefined(x)) then ( --(if_ (n==0) ":" ",")
     t1+=","+prop+"="+ObjectFormat(x);
--   if(IsString(x)) then t1+=","+prop+"="+x; else t1+=","+prop+"="+MaxFormat(x);
    )
   )
   if(t1!="") then ObjectProperties+=ent.name+t1+";";
  )
  (fileProperties.deleteProperty #custom "ObjectProperties");
  (fileProperties.addProperty #custom "ObjectProperties" ObjectProperties);
 )

 --needs work (not used)
 --props=GetHeaderObjects();
 global GetHeaderObjects; fn GetHeaderObjects=(
  local i=(fileProperties.findProperty #custom "ObjectProperties");
  if(i==0) then return #() else (
   local props=(tokenize ";" (fileProperties.getPropertyValue #custom i)); --needs work
   return props;
  )
 )

(callbacks.addScript #filePreSave "SaveHeaderObjects()" persistent:false); --ID:SaveHeaderObjects
