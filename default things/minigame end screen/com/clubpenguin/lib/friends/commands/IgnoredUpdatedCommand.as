//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.disney.friends.CredentialsVO;
    import com.adobe.serialization.json.JSON;

    public class IgnoredUpdatedCommand extends SignalCommand 
    {

        private static const MSG_IGNORED_UPDATED:String = "ignoredUpdate";

        [Inject]
        public var ignoredCredentials:Array;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var credentialsVO:CredentialsVO;
            var jsonStr:String;
            var rawCredentials:Array = [];
            for each (credentialsVO in this.ignoredCredentials)
            {
                rawCredentials.push(credentialsVO.toRaw());
            };
            jsonStr = com.adobe.serialization.json.JSON.encode(rawCredentials);
            this.bridge.sendStringInChunks(jsonStr, MSG_IGNORED_UPDATED);
        }


    }
}//package com.clubpenguin.lib.friends.commands
