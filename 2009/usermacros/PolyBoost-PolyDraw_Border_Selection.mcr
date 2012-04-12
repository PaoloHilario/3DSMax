macroScript PolyDraw_Border_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Border_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BorderTool 3
	)
)
