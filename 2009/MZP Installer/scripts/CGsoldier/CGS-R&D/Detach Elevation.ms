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
	