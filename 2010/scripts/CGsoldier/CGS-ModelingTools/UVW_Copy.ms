(
SS = getCurrentSelection()
try
(
if SS.count == 0 then
	( messageBox  "Nothing Selected"  )
else
	(
	if ( SS.count == 1 ) then
	(
	f360Lib.Copy_UVW_Mapping SS[1]
	format "Copy % UVW's\n" Copy_Mapping.count	
	)
	else
	( messageBox  "More than one object selected"  )
)
)
catch()
)