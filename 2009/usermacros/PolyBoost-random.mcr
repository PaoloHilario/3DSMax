macroScript random
category: "PolyBoost"
tooltip: "Random"
icon:#("PB_Icons1", 21)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRandomSelect $ 25.0 0 1 keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
