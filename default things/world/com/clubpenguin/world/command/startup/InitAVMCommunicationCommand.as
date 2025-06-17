//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.command.startup
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.world.WorldContext;
    import com.clubpenguin.lib.services.AVMBridgeService;

    public class InitAVMCommunicationCommand extends SignalCommand 
    {

        [Inject]
        public var _mainModel:IAppModel;
        [Inject]
        public var _context:WorldContext;
        private var _bridge:AVMBridgeService;


        override public function execute():void
        {
            this._bridge = AVMBridgeService(this._mainModel.getAVMBridge());
            this._bridge.connected.addOnce(this.onAVMConnect);
            this._mainModel.connectAVMBridge();
        }

        public function onAVMConnect():void
        {
            this._context.onAVMCommunicationReady();
        }


    }
}//package com.clubpenguin.world.command.startup
