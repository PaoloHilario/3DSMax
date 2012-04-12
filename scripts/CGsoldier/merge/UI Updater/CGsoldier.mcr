-------------------------------------------------------------------------------
-- CGsoldier.mcr
-- MacroScripts File
-- By PaoloHilario (paolo@cgsoldier.com)
-- Feb 29th 2004
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(
-------------------------------------------------------------------------------
--- CGsoldier Scripts - Launchers
-------------------------------------------------------------------------------
MacroScript CGS_MT category:"CGS-Launch" tooltip:"CGsoldier Modeling Tools" Icon:#("CGsoldier", 12)
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools.ms"
	)

MacroScript CGS_ST category:"CGS-Launch" tooltip:"CGsoldier Scene Tools" Icon:#("CGsoldier",2)
	(
	Include "$userscripts\\CGsoldier\\CGS-SceneTools.ms"
	)

MacroScript BSRun category:"CGS-Launch" tooltip:"Blur Scripts" Icon:#("CGS-BlurScripts",51)
	(
	Include "$userscripts\\BlurScripts\\BSRun.ms"
	)
	
-------------------------------------------------------------------------------
--- CGsoldier Scripts - Scene Tools
-------------------------------------------------------------------------------

MacroScript PassMonkey category:"CGS-SceneTools" tooltip:"CGS-PassMonkey" Icon:#("CGsoldier", 1)
	(
	Include "$userscripts\\CGsoldier\\CGS-SceneTools\\CGS-PassMonkey.ms"
	)
	
MacroScript RenderMonkey category:"CGS-SceneTools" tooltip:"CGS-RenderMonkey" Icon:#("CGsoldier", 2)
	(
	Include "$userscripts\\CGsoldier\\CGS-SceneTools\\CGS-RenderMonkey.ms"
	)

-------------------------------------------------------------------------------
--- CGsoldier Scripts - Modeling Tools
-------------------------------------------------------------------------------

MacroScript AffectPivot category:"CGS-ModelingTools" tooltip:"Affect Pivot"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\AffectPivot.ms"
	)

MacroScript CADcleaner category:"CGS-ModelingTools" tooltip:"CAD Cleaner"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\CAD_Cleaner.ms"
	)
		
MacroScript FastBoolAB category:"CGS-ModelingTools" tooltip:"FastBool (A)-(B)"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Fast_Boolean_AminusB.ms"
	)

MacroScript FastBoolIntersect category:"CGS-ModelingTools" tooltip:"FastBool Intersect"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Fast_Boolean_Intersect.ms"
	)

MacroScript FastBoolUnion category:"CGS-ModelingTools" tooltip:"FastBool Union"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Fast_Boolean_Union.ms"
	)
	
MacroScript KeepMapCollapse category:"CGS-ModelingTools" tooltip:"KeepMap Collapse"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Keep_Map_Collapse.ms"
	)

MacroScript KeepMapCollapseMesh category:"CGS-ModelingTools" tooltip:"KeepMap Collapse-Mesh"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Keep_Map_Collapse_Mesh.ms"
	)
	
MacroScript KeepMapCollapsePoly category:"CGS-ModelingTools" tooltip:"KeepMap Collapse-Poly"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Keep_Map_Collapse_Poly.ms"
	)
	
MacroScript KeyInvisible category:"CGS-ModelingTools" tooltip:"Key Invisible"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\KeyInvisible.ms"
	)
	
MacroScript LightsIncludeExclude category:"CGS-ModelingTools" tooltip:"Lights-IncludeExclude"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Lights-IncludeExclude.ms"
	)
	
MacroScript LightsMatchExclusions category:"CGS-ModelingTools" tooltip:"Lights-MatchExclusions"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Lights-MatchExclusions.ms"
	)
	
MacroScript LightsSelectedOFF category:"CGS-ModelingTools" tooltip:"Lights-Selected_OFF"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Lights-Selected_Off.ms"
	)

MacroScript LightsSelectedON category:"CGS-ModelingTools" tooltip:"Lights-Selected_ON"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Lights-Selected_On.ms"
	)
	
MacroScript LightsSelectedONLY category:"CGS-ModelingTools" tooltip:"Lights-Selected_ONLY"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Lights-Selected_On_Only.ms"
	)
	
MacroScript LoftDividerGRASS category:"CGS-ModelingTools" tooltip:"LoftDivider-Grass"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\LoftDivider-Grass.ms"
	)
	
MacroScript LoftDividerENGLISH category:"CGS-ModelingTools" tooltip:"LoftDivider-English Units"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\LoftDivider-UnitsEnglish.ms"
	)
	
