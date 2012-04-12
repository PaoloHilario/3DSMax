macroScript InsertVert_1
category: "PolyBoost"
tooltip: "InsertVert_1"
icon:#("PB_Icons5", 8)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBInsertVert $ 1 (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
