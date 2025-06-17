//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.BiVO;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class SendBICommand extends SignalCommand 
    {

        [Inject]
        public var biVO:BiVO;
        [Inject]
        public var mainModel:IAppModel;


        override public function execute():void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_CLOSE_NEWSPAPER);
            var data:Object = {"args":[this.biVO.biTrackingString]};
            message.data = data;
            this.mainModel.getAVMBridge().send(message);
        }


    }
}//package com.clubpenguin.world.command
