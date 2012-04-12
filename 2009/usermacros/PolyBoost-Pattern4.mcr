macroScript Pattern4
category: "PolyBoost"
tooltip: "Pattern4"
icon:#("PB_Icons2", 2)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern4 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
