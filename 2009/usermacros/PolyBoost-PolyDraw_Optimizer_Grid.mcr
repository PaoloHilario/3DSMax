macroScript PolyDraw_Optimizer_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Optimizer_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.OptiModel 1
	)
)
