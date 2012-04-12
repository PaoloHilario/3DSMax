macroScript DistanceConnect
category: "PolyBoost"
tooltip: "DistanceConnect"
icon:#("PB_Icons2", 25)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBDistanceConnect $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
