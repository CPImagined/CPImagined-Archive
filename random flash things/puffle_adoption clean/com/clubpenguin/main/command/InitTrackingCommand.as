//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.services.socket.TrackingService;
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import com.adobe.serialization.json.JSON;
    import com.clubpenguin.main.analytics.OmnitureAnalytics;
    import com.clubpenguin.main.analytics.AnalyticsContext;
    import com.clubpenguin.main.analytics.WebLoggerAnalytics;
    import com.clubpenguin.lib.services.AVMBridgeService;

    public class InitTrackingCommand extends SignalCommand 
    {

        private static const WEB_LOGGER_PHP:String = "/web_service/weblogger.php";

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var trackingService:TrackingService;
        [Inject]
        public var _onLoaded:Signal;


        override public function execute():void
        {
            var webServicePath:String;
            webServicePath = "";
            var pageURL:String = this.mainModel.getEnvironmentData().getBaseConfigPath();
            webServicePath = ((pageURL + this.mainModel.getLanguage()) + WEB_LOGGER_PHP);
            var scriptLoader:URLLoader = new URLLoader();
            scriptLoader.addEventListener(Event.COMPLETE, this.handleLoadSuccessful);
            scriptLoader.addEventListener(IOErrorEvent.IO_ERROR, this.handleLoadError);
            var scriptRequest:URLRequest = new URLRequest(webServicePath);
            scriptRequest.method = URLRequestMethod.GET;
            scriptLoader.load(scriptRequest);
        }

        private function handleLoadSuccessful(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.currentTarget);
            var analyticsConfig:Object = com.adobe.serialization.json.JSON.decode(String(loader.data));
            var omnitureAnalytics:OmnitureAnalytics = injector.getInstance(OmnitureAnalytics);
            var omnitureConfig:Object = analyticsConfig.omniture;
            var omnitureContext:AnalyticsContext = omnitureAnalytics.getContext();
            omnitureContext.initFromConfig(omnitureConfig);
            var webLoggerAnalytics:WebLoggerAnalytics = injector.getInstance(WebLoggerAnalytics);
            var webLoggerConfig:Object = analyticsConfig.web_logger;
            var webLoggerContext:AnalyticsContext = webLoggerAnalytics.getContext();
            webLoggerContext.initFromConfig(webLoggerConfig);
            this.trackingService.init((this.mainModel.getAVMBridge() as AVMBridgeService), webLoggerAnalytics, omnitureAnalytics);
            this._onLoaded.dispatch();
        }

        private function handleLoadError(event:IOErrorEvent):void
        {
            this._onLoaded.dispatch();
        }


    }
}//package com.clubpenguin.main.command
