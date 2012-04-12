macroScript StepLoop
category: "PolyBoost"
tooltip: "StepLoop"
icon:#("PB_Icons1", 22)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBStepLoop $ keyboard.shiftpressed keyboard.altpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
