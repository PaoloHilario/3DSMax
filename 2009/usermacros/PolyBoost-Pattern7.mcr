macroScript Pattern7
category: "PolyBoost"
tooltip: "Pattern7"
icon:#("PB_Icons2", 5)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern7 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
