macroScript LoopMode_toggle
category: "PolyBoost"
tooltip: "LoopMode_toggle"
icon:#("PB_Icons2", 17)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.ModeLoopRing 1
)
