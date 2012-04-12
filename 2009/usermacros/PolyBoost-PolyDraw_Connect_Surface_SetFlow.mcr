macroScript PolyDraw_Connect_Surface_SetFlow
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Surface_SetFlow"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = true
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 2
	)
)
