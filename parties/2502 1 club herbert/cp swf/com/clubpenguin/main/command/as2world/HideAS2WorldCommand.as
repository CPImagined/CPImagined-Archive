//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command.as2world
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class HideAS2WorldCommand extends SignalCommand 
    {

        [Inject]
        public var bridgeService:IAVMBridgeService;


        override public function execute():void
        {
            var messageToAS2:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_HIDE_AS2_WORLD);
            this.bridgeService.send(messageToAS2);
        }


    }
}//package com.clubpenguin.main.command.as2world
