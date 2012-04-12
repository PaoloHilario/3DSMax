macroScript PolyDraw_SwiftLoop_Grid
category: "PolyBoost"
tooltip: "PolyDraw_SwiftLoop_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PBPlacego 1
	)
)
