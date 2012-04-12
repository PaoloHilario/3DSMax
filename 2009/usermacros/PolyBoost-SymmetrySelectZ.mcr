macroScript SymmetrySelectZ
category: "PolyBoost"
tooltip: "SymmetrySelectZ"
icon:#("PB_Icons3", 29)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBSymmetrySelect $ 2 (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
