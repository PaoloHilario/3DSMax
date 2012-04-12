macroScript PolyDraw_SwiftLoop_Surface
category: "PolyBoost"
tooltip: "PolyDraw_SwiftLoop_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PBPlacego 2
	)
)
