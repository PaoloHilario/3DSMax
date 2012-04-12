macroScript odd
category: "PolyBoost"
tooltip: "Odd"
icon:#("PB_Icons2", 15)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBEvenOdd $ 1 1 keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
