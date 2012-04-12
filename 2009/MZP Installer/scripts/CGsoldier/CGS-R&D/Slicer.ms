global Slicer;
fn Slicer delta = 
	(
	meshSelected = $
	minZ = meshSelected.min.z
	maxZ = meshSelected.max.z
	disablesceneredraw()
	for currentZ = minZ to maxZ by delta do
		(
		modPanel.addModToSelection (SliceModifier ()) ui:on
		$.modifiers[#Slice].Slice_Type = 1
		$.modifiers[#Slice].slice_plane.position = [0,0,currentZ]
		collapseStack $
		)
	enablesceneredraw()
	)