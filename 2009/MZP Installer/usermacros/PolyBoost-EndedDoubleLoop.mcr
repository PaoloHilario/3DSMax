macroScript EndedDoubleLoop
category: "PolyBoost"
tooltip: "EndedDoubleLoop"
icon:#("PB_Icons2", 24)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildEndLoops $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
