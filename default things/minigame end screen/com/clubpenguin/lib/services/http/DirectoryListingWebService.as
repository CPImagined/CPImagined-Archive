//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.http
{
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.main.signal.SignalBus;
    import flash.external.ExternalInterface;
    import flash.net.URLRequestMethod;
    import com.clubpenguin.lib.vo.ErrorVO;

    public class DirectoryListingWebService extends HTTPServiceRequest 
    {

        private static const DIRECTORY_SERVICE_LIVE:String = "http://directory.clubpenguin.com/services";
        private static const DIRECTORY_SERVICE_STAGE:String = "http://stage-directory.clubpenguin.com/services";
        private static const DIRECTORY_SERVICE_QA:String = "http://n7vgq2clubpdir.general.disney.private/services";
        private static const DIRECTORY_SERVICE_DEV:String = "http://n7vgi1clubpdir.general.disney.private/services";
        public static const ENVIRONMENT_DEV:int = 0;
        public static const ENVIRONMENT_QA:int = 1;
        public static const ENVIRONMENT_STAGE:int = 2;
        public static const ENVIRONMENT_LIVE:int = 3;
        public static const CELLOPHANE_KEY_QA:String = "0869F69C-56CC-4EEB-9D5E-D3887F971033:AF5DC9E77FB4FE15F8C051ABC544435A410B46B725CE94B5";
        public static const CELLOPHANE_KEY_PROD:String = "9B407F96-418B-4E0B-93DB-3AD33CC7D72E:205EF7823B24EE5277E318E061E5557F4648F1BF4CCFB457";

        public const directoryListingReceived:Signal = new Signal(Object);

        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var signalBus:SignalBus;
        private var cachedResponse:HTTPResponse;
        private var _cellophaneKey:String;

        public function DirectoryListingWebService()
        {
            this.setupURL();
            responseReceived.add(this.handleResponseReceived);
            requestFailed.add(this.handleResponseFailed);
        }

        public static function getEnvironment():int
        {
            var currentDomain:String = (ExternalInterface.call("window.location.href.toString") as String).split("/", 3)[2];
            var environment:String = currentDomain.split(".")[0];
            if (environment.search(new RegExp("^dev")) != -1)
            {
                return (ENVIRONMENT_DEV);
            };
            if (((!(environment.search(new RegExp("^qa")) == -1)) || (!(environment.search(new RegExp("^gameqa2-play")) == -1))))
            {
                return (ENVIRONMENT_QA);
            };
            if (environment.search(new RegExp("^stage")) != -1)
            {
                return (ENVIRONMENT_STAGE);
            };
            return (ENVIRONMENT_LIVE);
        }


        override public function destroy():void
        {
            super.destroy();
            this.directoryListingReceived.removeAll();
        }

        public function submitRequest():void
        {
            if (this.cachedResponse != null)
            {
                this.handleResponseReceived(this.cachedResponse);
            }
            else
            {
                send(null);
            };
        }

        public function get cellophaneKey():String
        {
            return (this._cellophaneKey);
        }

        private function setupURL():void
        {
            var webServiceDomain:String;
            switch (getEnvironment())
            {
                case ENVIRONMENT_DEV:
                    this._cellophaneKey = CELLOPHANE_KEY_QA;
                    webServiceDomain = DIRECTORY_SERVICE_DEV;
                    break;
                case ENVIRONMENT_QA:
                    this._cellophaneKey = CELLOPHANE_KEY_QA;
                    webServiceDomain = DIRECTORY_SERVICE_QA;
                    break;
                case ENVIRONMENT_STAGE:
                    this._cellophaneKey = CELLOPHANE_KEY_PROD;
                    webServiceDomain = DIRECTORY_SERVICE_STAGE;
                    break;
                case ENVIRONMENT_LIVE:
                    this._cellophaneKey = CELLOPHANE_KEY_PROD;
                    webServiceDomain = DIRECTORY_SERVICE_LIVE;
                    break;
            };
            setURL(webServiceDomain, HTTPServiceRequest.JSON_ENCODING);
            setMethod(URLRequestMethod.GET);
        }

        private function showErrorDialog(message:String, ... args):void
        {
            var showErrorSignal:Signal = Signal(this.signalBus.showError);
            showErrorSignal.dispatch(new ErrorVO(this.localizer.getLocalizedString(message, args)));
        }

        private function handleResponseFailed(response:HTTPResponse):void
        {
            this.showErrorDialog("shell.DEFAULT_ERROR");
        }

        private function handleResponseReceived(response:HTTPResponse):void
        {
            if (((response.data == null) || (!(response.success))))
            {
                this.showErrorDialog("shell.DEFAULT_ERROR");
            };
            if (response.success)
            {
                this.directoryListingReceived.dispatch(response.data);
                this.cachedResponse = response;
            }
            else
            {
                this.directoryListingReceived.dispatch(null);
            };
        }

        private function handleWebServiceError(errorCode:int):void
        {
            if (errorCode)
            {
                this.showErrorDialog("shell.DEFAULT_ERROR");
            };
        }


    }
}//package com.clubpenguin.lib.services.http
