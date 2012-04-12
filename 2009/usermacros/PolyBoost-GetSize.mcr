macroScript GetSize
category: "PolyBoost"
tooltip: "GetSize"
icon:#("PB_Icons3", 20)
(
on isEnabled return (selection.count == 1)
on execute do PolyBoost.GetSizefunc()
)
