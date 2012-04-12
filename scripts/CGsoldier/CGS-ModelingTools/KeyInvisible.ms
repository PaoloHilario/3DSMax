(
Global Aoff=0

SS = getCurrentSelection()

if SS.count == 0 then
(
messageBox("Nothing Selected")
)
else
(

disablesceneredraw()

try 
(
 if animButtonState == True then
	( 
-- Set Flag to leave Animate button on if it is already on
	Aoff=0
	)
    else
	(
-- Set Flag to turn off Animate button at end of script if it was off
-- and turn on Animate button
	Aoff=1
	set animate on
	)
	NumObjs=SS.count
	
	for n=1 to NumObjs do
		(
		if ( isGroupHead ss[ N ] ) == true then
			(
			setGroupOpen ss[ N ] true
			)
		)

	
	while (NumObjs>0) do
		(
		T=sliderTime
-- Select object in Selection Set , Last one first

		select ss[ NumObjs ]

-- Check to see if it's a group head

		if ( isGroupHead ss[ NumObjs ] ) == false then
			(
			select ss[Numobjs]
-- if Not, Set keys before and after Time on slider

			Keyvis=getVisController $
			if Keyvis== null then 
				(
-- No controller, create and set keys
				at time 0 $.visibility=true
				at time ( T-1 ) $.visibility=true
				at time ( T+1 ) $.visibility=true
				at time ( T ) $.visibility=false
				)
			else
-- if it has a controller set a new key
				(
				addNewKey Keyvis ( T-1 )
				addNewKey Keyvis ( T+1 )
			
-- Set a Key for Current time on Slider
-- set Visibility to False 

				addNewKey Keyvis T
				$.visibility = False
				)
			)
-- Step back through Selection 

		NumObjs=NumObjs-1
		)

	NumObjs=SS.count
	for n=1 to NumObjs do
		(
		if ( isGroupHead ss[ n ] ) == true then
			(
			setGroupOpen ss[ n ] false
			)
		)
	if ( Aoff == 1 ) then
		(	animButtonState=False )
	select SS
	enablesceneredraw()
	)
	catch
	(
	if Aoff==1 then
		(	animButtonState=False )
	select SS
	enablesceneredraw()
	)
)
)