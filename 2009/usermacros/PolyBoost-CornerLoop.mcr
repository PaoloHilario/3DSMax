macroScript CornerLoop
category: "PolyBoost"
tooltip: "CornerLoop"
icon:#("PB_Icons2", 23)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildCornerLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
