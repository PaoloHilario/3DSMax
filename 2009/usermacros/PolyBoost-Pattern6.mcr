macroScript Pattern6
category: "PolyBoost"
tooltip: "Pattern6"
icon:#("PB_Icons2", 4)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern6 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)
