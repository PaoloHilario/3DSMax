macroScript InsertVert_2
category: "PolyBoost"
tooltip: "InsertVert_2"
icon:#("PB_Icons5", 9)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBInsertVert $ 2 (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
