
var doc=fl.createDocument();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,ms,sn,pr,ok,cfs,cfb,nfx;
ms=""; cfs=""; cfb=""; nfx="";
var dir="E:/Club/PO/bean/new bean/decomp/";
fl.trace("Test for graphic symbols import in progress, please wait...");
fl.trace("");
//check symbol_15.swf  (Symbol 15 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_15.swf",true);
sn="symbol_15.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_15"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_15.swf (Symbol 15 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_15.swf",true);
  sn="symbol_15.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_15"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_15.swf (Symbol 15 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_15.swf\n";
  } else {
    nfx=nfx+"symbol_15.swf (Symbol 15 in ASV)\n";
  }
}
//check symbol_20.swf  (Symbol 20 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_20.swf",true);
sn="symbol_20.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_20"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_20.swf (Symbol 20 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_20.swf",true);
  sn="symbol_20.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_20"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_20.swf (Symbol 20 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_20.swf\n";
  } else {
    nfx=nfx+"symbol_20.swf (Symbol 20 in ASV)\n";
  }
}
//check symbol_21.swf  (Symbol 21 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_21.swf",true);
sn="symbol_21.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_21"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_21.swf (Symbol 21 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_21.swf",true);
  sn="symbol_21.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_21"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_21.swf (Symbol 21 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_21.swf\n";
  } else {
    nfx=nfx+"symbol_21.swf (Symbol 21 in ASV)\n";
  }
}
//check symbol_22.swf  (Symbol 22 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_22.swf",true);
sn="symbol_22.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_22"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_22.swf (Symbol 22 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_22.swf",true);
  sn="symbol_22.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_22"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_22.swf (Symbol 22 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_22.swf\n";
  } else {
    nfx=nfx+"symbol_22.swf (Symbol 22 in ASV)\n";
  }
}
//check symbol_32.swf  (Symbol 32 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_32.swf",true);
sn="symbol_32.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_32"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_32.swf (Symbol 32 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_32.swf",true);
  sn="symbol_32.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_32"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_32.swf (Symbol 32 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_32.swf\n";
  } else {
    nfx=nfx+"symbol_32.swf (Symbol 32 in ASV)\n";
  }
}
//check symbol_34.swf  (Symbol 34 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_34.swf",true);
sn="symbol_34.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_34"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_34.swf (Symbol 34 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_34.swf",true);
  sn="symbol_34.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_34"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_34.swf (Symbol 34 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_34.swf\n";
  } else {
    nfx=nfx+"symbol_34.swf (Symbol 34 in ASV)\n";
  }
}
//check symbol_35.swf  (Symbol 35 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_35.swf",true);
sn="symbol_35.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_35"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_35.swf (Symbol 35 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_35.swf",true);
  sn="symbol_35.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_35"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_35.swf (Symbol 35 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_35.swf\n";
  } else {
    nfx=nfx+"symbol_35.swf (Symbol 35 in ASV)\n";
  }
}
//check symbol_37.swf  (Symbol 37 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_37.swf",true);
sn="symbol_37.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_37"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_37.swf (Symbol 37 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_37.swf",true);
  sn="symbol_37.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_37"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_37.swf (Symbol 37 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_37.swf\n";
  } else {
    nfx=nfx+"symbol_37.swf (Symbol 37 in ASV)\n";
  }
}
//check symbol_38.swf  (Symbol 38 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_38.swf",true);
sn="symbol_38.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_38"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_38.swf (Symbol 38 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_38.swf",true);
  sn="symbol_38.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_38"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_38.swf (Symbol 38 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_38.swf\n";
  } else {
    nfx=nfx+"symbol_38.swf (Symbol 38 in ASV)\n";
  }
}
//check symbol_40.swf  (Symbol 40 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_40.swf",true);
sn="symbol_40.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_40"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_40.swf (Symbol 40 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_40.swf",true);
  sn="symbol_40.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_40"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_40.swf (Symbol 40 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_40.swf\n";
  } else {
    nfx=nfx+"symbol_40.swf (Symbol 40 in ASV)\n";
  }
}
//check symbol_44.swf  (Symbol 44 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_44.swf",true);
sn="symbol_44.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_44"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_44.swf (Symbol 44 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_44.swf",true);
  sn="symbol_44.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_44"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_44.swf (Symbol 44 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_44.swf\n";
  } else {
    nfx=nfx+"symbol_44.swf (Symbol 44 in ASV)\n";
  }
}
//check symbol_46.swf  (Symbol 46 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_46.swf",true);
sn="symbol_46.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_46"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_46.swf (Symbol 46 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_46.swf",true);
  sn="symbol_46.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_46"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_46.swf (Symbol 46 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_46.swf\n";
  } else {
    nfx=nfx+"symbol_46.swf (Symbol 46 in ASV)\n";
  }
}
//check symbol_57.swf  (Symbol 57 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_57.swf",true);
sn="symbol_57.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_57"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_57.swf (Symbol 57 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_57.swf",true);
  sn="symbol_57.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_57"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_57.swf (Symbol 57 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_57.swf\n";
  } else {
    nfx=nfx+"symbol_57.swf (Symbol 57 in ASV)\n";
  }
}
//check symbol_67.swf  (Symbol 67 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_67.swf",true);
sn="symbol_67.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_67"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_67.swf (Symbol 67 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_67.swf",true);
  sn="symbol_67.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_67"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_67.swf (Symbol 67 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_67.swf\n";
  } else {
    nfx=nfx+"symbol_67.swf (Symbol 67 in ASV)\n";
  }
}
//check symbol_68.swf  (Symbol 68 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_68.swf",true);
sn="symbol_68.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_68"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_68.swf (Symbol 68 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_68.swf",true);
  sn="symbol_68.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_68"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_68.swf (Symbol 68 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_68.swf\n";
  } else {
    nfx=nfx+"symbol_68.swf (Symbol 68 in ASV)\n";
  }
}
//check symbol_70.swf  (Symbol 70 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_70.swf",true);
sn="symbol_70.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_70"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_70.swf (Symbol 70 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_70.swf",true);
  sn="symbol_70.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_70"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_70.swf (Symbol 70 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_70.swf\n";
  } else {
    nfx=nfx+"symbol_70.swf (Symbol 70 in ASV)\n";
  }
}
//check symbol_71.swf  (Symbol 71 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_71.swf",true);
sn="symbol_71.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_71"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_71.swf (Symbol 71 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_71.swf",true);
  sn="symbol_71.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_71"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_71.swf (Symbol 71 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_71.swf\n";
  } else {
    nfx=nfx+"symbol_71.swf (Symbol 71 in ASV)\n";
  }
}
//check symbol_72.swf  (Symbol 72 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_72.swf",true);
sn="symbol_72.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_72"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_72.swf (Symbol 72 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_72.swf",true);
  sn="symbol_72.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_72"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_72.swf (Symbol 72 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_72.swf\n";
  } else {
    nfx=nfx+"symbol_72.swf (Symbol 72 in ASV)\n";
  }
}
//check symbol_74.swf  (Symbol 74 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_74.swf",true);
sn="symbol_74.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_74"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_74.swf (Symbol 74 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_74.swf",true);
  sn="symbol_74.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_74"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_74.swf (Symbol 74 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_74.swf\n";
  } else {
    nfx=nfx+"symbol_74.swf (Symbol 74 in ASV)\n";
  }
}
//check symbol_76.swf  (Symbol 76 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_76.swf",true);
sn="symbol_76.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_76"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_76.swf (Symbol 76 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_76.swf",true);
  sn="symbol_76.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_76"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_76.swf (Symbol 76 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_76.swf\n";
  } else {
    nfx=nfx+"symbol_76.swf (Symbol 76 in ASV)\n";
  }
}
//check symbol_78.swf  (Symbol 78 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_78.swf",true);
sn="symbol_78.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_78"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_78.swf (Symbol 78 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_78.swf",true);
  sn="symbol_78.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_78"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_78.swf (Symbol 78 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_78.swf\n";
  } else {
    nfx=nfx+"symbol_78.swf (Symbol 78 in ASV)\n";
  }
}
//check symbol_79.swf  (Symbol 79 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_79.swf",true);
sn="symbol_79.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_79"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_79.swf (Symbol 79 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_79.swf",true);
  sn="symbol_79.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_79"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_79.swf (Symbol 79 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_79.swf\n";
  } else {
    nfx=nfx+"symbol_79.swf (Symbol 79 in ASV)\n";
  }
}
//check symbol_80.swf  (Symbol 80 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_80.swf",true);
sn="symbol_80.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_80"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_80.swf (Symbol 80 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_80.swf",true);
  sn="symbol_80.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_80"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_80.swf (Symbol 80 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_80.swf\n";
  } else {
    nfx=nfx+"symbol_80.swf (Symbol 80 in ASV)\n";
  }
}
//check symbol_82.swf  (Symbol 82 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_82.swf",true);
sn="symbol_82.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_82"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_82.swf (Symbol 82 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_82.swf",true);
  sn="symbol_82.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_82"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_82.swf (Symbol 82 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_82.swf\n";
  } else {
    nfx=nfx+"symbol_82.swf (Symbol 82 in ASV)\n";
  }
}
//check symbol_84.swf  (Symbol 84 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_84.swf",true);
sn="symbol_84.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_84"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_84.swf (Symbol 84 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_84.swf",true);
  sn="symbol_84.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_84"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_84.swf (Symbol 84 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_84.swf\n";
  } else {
    nfx=nfx+"symbol_84.swf (Symbol 84 in ASV)\n";
  }
}
//check symbol_86.swf  (Symbol 86 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_86.swf",true);
sn="symbol_86.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_86"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_86.swf (Symbol 86 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_86.swf",true);
  sn="symbol_86.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_86"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_86.swf (Symbol 86 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_86.swf\n";
  } else {
    nfx=nfx+"symbol_86.swf (Symbol 86 in ASV)\n";
  }
}
//check symbol_87.swf  (Symbol 87 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_87.swf",true);
sn="symbol_87.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_87"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_87.swf (Symbol 87 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_87.swf",true);
  sn="symbol_87.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_87"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_87.swf (Symbol 87 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_87.swf\n";
  } else {
    nfx=nfx+"symbol_87.swf (Symbol 87 in ASV)\n";
  }
}
//check symbol_88.swf  (Symbol 88 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_88.swf",true);
sn="symbol_88.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_88"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_88.swf (Symbol 88 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_88.swf",true);
  sn="symbol_88.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_88"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_88.swf (Symbol 88 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_88.swf\n";
  } else {
    nfx=nfx+"symbol_88.swf (Symbol 88 in ASV)\n";
  }
}
//check symbol_90.swf  (Symbol 90 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_90.swf",true);
sn="symbol_90.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_90"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_90.swf (Symbol 90 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_90.swf",true);
  sn="symbol_90.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_90"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_90.swf (Symbol 90 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_90.swf\n";
  } else {
    nfx=nfx+"symbol_90.swf (Symbol 90 in ASV)\n";
  }
}
//check symbol_92.swf  (Symbol 92 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_92.swf",true);
sn="symbol_92.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_92"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_92.swf (Symbol 92 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_92.swf",true);
  sn="symbol_92.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_92"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_92.swf (Symbol 92 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_92.swf\n";
  } else {
    nfx=nfx+"symbol_92.swf (Symbol 92 in ASV)\n";
  }
}
//check symbol_94.swf  (Symbol 94 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_94.swf",true);
sn="symbol_94.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_94"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_94.swf (Symbol 94 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_94.swf",true);
  sn="symbol_94.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_94"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_94.swf (Symbol 94 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_94.swf\n";
  } else {
    nfx=nfx+"symbol_94.swf (Symbol 94 in ASV)\n";
  }
}
//check symbol_96.swf  (Symbol 96 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_96.swf",true);
sn="symbol_96.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_96"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_96.swf (Symbol 96 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_96.swf",true);
  sn="symbol_96.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_96"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_96.swf (Symbol 96 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_96.swf\n";
  } else {
    nfx=nfx+"symbol_96.swf (Symbol 96 in ASV)\n";
  }
}
//check symbol_97.swf  (Symbol 97 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_97.swf",true);
sn="symbol_97.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_97"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_97.swf (Symbol 97 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_97.swf",true);
  sn="symbol_97.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_97"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_97.swf (Symbol 97 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_97.swf\n";
  } else {
    nfx=nfx+"symbol_97.swf (Symbol 97 in ASV)\n";
  }
}
//check symbol_98.swf  (Symbol 98 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_98.swf",true);
sn="symbol_98.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_98"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_98.swf (Symbol 98 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_98.swf",true);
  sn="symbol_98.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_98"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_98.swf (Symbol 98 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_98.swf\n";
  } else {
    nfx=nfx+"symbol_98.swf (Symbol 98 in ASV)\n";
  }
}
//check symbol_100.swf  (Symbol 100 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_100.swf",true);
sn="symbol_100.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_100"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_100.swf (Symbol 100 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_100.swf",true);
  sn="symbol_100.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_100"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_100.swf (Symbol 100 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_100.swf\n";
  } else {
    nfx=nfx+"symbol_100.swf (Symbol 100 in ASV)\n";
  }
}
//check symbol_102.swf  (Symbol 102 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_102.swf",true);
sn="symbol_102.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_102"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_102.swf (Symbol 102 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_102.swf",true);
  sn="symbol_102.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_102"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_102.swf (Symbol 102 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_102.swf\n";
  } else {
    nfx=nfx+"symbol_102.swf (Symbol 102 in ASV)\n";
  }
}
//check symbol_104.swf  (Symbol 104 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_104.swf",true);
sn="symbol_104.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_104"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_104.swf (Symbol 104 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_104.swf",true);
  sn="symbol_104.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_104"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_104.swf (Symbol 104 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_104.swf\n";
  } else {
    nfx=nfx+"symbol_104.swf (Symbol 104 in ASV)\n";
  }
}
//check symbol_106.swf  (Symbol 106 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_106.swf",true);
sn="symbol_106.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_106"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_106.swf (Symbol 106 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_106.swf",true);
  sn="symbol_106.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_106"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_106.swf (Symbol 106 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_106.swf\n";
  } else {
    nfx=nfx+"symbol_106.swf (Symbol 106 in ASV)\n";
  }
}
//check symbol_108.swf  (Symbol 108 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_108.swf",true);
sn="symbol_108.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_108"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_108.swf (Symbol 108 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_108.swf",true);
  sn="symbol_108.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_108"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_108.swf (Symbol 108 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_108.swf\n";
  } else {
    nfx=nfx+"symbol_108.swf (Symbol 108 in ASV)\n";
  }
}
//check symbol_109.swf  (Symbol 109 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_109.swf",true);
sn="symbol_109.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_109"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_109.swf (Symbol 109 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_109.swf",true);
  sn="symbol_109.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_109"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_109.swf (Symbol 109 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_109.swf\n";
  } else {
    nfx=nfx+"symbol_109.swf (Symbol 109 in ASV)\n";
  }
}
//check symbol_110.swf  (Symbol 110 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_110.swf",true);
sn="symbol_110.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_110"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_110.swf (Symbol 110 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_110.swf",true);
  sn="symbol_110.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_110"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_110.swf (Symbol 110 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_110.swf\n";
  } else {
    nfx=nfx+"symbol_110.swf (Symbol 110 in ASV)\n";
  }
}
//check symbol_111.swf  (Symbol 111 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_111.swf",true);
sn="symbol_111.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_111"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_111.swf (Symbol 111 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_111.swf",true);
  sn="symbol_111.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_111"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_111.swf (Symbol 111 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_111.swf\n";
  } else {
    nfx=nfx+"symbol_111.swf (Symbol 111 in ASV)\n";
  }
}
//check symbol_112.swf  (Symbol 112 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_112.swf",true);
sn="symbol_112.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_112"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_112.swf (Symbol 112 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_112.swf",true);
  sn="symbol_112.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_112"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_112.swf (Symbol 112 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_112.swf\n";
  } else {
    nfx=nfx+"symbol_112.swf (Symbol 112 in ASV)\n";
  }
}
//check symbol_114.swf  (Symbol 114 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_114.swf",true);
sn="symbol_114.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_114"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_114.swf (Symbol 114 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_114.swf",true);
  sn="symbol_114.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_114"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_114.swf (Symbol 114 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_114.swf\n";
  } else {
    nfx=nfx+"symbol_114.swf (Symbol 114 in ASV)\n";
  }
}
//check symbol_115.swf  (Symbol 115 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_115.swf",true);
sn="symbol_115.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_115"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_115.swf (Symbol 115 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_115.swf",true);
  sn="symbol_115.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_115"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_115.swf (Symbol 115 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_115.swf\n";
  } else {
    nfx=nfx+"symbol_115.swf (Symbol 115 in ASV)\n";
  }
}
//check symbol_117.swf  (Symbol 117 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_117.swf",true);
sn="symbol_117.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_117"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_117.swf (Symbol 117 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_117.swf",true);
  sn="symbol_117.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_117"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_117.swf (Symbol 117 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_117.swf\n";
  } else {
    nfx=nfx+"symbol_117.swf (Symbol 117 in ASV)\n";
  }
}
//check symbol_118.swf  (Symbol 118 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_118.swf",true);
sn="symbol_118.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_118"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_118.swf (Symbol 118 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_118.swf",true);
  sn="symbol_118.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_118"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_118.swf (Symbol 118 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_118.swf\n";
  } else {
    nfx=nfx+"symbol_118.swf (Symbol 118 in ASV)\n";
  }
}
//check symbol_120.swf  (Symbol 120 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_120.swf",true);
sn="symbol_120.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_120"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_120.swf (Symbol 120 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_120.swf",true);
  sn="symbol_120.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_120"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_120.swf (Symbol 120 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_120.swf\n";
  } else {
    nfx=nfx+"symbol_120.swf (Symbol 120 in ASV)\n";
  }
}
//check symbol_121.swf  (Symbol 121 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_121.swf",true);
sn="symbol_121.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_121"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_121.swf (Symbol 121 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_121.swf",true);
  sn="symbol_121.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_121"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_121.swf (Symbol 121 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_121.swf\n";
  } else {
    nfx=nfx+"symbol_121.swf (Symbol 121 in ASV)\n";
  }
}
//check symbol_123.swf  (Symbol 123 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_123.swf",true);
sn="symbol_123.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_123"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_123.swf (Symbol 123 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_123.swf",true);
  sn="symbol_123.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_123"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_123.swf (Symbol 123 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_123.swf\n";
  } else {
    nfx=nfx+"symbol_123.swf (Symbol 123 in ASV)\n";
  }
}
//check symbol_125.swf  (Symbol 125 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_125.swf",true);
sn="symbol_125.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_125"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_125.swf (Symbol 125 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_125.swf",true);
  sn="symbol_125.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_125"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_125.swf (Symbol 125 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_125.swf\n";
  } else {
    nfx=nfx+"symbol_125.swf (Symbol 125 in ASV)\n";
  }
}
//check symbol_127.swf  (Symbol 127 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_127.swf",true);
sn="symbol_127.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_127"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_127.swf (Symbol 127 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_127.swf",true);
  sn="symbol_127.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_127"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_127.swf (Symbol 127 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_127.swf\n";
  } else {
    nfx=nfx+"symbol_127.swf (Symbol 127 in ASV)\n";
  }
}
//check symbol_129.swf  (Symbol 129 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_129.swf",true);
sn="symbol_129.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_129"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_129.swf (Symbol 129 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_129.swf",true);
  sn="symbol_129.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_129"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_129.swf (Symbol 129 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_129.swf\n";
  } else {
    nfx=nfx+"symbol_129.swf (Symbol 129 in ASV)\n";
  }
}
//check symbol_131.swf  (Symbol 131 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_131.swf",true);
sn="symbol_131.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_131"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_131.swf (Symbol 131 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_131.swf",true);
  sn="symbol_131.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_131"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_131.swf (Symbol 131 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_131.swf\n";
  } else {
    nfx=nfx+"symbol_131.swf (Symbol 131 in ASV)\n";
  }
}
//check symbol_132.swf  (Symbol 132 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_132.swf",true);
sn="symbol_132.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_132"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_132.swf (Symbol 132 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_132.swf",true);
  sn="symbol_132.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_132"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_132.swf (Symbol 132 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_132.swf\n";
  } else {
    nfx=nfx+"symbol_132.swf (Symbol 132 in ASV)\n";
  }
}
//check symbol_133.swf  (Symbol 133 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_133.swf",true);
sn="symbol_133.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_133"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_133.swf (Symbol 133 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_133.swf",true);
  sn="symbol_133.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_133"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_133.swf (Symbol 133 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_133.swf\n";
  } else {
    nfx=nfx+"symbol_133.swf (Symbol 133 in ASV)\n";
  }
}
//check symbol_135.swf  (Symbol 135 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_135.swf",true);
sn="symbol_135.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_135"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_135.swf (Symbol 135 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_135.swf",true);
  sn="symbol_135.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_135"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_135.swf (Symbol 135 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_135.swf\n";
  } else {
    nfx=nfx+"symbol_135.swf (Symbol 135 in ASV)\n";
  }
}
//check symbol_137.swf  (Symbol 137 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_137.swf",true);
sn="symbol_137.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_137"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_137.swf (Symbol 137 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_137.swf",true);
  sn="symbol_137.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_137"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_137.swf (Symbol 137 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_137.swf\n";
  } else {
    nfx=nfx+"symbol_137.swf (Symbol 137 in ASV)\n";
  }
}
//check symbol_139.swf  (Symbol 139 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_139.swf",true);
sn="symbol_139.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_139"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_139.swf (Symbol 139 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_139.swf",true);
  sn="symbol_139.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_139"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_139.swf (Symbol 139 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_139.swf\n";
  } else {
    nfx=nfx+"symbol_139.swf (Symbol 139 in ASV)\n";
  }
}
//check symbol_141.swf  (Symbol 141 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_141.swf",true);
sn="symbol_141.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_141"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_141.swf (Symbol 141 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_141.swf",true);
  sn="symbol_141.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_141"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_141.swf (Symbol 141 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_141.swf\n";
  } else {
    nfx=nfx+"symbol_141.swf (Symbol 141 in ASV)\n";
  }
}
//check symbol_143.swf  (Symbol 143 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_143.swf",true);
sn="symbol_143.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_143"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_143.swf (Symbol 143 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_143.swf",true);
  sn="symbol_143.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_143"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_143.swf (Symbol 143 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_143.swf\n";
  } else {
    nfx=nfx+"symbol_143.swf (Symbol 143 in ASV)\n";
  }
}
//check symbol_145.swf  (Symbol 145 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_145.swf",true);
sn="symbol_145.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_145"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_145.swf (Symbol 145 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_145.swf",true);
  sn="symbol_145.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_145"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_145.swf (Symbol 145 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_145.swf\n";
  } else {
    nfx=nfx+"symbol_145.swf (Symbol 145 in ASV)\n";
  }
}
//check symbol_147.swf  (Symbol 147 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_147.swf",true);
sn="symbol_147.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_147"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_147.swf (Symbol 147 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_147.swf",true);
  sn="symbol_147.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_147"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_147.swf (Symbol 147 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_147.swf\n";
  } else {
    nfx=nfx+"symbol_147.swf (Symbol 147 in ASV)\n";
  }
}
//check symbol_149.swf  (Symbol 149 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_149.swf",true);
sn="symbol_149.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_149"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_149.swf (Symbol 149 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_149.swf",true);
  sn="symbol_149.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_149"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_149.swf (Symbol 149 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_149.swf\n";
  } else {
    nfx=nfx+"symbol_149.swf (Symbol 149 in ASV)\n";
  }
}
//check symbol_151.swf  (Symbol 151 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_151.swf",true);
sn="symbol_151.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_151"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_151.swf (Symbol 151 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_151.swf",true);
  sn="symbol_151.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_151"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_151.swf (Symbol 151 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_151.swf\n";
  } else {
    nfx=nfx+"symbol_151.swf (Symbol 151 in ASV)\n";
  }
}
//check symbol_153.swf  (Symbol 153 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_153.swf",true);
sn="symbol_153.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_153"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_153.swf (Symbol 153 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_153.swf",true);
  sn="symbol_153.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_153"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_153.swf (Symbol 153 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_153.swf\n";
  } else {
    nfx=nfx+"symbol_153.swf (Symbol 153 in ASV)\n";
  }
}
//check symbol_155.swf  (Symbol 155 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_155.swf",true);
sn="symbol_155.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_155"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_155.swf (Symbol 155 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_155.swf",true);
  sn="symbol_155.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_155"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_155.swf (Symbol 155 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_155.swf\n";
  } else {
    nfx=nfx+"symbol_155.swf (Symbol 155 in ASV)\n";
  }
}
//check symbol_157.swf  (Symbol 157 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_157.swf",true);
sn="symbol_157.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_157"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_157.swf (Symbol 157 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_157.swf",true);
  sn="symbol_157.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_157"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_157.swf (Symbol 157 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_157.swf\n";
  } else {
    nfx=nfx+"symbol_157.swf (Symbol 157 in ASV)\n";
  }
}
//check symbol_158.swf  (Symbol 158 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_158.swf",true);
sn="symbol_158.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_158"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_158.swf (Symbol 158 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_158.swf",true);
  sn="symbol_158.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_158"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_158.swf (Symbol 158 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_158.swf\n";
  } else {
    nfx=nfx+"symbol_158.swf (Symbol 158 in ASV)\n";
  }
}
//check symbol_159.swf  (Symbol 159 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_159.swf",true);
sn="symbol_159.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_159"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_159.swf (Symbol 159 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_159.swf",true);
  sn="symbol_159.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_159"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_159.swf (Symbol 159 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_159.swf\n";
  } else {
    nfx=nfx+"symbol_159.swf (Symbol 159 in ASV)\n";
  }
}
//check symbol_161.swf  (Symbol 161 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_161.swf",true);
sn="symbol_161.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_161"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_161.swf (Symbol 161 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_161.swf",true);
  sn="symbol_161.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_161"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_161.swf (Symbol 161 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_161.swf\n";
  } else {
    nfx=nfx+"symbol_161.swf (Symbol 161 in ASV)\n";
  }
}
//check symbol_162.swf  (Symbol 162 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_162.swf",true);
sn="symbol_162.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_162"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_162.swf (Symbol 162 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_162.swf",true);
  sn="symbol_162.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_162"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_162.swf (Symbol 162 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_162.swf\n";
  } else {
    nfx=nfx+"symbol_162.swf (Symbol 162 in ASV)\n";
  }
}
//check symbol_163.swf  (Symbol 163 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_163.swf",true);
sn="symbol_163.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_163"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_163.swf (Symbol 163 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_163.swf",true);
  sn="symbol_163.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_163"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_163.swf (Symbol 163 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_163.swf\n";
  } else {
    nfx=nfx+"symbol_163.swf (Symbol 163 in ASV)\n";
  }
}
//check symbol_165.swf  (Symbol 165 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_165.swf",true);
sn="symbol_165.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_165"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_165.swf (Symbol 165 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_165.swf",true);
  sn="symbol_165.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_165"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_165.swf (Symbol 165 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_165.swf\n";
  } else {
    nfx=nfx+"symbol_165.swf (Symbol 165 in ASV)\n";
  }
}
//check symbol_166.swf  (Symbol 166 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_166.swf",true);
sn="symbol_166.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_166"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_166.swf (Symbol 166 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_166.swf",true);
  sn="symbol_166.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_166"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_166.swf (Symbol 166 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_166.swf\n";
  } else {
    nfx=nfx+"symbol_166.swf (Symbol 166 in ASV)\n";
  }
}
//check symbol_168.swf  (Symbol 168 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_168.swf",true);
sn="symbol_168.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_168"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_168.swf (Symbol 168 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_168.swf",true);
  sn="symbol_168.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_168"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_168.swf (Symbol 168 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_168.swf\n";
  } else {
    nfx=nfx+"symbol_168.swf (Symbol 168 in ASV)\n";
  }
}
//check symbol_171.swf  (Symbol 171 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_171.swf",true);
sn="symbol_171.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_171"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_171.swf (Symbol 171 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_171.swf",true);
  sn="symbol_171.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_171"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_171.swf (Symbol 171 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_171.swf\n";
  } else {
    nfx=nfx+"symbol_171.swf (Symbol 171 in ASV)\n";
  }
}
//check symbol_174.swf  (Symbol 174 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_174.swf",true);
sn="symbol_174.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_174"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_174.swf (Symbol 174 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_174.swf",true);
  sn="symbol_174.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_174"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_174.swf (Symbol 174 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_174.swf\n";
  } else {
    nfx=nfx+"symbol_174.swf (Symbol 174 in ASV)\n";
  }
}
//check symbol_175.swf  (Symbol 175 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_175.swf",true);
sn="symbol_175.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_175"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_175.swf (Symbol 175 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_175.swf",true);
  sn="symbol_175.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_175"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_175.swf (Symbol 175 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_175.swf\n";
  } else {
    nfx=nfx+"symbol_175.swf (Symbol 175 in ASV)\n";
  }
}
//check symbol_181.swf  (Symbol 181 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_181.swf",true);
sn="symbol_181.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_181"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_181.swf (Symbol 181 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_181.swf",true);
  sn="symbol_181.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_181"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_181.swf (Symbol 181 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_181.swf\n";
  } else {
    nfx=nfx+"symbol_181.swf (Symbol 181 in ASV)\n";
  }
}
//check symbol_186.swf  (Symbol 186 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_186.swf",true);
sn="symbol_186.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_186"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_186.swf (Symbol 186 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_186.swf",true);
  sn="symbol_186.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_186"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_186.swf (Symbol 186 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_186.swf\n";
  } else {
    nfx=nfx+"symbol_186.swf (Symbol 186 in ASV)\n";
  }
}
//check symbol_191.swf  (Symbol 191 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_191.swf",true);
sn="symbol_191.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_191"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_191.swf (Symbol 191 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_191.swf",true);
  sn="symbol_191.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_191"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_191.swf (Symbol 191 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_191.swf\n";
  } else {
    nfx=nfx+"symbol_191.swf (Symbol 191 in ASV)\n";
  }
}
//check symbol_193.swf  (Symbol 193 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_193.swf",true);
sn="symbol_193.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_193"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_193.swf (Symbol 193 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_193.swf",true);
  sn="symbol_193.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_193"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_193.swf (Symbol 193 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_193.swf\n";
  } else {
    nfx=nfx+"symbol_193.swf (Symbol 193 in ASV)\n";
  }
}
//check symbol_198.swf  (Symbol 198 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_198.swf",true);
sn="symbol_198.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_198"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_198.swf (Symbol 198 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_198.swf",true);
  sn="symbol_198.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_198"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_198.swf (Symbol 198 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_198.swf\n";
  } else {
    nfx=nfx+"symbol_198.swf (Symbol 198 in ASV)\n";
  }
}
//check symbol_200.swf  (Symbol 200 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_200.swf",true);
sn="symbol_200.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_200"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_200.swf (Symbol 200 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_200.swf",true);
  sn="symbol_200.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_200"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_200.swf (Symbol 200 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_200.swf\n";
  } else {
    nfx=nfx+"symbol_200.swf (Symbol 200 in ASV)\n";
  }
}
//check symbol_204.swf  (Symbol 204 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_204.swf",true);
sn="symbol_204.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_204"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_204.swf (Symbol 204 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_204.swf",true);
  sn="symbol_204.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_204"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_204.swf (Symbol 204 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_204.swf\n";
  } else {
    nfx=nfx+"symbol_204.swf (Symbol 204 in ASV)\n";
  }
}
//check symbol_206.swf  (Symbol 206 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_206.swf",true);
sn="symbol_206.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_206"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_206.swf (Symbol 206 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_206.swf",true);
  sn="symbol_206.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_206"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_206.swf (Symbol 206 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_206.swf\n";
  } else {
    nfx=nfx+"symbol_206.swf (Symbol 206 in ASV)\n";
  }
}
//check symbol_211.swf  (Symbol 211 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_211.swf",true);
sn="symbol_211.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_211"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_211.swf (Symbol 211 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_211.swf",true);
  sn="symbol_211.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_211"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_211.swf (Symbol 211 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_211.swf\n";
  } else {
    nfx=nfx+"symbol_211.swf (Symbol 211 in ASV)\n";
  }
}
//check symbol_216.swf  (Symbol 216 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_216.swf",true);
sn="symbol_216.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_216"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_216.swf (Symbol 216 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_216.swf",true);
  sn="symbol_216.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_216"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_216.swf (Symbol 216 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_216.swf\n";
  } else {
    nfx=nfx+"symbol_216.swf (Symbol 216 in ASV)\n";
  }
}
//check symbol_227.swf  (Symbol 227 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_227.swf",true);
sn="symbol_227.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_227"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_227.swf (Symbol 227 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_227.swf",true);
  sn="symbol_227.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_227"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_227.swf (Symbol 227 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_227.swf\n";
  } else {
    nfx=nfx+"symbol_227.swf (Symbol 227 in ASV)\n";
  }
}
//check symbol_228.swf  (Symbol 228 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_228.swf",true);
sn="symbol_228.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_228"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_228.swf (Symbol 228 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_228.swf",true);
  sn="symbol_228.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_228"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_228.swf (Symbol 228 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_228.swf\n";
  } else {
    nfx=nfx+"symbol_228.swf (Symbol 228 in ASV)\n";
  }
}
//check symbol_230.swf  (Symbol 230 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_230.swf",true);
sn="symbol_230.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_230"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_230.swf (Symbol 230 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_230.swf",true);
  sn="symbol_230.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_230"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_230.swf (Symbol 230 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_230.swf\n";
  } else {
    nfx=nfx+"symbol_230.swf (Symbol 230 in ASV)\n";
  }
}
//check symbol_236.swf  (Symbol 236 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_236.swf",true);
sn="symbol_236.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_236"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_236.swf (Symbol 236 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_236.swf",true);
  sn="symbol_236.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_236"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_236.swf (Symbol 236 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_236.swf\n";
  } else {
    nfx=nfx+"symbol_236.swf (Symbol 236 in ASV)\n";
  }
}
//check symbol_239.swf  (Symbol 239 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_239.swf",true);
sn="symbol_239.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_239"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_239.swf (Symbol 239 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_239.swf",true);
  sn="symbol_239.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_239"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_239.swf (Symbol 239 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_239.swf\n";
  } else {
    nfx=nfx+"symbol_239.swf (Symbol 239 in ASV)\n";
  }
}
//check symbol_240.swf  (Symbol 240 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_240.swf",true);
sn="symbol_240.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_240"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_240.swf (Symbol 240 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_240.swf",true);
  sn="symbol_240.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_240"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_240.swf (Symbol 240 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_240.swf\n";
  } else {
    nfx=nfx+"symbol_240.swf (Symbol 240 in ASV)\n";
  }
}
//check symbol_242.swf  (Symbol 242 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_242.swf",true);
sn="symbol_242.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_242"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_242.swf (Symbol 242 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_242.swf",true);
  sn="symbol_242.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_242"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_242.swf (Symbol 242 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_242.swf\n";
  } else {
    nfx=nfx+"symbol_242.swf (Symbol 242 in ASV)\n";
  }
}
//check symbol_244.swf  (Symbol 244 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_244.swf",true);
sn="symbol_244.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_244"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_244.swf (Symbol 244 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_244.swf",true);
  sn="symbol_244.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_244"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_244.swf (Symbol 244 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_244.swf\n";
  } else {
    nfx=nfx+"symbol_244.swf (Symbol 244 in ASV)\n";
  }
}
//check symbol_246.swf  (Symbol 246 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_246.swf",true);
sn="symbol_246.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_246"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_246.swf (Symbol 246 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_246.swf",true);
  sn="symbol_246.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_246"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_246.swf (Symbol 246 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_246.swf\n";
  } else {
    nfx=nfx+"symbol_246.swf (Symbol 246 in ASV)\n";
  }
}
//check symbol_248.swf  (Symbol 248 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_248.swf",true);
sn="symbol_248.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_248"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_248.swf (Symbol 248 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_248.swf",true);
  sn="symbol_248.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_248"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_248.swf (Symbol 248 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_248.swf\n";
  } else {
    nfx=nfx+"symbol_248.swf (Symbol 248 in ASV)\n";
  }
}
//check symbol_250.swf  (Symbol 250 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_250.swf",true);
sn="symbol_250.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_250"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_250.swf (Symbol 250 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_250.swf",true);
  sn="symbol_250.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_250"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_250.swf (Symbol 250 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_250.swf\n";
  } else {
    nfx=nfx+"symbol_250.swf (Symbol 250 in ASV)\n";
  }
}
//check symbol_252.swf  (Symbol 252 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_252.swf",true);
sn="symbol_252.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_252"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_252.swf (Symbol 252 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_252.swf",true);
  sn="symbol_252.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_252"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_252.swf (Symbol 252 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_252.swf\n";
  } else {
    nfx=nfx+"symbol_252.swf (Symbol 252 in ASV)\n";
  }
}
//check symbol_254.swf  (Symbol 254 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_254.swf",true);
sn="symbol_254.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_254"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_254.swf (Symbol 254 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_254.swf",true);
  sn="symbol_254.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_254"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_254.swf (Symbol 254 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_254.swf\n";
  } else {
    nfx=nfx+"symbol_254.swf (Symbol 254 in ASV)\n";
  }
}
//check symbol_256.swf  (Symbol 256 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_256.swf",true);
sn="symbol_256.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_256"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_256.swf (Symbol 256 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_256.swf",true);
  sn="symbol_256.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_256"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_256.swf (Symbol 256 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_256.swf\n";
  } else {
    nfx=nfx+"symbol_256.swf (Symbol 256 in ASV)\n";
  }
}
//check symbol_258.swf  (Symbol 258 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_258.swf",true);
sn="symbol_258.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_258"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_258.swf (Symbol 258 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_258.swf",true);
  sn="symbol_258.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_258"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_258.swf (Symbol 258 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_258.swf\n";
  } else {
    nfx=nfx+"symbol_258.swf (Symbol 258 in ASV)\n";
  }
}
//check symbol_260.swf  (Symbol 260 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_260.swf",true);
sn="symbol_260.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_260"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_260.swf (Symbol 260 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_260.swf",true);
  sn="symbol_260.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_260"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_260.swf (Symbol 260 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_260.swf\n";
  } else {
    nfx=nfx+"symbol_260.swf (Symbol 260 in ASV)\n";
  }
}
//check symbol_262.swf  (Symbol 262 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_262.swf",true);
sn="symbol_262.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_262"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_262.swf (Symbol 262 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_262.swf",true);
  sn="symbol_262.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_262"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_262.swf (Symbol 262 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_262.swf\n";
  } else {
    nfx=nfx+"symbol_262.swf (Symbol 262 in ASV)\n";
  }
}
//check symbol_264.swf  (Symbol 264 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_264.swf",true);
sn="symbol_264.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_264"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_264.swf (Symbol 264 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_264.swf",true);
  sn="symbol_264.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_264"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_264.swf (Symbol 264 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_264.swf\n";
  } else {
    nfx=nfx+"symbol_264.swf (Symbol 264 in ASV)\n";
  }
}
//check symbol_265.swf  (Symbol 265 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_265.swf",true);
sn="symbol_265.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_265"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_265.swf (Symbol 265 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_265.swf",true);
  sn="symbol_265.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_265"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_265.swf (Symbol 265 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_265.swf\n";
  } else {
    nfx=nfx+"symbol_265.swf (Symbol 265 in ASV)\n";
  }
}
//check symbol_269.swf  (Symbol 269 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_269.swf",true);
sn="symbol_269.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_269"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_269.swf (Symbol 269 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_269.swf",true);
  sn="symbol_269.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_269"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_269.swf (Symbol 269 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_269.swf\n";
  } else {
    nfx=nfx+"symbol_269.swf (Symbol 269 in ASV)\n";
  }
}
//check symbol_270.swf  (Symbol 270 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_270.swf",true);
sn="symbol_270.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_270"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_270.swf (Symbol 270 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_270.swf",true);
  sn="symbol_270.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_270"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_270.swf (Symbol 270 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_270.swf\n";
  } else {
    nfx=nfx+"symbol_270.swf (Symbol 270 in ASV)\n";
  }
}
//check symbol_271.swf  (Symbol 271 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_271.swf",true);
sn="symbol_271.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_271"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_271.swf (Symbol 271 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_271.swf",true);
  sn="symbol_271.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_271"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_271.swf (Symbol 271 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_271.swf\n";
  } else {
    nfx=nfx+"symbol_271.swf (Symbol 271 in ASV)\n";
  }
}
//check symbol_273.swf  (Symbol 273 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_273.swf",true);
sn="symbol_273.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_273"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_273.swf (Symbol 273 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_273.swf",true);
  sn="symbol_273.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_273"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_273.swf (Symbol 273 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_273.swf\n";
  } else {
    nfx=nfx+"symbol_273.swf (Symbol 273 in ASV)\n";
  }
}
//check symbol_274.swf  (Symbol 274 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_274.swf",true);
sn="symbol_274.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_274"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_274.swf (Symbol 274 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_274.swf",true);
  sn="symbol_274.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_274"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_274.swf (Symbol 274 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_274.swf\n";
  } else {
    nfx=nfx+"symbol_274.swf (Symbol 274 in ASV)\n";
  }
}
//check symbol_276.swf  (Symbol 276 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_276.swf",true);
sn="symbol_276.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_276"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_276.swf (Symbol 276 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_276.swf",true);
  sn="symbol_276.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_276"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_276.swf (Symbol 276 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_276.swf\n";
  } else {
    nfx=nfx+"symbol_276.swf (Symbol 276 in ASV)\n";
  }
}
//check symbol_277.swf  (Symbol 277 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_277.swf",true);
sn="symbol_277.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_277"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_277.swf (Symbol 277 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_277.swf",true);
  sn="symbol_277.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_277"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_277.swf (Symbol 277 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_277.swf\n";
  } else {
    nfx=nfx+"symbol_277.swf (Symbol 277 in ASV)\n";
  }
}
//check symbol_278.swf  (Symbol 278 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_278.swf",true);
sn="symbol_278.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_278"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_278.swf (Symbol 278 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_278.swf",true);
  sn="symbol_278.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_278"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_278.swf (Symbol 278 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_278.swf\n";
  } else {
    nfx=nfx+"symbol_278.swf (Symbol 278 in ASV)\n";
  }
}
//check symbol_279.swf  (Symbol 279 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_279.swf",true);
sn="symbol_279.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_279"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_279.swf (Symbol 279 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_279.swf",true);
  sn="symbol_279.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_279"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_279.swf (Symbol 279 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_279.swf\n";
  } else {
    nfx=nfx+"symbol_279.swf (Symbol 279 in ASV)\n";
  }
}
//check symbol_280.swf  (Symbol 280 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_280.swf",true);
sn="symbol_280.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_280"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_280.swf (Symbol 280 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_280.swf",true);
  sn="symbol_280.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_280"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_280.swf (Symbol 280 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_280.swf\n";
  } else {
    nfx=nfx+"symbol_280.swf (Symbol 280 in ASV)\n";
  }
}
//check symbol_283.swf  (Symbol 283 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_283.swf",true);
sn="symbol_283.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_283"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_283.swf (Symbol 283 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_283.swf",true);
  sn="symbol_283.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_283"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_283.swf (Symbol 283 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_283.swf\n";
  } else {
    nfx=nfx+"symbol_283.swf (Symbol 283 in ASV)\n";
  }
}
//check symbol_284.swf  (Symbol 284 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_284.swf",true);
sn="symbol_284.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_284"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_284.swf (Symbol 284 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_284.swf",true);
  sn="symbol_284.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_284"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_284.swf (Symbol 284 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_284.swf\n";
  } else {
    nfx=nfx+"symbol_284.swf (Symbol 284 in ASV)\n";
  }
}
//check symbol_286.swf  (Symbol 286 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_286.swf",true);
sn="symbol_286.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_286"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_286.swf (Symbol 286 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_286.swf",true);
  sn="symbol_286.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_286"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_286.swf (Symbol 286 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_286.swf\n";
  } else {
    nfx=nfx+"symbol_286.swf (Symbol 286 in ASV)\n";
  }
}
//check symbol_289.swf  (Symbol 289 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_289.swf",true);
sn="symbol_289.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_289"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_289.swf (Symbol 289 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_289.swf",true);
  sn="symbol_289.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_289"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_289.swf (Symbol 289 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_289.swf\n";
  } else {
    nfx=nfx+"symbol_289.swf (Symbol 289 in ASV)\n";
  }
}
//check symbol_290.swf  (Symbol 290 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_290.swf",true);
sn="symbol_290.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_290"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_290.swf (Symbol 290 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_290.swf",true);
  sn="symbol_290.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_290"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_290.swf (Symbol 290 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_290.swf\n";
  } else {
    nfx=nfx+"symbol_290.swf (Symbol 290 in ASV)\n";
  }
}
//check symbol_292.swf  (Symbol 292 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_292.swf",true);
sn="symbol_292.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_292"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_292.swf (Symbol 292 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_292.swf",true);
  sn="symbol_292.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_292"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_292.swf (Symbol 292 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_292.swf\n";
  } else {
    nfx=nfx+"symbol_292.swf (Symbol 292 in ASV)\n";
  }
}
//check symbol_294.swf  (Symbol 294 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_294.swf",true);
sn="symbol_294.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_294"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_294.swf (Symbol 294 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_294.swf",true);
  sn="symbol_294.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_294"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_294.swf (Symbol 294 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_294.swf\n";
  } else {
    nfx=nfx+"symbol_294.swf (Symbol 294 in ASV)\n";
  }
}
//check symbol_297.swf  (Symbol 297 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_297.swf",true);
sn="symbol_297.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_297"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_297.swf (Symbol 297 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_297.swf",true);
  sn="symbol_297.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_297"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_297.swf (Symbol 297 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_297.swf\n";
  } else {
    nfx=nfx+"symbol_297.swf (Symbol 297 in ASV)\n";
  }
}
//check symbol_299.swf  (Symbol 299 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_299.swf",true);
sn="symbol_299.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_299"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_299.swf (Symbol 299 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_299.swf",true);
  sn="symbol_299.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_299"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_299.swf (Symbol 299 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_299.swf\n";
  } else {
    nfx=nfx+"symbol_299.swf (Symbol 299 in ASV)\n";
  }
}
//check symbol_301.swf  (Symbol 301 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_301.swf",true);
sn="symbol_301.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_301"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_301.swf (Symbol 301 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_301.swf",true);
  sn="symbol_301.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_301"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_301.swf (Symbol 301 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_301.swf\n";
  } else {
    nfx=nfx+"symbol_301.swf (Symbol 301 in ASV)\n";
  }
}
//check symbol_303.swf  (Symbol 303 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_303.swf",true);
sn="symbol_303.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_303"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_303.swf (Symbol 303 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_303.swf",true);
  sn="symbol_303.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_303"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_303.swf (Symbol 303 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_303.swf\n";
  } else {
    nfx=nfx+"symbol_303.swf (Symbol 303 in ASV)\n";
  }
}
//check symbol_304.swf  (Symbol 304 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_304.swf",true);
sn="symbol_304.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_304"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_304.swf (Symbol 304 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_304.swf",true);
  sn="symbol_304.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_304"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_304.swf (Symbol 304 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_304.swf\n";
  } else {
    nfx=nfx+"symbol_304.swf (Symbol 304 in ASV)\n";
  }
}
//check symbol_306.swf  (Symbol 306 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_306.swf",true);
sn="symbol_306.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_306"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_306.swf (Symbol 306 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_306.swf",true);
  sn="symbol_306.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_306"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_306.swf (Symbol 306 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_306.swf\n";
  } else {
    nfx=nfx+"symbol_306.swf (Symbol 306 in ASV)\n";
  }
}
//check symbol_308.swf  (Symbol 308 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_308.swf",true);
sn="symbol_308.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_308"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_308.swf (Symbol 308 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_308.swf",true);
  sn="symbol_308.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_308"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_308.swf (Symbol 308 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_308.swf\n";
  } else {
    nfx=nfx+"symbol_308.swf (Symbol 308 in ASV)\n";
  }
}
//check symbol_309.swf  (Symbol 309 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_309.swf",true);
sn="symbol_309.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_309"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_309.swf (Symbol 309 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_309.swf",true);
  sn="symbol_309.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_309"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_309.swf (Symbol 309 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_309.swf\n";
  } else {
    nfx=nfx+"symbol_309.swf (Symbol 309 in ASV)\n";
  }
}
//check symbol_311.swf  (Symbol 311 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_311.swf",true);
sn="symbol_311.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_311"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_311.swf (Symbol 311 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_311.swf",true);
  sn="symbol_311.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_311"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_311.swf (Symbol 311 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_311.swf\n";
  } else {
    nfx=nfx+"symbol_311.swf (Symbol 311 in ASV)\n";
  }
}
//check symbol_313.swf  (Symbol 313 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_313.swf",true);
sn="symbol_313.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_313"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_313.swf (Symbol 313 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_313.swf",true);
  sn="symbol_313.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_313"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_313.swf (Symbol 313 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_313.swf\n";
  } else {
    nfx=nfx+"symbol_313.swf (Symbol 313 in ASV)\n";
  }
}
//check symbol_314.swf  (Symbol 314 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_314.swf",true);
sn="symbol_314.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_314"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_314.swf (Symbol 314 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_314.swf",true);
  sn="symbol_314.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_314"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_314.swf (Symbol 314 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_314.swf\n";
  } else {
    nfx=nfx+"symbol_314.swf (Symbol 314 in ASV)\n";
  }
}
//check symbol_315.swf  (Symbol 315 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_315.swf",true);
sn="symbol_315.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_315"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_315.swf (Symbol 315 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_315.swf",true);
  sn="symbol_315.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_315"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_315.swf (Symbol 315 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_315.swf\n";
  } else {
    nfx=nfx+"symbol_315.swf (Symbol 315 in ASV)\n";
  }
}
//check symbol_316.swf  (Symbol 316 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_316.swf",true);
sn="symbol_316.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_316"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_316.swf (Symbol 316 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_316.swf",true);
  sn="symbol_316.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_316"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_316.swf (Symbol 316 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_316.swf\n";
  } else {
    nfx=nfx+"symbol_316.swf (Symbol 316 in ASV)\n";
  }
}
//check symbol_317.swf  (Symbol 317 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_317.swf",true);
sn="symbol_317.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_317"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_317.swf (Symbol 317 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_317.swf",true);
  sn="symbol_317.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_317"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_317.swf (Symbol 317 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_317.swf\n";
  } else {
    nfx=nfx+"symbol_317.swf (Symbol 317 in ASV)\n";
  }
}
//check symbol_318.swf  (Symbol 318 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_318.swf",true);
sn="symbol_318.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_318"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_318.swf (Symbol 318 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_318.swf",true);
  sn="symbol_318.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_318"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_318.swf (Symbol 318 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_318.swf\n";
  } else {
    nfx=nfx+"symbol_318.swf (Symbol 318 in ASV)\n";
  }
}
//check symbol_319.swf  (Symbol 319 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_319.swf",true);
sn="symbol_319.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_319"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_319.swf (Symbol 319 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_319.swf",true);
  sn="symbol_319.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_319"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_319.swf (Symbol 319 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_319.swf\n";
  } else {
    nfx=nfx+"symbol_319.swf (Symbol 319 in ASV)\n";
  }
}
//check symbol_321.swf  (Symbol 321 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_321.swf",true);
sn="symbol_321.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_321"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_321.swf (Symbol 321 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_321.swf",true);
  sn="symbol_321.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_321"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_321.swf (Symbol 321 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_321.swf\n";
  } else {
    nfx=nfx+"symbol_321.swf (Symbol 321 in ASV)\n";
  }
}
//check symbol_322.swf  (Symbol 322 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_322.swf",true);
sn="symbol_322.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_322"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_322.swf (Symbol 322 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_322.swf",true);
  sn="symbol_322.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_322"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_322.swf (Symbol 322 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_322.swf\n";
  } else {
    nfx=nfx+"symbol_322.swf (Symbol 322 in ASV)\n";
  }
}
//check symbol_323.swf  (Symbol 323 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_323.swf",true);
sn="symbol_323.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_323"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_323.swf (Symbol 323 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_323.swf",true);
  sn="symbol_323.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_323"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_323.swf (Symbol 323 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_323.swf\n";
  } else {
    nfx=nfx+"symbol_323.swf (Symbol 323 in ASV)\n";
  }
}
//check symbol_324.swf  (Symbol 324 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_324.swf",true);
sn="symbol_324.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_324"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_324.swf (Symbol 324 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_324.swf",true);
  sn="symbol_324.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_324"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_324.swf (Symbol 324 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_324.swf\n";
  } else {
    nfx=nfx+"symbol_324.swf (Symbol 324 in ASV)\n";
  }
}
//check symbol_327.swf  (Symbol 327 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_327.swf",true);
sn="symbol_327.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_327"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_327.swf (Symbol 327 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_327.swf",true);
  sn="symbol_327.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_327"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_327.swf (Symbol 327 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_327.swf\n";
  } else {
    nfx=nfx+"symbol_327.swf (Symbol 327 in ASV)\n";
  }
}
//check symbol_331.swf  (Symbol 331 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_331.swf",true);
sn="symbol_331.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_331"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_331.swf (Symbol 331 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_331.swf",true);
  sn="symbol_331.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_331"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_331.swf (Symbol 331 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_331.swf\n";
  } else {
    nfx=nfx+"symbol_331.swf (Symbol 331 in ASV)\n";
  }
}
//check symbol_332.swf  (Symbol 332 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_332.swf",true);
sn="symbol_332.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_332"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_332.swf (Symbol 332 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_332.swf",true);
  sn="symbol_332.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_332"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_332.swf (Symbol 332 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_332.swf\n";
  } else {
    nfx=nfx+"symbol_332.swf (Symbol 332 in ASV)\n";
  }
}
//check symbol_333.swf  (Symbol 333 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_333.swf",true);
sn="symbol_333.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_333"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_333.swf (Symbol 333 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_333.swf",true);
  sn="symbol_333.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_333"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_333.swf (Symbol 333 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_333.swf\n";
  } else {
    nfx=nfx+"symbol_333.swf (Symbol 333 in ASV)\n";
  }
}
//check symbol_341.swf  (Symbol 341 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_341.swf",true);
sn="symbol_341.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_341"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_341.swf (Symbol 341 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_341.swf",true);
  sn="symbol_341.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_341"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_341.swf (Symbol 341 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_341.swf\n";
  } else {
    nfx=nfx+"symbol_341.swf (Symbol 341 in ASV)\n";
  }
}
//check symbol_342.swf  (Symbol 342 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_342.swf",true);
sn="symbol_342.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_342"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_342.swf (Symbol 342 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_342.swf",true);
  sn="symbol_342.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_342"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_342.swf (Symbol 342 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_342.swf\n";
  } else {
    nfx=nfx+"symbol_342.swf (Symbol 342 in ASV)\n";
  }
}
//check symbol_343.swf  (Symbol 343 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_343.swf",true);
sn="symbol_343.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_343"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_343.swf (Symbol 343 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_343.swf",true);
  sn="symbol_343.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_343"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_343.swf (Symbol 343 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_343.swf\n";
  } else {
    nfx=nfx+"symbol_343.swf (Symbol 343 in ASV)\n";
  }
}
//check symbol_345.swf  (Symbol 345 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_345.swf",true);
sn="symbol_345.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_345"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_345.swf (Symbol 345 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_345.swf",true);
  sn="symbol_345.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_345"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_345.swf (Symbol 345 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_345.swf\n";
  } else {
    nfx=nfx+"symbol_345.swf (Symbol 345 in ASV)\n";
  }
}
//check symbol_347.swf  (Symbol 347 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_347.swf",true);
sn="symbol_347.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_347"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_347.swf (Symbol 347 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_347.swf",true);
  sn="symbol_347.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_347"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_347.swf (Symbol 347 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_347.swf\n";
  } else {
    nfx=nfx+"symbol_347.swf (Symbol 347 in ASV)\n";
  }
}
//check symbol_349.swf  (Symbol 349 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_349.swf",true);
sn="symbol_349.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_349"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_349.swf (Symbol 349 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_349.swf",true);
  sn="symbol_349.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_349"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_349.swf (Symbol 349 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_349.swf\n";
  } else {
    nfx=nfx+"symbol_349.swf (Symbol 349 in ASV)\n";
  }
}
//check symbol_350.swf  (Symbol 350 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_350.swf",true);
sn="symbol_350.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_350"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_350.swf (Symbol 350 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_350.swf",true);
  sn="symbol_350.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_350"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_350.swf (Symbol 350 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_350.swf\n";
  } else {
    nfx=nfx+"symbol_350.swf (Symbol 350 in ASV)\n";
  }
}
//check symbol_352.swf  (Symbol 352 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_352.swf",true);
sn="symbol_352.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_352"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_352.swf (Symbol 352 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_352.swf",true);
  sn="symbol_352.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_352"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_352.swf (Symbol 352 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_352.swf\n";
  } else {
    nfx=nfx+"symbol_352.swf (Symbol 352 in ASV)\n";
  }
}
//check symbol_353.swf  (Symbol 353 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_353.swf",true);
sn="symbol_353.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_353"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_353.swf (Symbol 353 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_353.swf",true);
  sn="symbol_353.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_353"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_353.swf (Symbol 353 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_353.swf\n";
  } else {
    nfx=nfx+"symbol_353.swf (Symbol 353 in ASV)\n";
  }
}
//check symbol_355.swf  (Symbol 355 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_355.swf",true);
sn="symbol_355.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_355"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_355.swf (Symbol 355 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_355.swf",true);
  sn="symbol_355.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_355"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_355.swf (Symbol 355 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_355.swf\n";
  } else {
    nfx=nfx+"symbol_355.swf (Symbol 355 in ASV)\n";
  }
}
//check symbol_356.swf  (Symbol 356 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_356.swf",true);
sn="symbol_356.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_356"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_356.swf (Symbol 356 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_356.swf",true);
  sn="symbol_356.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_356"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_356.swf (Symbol 356 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_356.swf\n";
  } else {
    nfx=nfx+"symbol_356.swf (Symbol 356 in ASV)\n";
  }
}
//check symbol_358.swf  (Symbol 358 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_358.swf",true);
sn="symbol_358.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_358"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_358.swf (Symbol 358 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_358.swf",true);
  sn="symbol_358.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_358"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_358.swf (Symbol 358 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_358.swf\n";
  } else {
    nfx=nfx+"symbol_358.swf (Symbol 358 in ASV)\n";
  }
}
//check symbol_359.swf  (Symbol 359 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_359.swf",true);
sn="symbol_359.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_359"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_359.swf (Symbol 359 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_359.swf",true);
  sn="symbol_359.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_359"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_359.swf (Symbol 359 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_359.swf\n";
  } else {
    nfx=nfx+"symbol_359.swf (Symbol 359 in ASV)\n";
  }
}
//check symbol_360.swf  (Symbol 360 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_360.swf",true);
sn="symbol_360.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_360"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_360.swf (Symbol 360 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_360.swf",true);
  sn="symbol_360.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_360"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_360.swf (Symbol 360 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_360.swf\n";
  } else {
    nfx=nfx+"symbol_360.swf (Symbol 360 in ASV)\n";
  }
}
//check symbol_362.swf  (Symbol 362 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_362.swf",true);
sn="symbol_362.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_362"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_362.swf (Symbol 362 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_362.swf",true);
  sn="symbol_362.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_362"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_362.swf (Symbol 362 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_362.swf\n";
  } else {
    nfx=nfx+"symbol_362.swf (Symbol 362 in ASV)\n";
  }
}
//check symbol_363.swf  (Symbol 363 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_363.swf",true);
sn="symbol_363.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_363"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_363.swf (Symbol 363 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_363.swf",true);
  sn="symbol_363.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_363"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_363.swf (Symbol 363 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_363.swf\n";
  } else {
    nfx=nfx+"symbol_363.swf (Symbol 363 in ASV)\n";
  }
}
//check symbol_365.swf  (Symbol 365 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_365.swf",true);
sn="symbol_365.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_365"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_365.swf (Symbol 365 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_365.swf",true);
  sn="symbol_365.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_365"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_365.swf (Symbol 365 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_365.swf\n";
  } else {
    nfx=nfx+"symbol_365.swf (Symbol 365 in ASV)\n";
  }
}
//check symbol_367.swf  (Symbol 367 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_367.swf",true);
sn="symbol_367.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_367"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_367.swf (Symbol 367 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_367.swf",true);
  sn="symbol_367.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_367"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_367.swf (Symbol 367 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_367.swf\n";
  } else {
    nfx=nfx+"symbol_367.swf (Symbol 367 in ASV)\n";
  }
}
//check symbol_368.swf  (Symbol 368 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_368.swf",true);
sn="symbol_368.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_368"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_368.swf (Symbol 368 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_368.swf",true);
  sn="symbol_368.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_368"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_368.swf (Symbol 368 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_368.swf\n";
  } else {
    nfx=nfx+"symbol_368.swf (Symbol 368 in ASV)\n";
  }
}
//check symbol_370.swf  (Symbol 370 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_370.swf",true);
sn="symbol_370.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_370"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_370.swf (Symbol 370 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_370.swf",true);
  sn="symbol_370.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_370"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_370.swf (Symbol 370 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_370.swf\n";
  } else {
    nfx=nfx+"symbol_370.swf (Symbol 370 in ASV)\n";
  }
}
//check symbol_371.swf  (Symbol 371 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_371.swf",true);
sn="symbol_371.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_371"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_371.swf (Symbol 371 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_371.swf",true);
  sn="symbol_371.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_371"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_371.swf (Symbol 371 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_371.swf\n";
  } else {
    nfx=nfx+"symbol_371.swf (Symbol 371 in ASV)\n";
  }
}
//check symbol_373.swf  (Symbol 373 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_373.swf",true);
sn="symbol_373.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_373"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_373.swf (Symbol 373 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_373.swf",true);
  sn="symbol_373.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_373"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_373.swf (Symbol 373 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_373.swf\n";
  } else {
    nfx=nfx+"symbol_373.swf (Symbol 373 in ASV)\n";
  }
}
//check symbol_378.swf  (Symbol 378 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_378.swf",true);
sn="symbol_378.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_378"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_378.swf (Symbol 378 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_378.swf",true);
  sn="symbol_378.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_378"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_378.swf (Symbol 378 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_378.swf\n";
  } else {
    nfx=nfx+"symbol_378.swf (Symbol 378 in ASV)\n";
  }
}
//check symbol_382.swf  (Symbol 382 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_382.swf",true);
sn="symbol_382.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_382"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_382.swf (Symbol 382 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_382.swf",true);
  sn="symbol_382.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_382"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_382.swf (Symbol 382 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_382.swf\n";
  } else {
    nfx=nfx+"symbol_382.swf (Symbol 382 in ASV)\n";
  }
}
//check symbol_383.swf  (Symbol 383 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_383.swf",true);
sn="symbol_383.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_383"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_383.swf (Symbol 383 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_383.swf",true);
  sn="symbol_383.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_383"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_383.swf (Symbol 383 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_383.swf\n";
  } else {
    nfx=nfx+"symbol_383.swf (Symbol 383 in ASV)\n";
  }
}
//check symbol_386.swf  (Symbol 386 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_386.swf",true);
sn="symbol_386.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_386"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_386.swf (Symbol 386 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_386.swf",true);
  sn="symbol_386.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_386"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_386.swf (Symbol 386 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_386.swf\n";
  } else {
    nfx=nfx+"symbol_386.swf (Symbol 386 in ASV)\n";
  }
}
//check symbol_390.swf  (Symbol 390 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_390.swf",true);
sn="symbol_390.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_390"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_390.swf (Symbol 390 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_390.swf",true);
  sn="symbol_390.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_390"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_390.swf (Symbol 390 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_390.swf\n";
  } else {
    nfx=nfx+"symbol_390.swf (Symbol 390 in ASV)\n";
  }
}
//check symbol_392.swf  (Symbol 392 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_392.swf",true);
sn="symbol_392.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_392"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_392.swf (Symbol 392 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_392.swf",true);
  sn="symbol_392.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_392"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_392.swf (Symbol 392 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_392.swf\n";
  } else {
    nfx=nfx+"symbol_392.swf (Symbol 392 in ASV)\n";
  }
}
//check symbol_394.swf  (Symbol 394 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_394.swf",true);
sn="symbol_394.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_394"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_394.swf (Symbol 394 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_394.swf",true);
  sn="symbol_394.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_394"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_394.swf (Symbol 394 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_394.swf\n";
  } else {
    nfx=nfx+"symbol_394.swf (Symbol 394 in ASV)\n";
  }
}
//check symbol_396.swf  (Symbol 396 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_396.swf",true);
sn="symbol_396.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_396"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_396.swf (Symbol 396 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_396.swf",true);
  sn="symbol_396.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_396"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_396.swf (Symbol 396 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_396.swf\n";
  } else {
    nfx=nfx+"symbol_396.swf (Symbol 396 in ASV)\n";
  }
}
//check symbol_398.swf  (Symbol 398 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_398.swf",true);
sn="symbol_398.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_398"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_398.swf (Symbol 398 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_398.swf",true);
  sn="symbol_398.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_398"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_398.swf (Symbol 398 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_398.swf\n";
  } else {
    nfx=nfx+"symbol_398.swf (Symbol 398 in ASV)\n";
  }
}
//check symbol_399.swf  (Symbol 399 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_399.swf",true);
sn="symbol_399.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_399"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_399.swf (Symbol 399 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_399.swf",true);
  sn="symbol_399.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_399"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_399.swf (Symbol 399 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_399.swf\n";
  } else {
    nfx=nfx+"symbol_399.swf (Symbol 399 in ASV)\n";
  }
}
//check symbol_400.swf  (Symbol 400 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_400.swf",true);
sn="symbol_400.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_400"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_400.swf (Symbol 400 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_400.swf",true);
  sn="symbol_400.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_400"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_400.swf (Symbol 400 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_400.swf\n";
  } else {
    nfx=nfx+"symbol_400.swf (Symbol 400 in ASV)\n";
  }
}
//check symbol_405.swf  (Symbol 405 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_405.swf",true);
sn="symbol_405.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_405"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_405.swf (Symbol 405 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_405.swf",true);
  sn="symbol_405.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_405"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_405.swf (Symbol 405 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_405.swf\n";
  } else {
    nfx=nfx+"symbol_405.swf (Symbol 405 in ASV)\n";
  }
}
//check symbol_406.swf  (Symbol 406 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_406.swf",true);
sn="symbol_406.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_406"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_406.swf (Symbol 406 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_406.swf",true);
  sn="symbol_406.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_406"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_406.swf (Symbol 406 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_406.swf\n";
  } else {
    nfx=nfx+"symbol_406.swf (Symbol 406 in ASV)\n";
  }
}
//check symbol_407.swf  (Symbol 407 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_407.swf",true);
sn="symbol_407.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_407"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_407.swf (Symbol 407 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_407.swf",true);
  sn="symbol_407.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_407"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_407.swf (Symbol 407 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_407.swf\n";
  } else {
    nfx=nfx+"symbol_407.swf (Symbol 407 in ASV)\n";
  }
}
//check symbol_408.swf  (Symbol 408 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_408.swf",true);
sn="symbol_408.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_408"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_408.swf (Symbol 408 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_408.swf",true);
  sn="symbol_408.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_408"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_408.swf (Symbol 408 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_408.swf\n";
  } else {
    nfx=nfx+"symbol_408.swf (Symbol 408 in ASV)\n";
  }
}
//check symbol_409.swf  (Symbol 409 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_409.swf",true);
sn="symbol_409.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_409"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_409.swf (Symbol 409 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_409.swf",true);
  sn="symbol_409.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_409"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_409.swf (Symbol 409 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_409.swf\n";
  } else {
    nfx=nfx+"symbol_409.swf (Symbol 409 in ASV)\n";
  }
}
//check symbol_410.swf  (Symbol 410 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_410.swf",true);
sn="symbol_410.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_410"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_410.swf (Symbol 410 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_410.swf",true);
  sn="symbol_410.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_410"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_410.swf (Symbol 410 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_410.swf\n";
  } else {
    nfx=nfx+"symbol_410.swf (Symbol 410 in ASV)\n";
  }
}
//check symbol_411.swf  (Symbol 411 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_411.swf",true);
sn="symbol_411.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_411"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_411.swf (Symbol 411 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_411.swf",true);
  sn="symbol_411.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_411"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_411.swf (Symbol 411 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_411.swf\n";
  } else {
    nfx=nfx+"symbol_411.swf (Symbol 411 in ASV)\n";
  }
}
//check symbol_412.swf  (Symbol 412 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_412.swf",true);
sn="symbol_412.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_412"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_412.swf (Symbol 412 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_412.swf",true);
  sn="symbol_412.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_412"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_412.swf (Symbol 412 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_412.swf\n";
  } else {
    nfx=nfx+"symbol_412.swf (Symbol 412 in ASV)\n";
  }
}
//check symbol_413.swf  (Symbol 413 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_413.swf",true);
sn="symbol_413.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_413"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_413.swf (Symbol 413 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_413.swf",true);
  sn="symbol_413.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_413"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_413.swf (Symbol 413 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_413.swf\n";
  } else {
    nfx=nfx+"symbol_413.swf (Symbol 413 in ASV)\n";
  }
}
//check symbol_414.swf  (Symbol 414 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_414.swf",true);
sn="symbol_414.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_414"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_414.swf (Symbol 414 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_414.swf",true);
  sn="symbol_414.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_414"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_414.swf (Symbol 414 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_414.swf\n";
  } else {
    nfx=nfx+"symbol_414.swf (Symbol 414 in ASV)\n";
  }
}
//check symbol_415.swf  (Symbol 415 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_415.swf",true);
sn="symbol_415.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_415"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_415.swf (Symbol 415 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_415.swf",true);
  sn="symbol_415.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_415"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_415.swf (Symbol 415 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_415.swf\n";
  } else {
    nfx=nfx+"symbol_415.swf (Symbol 415 in ASV)\n";
  }
}
//check symbol_416.swf  (Symbol 416 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_416.swf",true);
sn="symbol_416.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_416"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_416.swf (Symbol 416 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_416.swf",true);
  sn="symbol_416.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_416"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_416.swf (Symbol 416 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_416.swf\n";
  } else {
    nfx=nfx+"symbol_416.swf (Symbol 416 in ASV)\n";
  }
}
//check symbol_417.swf  (Symbol 417 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_417.swf",true);
sn="symbol_417.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_417"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_417.swf (Symbol 417 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_417.swf",true);
  sn="symbol_417.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_417"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_417.swf (Symbol 417 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_417.swf\n";
  } else {
    nfx=nfx+"symbol_417.swf (Symbol 417 in ASV)\n";
  }
}
//check symbol_418.swf  (Symbol 418 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_418.swf",true);
sn="symbol_418.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_418"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_418.swf (Symbol 418 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_418.swf",true);
  sn="symbol_418.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_418"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_418.swf (Symbol 418 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_418.swf\n";
  } else {
    nfx=nfx+"symbol_418.swf (Symbol 418 in ASV)\n";
  }
}
//check symbol_420.swf  (Symbol 420 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_420.swf",true);
sn="symbol_420.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_420"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_420.swf (Symbol 420 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_420.swf",true);
  sn="symbol_420.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_420"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_420.swf (Symbol 420 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_420.swf\n";
  } else {
    nfx=nfx+"symbol_420.swf (Symbol 420 in ASV)\n";
  }
}
//check symbol_421.swf  (Symbol 421 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_421.swf",true);
sn="symbol_421.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_421"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_421.swf (Symbol 421 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_421.swf",true);
  sn="symbol_421.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_421"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_421.swf (Symbol 421 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_421.swf\n";
  } else {
    nfx=nfx+"symbol_421.swf (Symbol 421 in ASV)\n";
  }
}
//check symbol_422.swf  (Symbol 422 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_422.swf",true);
sn="symbol_422.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_422"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_422.swf (Symbol 422 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_422.swf",true);
  sn="symbol_422.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_422"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_422.swf (Symbol 422 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_422.swf\n";
  } else {
    nfx=nfx+"symbol_422.swf (Symbol 422 in ASV)\n";
  }
}
//check symbol_423.swf  (Symbol 423 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_423.swf",true);
sn="symbol_423.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_423"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_423.swf (Symbol 423 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_423.swf",true);
  sn="symbol_423.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_423"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_423.swf (Symbol 423 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_423.swf\n";
  } else {
    nfx=nfx+"symbol_423.swf (Symbol 423 in ASV)\n";
  }
}
//check symbol_424.swf  (Symbol 424 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_424.swf",true);
sn="symbol_424.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_424"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_424.swf (Symbol 424 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_424.swf",true);
  sn="symbol_424.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_424"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_424.swf (Symbol 424 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_424.swf\n";
  } else {
    nfx=nfx+"symbol_424.swf (Symbol 424 in ASV)\n";
  }
}
//check symbol_425.swf  (Symbol 425 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_425.swf",true);
sn="symbol_425.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_425"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_425.swf (Symbol 425 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_425.swf",true);
  sn="symbol_425.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_425"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_425.swf (Symbol 425 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_425.swf\n";
  } else {
    nfx=nfx+"symbol_425.swf (Symbol 425 in ASV)\n";
  }
}
//check symbol_427.swf  (Symbol 427 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_427.swf",true);
sn="symbol_427.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_427"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_427.swf (Symbol 427 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_427.swf",true);
  sn="symbol_427.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_427"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_427.swf (Symbol 427 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_427.swf\n";
  } else {
    nfx=nfx+"symbol_427.swf (Symbol 427 in ASV)\n";
  }
}
//check symbol_428.swf  (Symbol 428 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_428.swf",true);
sn="symbol_428.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_428"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_428.swf (Symbol 428 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_428.swf",true);
  sn="symbol_428.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_428"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_428.swf (Symbol 428 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_428.swf\n";
  } else {
    nfx=nfx+"symbol_428.swf (Symbol 428 in ASV)\n";
  }
}
//check symbol_429.swf  (Symbol 429 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_429.swf",true);
sn="symbol_429.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_429"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_429.swf (Symbol 429 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_429.swf",true);
  sn="symbol_429.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_429"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_429.swf (Symbol 429 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_429.swf\n";
  } else {
    nfx=nfx+"symbol_429.swf (Symbol 429 in ASV)\n";
  }
}
//check symbol_430.swf  (Symbol 430 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_430.swf",true);
sn="symbol_430.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_430"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_430.swf (Symbol 430 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_430.swf",true);
  sn="symbol_430.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_430"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_430.swf (Symbol 430 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_430.swf\n";
  } else {
    nfx=nfx+"symbol_430.swf (Symbol 430 in ASV)\n";
  }
}
//check symbol_431.swf  (Symbol 431 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_431.swf",true);
sn="symbol_431.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_431"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_431.swf (Symbol 431 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_431.swf",true);
  sn="symbol_431.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_431"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_431.swf (Symbol 431 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_431.swf\n";
  } else {
    nfx=nfx+"symbol_431.swf (Symbol 431 in ASV)\n";
  }
}
//check symbol_437.swf  (Symbol 437 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_437.swf",true);
sn="symbol_437.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_437"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_437.swf (Symbol 437 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_437.swf",true);
  sn="symbol_437.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_437"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_437.swf (Symbol 437 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_437.swf\n";
  } else {
    nfx=nfx+"symbol_437.swf (Symbol 437 in ASV)\n";
  }
}
//check symbol_442.swf  (Symbol 442 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_442.swf",true);
sn="symbol_442.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_442"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_442.swf (Symbol 442 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_442.swf",true);
  sn="symbol_442.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_442"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_442.swf (Symbol 442 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_442.swf\n";
  } else {
    nfx=nfx+"symbol_442.swf (Symbol 442 in ASV)\n";
  }
}
//check symbol_443.swf  (Symbol 443 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_443.swf",true);
sn="symbol_443.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_443"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_443.swf (Symbol 443 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_443.swf",true);
  sn="symbol_443.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_443"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_443.swf (Symbol 443 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_443.swf\n";
  } else {
    nfx=nfx+"symbol_443.swf (Symbol 443 in ASV)\n";
  }
}
//check symbol_444.swf  (Symbol 444 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_444.swf",true);
sn="symbol_444.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_444"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_444.swf (Symbol 444 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_444.swf",true);
  sn="symbol_444.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_444"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_444.swf (Symbol 444 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_444.swf\n";
  } else {
    nfx=nfx+"symbol_444.swf (Symbol 444 in ASV)\n";
  }
}
//check symbol_445.swf  (Symbol 445 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_445.swf",true);
sn="symbol_445.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_445"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_445.swf (Symbol 445 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_445.swf",true);
  sn="symbol_445.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_445"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_445.swf (Symbol 445 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_445.swf\n";
  } else {
    nfx=nfx+"symbol_445.swf (Symbol 445 in ASV)\n";
  }
}
//check symbol_446.swf  (Symbol 446 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_446.swf",true);
sn="symbol_446.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_446"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_446.swf (Symbol 446 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_446.swf",true);
  sn="symbol_446.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_446"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_446.swf (Symbol 446 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_446.swf\n";
  } else {
    nfx=nfx+"symbol_446.swf (Symbol 446 in ASV)\n";
  }
}
//check symbol_447.swf  (Symbol 447 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_447.swf",true);
sn="symbol_447.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_447"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_447.swf (Symbol 447 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_447.swf",true);
  sn="symbol_447.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_447"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_447.swf (Symbol 447 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_447.swf\n";
  } else {
    nfx=nfx+"symbol_447.swf (Symbol 447 in ASV)\n";
  }
}
//check symbol_448.swf  (Symbol 448 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_448.swf",true);
sn="symbol_448.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_448"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_448.swf (Symbol 448 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_448.swf",true);
  sn="symbol_448.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_448"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_448.swf (Symbol 448 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_448.swf\n";
  } else {
    nfx=nfx+"symbol_448.swf (Symbol 448 in ASV)\n";
  }
}
//check symbol_449.swf  (Symbol 449 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_449.swf",true);
sn="symbol_449.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_449"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_449.swf (Symbol 449 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_449.swf",true);
  sn="symbol_449.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_449"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_449.swf (Symbol 449 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_449.swf\n";
  } else {
    nfx=nfx+"symbol_449.swf (Symbol 449 in ASV)\n";
  }
}
//check symbol_450.swf  (Symbol 450 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_450.swf",true);
sn="symbol_450.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_450"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_450.swf (Symbol 450 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_450.swf",true);
  sn="symbol_450.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_450"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_450.swf (Symbol 450 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_450.swf\n";
  } else {
    nfx=nfx+"symbol_450.swf (Symbol 450 in ASV)\n";
  }
}
//check symbol_451.swf  (Symbol 451 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_451.swf",true);
sn="symbol_451.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_451"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_451.swf (Symbol 451 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_451.swf",true);
  sn="symbol_451.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_451"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_451.swf (Symbol 451 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_451.swf\n";
  } else {
    nfx=nfx+"symbol_451.swf (Symbol 451 in ASV)\n";
  }
}
//check symbol_452.swf  (Symbol 452 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_452.swf",true);
sn="symbol_452.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_452"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_452.swf (Symbol 452 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_452.swf",true);
  sn="symbol_452.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_452"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_452.swf (Symbol 452 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_452.swf\n";
  } else {
    nfx=nfx+"symbol_452.swf (Symbol 452 in ASV)\n";
  }
}
//check symbol_453.swf  (Symbol 453 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_453.swf",true);
sn="symbol_453.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_453"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_453.swf (Symbol 453 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_453.swf",true);
  sn="symbol_453.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_453"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_453.swf (Symbol 453 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_453.swf\n";
  } else {
    nfx=nfx+"symbol_453.swf (Symbol 453 in ASV)\n";
  }
}
//check symbol_454.swf  (Symbol 454 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_454.swf",true);
sn="symbol_454.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_454"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_454.swf (Symbol 454 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_454.swf",true);
  sn="symbol_454.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_454"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_454.swf (Symbol 454 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_454.swf\n";
  } else {
    nfx=nfx+"symbol_454.swf (Symbol 454 in ASV)\n";
  }
}
//check symbol_455.swf  (Symbol 455 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_455.swf",true);
sn="symbol_455.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_455"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_455.swf (Symbol 455 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_455.swf",true);
  sn="symbol_455.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_455"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_455.swf (Symbol 455 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_455.swf\n";
  } else {
    nfx=nfx+"symbol_455.swf (Symbol 455 in ASV)\n";
  }
}
//check symbol_465.swf  (Symbol 465 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_465.swf",true);
sn="symbol_465.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_465"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_465.swf (Symbol 465 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_465.swf",true);
  sn="symbol_465.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_465"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_465.swf (Symbol 465 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_465.swf\n";
  } else {
    nfx=nfx+"symbol_465.swf (Symbol 465 in ASV)\n";
  }
}
//check symbol_466.swf  (Symbol 466 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_466.swf",true);
sn="symbol_466.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_466"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_466.swf (Symbol 466 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_466.swf",true);
  sn="symbol_466.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_466"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_466.swf (Symbol 466 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_466.swf\n";
  } else {
    nfx=nfx+"symbol_466.swf (Symbol 466 in ASV)\n";
  }
}
//check symbol_468.swf  (Symbol 468 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_468.swf",true);
sn="symbol_468.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_468"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_468.swf (Symbol 468 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_468.swf",true);
  sn="symbol_468.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_468"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_468.swf (Symbol 468 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_468.swf\n";
  } else {
    nfx=nfx+"symbol_468.swf (Symbol 468 in ASV)\n";
  }
}
//check symbol_470.swf  (Symbol 470 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_470.swf",true);
sn="symbol_470.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_470"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_470.swf (Symbol 470 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_470.swf",true);
  sn="symbol_470.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_470"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_470.swf (Symbol 470 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_470.swf\n";
  } else {
    nfx=nfx+"symbol_470.swf (Symbol 470 in ASV)\n";
  }
}
//check symbol_472.swf  (Symbol 472 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_472.swf",true);
sn="symbol_472.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_472"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_472.swf (Symbol 472 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_472.swf",true);
  sn="symbol_472.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_472"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_472.swf (Symbol 472 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_472.swf\n";
  } else {
    nfx=nfx+"symbol_472.swf (Symbol 472 in ASV)\n";
  }
}
//check symbol_473.swf  (Symbol 473 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_473.swf",true);
sn="symbol_473.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_473"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_473.swf (Symbol 473 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_473.swf",true);
  sn="symbol_473.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_473"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_473.swf (Symbol 473 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_473.swf\n";
  } else {
    nfx=nfx+"symbol_473.swf (Symbol 473 in ASV)\n";
  }
}
//check symbol_483.swf  (Symbol 483 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_483.swf",true);
sn="symbol_483.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_483"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_483.swf (Symbol 483 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_483.swf",true);
  sn="symbol_483.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_483"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_483.swf (Symbol 483 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_483.swf\n";
  } else {
    nfx=nfx+"symbol_483.swf (Symbol 483 in ASV)\n";
  }
}
//check symbol_494.swf  (Symbol 494 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_494.swf",true);
sn="symbol_494.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_494"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_494.swf (Symbol 494 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_494.swf",true);
  sn="symbol_494.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_494"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_494.swf (Symbol 494 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_494.swf\n";
  } else {
    nfx=nfx+"symbol_494.swf (Symbol 494 in ASV)\n";
  }
}
//check symbol_496.swf  (Symbol 496 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_496.swf",true);
sn="symbol_496.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_496"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_496.swf (Symbol 496 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_496.swf",true);
  sn="symbol_496.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_496"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_496.swf (Symbol 496 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_496.swf\n";
  } else {
    nfx=nfx+"symbol_496.swf (Symbol 496 in ASV)\n";
  }
}
//check symbol_497.swf  (Symbol 497 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_497.swf",true);
sn="symbol_497.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_497"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_497.swf (Symbol 497 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_497.swf",true);
  sn="symbol_497.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_497"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_497.swf (Symbol 497 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_497.swf\n";
  } else {
    nfx=nfx+"symbol_497.swf (Symbol 497 in ASV)\n";
  }
}
//check symbol_500.swf  (Symbol 500 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_500.swf",true);
sn="symbol_500.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_500"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_500.swf (Symbol 500 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_500.swf",true);
  sn="symbol_500.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_500"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_500.swf (Symbol 500 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_500.swf\n";
  } else {
    nfx=nfx+"symbol_500.swf (Symbol 500 in ASV)\n";
  }
}
//check symbol_501.swf  (Symbol 501 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_501.swf",true);
sn="symbol_501.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_501"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_501.swf (Symbol 501 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_501.swf",true);
  sn="symbol_501.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_501"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_501.swf (Symbol 501 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_501.swf\n";
  } else {
    nfx=nfx+"symbol_501.swf (Symbol 501 in ASV)\n";
  }
}
//check symbol_502.swf  (Symbol 502 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_502.swf",true);
sn="symbol_502.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_502"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_502.swf (Symbol 502 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_502.swf",true);
  sn="symbol_502.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_502"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_502.swf (Symbol 502 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_502.swf\n";
  } else {
    nfx=nfx+"symbol_502.swf (Symbol 502 in ASV)\n";
  }
}
//check symbol_503.swf  (Symbol 503 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_503.swf",true);
sn="symbol_503.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_503"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_503.swf (Symbol 503 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_503.swf",true);
  sn="symbol_503.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_503"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_503.swf (Symbol 503 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_503.swf\n";
  } else {
    nfx=nfx+"symbol_503.swf (Symbol 503 in ASV)\n";
  }
}
//check symbol_504.swf  (Symbol 504 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_504.swf",true);
sn="symbol_504.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_504"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_504.swf (Symbol 504 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_504.swf",true);
  sn="symbol_504.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_504"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_504.swf (Symbol 504 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_504.swf\n";
  } else {
    nfx=nfx+"symbol_504.swf (Symbol 504 in ASV)\n";
  }
}
//check symbol_506.swf  (Symbol 506 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_506.swf",true);
sn="symbol_506.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_506"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_506.swf (Symbol 506 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_506.swf",true);
  sn="symbol_506.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_506"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_506.swf (Symbol 506 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_506.swf\n";
  } else {
    nfx=nfx+"symbol_506.swf (Symbol 506 in ASV)\n";
  }
}
//check symbol_519.swf  (Symbol 519 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_519.swf",true);
sn="symbol_519.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_519"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_519.swf (Symbol 519 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_519.swf",true);
  sn="symbol_519.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_519"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_519.swf (Symbol 519 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_519.swf\n";
  } else {
    nfx=nfx+"symbol_519.swf (Symbol 519 in ASV)\n";
  }
}
//check symbol_520.swf  (Symbol 520 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_520.swf",true);
sn="symbol_520.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_520"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_520.swf (Symbol 520 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_520.swf",true);
  sn="symbol_520.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_520"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_520.swf (Symbol 520 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_520.swf\n";
  } else {
    nfx=nfx+"symbol_520.swf (Symbol 520 in ASV)\n";
  }
}
//check symbol_521.swf  (Symbol 521 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_521.swf",true);
sn="symbol_521.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_521"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_521.swf (Symbol 521 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_521.swf",true);
  sn="symbol_521.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_521"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_521.swf (Symbol 521 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_521.swf\n";
  } else {
    nfx=nfx+"symbol_521.swf (Symbol 521 in ASV)\n";
  }
}
//check symbol_562.swf  (Symbol 523 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_562.swf",true);
sn="symbol_562.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_562"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_562.swf (Symbol 523 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_562.swf",true);
  sn="symbol_562.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_562"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_562.swf (Symbol 523 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_562.swf\n";
  } else {
    nfx=nfx+"symbol_562.swf (Symbol 523 in ASV)\n";
  }
}
//check symbol_563.swf  (Symbol 524 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_563.swf",true);
sn="symbol_563.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_563"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_563.swf (Symbol 524 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_563.swf",true);
  sn="symbol_563.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_563"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_563.swf (Symbol 524 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_563.swf\n";
  } else {
    nfx=nfx+"symbol_563.swf (Symbol 524 in ASV)\n";
  }
}
//check symbol_564.swf  (Symbol 525 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_564.swf",true);
sn="symbol_564.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_564"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_564.swf (Symbol 525 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_564.swf",true);
  sn="symbol_564.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_564"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_564.swf (Symbol 525 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_564.swf\n";
  } else {
    nfx=nfx+"symbol_564.swf (Symbol 525 in ASV)\n";
  }
}
//check symbol_565.swf  (Symbol 526 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_565.swf",true);
sn="symbol_565.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_565"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_565.swf (Symbol 526 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_565.swf",true);
  sn="symbol_565.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_565"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_565.swf (Symbol 526 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_565.swf\n";
  } else {
    nfx=nfx+"symbol_565.swf (Symbol 526 in ASV)\n";
  }
}
//check symbol_568.swf  (Symbol 529 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_568.swf",true);
sn="symbol_568.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_568"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_568.swf (Symbol 529 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_568.swf",true);
  sn="symbol_568.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_568"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_568.swf (Symbol 529 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_568.swf\n";
  } else {
    nfx=nfx+"symbol_568.swf (Symbol 529 in ASV)\n";
  }
}
//check symbol_569.swf  (Symbol 530 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_569.swf",true);
sn="symbol_569.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_569"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_569.swf (Symbol 530 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_569.swf",true);
  sn="symbol_569.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_569"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_569.swf (Symbol 530 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_569.swf\n";
  } else {
    nfx=nfx+"symbol_569.swf (Symbol 530 in ASV)\n";
  }
}
//check symbol_573.swf  (Symbol 534 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_573.swf",true);
sn="symbol_573.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_573"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_573.swf (Symbol 534 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_573.swf",true);
  sn="symbol_573.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_573"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_573.swf (Symbol 534 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_573.swf\n";
  } else {
    nfx=nfx+"symbol_573.swf (Symbol 534 in ASV)\n";
  }
}
//check symbol_575.swf  (Symbol 536 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_575.swf",true);
sn="symbol_575.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_575"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_575.swf (Symbol 536 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_575.swf",true);
  sn="symbol_575.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_575"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_575.swf (Symbol 536 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_575.swf\n";
  } else {
    nfx=nfx+"symbol_575.swf (Symbol 536 in ASV)\n";
  }
}
//check symbol_576.swf  (Symbol 537 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_576.swf",true);
sn="symbol_576.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_576"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_576.swf (Symbol 537 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_576.swf",true);
  sn="symbol_576.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_576"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_576.swf (Symbol 537 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_576.swf\n";
  } else {
    nfx=nfx+"symbol_576.swf (Symbol 537 in ASV)\n";
  }
}
//check symbol_577.swf  (Symbol 538 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_577.swf",true);
sn="symbol_577.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_577"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_577.swf (Symbol 538 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_577.swf",true);
  sn="symbol_577.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_577"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_577.swf (Symbol 538 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_577.swf\n";
  } else {
    nfx=nfx+"symbol_577.swf (Symbol 538 in ASV)\n";
  }
}
//check symbol_585.swf  (Symbol 546 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_585.swf",true);
sn="symbol_585.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_585"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_585.swf (Symbol 546 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_585.swf",true);
  sn="symbol_585.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_585"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_585.swf (Symbol 546 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_585.swf\n";
  } else {
    nfx=nfx+"symbol_585.swf (Symbol 546 in ASV)\n";
  }
}
//check symbol_586.swf  (Symbol 547 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_586.swf",true);
sn="symbol_586.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_586"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_586.swf (Symbol 547 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_586.swf",true);
  sn="symbol_586.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_586"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_586.swf (Symbol 547 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_586.swf\n";
  } else {
    nfx=nfx+"symbol_586.swf (Symbol 547 in ASV)\n";
  }
}
//check symbol_590.swf  (Symbol 551 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_590.swf",true);
sn="symbol_590.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_590"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_590.swf (Symbol 551 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_590.swf",true);
  sn="symbol_590.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_590"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_590.swf (Symbol 551 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_590.swf\n";
  } else {
    nfx=nfx+"symbol_590.swf (Symbol 551 in ASV)\n";
  }
}
//check symbol_598.swf  (Symbol 559 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_598.swf",true);
sn="symbol_598.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_598"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_598.swf (Symbol 559 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_598.swf",true);
  sn="symbol_598.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_598"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_598.swf (Symbol 559 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_598.swf\n";
  } else {
    nfx=nfx+"symbol_598.swf (Symbol 559 in ASV)\n";
  }
}
//check symbol_602.swf  (Symbol 563 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_602.swf",true);
sn="symbol_602.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_602"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_602.swf (Symbol 563 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_602.swf",true);
  sn="symbol_602.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_602"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_602.swf (Symbol 563 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_602.swf\n";
  } else {
    nfx=nfx+"symbol_602.swf (Symbol 563 in ASV)\n";
  }
}
//check symbol_603.swf  (Symbol 564 in ASV)
fl.getDocumentDOM().importFile("file:///"+dir+"symbol_603.swf",true);
sn="symbol_603.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_603"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_603.swf (Symbol 564 in ASV)\n";}
pr=false;
ok=false;
if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {pr=true;}
  doc.exitEditMode();
}
if (pr==true){
  lib.deleteItem(sn);
  fl.getDocumentDOM().importFile("file:///"+dir+"swapped/symbol_603.swf",true);
  sn="symbol_603.swf"; si=lib.findItemIndex(sn);
  if (si=='') {sn="symbol_603"; si=lib.findItemIndex(sn);}
  if (si=='') {ms=ms+"symbol_603.swf (Symbol 564 in ASV)\n";}
  if (si!=""){
  lib.editItem(sn);
  doc.selectAll();
  tl=doc.getTimeline();
  newSel[0]=tl.layers[0].frames[0].elements[0];
  if (!((!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))))) {ok=true;} }
  doc.exitEditMode();
  if (ok==true){
    cfs=cfs+"symbol_603.swf\n";
  } else {
    nfx=nfx+"symbol_603.swf (Symbol 564 in ASV)\n";
  }
}
if (cfs!=""){
 fl.trace("Copy and overwrite following files from 'swapped' folder to rebuild folder:");
 fl.trace(""); fl.trace(cfs);
}
if (cfb!=""){
 fl.trace("Copy and overwrite following files from 'autobadfills' folder to rebuild folder:");
 fl.trace(""); fl.trace(cfb);
}
if (nfx!=""){
 fl.trace("Check if following symbols in ASV are really blank using Preview in Library Tab.");
 fl.trace(" * If a symbol is not blank, manually create a replacement placeholder SWF file and overwrite.");
 fl.trace(" * If a symbol is really blank, you may either try to continue using it as it is, or, if this fails, manually create a replacement placeholder SWF file and overwrite.");
 fl.trace(""); fl.trace(nfx);
}
if (ms!=""){
 fl.trace("Manually create replacement placeholder SWF files and overwrite the following:");
 fl.trace(""); fl.trace(ms);
}
if ((ms=="")&&(cfs=="")&&(cfb=="")&&(nfx=="")){
 fl.trace("No problems were detected.");
 fl.trace("");
}
fl.trace("Test complete.");
fl.trace("");
