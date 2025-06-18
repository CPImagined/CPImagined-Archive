//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;

    public class ShowOverlayCommand extends SignalCommand 
    {

        [Inject]
        public var _mainModel:MainModel;


        override public function execute():void
        {
            this._mainModel.overlayCount--;
        }


    }
}//package com.clubpenguin.main.command
