macroScript catSaveAnim
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Save Anim" 
            buttontext:"Save Anim" 
            Icon:#("CAT",6)
(
	on execute do (	
	   	if selection.count != 1 then return false;
	--	rSaveAnim.openDialog selection[1];
		rSaveFile.openDialog selection[1] "Animation" ".clp";
	)
	
	on isVisible do 
	(
		try(
	   		if selection.count != 1 then return false;
			local catcontrol = GetCATNodeGroup selection[1];
			if catcontrol== undefined then  return false;
			if catcontrol.catparent.NumLayers == 0 then return false;
			if catcontrol.catparent.selectedlayer < 1 then return false;
		--	if catcontrol.catparent.layers.controller[catcontrol.catparent.selectedlayer].controller.LayerType =="CATMotion" then return false;
			return true;
		)catch( return false; )
	)
)