MacroScript LoftDividerMETRIC category:"CGS-ModelingTools" tooltip:"LoftDivider-Metric Units"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\LoftDivider-UnitsMetric.ms"
	)
	
MacroScript NSexporter category:"CGS-ModelingTools" tooltip:"Named Selections-Exporter"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\named_selections_exporter.ms"
	)
	
MacroScript NSimporter category:"CGS-ModelingTools" tooltip:"Named Selections-Importer"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\named_selections_importer.ms"
	)
	
MacroScript PivotCenter category:"CGS-ModelingTools" tooltip:"Pivot-Center"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Pivot_Center.ms"
	)
	
MacroScript PivotCenterMinZ category:"CGS-ModelingTools" tooltip:"Pivot-Center & Min Z"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Pivot_Center_Min_Z.ms"
	)
	
MacroScript PivotMatch category:"CGS-ModelingTools" tooltip:"Pivot-Match"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Pivot_Match.ms"
	)
	
MacroScript PivotMinZ category:"CGS-ModelingTools" tooltip:"Pivot-Min Z"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Pivot_Min_Z.ms"
	)
	
MacroScript PolyCleaner category:"CGS-ModelingTools" tooltip:"Poly Cleaner"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\PolyCleaner.ms"
	)
	
MacroScript RoofMonkey category:"CGS-ModelingTools" tooltip:"Roof Monkey"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Roof_Monkey.ms"
	)
	
MacroScript SelectionDrop category:"CGS-ModelingTools" tooltip:"Selection Drop"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Selection_Drop.ms"
	)
	
MacroScript SuperNamer category:"CGS-ModelingTools" tooltip:"Super Namer"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Super_Namer.ms"
	)
	
MacroScript TempMerge category:"CGS-ModelingTools" tooltip:"Temp-Merge"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Temp_Merge.ms"
	)
	
MacroScript TempSaveSelected category:"CGS-ModelingTools" tooltip:"Temp-Save Selected"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Temp_Save_Selected.ms"
	)
	
MacroScript UVWcopy category:"CGS-ModelingTools" tooltip:"UVW-Copy Mapping"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\UVW_Copy.ms"
	)
	
MacroScript UVWpastecopy category:"CGS-ModelingTools" tooltip:"UVW-Paste as Copy"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\UVW_Paste_Copy.ms"
	)
	
MacroScript UVWpasteinstance category:"CGS-ModelingTools" tooltip:"UVW-Paste as Instance"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\UVW_Paste_Instance.ms"
	)
	
MacroScript Variegator category:"CGS-ModelingTools" tooltip:"Variegator"
	(
	Include "$userscripts\\CGsoldier\\CGS-ModelingTools\\Variegator.ms"
	)
	
-------------------------------------------------------------------------------------------
---- Blur Scripts
-------------------------------------------------------------------------------------------	

MacroScript ActiveMtlSlot category:"CGS-Scripts_Blur" tooltip:"ActiveMtlSlot"
	(
	Include "$userscripts/BlurScripts/ActiveMtlSlot.ms"
	)

MacroScript AnimatedAlign category:"CGS-Scripts_Blur" tooltip:"AnimatedAlign"
	(
	Include "$userscripts/BlurScripts/AnimatedAlign.ms"
	)

MacroScript AssignAtmMatte category:"CGS-Scripts_Blur" tooltip:"AssignAtmMatte"
	(
	Include "$userscripts/BlurScripts/AssignAtmMatte.ms"
	)
	
MacroScript AssignObjectMatte category:"CGS-Scripts_Blur" tooltip:"AssignObjectMatte"
	(
	Include "$userscripts/BlurScripts/AssignObjectMatte.ms"
	)

MacroScript AssignSceneMatte category:"CGS-Scripts_Blur" tooltip:"AssignSceneMatte"
	(
	Include "$userscripts/BlurScripts/AssignSceneMatte.ms"
	)

MacroScript AtmPass category:"CGS-Scripts_Blur" tooltip:"AtmPass" Icon:#("CGS-BlurScripts",23)
	(
	Include "$userscripts/BlurScripts/AtmPass.ms"
	)

MacroScript AttachSelection category:"CGS-Scripts_Blur" tooltip:"AttachSelection"
	(
	Include "$userscripts/BlurScripts/AttachSelection.ms"
	)
	
MacroScript BBoxMaker category:"CGS-Scripts_Blur" tooltip:"BBoxMaker"
	(
	Include "$userscripts/BlurScripts/BBoxMaker.ms"
	)

MacroScript BigBrother category:"CGS-Scripts_Blur" tooltip:"BigBrother" Icon:#("CGS-BlurScripts",17)
	(
	Include "$userscripts/BlurScripts/BigBrother.ms"
	)
	
