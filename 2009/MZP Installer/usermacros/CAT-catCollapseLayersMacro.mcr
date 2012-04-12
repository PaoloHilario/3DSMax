macroScript catCollapseLayersMacro
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Collapse Layers" 
            buttontext:"Collapse Layers" 
            Icon:#("CAT",6)
(
	on execute do (	
	   	if selection.count != 1 then return false;
		rCollapseLayers.openDialog selection[1][3].catparent 
		SetDialogPos rCollapseLayers mouse.pos;
	)
	
	on isVisible do 
	(
		try(
	   		if selection.count != 1 then return false;
			selection[1][3].catparent;
			return true;
		)catch( return false; )
	)
)
