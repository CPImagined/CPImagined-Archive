//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.puffle.MoodVO;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.services.AVMBridgeService;

    public class SendPuffleMoodToAS2Command extends SignalCommand 
    {

        [Inject]
        public var moodVO:MoodVO;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var message:AVMBridgeMessage;
            var data:Object;
            if (this.moodVO)
            {
                message = new AVMBridgeMessage(AVMBridgeMessage.MSG_UPDATE_PUFFLE_MOOD);
                data = this.moodVO.getAllMoods();
                data.puffleID = this.moodVO.puffleID;
                message.data = data;
                if (this.bridge)
                {
                    AVMBridgeService(this.bridge).send(message);
                }
                else
                {
                    throw (new Error("[SendPuffleMoodToAS2Command] -> execute(): ERROR!!! bridge is NULL!"));
                };
            }
            else
            {
                throw (new Error("[SendPuffleMoodToAS2Command] -> execute(): ERROR!!! moodVO is NULL!"));
            };
        }


    }
}//package com.clubpenguin.main.command
