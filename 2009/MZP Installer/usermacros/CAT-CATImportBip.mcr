macroScript CATImportBip
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Import BIP" 
            buttontext:"Import BIP" 
            Icon:#("CAT",6)
(
	on execute do (	
		try(
			rImportBIP.openDialog catparentnode:selection[1][3].catparent
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
