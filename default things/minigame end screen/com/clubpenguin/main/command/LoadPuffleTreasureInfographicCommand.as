//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import org.osflash.signals.Signal;

    public class LoadPuffleTreasureInfographicCommand extends SignalCommand 
    {

        [Inject]
        public var appSignalBus:IAppSignalBus;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            var payload:Object;
            var moduleVo:ModuleVO = new ModuleVO();
            moduleVo.moduleName = ModuleFilenamesEnum.PUFFLE_TREASURE_INFOGRAPHIC.key;
            if (!this.mainModel.myPlayerVO.hasSeenPuffleTreasureInfographic)
            {
                this.mainModel.myPlayerVO.hasSeenPuffleTreasureInfographic = true;
                payload = new Object();
                payload.hasSeenPuffleTreasureInfographic = true;
                payload.player_id = this.mainModel.myPlayerVO.player_id;
                (this.appSignalBus.getSyncPlayerData() as Signal).dispatch(payload);
                (this.appSignalBus.getLoadModule() as Signal).dispatch(moduleVo);
            };
        }


    }
}//package com.clubpenguin.main.command
