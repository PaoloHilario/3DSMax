macroScript paste
category: "PolyBoost"
tooltip: "Paste"
icon:#("PB_Icons2", 12)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Pastefunc()
)
