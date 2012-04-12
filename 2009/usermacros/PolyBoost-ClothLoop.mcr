macroScript ClothLoop
category: "PolyBoost"
tooltip: "ClothLoop"
icon:#("PB_Icons5", 25)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothLoopRing 1
)
