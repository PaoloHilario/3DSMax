macroScript UV_ShrinkLoop
category: "PolyBoost"
tooltip: "UV_ShrinkLoop"
icon:#("PB_Icons3", 12)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_ShLoopfunc()
)
