macroScript ClothShrink
category: "PolyBoost"
tooltip: "ClothShrink"
icon:#("PB_Icons5", 24)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothGrowShrink 2
)
