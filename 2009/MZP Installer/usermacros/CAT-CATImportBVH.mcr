macroScript CATImportBVH
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Import BVH" 
            buttontext:"Import BVH" 
            Icon:#("CAT",6)
(
	fn filtertracks t = ( return true; )
	on execute do (	
		try(
			rImportBVH.openDialog catparent:selection[1][3].catparent
		)catch(	return false; )
	)
	on isVisible do 
	(
   		if selection.count != 1 then return false;
		try( 
			selection[1][3].catparent
		)catch(	return false; )
		return true;
	)
)
