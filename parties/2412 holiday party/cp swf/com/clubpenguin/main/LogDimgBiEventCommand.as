//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLVariables;
    import flash.net.URLRequestMethod;
    import flash.net.URLRequestHeader;

    public class LogDimgBiEventCommand extends SignalCommand 
    {

        private var LOGGER_URL:String = "https://stage.api.disney.com/datatech/serverlog/v1/";
        [Inject]
        public var params:Object;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var environmentData:EnvironmentDataVO;


        override public function execute():void
        {
            var key1:String;
            var swid:String;
            var playerSwid:String;
            var key2:String;
            var request:URLRequest;
            var headers:Array;
            for (key1 in this.params)
            {
            };
            swid = this.mainModel.myPlayerVO.player_swid;
            playerSwid = ((swid == null) ? "{unkown}" : swid);
            var urlLoader:URLLoader = new URLLoader(new URLRequest(this.LOGGER_URL));
            urlLoader.addEventListener(Event.COMPLETE, this.onPOSTComplete);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onPOSTError);
            var urlVars:URLVariables = new URLVariables();
            urlVars.app = ((this.environmentData.environment == "live") ? "clubpenguin" : "qa_clubpenguin");
            urlVars.network = "c";
            urlVars.view_network = "cp";
            urlVars.app_locale = this.getLocale();
            urlVars.lang = urlVars.app_locale;
            urlVars.user_id = playerSwid;
            urlVars.timestamp_ms = new Date().getTime();
            for (key2 in this.params)
            {
                urlVars[key2] = this.params[key2];
            };
            request = new URLRequest(this.LOGGER_URL);
            request.method = URLRequestMethod.POST;
            headers = [];
            headers.push(new URLRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8"));
            headers.push(new URLRequestHeader("Authorization", "FD 9B407F96-418B-4E0B-93DB-3AD33CC7D72E:205EF7823B24EE5277E318E061E5557F4648F1BF4CCFB457"));
            request.requestHeaders = headers;
            request.data = urlVars;
            urlLoader.load(request);
        }

        private function onPOSTComplete(event:Event):void
        {
        }

        private function onPOSTError(event:IOErrorEvent):void
        {
        }

        private function getLocale():String
        {
            var lang:String = this.mainModel.getEnvironmentData().language;
            switch (lang)
            {
                case "en":
                    return ("en_US");
                case "fr":
                    return ("fr_FR");
                case "pt":
                    return ("pt_BR");
                case "es":
                    return ("es_ES");
                case "de":
                    return ("de_DE");
            };
            throw (new Error((("LogDimgBiEventCommand could not determine the locale for the specified langauge. Make sure that '" + lang) + "' has been added to the switch.")));
        }


    }
}//package com.clubpenguin.main
