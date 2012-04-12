macroScript fill
category: "PolyBoost"
tooltip: "Fill"
icon:#("PB_Icons2", 26)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBSelectFill $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
