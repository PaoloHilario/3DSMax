(

FileIn "$userscripts\\CGsoldier\\functions\\F360Lib_Functions.mse"	

SS = getCurrentSelection()
disablesceneredraw()
try
(
if SS.count == 0 then
	( messageBox  "Nothing Selected"  )
else
	(
	for i=1 to SS.count do
		(
		Cobj=SS[i]
		if ( iskindof Cobj.baseobject  Editable_mesh ) then
			(
			f360Lib.Copy_UVW_Mapping SS[i]
			convertto Cobj Editable_mesh
			f360Lib.Paste_UVW_Mapping_Copy SS[i]
			)
		if ( iskindof Cobj.baseobject  Editable_poly ) then
			(
			f360Lib.Copy_UVW_Mapping SS[i]
			convertto Cobj Editable_poly
			f360Lib.Paste_UVW_Mapping_Copy SS[i]
			)
		)
	)
)
catch ( 	enablesceneredraw() ; redrawViews() )
max modify mode
enablesceneredraw() 
redrawViews() 
)

