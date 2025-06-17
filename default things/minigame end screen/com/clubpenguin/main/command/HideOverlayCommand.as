//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;

    public class HideOverlayCommand extends SignalCommand 
    {

        [Inject]
        public var _mainModel:MainModel;


        override public function execute():void
        {
            this._mainModel.overlayCount = (this._mainModel.overlayCount + 1);
        }


    }
}//package com.clubpenguin.main.command
