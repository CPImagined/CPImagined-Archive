//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.command.startup
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.world.WorldContext;
    import com.clubpenguin.world.view.AS2ContentView;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.world.service.LoadAS2ClubPenguinService;
    import flash.display.Loader;
    import com.clubpenguin.lib.services.http.LoadSWFResponse;

    public class LoadAS2Command extends SignalCommand 
    {

        [Inject]
        public var _worldContext:WorldContext;
        [Inject]
        public var _as2ContentView:AS2ContentView;
        [Inject]
        public var _mainModel:IAppModel;
        private var _service:LoadAS2ClubPenguinService;


        override public function execute():void
        {
            this._service = new LoadAS2ClubPenguinService(this._mainModel.getEnvironmentData());
            this._service.responseReceived.addOnce(this.onResponseReceived);
            this._service.requestFailed.addOnce(this.onRequestFailed);
            this._service.send(null, false);
        }

        private function onResponseReceived(response:LoadSWFResponse):void
        {
            this._worldContext.onAS2Loaded();
            this._as2ContentView.addContent((response.data as Loader));
        }

        private function onRequestFailed(response:LoadSWFResponse):void
        {
            throw (new Error(("LoadAS2Command -> Failed to load the AS2. \n" + response)));
        }


    }
}//package com.clubpenguin.world.command.startup
