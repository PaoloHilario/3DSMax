macroScript even
category: "PolyBoost"
tooltip: "Even"
icon:#("PB_Icons2", 14)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBEvenOdd $ 0 1 keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
