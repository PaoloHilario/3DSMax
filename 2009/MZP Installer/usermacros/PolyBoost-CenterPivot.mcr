macroScript CenterPivot
category: "PolyBoost"
tooltip: "CenterPivot"
icon:#("PB_Icons3", 22)
(
on isEnabled return (selection.count != 0)
on execute do (for i in selection do i.pivot = i.center)
)
