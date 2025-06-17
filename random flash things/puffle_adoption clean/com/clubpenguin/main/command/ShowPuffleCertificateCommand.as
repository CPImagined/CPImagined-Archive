//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.vo.ModuleVO;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;
    import com.clubpenguin.lib.vo.PlayerVO;
    import org.osflash.signals.Signal;

    public class ShowPuffleCertificateCommand extends SignalCommand 
    {

        [Inject]
        public var puffleVO:PuffleVO;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var signalBus:SignalBus;


        override public function execute():void
        {
            var moduleVO:ModuleVO = new ModuleVO();
            moduleVO.moduleName = ModuleFilenamesEnum.PUFFLE_CERTIFICATE.key;
            var playerVO:PlayerVO = this.mainModel.getPlayerVO();
            moduleVO.moduleData = {
                "puffleVO":this.puffleVO,
                "playerVO":playerVO
            };
            Signal(this.signalBus.loadModule).dispatch(moduleVO);
        }


    }
}//package com.clubpenguin.main.command
