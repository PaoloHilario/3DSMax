macroScript Ox_Add_Hair category:"Ornatrix" tooltip:"Ox Add Hair"
(
	if($ != undefined) then
	(
		maxOps.CloneNodes selection offset:[0,0,0] expandHierarchy:false cloneType:#reference newNodes:&newNode
		
		for i=1 to selection.count do (
			newNode[i].parent = selection[i]
		
			if((SuperClassOf selection[i]) == GeometryClass) then (
				addModifier newNode[i] (Ox_Guides_from_Surface())
				addModifier newNode[i] (Ox_Edit_Guides())
				addModifier newNode[i] (Ox_Hair_From_Guides())
			)
			
			if((SuperClassOf selection[i]) == Shape) then (
				addModifier newNode[i] (Ox_Guides_On_Spline())
				addModifier newNode[i] (Ox_Edit_Guides())
			)
		)
			
		select newNode
	)
)
