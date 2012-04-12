(
	if $ != undefined then
	(
	for obj in $ do
		(
		for x=1 to obj.modifiers.count do
		deletemodifier obj 1
		)
	messagebox "All Modifiers Removed From Selected Objects" title:"Kill All Modifiers"
	)
	else
		(
		messagebox "No Objects Selected" title:"Kill All Modifiers"
		)
)

	
