macroScript UV_Stitch
category: "PolyBoost"
tooltip: "UV Stitch"
icon:#("PB_Icons4", 26)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do 
	(
	PolyBoost.UV_stitch()
	)
)
