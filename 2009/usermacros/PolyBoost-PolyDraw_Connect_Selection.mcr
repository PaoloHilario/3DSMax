macroScript PolyDraw_Connect_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = false
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 3
	)
)
