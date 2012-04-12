macroScript Pattern8
category: "PolyBoost"
tooltip: "Pattern8"
icon:#("PB_Icons2", 6)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern8 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
