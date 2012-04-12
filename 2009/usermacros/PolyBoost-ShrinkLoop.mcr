macroScript ShrinkLoop
category: "PolyBoost"
tooltip: "ShrinkLoop"
icon:#("PB_Icons1", 6)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBShrinkLoop $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
