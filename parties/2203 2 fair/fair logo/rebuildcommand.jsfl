fl.outputPanel.clear();
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

if (fl.runScript("file:///"+dp+"jsfl/util/check_text_tool.jsfl","d94iwjydr")!="0") {
if (fl.runScript("file:///"+dp+"jsfl/import.jsfl","ra3i8jqww")!="0") {
fl.runScript("file:///"+dp+"jsfl/rebuildpart1.jsfl");
fl.runScript("file:///"+dp+"jsfl/rebuildpart2.jsfl");
fl.runScript("file:///"+dp+"jsfl/rebuildpart3.jsfl");
fl.runScript("file:///"+dp+"jsfl/rebuildpart4.jsfl");
fl.runScript("file:///"+dp+"jsfl/rebuildpart5.jsfl");
fl.saveDocument(fl.getDocumentDOM(), "file:///"+dp+"logo_rebuild_done.fla");
alert("Rebuild completed.")
}
}

    } else alert(msg);
  } else alert(msg);
} else alert(msg);

