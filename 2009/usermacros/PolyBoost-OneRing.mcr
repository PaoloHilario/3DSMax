macroScript OneRing
category: "PolyBoost"
tooltip: "OneRing"
icon:#("PB_Icons2", 9)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternOnering $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
