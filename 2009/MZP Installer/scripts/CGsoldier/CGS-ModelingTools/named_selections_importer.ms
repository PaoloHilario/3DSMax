fn merge_bonus elem =
	(
	namedselfile = openFile elem mode:"r"

	if namedselfile != undefined then
		(
		ligne = readline namedselfile
		
		while not eof namedselfile do
			(
			actutabobjname = "#("
			nomactusel = substring (ligne) 2 100
			obj_manquant_test = 0
			obj_manquant = (nomactusel + " incomplet. Objets absent(s):\n")
			while not eof namedselfile do
				(
				ligne = readline namedselfile
				if ligne[1] == "|" then exit
				try
					(
					execute ("$'" + ligne + "'.name")
					actutabobjname = actutabobjname + "$'" + ligne + "', "
					)
				catch
					(
					obj_manquant_test = 1
					obj_manquant += (ligne + "\n")
					) 
				)
			actutabobjname = substring actutabobjname 1 (actutabobjname.count-2)
			actutabobjname = actutabobjname + ")"
			if actutabobjname.count > 4 then 
				(
				execute ("selectionSets [\"" + nomactusel + "\"] = " + actutabobjname)
				if obj_manquant_test != 0 then messageBox obj_manquant
				)
			)
		close namedselfile
		)

	)

extfile = getOpenFileName  caption:"Select a text file:" filename:"" types:"Max File|*.txt|"

if extfile != undefined then
	(
	merge_bonus extfile
	)