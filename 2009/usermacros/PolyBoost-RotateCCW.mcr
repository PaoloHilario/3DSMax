macroScript RotateCCW
category: "PolyBoost"
tooltip: "RotateCCW"
icon:#("PB_Icons3", 18)
(
on isEnabled return (selection.count == 1)
on execute do
	(
	if keyboard.shiftpressed then PolyBoost.SmartRotate -30
	else PolyBoost.SmartRotate -90
	)
)
