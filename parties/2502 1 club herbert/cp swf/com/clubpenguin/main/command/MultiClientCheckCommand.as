//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.model.MainModel;
    import flash.net.LocalConnection;
    import flash.events.StatusEvent;

    public class MultiClientCheckCommand extends SignalCommand 
    {

        [Inject]
        public var _onComplete:Signal;
        [Inject]
        public var _model:MainModel;
        private var _sendConnection:LocalConnection;
        private var _recieveConnection:LocalConnection;


        override public function execute():void
        {
            this.checkLocalConnection();
        }

        private function checkLocalConnection():void
        {
            this._sendConnection = new LocalConnection();
            this._sendConnection.addEventListener(StatusEvent.STATUS, this.onLocalConnectionStatus);
            this._sendConnection.send("lc_name", "lcHandler");
        }

        public function onLocalConnectionStatus(event:StatusEvent):void
        {
            switch (event.level)
            {
                case "status":
                    this._model.getEnvironmentData().multiClientCheckFailed = true;
                    this._onComplete.dispatch();
                    break;
                case "error":
                    this.createRecieverLocalConection();
                    break;
            };
        }

        private function createRecieverLocalConection():void
        {
            this._recieveConnection = new LocalConnection();
            this._recieveConnection.client = this;
            try
            {
                this._recieveConnection.connect("lc_name");
            }
            catch(error:ArgumentError)
            {
            };
            this._onComplete.dispatch();
        }

        public function lcHandler():void
        {
        }


    }
}//package com.clubpenguin.main.command
