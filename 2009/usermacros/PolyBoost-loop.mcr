macroScript loop
category: "PolyBoost"
tooltip: "Loop"
icon:#("PB_Icons1", 2)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
