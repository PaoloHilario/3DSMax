macroScript Pattern1
category: "PolyBoost"
tooltip: "Pattern1"
icon:#("PB_Icons1", 25)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern1 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
