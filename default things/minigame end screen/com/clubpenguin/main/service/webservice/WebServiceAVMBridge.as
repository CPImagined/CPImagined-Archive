//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice
{
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.services.IAVMBridgeService;

    public class WebServiceAVMBridge 
    {


        public static function sendData(bridge:IAVMBridgeService, name:String, key:String, value:*, isDone:Boolean):void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_WEB_SERVICE_DATA);
            message.data = {
                "name":name,
                "key":key,
                "value":value,
                "isDone":isDone
            };
            bridge.send(message);
        }


    }
}//package com.clubpenguin.main.service.webservice
