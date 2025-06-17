//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import com.clubpenguin.lib.module.BaseModule;

    public class LoadBanningModuleCommand extends SignalCommand 
    {

        [Inject]
        public var onLoaded:Signal;
        [Inject]
        public var signalBus:IAppSignalBus;
        private var _moduleVO:ModuleVO;


        override public function execute():void
        {
            SignalBus(this.signalBus).moduleLoaded.add(this.onModuleLoaded);
            this._moduleVO = new ModuleVO();
            this._moduleVO.moduleName = ModuleFilenamesEnum.BANNING.key;
            this._moduleVO.moduleData = null;
            this._moduleVO.hideLoadingDialog = true;
            this._moduleVO.modalBackgroundEnabled = false;
            this._moduleVO.moduleLayer = "notifications";
            this._moduleVO.persistent = true;
            Signal(this.signalBus.getLoadModule()).dispatch(this._moduleVO);
        }

        private function onModuleLoaded(module:BaseModule, moduleVO:ModuleVO):void
        {
            if (moduleVO != this._moduleVO)
            {
                return;
            };
            SignalBus(this.signalBus).moduleLoaded.remove(this.onModuleLoaded);
            this.onLoaded.dispatch();
        }


    }
}//package com.clubpenguin.main.command
