//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import org.osflash.signals.Signal;

    public class LoadSwfAddressCommand extends SignalCommand 
    {

        [Inject]
        public var _model:MainModel;
        [Inject]
        public var _onLoaded:Signal;


        override public function execute():void
        {
            this._model.initSWFAddress();
            this._onLoaded.dispatch();
        }


    }
}//package com.clubpenguin.main.command
