global detach_elev;
fn detach_elev delta =
	(
	local plist = #()
	for i = 1 to (polyop.getnumverts $) do
		(
		p = polyop.getVert $ i 
		if p.z <= (delta-1) then append plist i 
		)
	polyop.detachFaces $ (polyop.getFacesUsingVert $ plist) asNode:True delete:true 
	)

global Slicer2;
fn Slicer2 delta = 
	(
	obj = $
	minZ = obj.min.z
	maxZ = obj.max.z
	obj.split = on
--	disablesceneredraw()
	for currentZ = minZ to maxZ by delta do
		(
		obj.split = on
		obj.slice [0,0,1] [0,0,currentz]
		detach_elev currentz
		redrawViews()
		)
--	enablesceneredraw()
	)