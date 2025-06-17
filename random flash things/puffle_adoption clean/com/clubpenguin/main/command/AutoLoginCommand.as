//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;

    public class AutoLoginCommand extends SignalCommand 
    {

        [Inject(name="flashVars")]
        public var flashVars:Object;
        [Inject]
        public var _mainModel:MainModel;


        override public function execute():void
        {
            var _environmentDataObject:EnvironmentDataVO = this._mainModel.getEnvironmentData();
            _environmentDataObject.nau = this.flashVars.nau;
            _environmentDataObject.nal = this.flashVars.nal;
            _environmentDataObject.nad = this.flashVars.nad;
        }


    }
}//package com.clubpenguin.main.command