MacroScript BipedCataloger category:"CGS-Scripts_Blur" tooltip:"BipedCataloger"
	(
	Include "$userscripts/BlurScripts/BipedCataloger.ms"
	)
	
MacroScript BitmapFilteringControl category:"CGS-Scripts_Blur" tooltip:"BitmapFilteringControl"
	(
	Include "$userscripts/BlurScripts/BitmapFilteringControl.ms"
	)

MacroScript BlankMat category:"CGS-Scripts_Blur" tooltip:"BlankMat"
	(
	Include "$userscripts/BlurScripts/BlankMat.ms"
	)

MacroScript Blinders category:"CGS-Scripts_Blur" tooltip:"Blinders"
	(
	Include "$userscripts/BlurScripts/Blinders.ms"
	)

MacroScript BlurPrimitives category:"CGS-Scripts_Blur" tooltip:"BlurPrimitives" Icon:#("CGS-BlurScripts",21)
	(
	Include "$userscripts/BlurScripts/BlurPrimitives.ms"
	)

MacroScript BoxSkeleton category:"CGS-Scripts_Blur" tooltip:"BoxSkeleton" Icon:#("CGS-BlurScripts",26)
	(
	Include "$userscripts/BlurScripts/BoxSkeleton.ms"
	)
	
MacroScript BSRun category:"CGS-Scripts_Blur" tooltip:"BSRun" Icon:#("CGS-BlurScripts",51)
	(
	Include "$userscripts/BlurScripts/BSRun.ms"
	)

MacroScript CameraClipper category:"CGS-Scripts_Blur" tooltip:"CameraClipper" Icon:#("CGS-BlurScripts",32)
	(
	Include "$userscripts/BlurScripts/CameraClipper.ms"
	)
	
MacroScript CameraControl category:"CGS-Scripts_Blur" tooltip:"CameraControl"
	(
	Include "$userscripts/BlurScripts/CameraControl.ms"
	)

MacroScript CameraMaker category:"CGS-Scripts_Blur" tooltip:"CameraMaker" Icon:#("CGS-BlurScripts",2)
	(
	Include "$userscripts/BlurScripts/CameraMaker.ms"
	)
	
MacroScript CameraMapApplier category:"CGS-Scripts_Blur" tooltip:"CameraMapApplier"
	(
	Include "$userscripts/BlurScripts/CameraMapApplier.ms"
	)

MacroScript CameraTransfer category:"CGS-Scripts_Blur" tooltip:"CameraTransfer"
	(
	Include "$userscripts/BlurScripts/CameraTransfer.ms"
	)
	
MacroScript ChamferConverter category:"CGS-Scripts_Blur" tooltip:"ChamferConverter" Icon:#("CGS-BlurScripts",36)
	(
	Include "$userscripts/BlurScripts/ChamferConverter.ms"
	)
	
MacroScript ChangeBitmaps category:"CGS-Scripts_Blur" tooltip:"ChangeBitmaps"
	(
	Include "$userscripts/BlurScripts/ChangeBitmaps.ms"
	)
	
MacroScript ClearMedit category:"CGS-Scripts_Blur" tooltip:"ClearMedit" Icon:#("CGS-BlurScripts",4)
	(
	Include "$userscripts/BlurScripts/ClearMedit.ms"
	)

MacroScript CollapseSubObjectMaterial category:"CGS-Scripts_Blur" tooltip:"CollapseSubObjectMaterial"
	(
	Include "$userscripts/BlurScripts/CollapseSubObjectMaterial.ms"
	)
	
MacroScript CStudioGlobalTCB category:"CGS-Scripts_Blur" tooltip:"CStudioGlobalTCB"
	(
	Include "$userscripts/BlurScripts/CStudioGlobalTCB.ms"
	)

MacroScript DisplayInstances category:"CGS-Scripts_Blur" tooltip:"DisplayInstances"
	(
	Include "$userscripts/BlurScripts/DisplayInstances.ms"
	)
	
MacroScript DisplayMat category:"CGS-Scripts_Blur" tooltip:"DisplayMat"
	(
	Include "$userscripts/BlurScripts/DisplayMat.ms"
	)
	
MacroScript DisplayMatID category:"CGS-Scripts_Blur" tooltip:"DisplayMatID"
	(
	Include "$userscripts/BlurScripts/DisplayMatID.ms"
	)

MacroScript DisplayUsedMapChannels category:"CGS-Scripts_Blur" tooltip:"DisplayUsedMapChannels"
	(
	Include "$userscripts/BlurScripts/DisplayUsedMapChannels.ms"
	)

MacroScript DoScript category:"CGS-Scripts_Blur" tooltip:"Do" Icon:#("CGS-BlurScripts",14)
	(
	Include "$userscripts/BlurScripts/Do.ms"
	)
	
