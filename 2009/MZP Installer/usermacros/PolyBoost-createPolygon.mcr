macroScript createPolygon
category: "PolyBoost"
tooltip: "CreatePolygon"
icon:#("PB_Icons5", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.CreatePolygon()
)
