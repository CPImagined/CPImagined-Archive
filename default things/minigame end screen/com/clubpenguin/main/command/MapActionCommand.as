//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.map.MapActionVO;
    import com.clubpenguin.main.model.MapDataModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.model.ModuleModel;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;

    public class MapActionCommand extends SignalCommand 
    {

        [Inject]
        public var mapActionVO:MapActionVO;
        [Inject]
        public var mapDataModel:MapDataModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var moduleModel:ModuleModel;


        override public function execute():void
        {
            var moduleVO:ModuleVO;
            this.mapDataModel.selectedMapAction = this.mapActionVO;
            var key:ModuleFilenamesEnum = ModuleFilenamesEnum.MAP_TRIGGERS;
            if (this.moduleModel.isModuleOpen(key))
            {
                this.signalBus.closeView.dispatch(this.moduleModel.getModuleWithKey(key));
            }
            else
            {
                if (!this.mapActionVO.isEmpty())
                {
                    moduleVO = new ModuleVO();
                    moduleVO.moduleName = ModuleFilenamesEnum.MAP_TRIGGERS.key;
                    moduleVO.moduleData = {"makeTriggersVisible":this.mapActionVO.makeTriggersVisible};
                    moduleVO.modalBackgroundEnabled = false;
                    moduleVO.hideLoadingDialog = true;
                    moduleVO.disableMouse = true;
                    this.signalBus.loadModule.dispatch(moduleVO);
                };
            };
        }


    }
}//package com.clubpenguin.main.command
