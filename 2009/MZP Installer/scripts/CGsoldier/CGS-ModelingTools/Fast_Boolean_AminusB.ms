fn PickFilterGeometry SelObj = ((SuperClassof SelObj == GeometryClass))

--on execute do 
(
local ObjIsPoly=false

FileIn "$userscripts\\CGsoldier\\functions\\F360Lib_Functions.mse"

If ( SuperClassof $ != GeometryClass ) then
	(
	MessageBox "Please Select one object to Boolean from...." Title:"Boolean"
	)
else 
	(
	if ( selection.count == 1) then
		(	
		SelObj = Selection[1]
		f360Lib.Copy_UVW_Mapping SelObj
		if ( iskindof SelObj.baseobject editable_poly ) then ObjIsPoly=true
		
		BoolShape = pickobject Prompt:"Please Select Object to Boolean" message:"Please Select Object to Boolean" filter:PickFilterGeometry
		
		if ( isValidNode BoolShape ) then
		(
		max create mode
	 	boolObj.createBooleanObject SelObj boolshape 4 5
		boolObj.setBoolOp SelObj 3
		if (ObjIsPoly) then ( convertto SelObj editable_poly ) 
			else ( convertto SelObj editable_mesh )
		max Modify Mode
		f360Lib.Paste_UVW_Mapping_Copy SelObj
		)
		)
	else
		( MessageBox "Please Select one object to Boolean from...." Title:"Boolean" )	
	)
)
--on isEnabled return (not (SuperClassof $ != GeometryClass))
