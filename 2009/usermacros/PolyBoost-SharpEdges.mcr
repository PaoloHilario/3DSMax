macroScript SharpEdges
category: "PolyBoost"
tooltip: "SharpEdges"
icon:#("PB_Icons1", 9)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	if subobjectLevel == 2 do PolyBGetHardEdges $ (keyboard.shiftpressed) (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
