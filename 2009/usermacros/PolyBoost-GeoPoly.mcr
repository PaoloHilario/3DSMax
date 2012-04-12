macroScript GeoPoly
category: "PolyBoost"
tooltip: "GeoPoly"
icon:#("PB_Icons5", 12)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do (if subobjectlevel == 4 do PolyBGeoPoly $ (PolyBoost.isEP()) (modpanel.getcurrentobject()))
)
