var dp = "";
var fn = "SledRacer_rebuild.fla";
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

fl.openDocument("file:///"+dp+"SledRacer_rebuild.fla");
function d94iwjydr() {
var doc=fl.getDocumentDOM();
if (undefined==doc) {fl.trace("Message from ASV: FLA could not be opened. Make sure target Flash version is correct. Rebuild cannot continue."); fl.trace(""); return("0");}
var tl=doc.getTimeline();
doc.addNewText({left:0, top:0, right:100, bottom:100});
var tx=tl.layers[0].frames[0].elements[0];
var tt = (tx.textType=="static");
doc.setTextString("test");
doc.selectAll();
doc.deleteSelection();
if (tt) {fl.trace("Message from ASV: 'Static Text' option is selected in Flash Text Tool properties. This is incompatible with current rebuild. Please select 'Dynamic Text' in Text Tool properties, exit Flash, then restart the rebuild.");return("0");}else{return("1")}
}

    } else alert(msg);
  } else alert(msg);
} else alert(msg);

