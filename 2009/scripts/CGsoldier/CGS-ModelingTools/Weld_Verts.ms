allverts=#{}
fn weldverts =
	(
	for obj in selection do
	if classof obj == Editable_mesh or classof obj == Editable_Poly do  
		(
		allverts = obj.selectedverts = obj.verts
		case of
			(              
			(classof obj == Editable_Poly) :
				(
				obj.weldThreshold = 0.1
				polyop.weldvertsbythreshold obj allverts
				)              
			(classof obj == Editable_mesh) : 
				(
				meshop.weldvertsbythreshold obj allverts 0.1
				)
			default : ()
			)              
		)
	)
weldverts()
