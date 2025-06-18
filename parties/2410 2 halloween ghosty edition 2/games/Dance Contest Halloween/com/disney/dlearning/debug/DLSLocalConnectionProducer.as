
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.disney.dlearning.debug.DLSLocalConnectionProducer extends Object
    {
        var conn;
        function DLSLocalConnectionProducer () {
            super();
            conn = new LocalConnection();
            conn.onStatus = onStatus;
        }
        function sendMessage(type, message) {
            var _local2 = new Object();
            _local2.type = type;
            _local2.message = message;
            var _local3 = new com.disney.dlearning.serialization.JSON();
            conn.send("DLS.CONNECTION", "DLSlcHandler", _local3.stringify(_local2));
        }
        function onStatus(event) {
            switch (event.level) {
                case "status" : 
                    break;
                case "error" : 
                    break;
            }
        }
    }
