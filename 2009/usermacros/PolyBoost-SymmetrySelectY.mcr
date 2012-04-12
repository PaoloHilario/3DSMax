macroScript SymmetrySelectY
category: "PolyBoost"
tooltip: "SymmetrySelectY"
icon:#("PB_Icons3", 28)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBSymmetrySelect $ 1 (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
