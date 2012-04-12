macroScript UVhorizontal
category: "PolyBoost"
tooltip: "UVhorizontal"
icon:#("PB_Icons5", 11)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_Lineup 2
)
