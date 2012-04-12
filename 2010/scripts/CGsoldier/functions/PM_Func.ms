----------------------------
--- PASSMONKEY FUNCTIONS ---
----------------------------

--- Global Variables ---

global KillLights
global SetLights
global SetCameraView
global SelectZEM
global SetZEM

--- Functions ---

fn KillLights =
	(
	for obj in lights do
		(
		if iskindof obj light do
		obj.on = false
		)
	)

fn SetLights =
	(
	for obj in selection do
		(
		if iskindof obj light then 
		obj.on = true
		)
	)

fn SetCameraView =
	(
	setselectfilter 5
	max select all
		(
		for obj in selection do
		if iskindof obj camera then
		select obj
		viewport.SetCamera$
		)
	setselectfilter 1
	)
	
fn SelectZEM = 
	(
	select $'ZEM*'
		(
		for obj in selection do
			(
			if obj.isHidden == false then
			select obj
			)
			
		if selection.count > 1 then
			(
			clearNodeSelection()
			)
		)
	)
			
			
fn SetZEM = 
	(
	SelectZEM()
		(
		if selection.count > 1 then
			(
			if queryBox "Too Many ZEM objects in Scene!\nDo you want to fix that?" title:"Pass Monkey Error" beep:true then
			macros.run "Edit" "namedSelSets"
			)
			
		if selection.count == 1 then
			(
			environmentMap = selection[1].material.diffuseMap
			) 
			else
			environmentMap = undefined
			)	
		)
