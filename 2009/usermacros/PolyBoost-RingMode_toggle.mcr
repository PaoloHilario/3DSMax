macroScript RingMode_toggle
category: "PolyBoost"
tooltip: "RingMode_toggle"
icon:#("PB_Icons2", 18)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.ModeLoopRing 2
)
