//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.ActiveQuestsModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class UpdateRewardReadyIconCommand extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var questModel:ActiveQuestsModel;


        override public function execute():void
        {
            Log.debug("\tUpdateRewardReadyIconCommand.execute()");
            Log.debug(("\t\tquestModel.rewardsReadyAmount: " + this.questModel.rewardsReadyAmount));
            var rewardsReadyUpdateMessage:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_AS2_QUEST_REWARDS_READY);
            rewardsReadyUpdateMessage.data = {"rewardsReady":this.questModel.rewardsReadyAmount};
            this.bridge.send(rewardsReadyUpdateMessage);
        }


    }
}//package com.clubpenguin.main.command
