macroScript Straighten_Loops
category: "PolyBoost"
tooltip: "Straighten Loops"
icon:#("PB_Icons4", 30)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBStraightLoop $ keyboard.shiftpressed false false (PolyBoost.isEP()) cursel
		)
	)
)
