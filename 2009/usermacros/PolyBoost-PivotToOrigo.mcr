macroScript PivotToOrigo
category: "PolyBoost"
tooltip: "PivotToOrigo"
icon:#("PB_Icons3", 23)
(
on isEnabled return (selection.count != 0)
on execute do (for i in selection do i.pivot = [0,0,0])
)
