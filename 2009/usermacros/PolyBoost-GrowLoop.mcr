macroScript GrowLoop
category: "PolyBoost"
tooltip: "Growloop"
icon:#("PB_Icons1", 4)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBGrowLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
