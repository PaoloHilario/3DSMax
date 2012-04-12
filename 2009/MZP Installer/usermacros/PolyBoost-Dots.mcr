macroScript Dots
category: "PolyBoost"
tooltip: "Dots"
icon:#("PB_Icons2", 10)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternDots $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
