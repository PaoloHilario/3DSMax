macroScript RandomGrow
category: "PolyBoost"
tooltip: "RandomGrow"
icon:#("PB_Icons1", 23)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRandomGrowShrink $ true (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
