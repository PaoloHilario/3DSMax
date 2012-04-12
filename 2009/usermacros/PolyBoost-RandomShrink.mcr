macroScript RandomShrink
category: "PolyBoost"
tooltip: "RandomShrink"
icon:#("PB_Icons1", 24)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRandomGrowShrink $ false (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
