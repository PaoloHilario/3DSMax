macroScript GrowLine
category: "PolyBoost"
tooltip: "GrowLine"
icon:#("PB_Icons2", 7)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternGrowline $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