MacroScript DoClassic category:"CGS-Scripts_Blur" tooltip:"DoClassic"
	(
	Include "$userscripts/BlurScripts/DoClassic.ms"
	)

MacroScript ExpertModeControls category:"CGS-Scripts_Blur" tooltip:"ExpertModeControls"
	(
	Include "$userscripts/BlurScripts/ExpertModeControls.ms"
	)

MacroScript FigureModeControl category:"CGS-Scripts_Blur" tooltip:"FigureModeControl" Icon:#("CGS-BlurScripts",59)
	(
	Include "$userscripts/BlurScripts/FigureModeControl.ms"
	)

MacroScript FindByMaterial category:"CGS-Scripts_Blur" tooltip:"FindByMaterial"
	(
	Include "$userscripts/BlurScripts/FindByMaterial.ms"
	)
	
MacroScript GetMat category:"CGS-Scripts_Blur" tooltip:"GetMat"
	(
	Include "$userscripts/BlurScripts/GetMat.ms"
	)

MacroScript GlobalMotionBlur category:"CGS-Scripts_Blur" tooltip:"GlobalMotionBlur" Icon:#("CGS-BlurScripts",13)
	(
	Include "$userscripts/BlurScripts/GlobalMotionBlur.ms"
	)

MacroScript GoAway category:"CGS-Scripts_Blur" tooltip:"GoAway"
	(
	Include "$userscripts/BlurScripts/GoAway.ms"
	)

MacroScript GodsEyeView category:"CGS-Scripts_Blur" tooltip:"GodsEyeView"
	(
	Include "$userscripts/BlurScripts/GodsEyeView.ms"
	)

MacroScript GradientUtilities category:"CGS-Scripts_Blur" tooltip:"GradientUtilities" Icon:#("CGS-BlurScripts",12)
	(
	Include "$userscripts/BlurScripts/GradientUtilities.ms"
	)

MacroScript IsolateByMaterial category:"CGS-Scripts_Blur" tooltip:"IsolateByMaterial"
	(
	Include "$userscripts/BlurScripts/IsolateByMaterial.ms"
	)

MacroScript IWantMyMom category:"CGS-Scripts_Blur" tooltip:"IWantMyMom!" Icon:#("CGS-BlurScripts",24)
	(
	Include "$userscripts/BlurScripts/IWantMyMom.ms"
	)
	
MacroScript KeyMaker category:"CGS-Scripts_Blur" tooltip:"KeyMaker"
	(
	Include "$userscripts/BlurScripts/KeyMaker.ms"
	)

MacroScript KillAnimation category:"CGS-Scripts_Blur" tooltip:"KillAnimation" Icon:#("CGS-BlurScripts",38)
	(
	Include "$userscripts/BlurScripts/KillAnimation.ms"
	)

MacroScript KillDuplicateMaterials category:"CGS-Scripts_Blur" tooltip:"KillDuplicateMaterials" Icon:#("CGS-BlurScripts",42)
	(
	Include "$userscripts/BlurScripts/KillDuplicateMaterials.ms"
	)
	
MacroScript KillLayerman category:"CGS-Scripts_Blur" tooltip:"KillLayerman" Icon:#("CGS-BlurScripts",60)
	(
	Include "$userscripts/BlurScripts/KillLayerman.ms"
	)
	
MacroScript KillMaterial category:"CGS-Scripts_Blur" tooltip:"KillMaterial" Icon:#("CGS-BlurScripts",28)
	(
	Include "$userscripts/BlurScripts/KillMaterial.ms"
	)
	
MacroScript KillMissingModifiers category:"CGS-Scripts_Blur" tooltip:"KillMissingModifiers" Icon:#("CGS-BlurScripts",61)
	(
	Include "$userscripts/BlurScripts/KillMissingModifiers.ms"
	)

MacroScript LightControl category:"CGS-Scripts_Blur" tooltip:"LightControl" Icon:#("CGS-BlurScripts",52)
	(
	Include "$userscripts/BlurScripts/LightControl.ms"
	)

MacroScript LightIncludeExcludeManager category:"CGS-Scripts_Blur" tooltip:"LightIncludeExcludeManager"
	(
	Include "$userscripts/BlurScripts/LightIncludeExcludeManager.ms"
	)

MacroScript LightUtilities category:"CGS-Scripts_Blur" tooltip:"LightUtilities" Icon:#("CGS-BlurScripts",39)
	(
	Include "$userscripts/BlurScripts/LightUtilities.ms"
	)

MacroScript MakeUnique category:"CGS-Scripts_Blur" tooltip:"MakeUnique" Icon:#("CGS-BlurScripts",25)
	(
	Include "$userscripts/BlurScripts/MakeUnique.ms"
	)

