macroScript Pattern3
category: "PolyBoost"
tooltip: "Pattern3"
icon:#("PB_Icons2", 1)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern3 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
