macroScript PolyDraw_Connect_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = false
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 2
	)
)
