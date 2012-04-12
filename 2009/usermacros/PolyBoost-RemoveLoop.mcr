macroScript RemoveLoop
category: "PolyBoost"
tooltip: "RemoveLoop"
icon:#("PB_Icons1", 17)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBRemoveLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
)
