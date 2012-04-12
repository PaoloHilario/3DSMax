macroScript SpinEdge
category: "PolyBoost"
tooltip: "SpinEdge"
icon:#("PB_Icons5", 2)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBSpinEdge $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
