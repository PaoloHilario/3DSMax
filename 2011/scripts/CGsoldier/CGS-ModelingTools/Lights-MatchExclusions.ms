(
	-- ********************************************************************************
-- *Exclusive.ms
-- *Exclusive will match the exclusions of one light to another.
-- * by Conrad Santiago
-- * v1.0
-- *August 1999
-- * 
-- * NOTES:
-- *      Please report any bugs you may find.
-- *      for best viewing, set EditorTabWidth = 2
-- *
-- ********************************************************************************
-- * 
-- ********************************************************************************
-- Start Utility
-- ********************************************************************************
lightflag = false
fn LightFilt l = superclassof l == light
-- Test for any lights selected.
for n = 1 to selection.count do
	(
	if superclassof selection[n] == light then 
		(
		lightflag = true
		exit
		)
	)
	
if lightflag then
	-- Match exclude list to selected lights.
	(
		TargLite = pickobject prompt:"Pick a light" filter:LightFilt select:false
				
		for n = 1 to selection.count do
			(
			if superclassof selection[n] == light then 
				(
				if TargLite.excludelist == undefined then selection[n].includelist = TargLite.includelist
				if TargLite.includelist == undefined then selection[n].excludelist = TargLite.excludelist
				)
			)
	)
else
	messagebox "No lights selected!"
)
