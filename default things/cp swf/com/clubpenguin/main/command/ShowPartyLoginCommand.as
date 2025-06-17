//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class ShowPartyLoginCommand extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var showPartyLogin:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_SHOW_PARTY_LOGIN);
            showPartyLogin.data = new Object();
            this.bridge.send(showPartyLogin);
        }


    }
}//package com.clubpenguin.main.command
