macroScript DottedLoop
category: "PolyBoost"
tooltip: "DottedLoop"
icon:#("PB_Icons2", 20)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBDotLoop $ 1 keyboard.shiftpressed keyboard.altpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
