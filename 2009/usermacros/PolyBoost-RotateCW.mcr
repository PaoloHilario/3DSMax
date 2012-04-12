macroScript RotateCW
category: "PolyBoost"
tooltip: "RotateCW"
icon:#("PB_Icons3", 17)
(
on isEnabled return (selection.count == 1)
on execute do 
	(
	if keyboard.shiftpressed then PolyBoost.SmartRotate 30
	else PolyBoost.SmartRotate 90
	)
)
