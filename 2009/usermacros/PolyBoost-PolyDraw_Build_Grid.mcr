macroScript PolyDraw_Build_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Build_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BuildModel 1
	)
)
