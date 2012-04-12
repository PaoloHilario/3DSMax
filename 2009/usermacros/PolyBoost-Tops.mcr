macroScript Tops
category: "PolyBoost"
tooltip: "Tops"
icon:#("PB_Icons1", 7)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBSelectTops $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
