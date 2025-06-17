//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.disneylearning.managers.debug
{
    import flash.net.LocalConnection;
    import flash.events.StatusEvent;
    import com.adobe.serialization.json.JSON;
    import com.adobe.serialization.json.*;
    import com.adobe.crypto.*;

    public class DLSLocalConnectionProducer 
    {

        private var conn:LocalConnection;
        private var key:String = "DISNEY_LEARNING_SUPER_KEY";

        public function DLSLocalConnectionProducer()
        {
            this.conn = new LocalConnection();
            this.conn.addEventListener(StatusEvent.STATUS, this.onStatus);
        }

        public function sendMessage(_arg_1:String, message:String):void
        {
            var m:Object = new Object();
            m.type = _arg_1;
            m.message = message;
            this.conn.send("DLS.CONNECTION", "DLSlcHandler", com.adobe.serialization.json.JSON.encode(m));
        }

        private function onStatus(event:StatusEvent):void
        {
            switch (event.level)
            {
                case "status":
                    break;
                case "error":
                    break;
            };
        }


    }
}//package com.disney.disneylearning.managers.debug
