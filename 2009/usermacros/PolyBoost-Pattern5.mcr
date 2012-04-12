macroScript Pattern5
category: "PolyBoost"
tooltip: "Pattern5"
icon:#("PB_Icons2", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern5 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
