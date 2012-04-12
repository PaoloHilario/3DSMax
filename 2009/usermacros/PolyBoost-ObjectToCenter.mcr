macroScript ObjectToCenter
category: "PolyBoost"
tooltip: "ObjectToCenter"
icon:#("PB_Icons3", 24)
(
on isEnabled return (selection.count != 0)
on execute do (for i in selection do i.pos = [0,0,0])
)
