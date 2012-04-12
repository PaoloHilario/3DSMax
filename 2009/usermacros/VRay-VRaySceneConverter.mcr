macroScript VRaySceneConverter category:"VRay" buttontext:"V-Ray scene converter" tooltip:"Convert all scene materials to VRayMtl and all raytraced shadows to VRay shadows" (
	local res=queryBox "All scene materials and raytraced shadows will be converted to VRay materials and shadows. Are you sure?" title:"VRay scene converter"
	if res then convertToVRay()
)
