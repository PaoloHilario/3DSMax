macroScript PolyDraw_Build_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Build_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BuildModel 2
	)
)
