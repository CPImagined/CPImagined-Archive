//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command.loadingScreen
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.LoadingScreenModel;

    public class UpdateLoadingScreenCommand extends SignalCommand 
    {

        [Inject]
        public var loadingScreenModel:LoadingScreenModel;
        [Inject]
        public var percentageComplete:Number;


        override public function execute():void
        {
            this.loadingScreenModel.updateProgress(this.percentageComplete);
        }


    }
}//package com.clubpenguin.main.command.loadingScreen
