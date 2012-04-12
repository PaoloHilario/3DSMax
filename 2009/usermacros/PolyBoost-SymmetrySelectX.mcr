macroScript SymmetrySelectX
category: "PolyBoost"
tooltip: "SymmetrySelectX"
icon:#("PB_Icons3", 27)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBSymmetrySelect $ 0 (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
