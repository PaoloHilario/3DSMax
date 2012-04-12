macroScript PolyDraw_Border_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Border_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BorderTool 1
	)
)
