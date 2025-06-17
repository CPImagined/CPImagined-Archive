//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.JSONLoader extends com.clubpenguin.util.EventDispatcher
    {
        var loadVars, updateListeners;
        function JSONLoader () {
            super();
        }
        function load(url) {
            raw = "";
            data = null;
            loadVars = new LoadVars();
            loadVars.onData = com.clubpenguin.util.Delegate.create(this, onData);
            loadVars.load(url);
        }
        function onData(jsonText) {
            if (jsonText == undefined) {
                updateListeners(FAIL);
                return(undefined);
            }
            try {
                raw = jsonText;
                data = com.clubpenguin.util.JSONParser.parse(jsonText);
                updateListeners(COMPLETE);
            } catch(ex) {
                updateListeners(FAIL);
            }
        }
        function toString() {
            return("[JSONLoader]");
        }
        static var COMPLETE = "complete";
        static var FAIL = "fail";
        static var CLASS_NAME = "com.clubpenguin.util.JSONLoader";
        var raw = "";
        var data = null;
    }