MacroScript MapCollector category:"CGS-Scripts_Blur" tooltip:"MapCollector" Icon:#("CGS-BlurScripts",62)
	(
	Include "$userscripts/BlurScripts/MapCollector.ms"
	)

MacroScript MaterialControl category:"CGS-Scripts_Blur" tooltip:"MaterialControl"
	(
	Include "$userscripts/BlurScripts/MaterialControl.ms"
	)

MacroScript MaterialConverter category:"CGS-Scripts_Blur" tooltip:"MaterialConverter" Icon:#("CGS-BlurScripts",27)
	(
	Include "$userscripts/BlurScripts/MaterialConverter.ms"
	)
	
MacroScript MaterialToWirecolor category:"CGS-Scripts_Blur" tooltip:"MaterialToWirecolor"
	(
	Include "$userscripts/BlurScripts/MaterialToWirecolor.ms"
	)

MacroScript MaterialRipper category:"CGS-Scripts_Blur" tooltip:"MaterialRipper"
	(
	Include "$userscripts/BlurScripts/MaterialRipper.ms"
	)

MacroScript MaterialStuffer category:"CGS-Scripts_Blur" tooltip:"MaterialStuffer" Icon:#("CGS-BlurScripts",49)
	(
	Include "$userscripts/BlurScripts/MaterialStuffer.ms"
	)

MacroScript MatIDCopyPaste category:"CGS-Scripts_Blur" tooltip:"MatIDCopyPaste"
	(
	Include "$userscripts/BlurScripts/MatIDCopyPaste.ms"
	)

MacroScript MergeTwo category:"CGS-Scripts_Blur" tooltip:"MergeTwo"
	(
	Include "$userscripts/BlurScripts/MergeTwo.ms"
	)

MacroScript MeshsmoothControl category:"CGS-Scripts_Blur" tooltip:"MeshsmoothControl" Icon:#("CGS-BlurScripts",9)
	(
	Include "$userscripts/BlurScripts/MeshsmoothControl.ms"
	)
	
MacroScript MissingUVWSelect category:"CGS-Scripts_Blur" tooltip:"MissingUVWSelect"
	(
	Include "$userscripts/BlurScripts/MissingUVWSelect.ms"
	)

MacroScript ModelHairControl category:"CGS-Scripts_Blur" tooltip:"ModelHairControl"
	(
	Include "$userscripts/BlurScripts/ModelHairControl.ms"
	)
	
MacroScript ModifierManager category:"CGS-Scripts_Blur" tooltip:"ModifierManager"
	(
	Include "$userscripts/BlurScripts/ModifierManager.ms"
	)

MacroScript MotionBlurSelect category:"CGS-Scripts_Blur" tooltip:"MotionBlurSelect" Icon:#("CGS-BlurScripts",6)
	(
	Include "$userscripts/BlurScripts/MotionBlurSelect.ms"
	)

MacroScript NoiseControllerRandomSeed category:"CGS-Scripts_Blur" tooltip:"NoiseControllerRandomSeed" Icon:#("CGS-BlurScripts",15)
	(
	Include "$userscripts/BlurScripts/NoiseControllerRandomSeed.ms"
	)

MacroScript ObjectLock category:"CGS-Scripts_Blur" tooltip:"ObjectLock" Icon:#("CGS-BlurScripts",35)
	(
	Include "$userscripts/BlurScripts/ObjectLock.ms"
	)
	
MacroScript ObjectReplacer category:"CGS-Scripts_Blur" tooltip:"ObjectReplacer"
	(
	Include "$userscripts/BlurScripts/ObjectReplacer.ms"
	)

MacroScript ParticleControl category:"CGS-Scripts_Blur" tooltip:"ParticleControl" Icon:#("CGS-BlurScripts",11)
	(
	Include "$userscripts/BlurScripts/ParticleControl.ms"
	)

MacroScript ParticleConverter category:"CGS-Scripts_Blur" tooltip:"ParticleConverter" Icon:#("CGS-BlurScripts",29)
	(
	Include "$userscripts/BlurScripts/ParticleConverter.ms"
	)
	
MacroScript ParticlePercent category:"CGS-Scripts_Blur" tooltip:"ParticlePercent"
	(
	Include "$userscripts/BlurScripts/ParticlePercent.ms"
	)

MacroScript PatchControl category:"CGS-Scripts_Blur" tooltip:"PatchControl"
	(
	Include "$userscripts/BlurScripts/PatchControl.ms"
	)

