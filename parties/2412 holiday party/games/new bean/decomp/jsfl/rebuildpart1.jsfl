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

//fl.enableImmediateUpdates();
fl.openDocument("file:///"+dp+"BeanCounters_rebuild.fla");
var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,li,ci,pi,tx,r0,nr,cx,cy,el,sm;

//movie properties
doc.width=760;
doc.height=480;
doc.frameRate=24;
doc.backgroundColor="#3399CC";


    } else alert(msg);
  } else alert(msg);
} else alert(msg);

