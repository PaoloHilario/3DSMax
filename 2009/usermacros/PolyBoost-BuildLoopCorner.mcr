macroScript BuildLoopCorner
category: "PolyBoost"
tooltip: "BuildLoopCorner"
icon:#("PB_Icons2", 22)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildCorner $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
