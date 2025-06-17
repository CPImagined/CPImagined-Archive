//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class ShowHiddenPuffleInAS2Command extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var mainModel:AdoptionModel;


        override public function execute():void
        {
            var puffleBridgeMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_UNHIDE_PUFFLE);
            var currentPlayerId:Number = this.mainModel.playerVO.player_id;
            puffleBridgeMessage.data = {"playerId":currentPlayerId};
            this.bridge.send(puffleBridgeMessage);
        }


    }
}//package com.clubpenguin.puffles.adoption.commands
