macroScript SetFlow
category: "PolyBoost"
tooltip: "SetFlow"
icon:#("PB_Icons5", 14)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		if subobjectlevel == 2 then PolyBSetFlow $ false keyboard.shiftpressed (PolyBoost.isEP()) cursel
		else if subobjectlevel == 1 do PolyBSetFlowVertex $ (PolyBoost.isEP()) cursel
		)
	)
)
