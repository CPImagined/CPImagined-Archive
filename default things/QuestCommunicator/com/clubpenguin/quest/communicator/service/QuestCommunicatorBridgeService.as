//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.quest.communicator.service
{
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.util.Log;

    public class QuestCommunicatorBridgeService 
    {

        private const MESSAGE_QUEST_COMM_DISPLAY:String = "questcommunicator";
        private const MESSAGE_QUEST_COMM_DISMISS:String = "questcommunicatordismiss";

        private var _bridge:IAVMBridgeService;
        private var _displayQuestMessage:Signal;
        private var _dismissQuestMessage:Signal;

        public function QuestCommunicatorBridgeService()
        {
            this._displayQuestMessage = new Signal(Object);
            this._dismissQuestMessage = new Signal();
        }

        public function init(appModel:IAppModel):void
        {
            this._bridge = appModel.getAVMBridge();
            this._bridge.getAS2DataReceived().add(this.onBridgeResponse);
        }

        private function onBridgeResponse(payloadType:String, payload:Object):void
        {
            Log.info(("QuestCommunicatorBridgeService - Check payloadType " + payloadType));
            if (payloadType == this.MESSAGE_QUEST_COMM_DISPLAY)
            {
                Log.info(("QuestCommunicatorBridgeService - Display payloadType: " + payloadType));
                this._displayQuestMessage.dispatch(payload);
            }
            else
            {
                if (payloadType == this.MESSAGE_QUEST_COMM_DISMISS)
                {
                    Log.info("QuestCommunicatorBridgeService - Dismiss");
                    this._dismissQuestMessage.dispatch();
                };
            };
        }

        public function get displayQuestMessage():Signal
        {
            return (this._displayQuestMessage);
        }

        public function get dismissQuestMessage():Signal
        {
            return (this._dismissQuestMessage);
        }


    }
}//package com.clubpenguin.quest.communicator.service
