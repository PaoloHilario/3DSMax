macroScript PaintConnect_toggle
category: "PolyBoost"
tooltip: "PaintConnect_toggle"
icon:#("PB_Icons3", 5)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.PaintCgofunc()
)
