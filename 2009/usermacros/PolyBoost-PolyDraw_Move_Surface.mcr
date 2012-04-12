macroScript PolyDraw_Move_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Move_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.Movetoolini 2
	)
)
