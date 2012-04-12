macroScript Ring
category: "PolyBoost"
tooltip: "Ring"
icon:#("PB_Icons1", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRing $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
