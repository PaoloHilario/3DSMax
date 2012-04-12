macroScript outline
category: "PolyBoost"
tooltip: "Outline"
icon:#("PB_Icons1", 27)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBOutline $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
