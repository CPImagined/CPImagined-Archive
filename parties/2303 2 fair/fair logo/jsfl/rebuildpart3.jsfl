var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,li,ci,pi,tx,r0,nr,cx,cy,el,sm;

doc.docClass="_asv_dummy_doc_class"
//create main timeline
tl=doc.getTimeline();
tl.layers[0].name="L1";
lib.addItemToDocument({x:0, y:0},"Symbol_26");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.moveSelectionBy({x:0, y:-0.05});
newSel[0].name="globalLogo";
doc.selectNone();
tl.layers[0].locked=false;
tl.setSelectedFrames([0,0,0],true);
