//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.debug.DLSLocalConnectionProducer extends Object
    {
        var conn;
        function DLSLocalConnectionProducer () {
            super();
            conn = new LocalConnection();
            conn.onStatus = onStatus;
        }
        function sendMessage(_arg_5, _arg_4) {
            var _local_2 = new Object();
            _local_2.type = _arg_5;
            _local_2.message = _arg_4;
            var _local_3 = new com.disney.dlearning.serialization.JSON();
            conn.send("DLS.CONNECTION", "DLSlcHandler", _local_3.stringify(_local_2));
        }
        function onStatus(_arg_1) {
            switch (_arg_1.level) {
                case "status" : 
                    break;
                case "error" : 
            }
        }
    }
