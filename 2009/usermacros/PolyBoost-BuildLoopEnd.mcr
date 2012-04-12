macroScript BuildLoopEnd
category: "PolyBoost"
tooltip: "BuildLoopEnd"
icon:#("PB_Icons2", 21)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildEnd $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
