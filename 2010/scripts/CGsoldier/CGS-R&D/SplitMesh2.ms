global splitmesh2; 
fn splitmesh2 = 
	(
	$.split = on
	polyop.slice $ ($.faces) (ray $.center [0,0,1])
	$.SetSelection #Face #{1}
	$.SelectElement()
	polyop.detachFaces $ ($.GetSelection #face) asNode:true
	)
