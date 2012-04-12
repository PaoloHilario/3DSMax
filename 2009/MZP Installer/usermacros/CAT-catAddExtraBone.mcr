macroScript catAddExtraBone
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Add Extra Bone" 
            buttontext:"Add Extra Bone" 
            Icon:#("CAT",6)
(
	on execute do (	
		try(
			local extrabone = selection[1][3].AddArbBone();
			select extrabone.node;
		)catch(	return false; )
	)
	on isVisible do 
	(
   		if selection.count != 1 then return false;
		try( 
			if(selection[1][3].catparent.catmode!=0) then return false;
		)catch(	return false; )
		return true;
	)
)
