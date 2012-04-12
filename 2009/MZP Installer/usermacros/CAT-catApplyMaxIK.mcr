macroScript catApplyMaxIK
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Apply a Max IK chain to a CAT bone hierarchy" 
            buttontext:"Apply Max IK" 
            Icon:#("CAT",1)
(
   on execute do rApplyIKChain.openDialog()
)
