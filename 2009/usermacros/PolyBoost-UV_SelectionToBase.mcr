macroScript UV_SelectionToBase
category: "PolyBoost"
tooltip: "UV_SelectionToBase"
icon:#("PB_Icons3", 7)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_ToBasefunc()
)
