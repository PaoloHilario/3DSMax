macroScript imap_merger
 category:"VArcht Tools"  
	toolTip:"Imap Merger"
	Icon:#("varcht1",4)
	-- Imap_Merger
	-- By Eric Boer
	-- v 2.00
	-- changed from DosCommand to a bat file launched with shelllaunch to avoid issues with spaces in filepaths
	-- added check for imapviewer in the maxroot
	-- 6/01/08
	
(
global fldrimaps=#()
global imapname=#()
global imapfldr=""
global ldmergemaps=""
global tembat=""



if (getfiles (getDir #maxroot+"imapviewer.exe")).count != 0 then

(

rollout imap_merger "imap_merger" 
	(
	button btn1 "Get Path" align:#center offset:[0,5] width:131 height:18   
	edittext pth1 "" text:imapfldr align:#center offset:[0,10] width:158 height:13
	multiListBox lbx1 "Select Imaps" align:#center offset:[0,10] width:150 height:18 items:imapname
	button btn2 "Merge" align:#center offset:[0,5] width:131 height:38
	Button abt1 "about" align:#center offset:[0,5] width:60 height:20 enabled:true
	
	
	
	on btn1 pressed do
	(
	 getfldr=getOpenFileName caption:"Open:" filename:"*.*" \
			types:"irmap(*.vrmap)|*.vrmap|"
		if getfldr != undefined then	
			(
			imapfldr=getfilenamepath getfldr
			fldrimaps = getFiles (imapfldr+"*.vrmap")
			for imaps in fldrimaps do (append imapname (filenameFromPath imaps))
			--print imapname
			DestroyDialog imap_merger
			createDialog imap_merger 200 420
			)
	)
	
	on lbx1 selected val do
		(
		--print lbx1.items[val]
	 print lbx1.selection[val] 

		
		if lbx1.selection[val] == true then
			(
			append ldmergemaps (" -load \""+imapfldr+lbx1.items[val]+"\"")
			--print ("ldmergemaps="+ldmergemaps)
			)
			
		if lbx1.selection[val] == false then
			(
			remstr=(" -load \""+imapfldr+lbx1.items[val]+"\"")
			remcnt = findString ldmergemaps remstr
			ldmergemaps=replace ldmergemaps remcnt remstr.count ""
			--print ("ldmergemaps="+ldmergemaps)
			)
		
		)
		
	on lbx1 doubleclicked val do
		(
		tempbat = createfile (getDir #maxroot+"imapmergetemp.bat")
		print (getDir #maxroot+"imapviewer.exe\""+(" -load \"" + imapfldr + lbx1.items[val])) to:tempbat
		close tempbat
		ShellLaunch (getDir #maxroot+"imapmergetemp.bat") ""
		)	
		
	on btn2 pressed do 
		(
		svmergemap=getSaveFileName caption:"Save Merged:" filename:"imap" \
			types:"irmap(*.vrmap)|*.vrmap|"
		if svmergemap != undefined then
			(
			tempbat = createfile (getDir #maxroot+"imapmergetemp.bat")
			format ("\""+getDir #maxroot+"imapviewer.exe\" "+ldmergemaps+" -save \""+svmergemap+"\" -nodisplay\n") to:tempbat
			close tempbat
			ShellLaunch (getDir #maxroot+"imapmergetemp.bat") ""
			)
		)
		
	on abt1 pressed do
		 (
		 	rollout about1 "About" 
			(
				
				group "VArcht Tools..."
				(
					label label01 "IMap Merger"
					label label02 "Version 2.00 - 06/01/08" 
					label label04 "by Eric Boer"
					hyperlink label05 "http://www.varcht.net/" address:"http://www.varcht.net/" align:#center color:(color 0 0 192)
					hyperlink label06 "admin@varcht.net" address:"mailto:admin@varcht.net" align:#center color:(color 0 0 192)
					Button cls1 "close"  width:60 height:20 enabled:true
				)
					on cls1 pressed do 
						(
						DestroyDialog about1
						)				
			) 		 
		 createDialog about1 360 160
		 
		 )
	on imap_merger close do
(
	try
	deletefile (getDir #maxroot+"imapmergetemp.bat")
	catch()
)
	)



createDialog imap_merger 200 420
)

else
(
Messagebox "imapviewer.exe not found in the Max Root\n Please copy imapviewer.exe to the Max root\n and run the script again" title:"VARCHT Tools"
)

)
