macroScript PolyDraw_Move_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Move_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.Movetoolini 1
	)
)