MacroScript PivotPlacer category:"CGS-Scripts_Blur" tooltip:"PivotPlacer" Icon:#("CGS-BlurScripts",41)
	(
	Include "$userscripts/BlurScripts/PivotPlacer.ms"
	)

MacroScript Planter category:"CGS-Scripts_Blur" tooltip:"Planter"
	(
	Include "$userscripts/BlurScripts/Planter.ms"
	)

MacroScript PolygonCount category:"CGS-Scripts_Blur" tooltip:"PolygonCount" Icon:#("CGS-BlurScripts",47)
	(
	Include "$userscripts/BlurScripts/PolygonCount.ms"
	)
	
MacroScript PolyEdgeCount category:"CGS-Scripts_Blur" tooltip:"PolyEdgeCount"
	(
	Include "$userscripts/BlurScripts/PolyEdgeCount.ms"
	)
	
MacroScript PolyIterDown category:"CGS-Scripts_Blur" tooltip:"PolyIterDown"
	(
	Include "$userscripts/BlurScripts/PolyIterDown.ms"
	)
	
MacroScript PolyIterUp category:"CGS-Scripts_Blur" tooltip:"PolyIterUp"
	(
	Include "$userscripts/BlurScripts/PolyIterUp.ms"
	)
	
MacroScript PrepFamous category:"CGS-Scripts_Blur" tooltip:"PrepFamous" Icon:#("CGS-BlurScripts",48)
	(
	Include "$userscripts/BlurScripts/PrepFamous.ms"
	)
	
MacroScript ProceduralMapScale category:"CGS-Scripts_Blur" tooltip:"ProceduralMapScale"
	(
	Include "$userscripts/BlurScripts/ProceduralMapScale.ms"
	)

MacroScript QuickMaterial category:"CGS-Scripts_Blur" tooltip:"QuickMaterial" Icon:#("CGS-BlurScripts",31)
	(
	Include "$userscripts/BlurScripts/QuickMaterial.ms"
	)
	
MacroScript QuickMeasure category:"CGS-Scripts_Blur" tooltip:"QuickMeasure" Icon:#("CGS-BlurScripts",22)
	(
	Include "$userscripts/BlurScripts/QuickMeasure.ms"
	)

MacroScript RandomFaceSelect category:"CGS-Scripts_Blur" tooltip:"RandomFaceSelect"
	(
	Include "$userscripts/BlurScripts/RandomFaceSelect.ms"
	)

MacroScript RandomFaceRemover category:"CGS-Scripts_Blur" tooltip:"RandomFaceRemover" Icon:#("CGS-BlurScripts",30)
	(
	Include "$userscripts/BlurScripts/RandomFaceRemover.ms"
	)

MacroScript RandomMapPhase category:"CGS-Scripts_Blur" tooltip:"RandomMapPhase" Icon:#("CGS-BlurScripts",18)
	(
	Include "$userscripts/BlurScripts/RandomMapPhase.ms"
	)

MacroScript RandomMat category:"CGS-Scripts_Blur" tooltip:"RandomMat" Icon:#("CGS-BlurScripts",20)
	(
	Include "$userscripts/BlurScripts/RandomMat.ms"
	)

MacroScript RandomSelect category:"CGS-Scripts_Blur" tooltip:"RandomSelect" Icon:#("CGS-BlurScripts",34)
	(
	Include "$userscripts/BlurScripts/RandomSelect.ms"
	)
	
MacroScript RandomTransform category:"CGS-Scripts_Blur" tooltip:"RandomTransform"
	(
	Include "$userscripts/BlurScripts/RandomTransform.ms"
	)

MacroScript RandomTrackTiming category:"CGS-Scripts_Blur" tooltip:"RandomTrackTiming" Icon:#("CGS-BlurScripts",43)
	(
	Include "$userscripts/BlurScripts/RandomTrackTiming.ms"
	)

MacroScript ReloadAllBitmaps category:"CGS-Scripts_Blur" tooltip:"ReloadAllBitmaps"
	(
	Include "$userscripts/BlurScripts/ReloadAllBitmaps.ms"
	)

MacroScript ReloadSelectedSlot category:"CGS-Scripts_Blur" tooltip:"ReloadSelectedSlot" Icon:#("CGS-BlurScripts",37)
	(
	Include "$userscripts/BlurScripts/ReloadSelectedSlot.ms"
	)

MacroScript RemoveNoiseAnimation category:"CGS-Scripts_Blur" tooltip:"RemoveNoiseAnimation" Icon:#("CGS-BlurScripts",16)
	(
	Include "$userscripts/BlurScripts/RemoveNoiseAnimation.ms"
	)

MacroScript Renamer category:"CGS-Scripts_Blur" tooltip:"Renamer" Icon:#("CGS-BlurScripts",53)
	(
	Include "$userscripts/BlurScripts/Renamer.ms"
	)

