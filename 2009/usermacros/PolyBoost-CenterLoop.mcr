macroScript CenterLoop
category: "PolyBoost"
tooltip: "CenterLoop"
icon:#("PB_Icons5", 13)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBCenterLoop $ true (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
