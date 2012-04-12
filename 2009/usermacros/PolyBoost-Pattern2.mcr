macroScript Pattern2
category: "PolyBoost"
tooltip: "Pattern2"
icon:#("PB_Icons1", 26)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern2 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
