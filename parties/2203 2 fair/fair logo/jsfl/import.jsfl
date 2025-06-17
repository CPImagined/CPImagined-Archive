var dp = "";
var fn = "logo_rebuild.fla";
var msg = "Message from Action Script Viewer:\n\n"+
          "Before running the rebuild script, the document\n\n"+fn+"\n\nmust be opened as the only document in Flash.\n\n"+
          "Please refer to readme.txt file for instructions.";
var fn = FLfile.platformPathToURI(fn);
fn = fn.substr(8,fn.length-8);

if (flash.documents[0] != undefined)
{
  dp = flash.documents[0].pathURI;
  if (dp != undefined)
  {
    if ((dp.substr(0,8) == "file:///") &&
        (dp.substr(dp.length-fn.length,fn.length) == fn))
    {
       dp = dp.substr(8,dp.length - fn.length -8);

fl.openDocument("file:///"+dp+"logo_rebuild.fla");
var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var si,ms,ms2,sn;
var newSel=new Array();
var name, item,nn,bitmapname,bitmapnamelen;
ms="";
ms2="";

function ra3i8jqww() {
if (undefined==doc) {fl.trace("Message from ASV: FLA could not be opened. Make sure target Flash version is correct. Rebuild cannot continue."); fl.trace(""); return("0");}
if (ms2!="") {fl.trace("Message from ASV: Flash may not have correctly imported the files(s) listed below:")
fl.trace("");
fl.trace(ms2);
fl.trace("");
fl.trace("");
if (!confirm("Message from ASV: Flash may not have correctly imported some graphic symbols.\n\nThese symbols are listed in the output panel.\n\nHelpful hints about this issue can be found in 'import_hints.txt' file in the rebuild folder.\n\nDo you want to ignore this and continue?")) return("0");}
if (ms=="") return("1"); else {
fl.trace(""); fl.trace("Message from ASV: Flash was not able to import following file(s):"); fl.trace(""); fl.trace(ms); fl.trace("");
if ((ms.indexOf(".flv") !== -1)) { fl.trace("(When importing FLV files, make sure to select the options specified in readme.txt)");};
fl.trace("Rebuild cannot continue until this is fixed.");
return("0");} }

function ra3i8jqwa()
{
  var newbmps = new Array();
  for (var n=0;n<lib.items.length;n++)
  {
    item = lib.items[n];
    if (item.itemType=="bitmap")
    {
      name = item.name;
      if (name.substring(0,bitmapnamelen)==bitmapname)
      {
        if (name.substring(name.length - 6)!="  fill")
        {
          newbmps.push(item);
        }
      }
    }
  }
  newbmps.sort(function(a, b){return parseInt(a.name.substring(bitmapnamelen)) - parseInt(b.name.substring(bitmapnamelen))});
  nn=0;
  for (var n=0;n<newbmps.length;n++)
  {
    item = newbmps[n];
    if (arguments[nn]=="lossless") {item.compressionType="lossless";} else {item.compressionType="photo";}
    if (arguments[nn+1]=="smoothing") {item.allowSmoothing=true;} else {item.allowSmoothing=false;}
    nn+=2;
    if (nn>=arguments.length) break;
  }
  for (var n=0;n<newbmps.length;n++)
  {
    item = newbmps[n];
    item.name=item.name+"  fill";
  }
}

lib.selectAll();
lib.deleteItem();
bitmapname="Bitmap";
fl.getDocumentDOM().importFile("file:///"+dp+"asv_import_bitmap_symbol.swf",true);
if (lib.items.length==2){
item = lib.items[0];
if (item.itemType!="bitmap"){lib.selectItem(item.name)}else{lib.selectItem(lib.items[1].name)};
lib.deleteItem();
item = lib.items[0];
if (item.itemType=="bitmap") {bitmapname=item.name.substring(0,item.name.length-2);item.name="ASV"}
bitmapname=bitmapname+" ";
bitmapnamelen=bitmapname.length;
}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_1.swf",true);
sn="symbol_1.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_1"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_1.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_1.swf (Symbol 1 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_6.swf",true);
sn="symbol_6.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_6"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_6.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_6.swf (Symbol 6 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"sound_8.mp3",true);
sn="sound_8.mp3"; si=lib.findItemIndex(sn);
if (si=='') {sn="sound_8"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"sound_8.mp3\n";}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_9.swf",true);
sn="symbol_9.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_9"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_9.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_9.swf (Symbol 9 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_11.swf",true);
sn="symbol_11.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_11"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_11.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_11.swf (Symbol 11 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_12.swf",true);
sn="symbol_12.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_12"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_12.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_12.swf (Symbol 12 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_13.swf",true);
sn="symbol_13.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_13"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_13.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_13.swf (Symbol 13 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_15.swf",true);
sn="symbol_15.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_15"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_15.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_15.swf (Symbol 15 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_20.swf",true);
sn="symbol_20.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_20"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_20.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_20.swf (Symbol 20 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_22.swf",true);
sn="symbol_22.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_22"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_22.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_22.swf (Symbol 22 in ASV)\n";}
doc.exitEditMode();}
fl.getDocumentDOM().importFile("file:///"+dp+"symbol_23.swf",true);
sn="symbol_23.swf"; si=lib.findItemIndex(sn);
if (si=='') {sn="symbol_23"; si=lib.findItemIndex(sn);}
if (si=='') {ms=ms+"symbol_23.swf\n";}
if (si!=""){
lib.editItem(sn);
doc.selectAll();
tl=doc.getTimeline();
newSel[0]=tl.layers[0].frames[0].elements[0];
if (!newSel[0] || ((newSel[0].width==0) && (newSel[0].height==0))) {ms2=ms2+"symbol_23.swf (Symbol 23 in ASV)\n";}
doc.exitEditMode();}

    } else alert(msg);
  } else alert(msg);
} else alert(msg);

