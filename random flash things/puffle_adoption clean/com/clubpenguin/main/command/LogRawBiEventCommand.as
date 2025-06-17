//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.adobe.serialization.json.JSONEncoder;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLVariables;
    import flash.net.URLRequestMethod;

    public class LogRawBiEventCommand extends SignalCommand 
    {

        private static const LOGGER_DEV_URL:String = "http://dcefriendsweb01.sandbox.clubpenguin.com/logging-web-service/log";
        private static const LOGGER_LIVE_URL:String = "http://logger.friends.go.com/logging-web-service/log";

        [Inject]
        public var params:Object;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var environmentData:EnvironmentDataVO;


        override public function execute():void
        {
            var url:String;
            var key2:String;
            var jsonEncoder:JSONEncoder;
            var logRecordJson:String;
            var request:URLRequest;
            var swid:String = this.mainModel.myPlayerVO.player_swid;
            var playerSwid:String = ((swid == null) ? "{unkown}" : swid);
            if (((this.environmentData.environment == "live") || (this.environmentData.environment == "stage")))
            {
                url = LOGGER_LIVE_URL;
            }
            else
            {
                url = LOGGER_DEV_URL;
            };
            var urlLoader:URLLoader = new URLLoader(new URLRequest(url));
            urlLoader.addEventListener(Event.COMPLETE, this.onPOSTComplete);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onPOSTError);
            var urlVars:URLVariables = new URLVariables();
            urlVars.s = playerSwid;
            urlVars.d = new Date().getTime();
            var logRecord:Object = {};
            logRecord.d = 0;
            for (key2 in this.params)
            {
                logRecord[key2] = this.params[key2];
            };
            jsonEncoder = new JSONEncoder([logRecord]);
            logRecordJson = jsonEncoder.getString();
            urlVars.r = logRecordJson;
            request = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = urlVars;
            urlLoader.load(request);
        }

        private function onPOSTComplete(event:Event):void
        {
        }

        private function onPOSTError(event:IOErrorEvent):void
        {
        }


    }
}//package com.clubpenguin.main.command
