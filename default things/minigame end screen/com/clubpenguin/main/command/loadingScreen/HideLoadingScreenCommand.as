//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command.loadingScreen
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.LoadingScreenModel;

    public class HideLoadingScreenCommand extends SignalCommand 
    {

        [Inject]
        public var loadingScreenModel:LoadingScreenModel;


        override public function execute():void
        {
            this.loadingScreenModel.hide();
        }


    }
}//package com.clubpenguin.main.command.loadingScreen
