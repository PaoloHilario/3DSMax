macroScript Space_Loops
category: "PolyBoost"
tooltip: "Space Loops"
icon:#("PB_Icons4", 28)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBSpaceLoop $ keyboard.shiftpressed false (PolyBoost.isEP()) cursel
		)
	)
)
