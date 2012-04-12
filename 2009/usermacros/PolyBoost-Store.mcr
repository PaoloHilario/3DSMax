macroScript Store
category: "PolyBoost"
tooltip: "Store"
icon:#("PB_Icons2", 11)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Storefunc()
)
