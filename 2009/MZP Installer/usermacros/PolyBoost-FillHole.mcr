macroScript FillHole
category: "PolyBoost"
tooltip: "FillHole"
icon:#("PB_Icons3", 1)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBSelectFillHole $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
