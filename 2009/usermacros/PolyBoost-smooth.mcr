macroScript smooth
category: "PolyBoost"
tooltip: "Smooth"
icon:#("PB_Icons1", 18)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Smoothfunc()
)
