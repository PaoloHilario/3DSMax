macroScript Relax_Loops
category: "PolyBoost"
tooltip: "Relax Loops"
icon:#("PB_Icons4", 31)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBRelaxLoop $ keyboard.shiftpressed false (PolyBoost.isEP()) cursel
		)
	)
)
