//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.service.webservice.WebServiceManagerProxy;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.signal.loadingScreen.ShowLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.UpdateLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import flash.utils.getTimer;

    public class SendWebServiceDataCommand extends SignalCommand 
    {

        [Inject]
        public var _webServiceManager:WebServiceManagerProxy;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var showLoadingScreenSignal:ShowLoadingScreenSignal;
        [Inject]
        public var updateLoadingScreenSignal:UpdateLoadingScreenSignal;
        [Inject]
        public var hideLoadingScreenSignal:HideLoadingScreenSignal;
        private var startTime:int;
        private var PERFORMANCE_FLAG:int = 10;
        private var WEBSERVICES_TIME_ATTRIBUTE:String = "webServicesSentToAS2Time";


        override public function execute():void
        {
            this.startTime = getTimer();
            this._webServiceManager.dataSent.addOnce(this.onDataSent);
            this._webServiceManager.dataLoadProgress.add(this.onDataLoadProgress);
            this.showLoadingScreenSignal.dispatch("");
            this._webServiceManager.sendDataAcrossBridge();
        }

        private function onDataLoadProgress(progress:Number):void
        {
            this.updateLoadingScreenSignal.dispatch(progress);
        }

        public function onDataSent():void
        {
            this._webServiceManager.dataLoadProgress.removeAll();
        }


    }
}//package com.clubpenguin.main.command
