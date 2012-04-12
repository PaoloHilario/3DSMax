macroScript ResetXForm
category: "PolyBoost"
tooltip: "ResetXForm"
icon:#("PB_Icons3", 19)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do PolyBoost.Resetxfunc $
)
