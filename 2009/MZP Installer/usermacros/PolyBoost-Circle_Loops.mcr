macroScript Circle_Loops
category: "PolyBoost"
tooltip: "Circle Loops"
icon:#("PB_Icons4", 29)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBCircleLoop $ keyboard.shiftpressed false (PolyBoost.isEP()) cursel
		)
	)
)
