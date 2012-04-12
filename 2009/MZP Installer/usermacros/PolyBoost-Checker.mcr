macroScript Checker
category: "PolyBoost"
tooltip: "Checker"
icon:#("PB_Icons2", 8)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternChecker $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
