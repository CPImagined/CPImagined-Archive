//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.IVO;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.services.AVMBridgeService;

    public class SendMyPuffleRemovedToAS2Command extends SignalCommand 
    {

        [Inject]
        public var itemVO:IVO;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var puffleVO:PuffleVO;
            var message:AVMBridgeMessage;
            var data:Object;
            if (this.itemVO)
            {
                puffleVO = (this.itemVO as PuffleVO);
                message = new AVMBridgeMessage(AVMBridgeMessage.MSG_MY_PUFFLE_REMOVED);
                data = new Object();
                data.puffleID = puffleVO.id;
                message.data = data;
                puffleVO.destroy();
                if (this.bridge)
                {
                    AVMBridgeService(this.bridge).send(message);
                }
                else
                {
                    throw (new Error("[SendMyPuffleRemovedToAS2Command] -> execute(): ERROR!!! bridge is NULL!"));
                };
            }
            else
            {
                throw (new Error("[SendMyPuffleRemovedToAS2Command] -> execute(): ERROR!!! itemVO is NULL!"));
            };
        }


    }
}//package com.clubpenguin.main.command
