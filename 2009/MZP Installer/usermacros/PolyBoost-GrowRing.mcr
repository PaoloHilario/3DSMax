macroScript GrowRing
category: "PolyBoost"
tooltip: "GrowRing"
icon:#("PB_Icons1", 5)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBGrowShrinkRing $ keyboard.altpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
