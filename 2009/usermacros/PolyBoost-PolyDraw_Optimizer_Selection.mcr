macroScript PolyDraw_Optimizer_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Optimizer_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.OptiModel 3
	)
)
