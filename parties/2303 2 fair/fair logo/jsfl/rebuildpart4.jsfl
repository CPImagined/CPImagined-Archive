var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,li,ci,pi,tx,r0,nr,cx,cy,el,sm;

doc.docClass="_asv_dummy_doc_class"

//masks
lib.editItem("Symbol_17");
tl=doc.getTimeline();
pi=tl.findLayerIndex("L4")[0];
tl.layers[pi].layerType="mask"
ci=tl.findLayerIndex("L5")[0];
tl.layers[ci].layerType="masked"
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L4")[0];
ci=tl.findLayerIndex("L5")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
pi=tl.findLayerIndex("L6")[0];
tl.layers[pi].layerType="mask"
ci=tl.findLayerIndex("L7")[0];
tl.layers[ci].layerType="masked"
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L6")[0];
ci=tl.findLayerIndex("L7")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
doc.exitEditMode();
lib.editItem("Symbol_19");
tl=doc.getTimeline();
pi=tl.findLayerIndex("L4")[0];
tl.layers[pi].layerType="mask" //masked layer not found
tl.addNewLayer();
tl.layers[0].name="E4";//create empty layer
ci=tl.findLayerIndex("E4")[0];
tl.layers[ci].layerType="masked"
pi=tl.findLayerIndex("L4")[0];
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L4")[0];
ci=tl.findLayerIndex("E4")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
pi=tl.findLayerIndex("L5")[0];
tl.layers[pi].layerType="mask" //masked layer not found
tl.addNewLayer();
tl.layers[0].name="E5";//create empty layer
ci=tl.findLayerIndex("E5")[0];
tl.layers[ci].layerType="masked"
pi=tl.findLayerIndex("L5")[0];
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L5")[0];
ci=tl.findLayerIndex("E5")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
doc.exitEditMode();
lib.editItem("Symbol_24");
tl=doc.getTimeline();
pi=tl.findLayerIndex("L2")[0];
tl.layers[pi].layerType="mask"
ci=tl.findLayerIndex("L3")[0];
tl.layers[ci].layerType="masked"
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L2")[0];
ci=tl.findLayerIndex("L3")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
pi=tl.findLayerIndex("L4")[0];
tl.layers[pi].layerType="mask"
ci=tl.findLayerIndex("L5")[0];
tl.layers[ci].layerType="masked"
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L4")[0];
ci=tl.findLayerIndex("L5")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
doc.exitEditMode();
lib.editItem("Symbol_25");
tl=doc.getTimeline();
pi=tl.findLayerIndex("L2")[0];
tl.layers[pi].layerType="mask" //masked layer not found
tl.addNewLayer();
tl.layers[0].name="E2";//create empty layer
ci=tl.findLayerIndex("E2")[0];
tl.layers[ci].layerType="masked"
pi=tl.findLayerIndex("L2")[0];
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L2")[0];
ci=tl.findLayerIndex("E2")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
pi=tl.findLayerIndex("L3")[0];
tl.layers[pi].layerType="mask" //masked layer not found
tl.addNewLayer();
tl.layers[0].name="E3";//create empty layer
ci=tl.findLayerIndex("E3")[0];
tl.layers[ci].layerType="masked"
pi=tl.findLayerIndex("L3")[0];
tl.reorderLayer(ci,pi,false);
pi=tl.findLayerIndex("L3")[0];
ci=tl.findLayerIndex("E3")[0];
tl.layers[ci].parentLayer=tl.layers[pi];
doc.exitEditMode();
