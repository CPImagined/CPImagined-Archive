package com.disney.disneylearning.managers.debug{
    import flash.net.LocalConnection;
    import flash.events.StatusEvent;
    import com.adobe.serialization.json.JSON;
    import com.adobe.serialization.json.*;
    import com.adobe.crypto.*;

    public class DLSLocalConnectionProducer {

        private var conn:LocalConnection;
        private var key:String = "DISNEY_LEARNING_SUPER_KEY";

        public function DLSLocalConnectionProducer(){
            this.conn = new LocalConnection();
            this.conn.addEventListener(StatusEvent.STATUS, this.onStatus);
        }

        public function sendMessage(_arg_1:String, _arg_2:String):void{
            var _local_3:Object = new Object();
            _local_3.type = _arg_1;
            _local_3.message = _arg_2;
            this.conn.send("DLS.CONNECTION", "DLSlcHandler", com.adobe.serialization.json.JSON.encode(_local_3));
        }

        private function onStatus(_arg_1:StatusEvent):void{
            switch (_arg_1.level){
                case "status":
                    trace("LocalConnection.send() succeeded");
                    return;
                case "error":
                    trace("LocalConnection.send() failed");
                    return;
            };
        }


    }
}//package com.disney.disneylearning.managers.debug
