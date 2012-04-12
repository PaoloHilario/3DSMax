macroScript PolyDraw_Optimizer_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Optimizer_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.OptiModel 2
	)
)
