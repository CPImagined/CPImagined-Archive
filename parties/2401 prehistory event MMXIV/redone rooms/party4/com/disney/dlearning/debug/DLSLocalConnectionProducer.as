//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.debug.DLSLocalConnectionProducer extends Object
    {
        var conn;
        function DLSLocalConnectionProducer () {
            super();
            conn = new LocalConnection();
            conn.onStatus = onStatus;
        }
        function sendMessage(type, message) {
            var _local_2 = new Object();
            _local_2.type = type;
            _local_2.message = message;
            var _local_3 = new com.disney.dlearning.serialization.JSON();
            trace("[DLS CONNECTION]: Sending message");
            conn.send("DLS.CONNECTION", "DLSlcHandler", _local_3.stringify(_local_2));
        }
        function onStatus(event) {
            switch (event.level) {
                case "status" : 
                    trace("[DLS CONNECTION]:Send() succeeded");
                    break;
                case "error" : 
                    trace("[DLS CONNECTION]:Send() failed");
                    break;
            }
        }
    }
