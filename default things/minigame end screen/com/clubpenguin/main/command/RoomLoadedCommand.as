//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;

    public class RoomLoadedCommand extends SignalCommand 
    {

        private const CJ_COURTYARD_SOLO_ROOM_ID:int = 324;

        [Inject]
        public var appModel:MainModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var room_id:int;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var courtyardModuleVO:ModuleVO;
            if (this.room_id == this.CJ_COURTYARD_SOLO_ROOM_ID)
            {
                courtyardModuleVO = new ModuleVO();
                courtyardModuleVO.moduleName = ModuleFilenamesEnum.COURTYARD_SENSEI.key;
                courtyardModuleVO.modalBackgroundEnabled = false;
                courtyardModuleVO.hideLoadingDialog = true;
                this.signalBus.loadModule.dispatch(courtyardModuleVO);
            };
        }


    }
}//package com.clubpenguin.main.command
