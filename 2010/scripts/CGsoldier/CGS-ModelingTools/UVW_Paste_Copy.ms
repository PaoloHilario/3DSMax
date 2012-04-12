(
if ( F360Lib_Copy_Mapping == undefined  ) then
( format "No Mapping in copy buffer\n"  )
else
(
if ( F360Lib_Copy_Mapping.count == 0  ) then
( format "No Mapping in copy buffer\n"  )
else
(
SS = getCurrentSelection()
if SS.count == 0 then
	( messageBox  "Nothing Selected"  )
else
	(
	for i=1 to SS.count do
	(
	f360Lib.Paste_UVW_Mapping_Copy SS[i]
	)
	format "Paste % UVW's\n" F360Lib_Copy_Mapping.count	
	)
)
)
)