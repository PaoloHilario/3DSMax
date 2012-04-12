macroScript UV_GrowLoop
category: "PolyBoost"
tooltip: "UV_GrowLoop"
icon:#("PB_Icons3", 11)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_GLoopfunc()
)
