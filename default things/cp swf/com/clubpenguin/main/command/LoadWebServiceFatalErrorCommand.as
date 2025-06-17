//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import com.clubpenguin.lib.vo.ErrorVO;
    import org.osflash.signals.Signal;

    public class LoadWebServiceFatalErrorCommand extends SignalCommand 
    {

        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var _mainModel:MainModel;
        [Inject]
        public var hideLoadingScreen:HideLoadingScreenSignal;
        [Inject]
        public var errorVO:ErrorVO;


        override public function execute():void
        {
            this.bridge.close();
            this.hideLoadingScreen.dispatch();
            Signal(this._mainModel.signalBus.showError).dispatch(this.errorVO);
        }


    }
}//package com.clubpenguin.main.command
