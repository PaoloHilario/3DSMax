macroScript PolyDraw_Build_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Build_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BuildModel 3
	)
)
