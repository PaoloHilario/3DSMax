macroScript Curve_Loops
category: "PolyBoost"
tooltip: "Curve Loops"
icon:#("PB_Icons4", 27)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBCurveLoop $ keyboard.shiftpressed false true (PolyBoost.isEP()) cursel
		)
	)
)