MacroScript RenderCam category:"CGS-Scripts_Blur" tooltip:"RenderCam" Icon:#("CGS-BlurScripts",19)
	(
	Include "$userscripts/BlurScripts/RenderCam.ms"
	)
	
MacroScript RenderSettingsControl category:"CGS-Scripts_Blur" tooltip:"RenderSettingsControl"
	(
	Include "$userscripts/BlurScripts/RenderSettingsControl.ms"
	)

MacroScript ResetViewports category:"CGS-Scripts_Blur" tooltip:"ResetViewports" Icon:#("CGS-BlurScripts",44)
	(
	Include "$userscripts/BlurScripts/ResetViewports.ms"
	)
	
MacroScript ScaleByDistance category:"CGS-Scripts_Blur" tooltip:"ScaleByDistance"
	(
	Include "$userscripts/BlurScripts/ScaleByDistance.ms"
	)

MacroScript SceneCapture category:"CGS-Scripts_Blur" tooltip:"SceneCapture"
	(
	Include "$userscripts/BlurScripts/SceneCapture.ms"
	)

MacroScript SceneRipper category:"CGS-Scripts_Blur" tooltip:"SceneRipper"
	(
	Include "$userscripts/BlurScripts/SceneRipper.ms"
	)

MacroScript SelectBipedRoot category:"CGS-Scripts_Blur" tooltip:"SelectBipedRoot"
	(
	Include "$userscripts/BlurScripts/SelectBipedRoot.ms"
	)

MacroScript SelectByLightIncludeExclude category:"CGS-Scripts_Blur" tooltip:"SelectByLightIncludeExclude"
	(
	Include "$userscripts/BlurScripts/SelectByLightIncludeExclude.ms"
	)

MacroScript SelectByNoMaterial category:"CGS-Scripts_Blur" tooltip:"SelectByNoMaterial"
	(
	Include "$userscripts/BlurScripts/SelectByNoMaterial.ms"
	)
	
MacroScript SelectedVerticesToStitchPointGroup category:"CGS-Scripts_Blur" tooltip:"SelectedVerticesToStitchPointGroup"
	(
	Include "$userscripts/BlurScripts/SelectedVerticesToStitchPointGroup.ms"
	)

MacroScript SelectEntireBiped category:"CGS-Scripts_Blur" tooltip:"SelectEntireBiped"
	(
	Include "$userscripts/BlurScripts/SelectEntireBiped.ms"
	)
	
MacroScript SelectEntireBipedExceptRoot category:"CGS-Scripts_Blur" tooltip:"SelectEntireBipedExceptRoot"
	(
	Include "$userscripts/BlurScripts/SelectEntireBipedExceptRoot.ms"
	)
	
MacroScript SelectInstances category:"CGS-Scripts_Blur" tooltip:"SelectInstances"
	(
	Include "$userscripts/BlurScripts/SelectInstances.ms"
	)

MacroScript SelectNonSmoothedFaces category:"CGS-Scripts_Blur" tooltip:"SelectNonSmoothedFaces"
	(
	Include "$userscripts/BlurScripts/SelectNonSmoothedFaces.ms"
	)

MacroScript ShaderConverter category:"CGS-Scripts_Blur" tooltip:"ShaderConverter"
	(
	Include "$userscripts/BlurScripts/ShaderConverter.ms"
	)
	
MacroScript ShowCameras category:"CGS-Scripts_Blur" tooltip:"ShowCameras"
	(
	Include "$userscripts/BlurScripts/ShowCameras.ms"
	)
	
MacroScript ShowLights category:"CGS-Scripts_Blur" tooltip:"ShowLights"
	(
	Include "$userscripts/BlurScripts/ShowLights.ms"
	)

MacroScript SimpleScatter category:"CGS-Scripts_Blur" tooltip:"SimpleScatter"
	(
	Include "$userscripts/BlurScripts/SimpleScatter.ms"
	)

MacroScript SmokeThis category:"CGS-Scripts_Blur" tooltip:"SmokeThis" Icon:#("CGS-BlurScripts",7)
	(
	Include "$userscripts/BlurScripts/SmokeThis.ms"
	)

MacroScript SplineControl category:"CGS-Scripts_Blur" tooltip:"SplineControl"
	(
	Include "$userscripts/BlurScripts/SplineControl.ms"
	)

MacroScript StackBottom category:"CGS-Scripts_Blur" tooltip:"StackBottom" Icon:#("CGS-BlurScripts",55)
	(
	Include "$userscripts/BlurScripts/StackBottom.ms"
	)
	
