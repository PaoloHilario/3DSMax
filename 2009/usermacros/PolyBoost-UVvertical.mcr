macroScript UVvertical
category: "PolyBoost"
tooltip: "UVvertical"
icon:#("PB_Icons5", 10)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_Lineup 1
)
