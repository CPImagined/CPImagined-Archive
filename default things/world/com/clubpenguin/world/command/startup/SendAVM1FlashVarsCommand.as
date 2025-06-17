//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.command.startup
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.module.IAppContext;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class SendAVM1FlashVarsCommand extends SignalCommand 
    {

        [Inject]
        public var _context:IAppContext;
        private var _bridge:IAVMBridgeService;


        override public function execute():void
        {
            var mainModel:IAppModel = this._context.getModel();
            this._bridge = mainModel.getAVMBridge();
            var msg:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_SET_BOOT_DATA);
            msg.data = mainModel.getEnvironmentData();
            this._bridge.send(msg);
        }


    }
}//package com.clubpenguin.world.command.startup