MacroScript StackControl category:"CGS-Scripts_Blur" tooltip:"StackControl" Icon:#("CGS-BlurScripts",58)
	(
	Include "$userscripts/BlurScripts/StackControl.ms"
	)

MacroScript StackDown category:"CGS-Scripts_Blur" tooltip:"StackDown" Icon:#("CGS-BlurScripts",57)
	(
	Include "$userscripts/BlurScripts/StackDown.ms"
	)

MacroScript StackTop category:"CGS-Scripts_Blur" tooltip:"StackTop" Icon:#("CGS-BlurScripts",54)
	(
	Include "$userscripts/BlurScripts/StackTop.ms"
	)
	
MacroScript StackUp category:"CGS-Scripts_Blur" tooltip:"StackUp" Icon:#("CGS-BlurScripts",56)
	(
	Include "$userscripts/BlurScripts/StackUp.ms"
	)

MacroScript StitchBatch category:"CGS-Scripts_Blur" tooltip:"StitchBatch"
	(
	Include "$userscripts/BlurScripts/StitchBatch.ms"
	)

MacroScript SubdivisionControl category:"CGS-Scripts_Blur" tooltip:"SubdivisionControl"
	(
	Include "$userscripts/BlurScripts/SubdivisionControl.ms"
	)

MacroScript SwapMaterials category:"CGS-Scripts_Blur" tooltip:"SwapMaterials"
	(
	Include "$userscripts/BlurScripts/SwapMaterials.ms"
	)

MacroScript Sym category:"CGS-Scripts_Blur" tooltip:"Sym" Icon:#("CGS-BlurScripts",1)
	(
	Include "$userscripts/BlurScripts/Sym.ms"
	)

MacroScript TargetSync category:"CGS-Scripts_Blur" tooltip:"TargetSync"
	(
	Include "$userscripts/BlurScripts/TargetSync.ms"
	)

MacroScript TextureMapViewer category:"CGS-Scripts_Blur" tooltip:"TextureMapViewer" Icon:#("CGS-BlurScripts",45)
	(
	Include "$userscripts/BlurScripts/TextureMapViewer.ms"
	)

MacroScript ThreePoint category:"CGS-Scripts_Blur" tooltip:"ThreePoint" Icon:#("CGS-BlurScripts",40)
	(
	Include "$userscripts/BlurScripts/ThreePoint.ms"
	)

MacroScript Tracer category:"CGS-Scripts_Blur" tooltip:"Tracer"
	(
	Include "$userscripts/BlurScripts/Tracer.ms"
	)
	
MacroScript TrackviewReady category:"CGS-Scripts_Blur" tooltip:"TrackviewReady"
	(
	Include "$userscripts/BlurScripts/TrackviewReady.ms"
	)

MacroScript TransformTools category:"CGS-Scripts_Blur" tooltip:"TransformTools" Icon:#("CGS-BlurScripts",3)
	(
	Include "$userscripts/BlurScripts/TransformTools.ms"
	)
	
MacroScript VertexPlacer category:"CGS-Scripts_Blur" tooltip:"VertexPlacer" Icon:#("CGS-BlurScripts",46)
	(
	Include "$userscripts/BlurScripts/VertexPlacer.ms"
	)
	
MacroScript ViewCamera category:"CGS-Scripts_Blur" tooltip:"ViewCamera" Icon:#("CGS-BlurScripts",8)
	(
	Include "$userscripts/BlurScripts/ViewCamera.ms"
	)

MacroScript WhoIncludesMe category:"CGS-Scripts_Blur" tooltip:"WhoIncludesMe"
	(
	Include "$userscripts/BlurScripts/WhoIncludesMe.ms"
	)

MacroScript WipeLayermanData category:"CGS-Scripts_Blur" tooltip:"WipeLayermanData" Icon:#("CGS-BlurScripts",50)
	(
	Include "$userscripts/BlurScripts/WipeLayermanData.ms"
	)

MacroScript WireJumble category:"CGS-Scripts_Blur" tooltip:"WireJumble" Icon:#("CGS-BlurScripts",33)
	(
	Include "$userscripts/BlurScripts/WireJumble.ms"
	)
	
MacroScript XRefBoxMode category:"CGS-Scripts_Blur" tooltip:"XRefBoxMode"
	(
	Include "$userscripts/BlurScripts/XRefBoxMode.ms"
	)
	
MacroScript XRefHidden category:"CGS-Scripts_Blur" tooltip:"XRefHidden"
	(
	Include "$userscripts/BlurScripts/XRefHidden.ms"
	)
	
MacroScript XRefUpdate category:"CGS-Scripts_Blur" tooltip:"XRefUpdate"
	(
	Include "$userscripts/BlurScripts/XRefUpdate.ms"
	)
)