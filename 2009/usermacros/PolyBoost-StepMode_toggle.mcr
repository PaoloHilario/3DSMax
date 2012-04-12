macroScript StepMode_toggle
category: "PolyBoost"
tooltip: "StepMode_toggle"
icon:#("PB_Icons2", 19)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Stepfunc()
)
