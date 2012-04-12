macroScript ClothGrow
category: "PolyBoost"
tooltip: "ClothGrow"
icon:#("PB_Icons5", 23)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothGrowShrink 1
)
