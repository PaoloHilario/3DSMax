macroScript Quickclone
category: "PolyBoost"
tooltip: "Quickclone"
icon:#("PB_Icons3", 26)
(
on isEnabled return (selection.count == 1)
on execute do
	(
	if keyboard.altpressed do PolyBoost.Clonefunc()
	PolyBoost.Clonefunc()
	)
)
