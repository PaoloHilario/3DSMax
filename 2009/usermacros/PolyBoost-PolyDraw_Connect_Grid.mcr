macroScript PolyDraw_Connect_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = false
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 1
	)
)
