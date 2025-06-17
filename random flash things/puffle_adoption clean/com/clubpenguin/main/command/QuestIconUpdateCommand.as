//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.ActiveQuestsModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.vo.quest.QuestVO;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class QuestIconUpdateCommand extends SignalCommand 
    {

        private static var _isAlreadySendingMessage:Boolean = false;

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var activeQuestsModel:ActiveQuestsModel;


        override public function execute():void
        {
            Log.debug("\tQuestIconUpdateCommand.execute()");
            if (!_isAlreadySendingMessage)
            {
                _isAlreadySendingMessage = true;
                this.bridge.getRoomLoaded().addOnce(this.sendVisibilityData);
            };
        }

        private function sendVisibilityData(e:Object):void
        {
            var questVO:QuestVO;
            Log.debug("\tQuestIconUpdateCommand.sendVisibilityData()");
            _isAlreadySendingMessage = false;
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_UPDATE_QUEST_ICON_VISIBILITY);
            var data:Object = new Object();
            for each (questVO in this.activeQuestsModel.getAllItems())
            {
                switch (questVO.strID)
                {
                    case "shopping":
                        Log.debug(("\t\t" + this.isPastIconState(questVO)));
                        data.shopClothingCatalogueIconVisibility = this.isPastIconState(questVO);
                        break;
                    case "puffle":
                        Log.debug(("\t\t" + this.isPastIconState(questVO)));
                        data.petPuffleAdoptionIconVisibility = this.isPastIconState(questVO);
                        break;
                    case "igloo":
                        Log.debug(("\t\t" + this.isPastIconState(questVO)));
                        data.iglooEditIglooIconVisibility = this.isPastIconState(questVO);
                        break;
                };
            };
            message.data = data;
            this.bridge.send(message);
        }

        private function isPastIconState(questVO:QuestVO):Boolean
        {
            return ((questVO.isComplete()) || (questVO.prizeClaimed()));
        }


    }
}//package com.clubpenguin.main.command
