macroScript PolyDraw_Move_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Move_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.Movetoolini 3
	)
)
