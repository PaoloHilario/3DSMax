macroScript FlowConnect
category: "PolyBoost"
tooltip: "FlowConnect"
icon:#("PB_Icons3", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Flowfunc true
)
