(
objset = getcurrentselection()
for obj in objset do
	(
	if superclassof obj == GeometryClass do
		(
		select obj
		macros.run "Modifier Stack" "Convert_to_Mesh"
		subobjectLevel = 2
		select obj.edges
		actionMan.executeAction 951718758 "40036" -- Autoedge Command
		macros.run "Modifier Stack" "Convert_to_Poly"
		)
	)
ProgressEnd()
)	
	
