macroScript UV_SpaceVertical
category: "PolyBoost"
tooltip: "UV SpaceVertical"
icon:#("PB_Icons3", 16)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do 
	(
	PolyBoost.UV_Space 1
	)
)
