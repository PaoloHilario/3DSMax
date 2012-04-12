macroScript PolyDraw_Connect_Selection_SetFlow
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Selection_SetFlow"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = true
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 3
	)
)
