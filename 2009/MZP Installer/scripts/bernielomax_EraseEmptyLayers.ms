MacroScript deleteEmptyLayers category:"bernardo_SCRIPTS"
(
---Description: This Macroscript erases empty lays in the layer manager
--- bernardo amorim 2008	
emptyLayers =#()
for i = 0 to layerManager.count-1 do
(
    ilayer = layerManager.getLayer i
    layerName = ilayer.name 
	layer = ILayerManager.getLayerObject i
	layerNodes = refs.dependents layer
  ---format "Layer: %; nodes: %\n" layerName layerNodes
	
	layer.Nodes &theNodesTemp

    if theNodesTemp.count == 0  do (
	----print "empty layer"
	append emptyLayers (layerName as string)
 ---  print layerName
	)
)
format "vazias: % \n" emptylayers
for i = 1 to emptyLayers.count do ( layermanager.deleteLayerByName emptyLayers[i])

if LayerManager.isDialogOpen() ==true then (LayerManager.closeDialog();layermanager.editlayerbyname "") else(layermanager.editlayerbyname "")



)