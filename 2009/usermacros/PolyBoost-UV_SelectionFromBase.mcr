macroScript UV_SelectionFromBase
category: "PolyBoost"
tooltip: "UV_SelectionFromBase"
icon:#("PB_Icons3", 8)
(
on isEnabled return PolyBoost.validUVobj2func()
on execute do PolyBoost.UV_ToUvfunc()
)
