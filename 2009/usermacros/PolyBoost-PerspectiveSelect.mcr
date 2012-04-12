macroScript PerspectiveSelect
category: "PolyBoost"
tooltip: "PerspectiveSelect"
icon:#("PB_Icons2", 16)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	if subobjectlevel == 2 or subobjectlevel == 3 then
		(
		PolyBPerspectiveSelect $ 30.0 (Inverse(getViewTM())).row3 true keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
		)
	else PolyBPerspectiveSelect $ 30.0 (Inverse(getViewTM())).row3 false keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
