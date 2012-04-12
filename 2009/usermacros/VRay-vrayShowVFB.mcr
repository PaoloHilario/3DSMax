macroScript vrayShowVFB category:"VRay" buttontext:"V-Ray VFB" tooltip:"Displays the last rendered V-Ray VFB, if is exists" (
	r=renderers.current
	cls=r.classid
	if (cls[1]==1941615238 and cls[2]==2012806412) then r.showLastVFB()
)
