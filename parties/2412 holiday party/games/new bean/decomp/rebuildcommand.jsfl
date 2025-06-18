fl.outputPanel.clear();
var dp = "";
var fn = "BeanCounters_rebuild.fla";
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
alert("Imports completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart1.jsfl");
alert("Part 1 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart2.jsfl");
alert("Part 2 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart3.jsfl");
alert("Part 3 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart4.jsfl");
alert("Part 4 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart5.jsfl");
alert("Part 5 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart6.jsfl");
alert("Part 6 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart7.jsfl");
alert("Part 7 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart8.jsfl");
alert("Part 8 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart9.jsfl");
alert("Part 9 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart10.jsfl");
fl.saveDocument(fl.getDocumentDOM(), "file:///"+dp+"BeanCounters_rebuild_backup_1.fla");
FLfile.write("file:///"+dp+"prompted_mode_log.txt","Rebuild part 10 completed. Saved as BeanCounters_rebuild_backup_1.fla\r\n","append");
alert("Part 10 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart11.jsfl");
alert("Part 11 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart12.jsfl");
alert("Part 12 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart13.jsfl");
alert("Part 13 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart14.jsfl");
alert("Part 14 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart15.jsfl");
alert("Part 15 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart16.jsfl");
alert("Part 16 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart17.jsfl");
alert("Part 17 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart18.jsfl");
alert("Part 18 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart19.jsfl");
alert("Part 19 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart20.jsfl");
fl.saveDocument(fl.getDocumentDOM(), "file:///"+dp+"BeanCounters_rebuild_backup_2.fla");
FLfile.write("file:///"+dp+"prompted_mode_log.txt","Rebuild part 20 completed. Saved as BeanCounters_rebuild_backup_2.fla\r\n","append");
alert("Part 20 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart21.jsfl");
alert("Part 21 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart22.jsfl");
alert("Part 22 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart23.jsfl");
alert("Part 23 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart24.jsfl");
alert("Part 24 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart25.jsfl");
alert("Part 25 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart26.jsfl");
alert("Part 26 of 27 completed.");
fl.runScript("file:///"+dp+"jsfl/rebuildpart27.jsfl");
fl.saveDocument(fl.getDocumentDOM(), "file:///"+dp+"BeanCounters_rebuild_done.fla");
alert("Rebuild completed.")
}
}

    } else alert(msg);
  } else alert(msg);
} else alert(msg);

