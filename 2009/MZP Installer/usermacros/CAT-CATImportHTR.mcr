macroScript CATImportHTR
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Import HTR" 
            buttontext:"Import HTR" 
            Icon:#("CAT",6)
(
	on execute do (	
		try(	rImportHTR.openDialog catparent:selection[1][3].catparent
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
