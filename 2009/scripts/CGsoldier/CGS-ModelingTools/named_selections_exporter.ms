try
	(
	namedselfile = CreateFile (Maxfilepath + "namedsel.txt")
	
	if getNumNamedselsets() != undefined then
		(
		for i in 1 to getNumNamedselsets() do
			(
			format "%\n" ("|"+(getNamedselsetName i)) to:namedselfile
			for j in 1 to (getNamedselsetItemcount i) do
				(
				format "%\n" (getNamedselsetItem i j).name to:namedselfile 
				)		
			)
		)
	close namedselfile
	)


catch (messageBox "nom de selection vide")
