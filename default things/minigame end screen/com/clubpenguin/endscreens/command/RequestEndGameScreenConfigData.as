//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.endscreens.service.MiniGameEndScreensService;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class RequestEndGameScreenConfigData extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var service:MiniGameEndScreensService;


        override public function execute():void
        {
            Log.debug("MinigameEndScreens :: RequestEndGameScreenConfigData.execute");
            var requestEndGameScreenData:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_REQUEST_END_GAME_DATA);
            this.bridge.send(requestEndGameScreenData);
            this.bridge.getEndGameScreenData().addOnce(this.service.handleEndGameConfigData);
        }


    }
}//package com.clubpenguin.endscreens.command
