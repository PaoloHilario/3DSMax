macroScript PolyDraw_Border_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Border_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BorderTool 2
	)
)
