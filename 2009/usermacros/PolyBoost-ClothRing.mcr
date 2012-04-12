macroScript ClothRing
category: "PolyBoost"
tooltip: "ClothRing"
icon:#("PB_Icons5", 26)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothLoopRing 2
)
