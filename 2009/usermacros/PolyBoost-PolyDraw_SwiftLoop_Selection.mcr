macroScript PolyDraw_SwiftLoop_Selection
category: "PolyBoost"
tooltip: "PolyDraw_SwiftLoop_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PBPlacego 3
	)
)
