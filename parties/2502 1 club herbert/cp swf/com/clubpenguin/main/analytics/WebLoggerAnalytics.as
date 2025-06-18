//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.analytics
{
    import com.clubpenguin.main.model.MainModel;
    import flash.net.URLLoader;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import com.clubpenguin.lib.util.StringUtils;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequestMethod;

    public class WebLoggerAnalytics extends BaseAnalytics 
    {

        private var LOGGER_URL:String = "http://logger.clubpenguin.com/log_event";
        private var _webLoggerContext:WebLoggerContext;
        [Inject]
        public var mainModel:MainModel;

        public function WebLoggerAnalytics()
        {
            super(new WebLoggerContext());
            this._webLoggerContext = WebLoggerContext(_context);
        }

        override public function getContext():AnalyticsContext
        {
            return (this._webLoggerContext);
        }

        override public function setContext(context:AnalyticsContext):void
        {
            super.setContext(context);
            this._webLoggerContext = WebLoggerContext(context);
        }

        override protected function logItem(itemName:String, data:Array=null):Boolean
        {
            var category:String;
            var playerId:Number;
            var playerIdStr:String;
            var urlLoader:URLLoader;
            var urlVars:URLVariables;
            var request:URLRequest;
            try
            {
                category = this.getItemCategory(itemName);
                if (!StringUtils.isValidString(category))
                {
                    var _local_4:* = false;
                    return (_local_4);
                };
                playerId = this.mainModel.myPlayerVO.player_id;
                playerIdStr = ((isNaN(playerId)) ? "0" : String(playerId));
                urlLoader = new URLLoader(new URLRequest(this.LOGGER_URL));
                urlLoader.addEventListener(Event.COMPLETE, this.onWebLoggerPOSTComplete);
                urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onWebLoggerPOSTError);
                urlVars = new URLVariables();
                urlVars.land = "1";
                urlVars.user = playerIdStr;
                urlVars.event = category;
                urlVars.data = (((itemName + "|") + this.mainModel.getLanguage()) + this.parseCustomDataToString(data));
                urlVars.debug = 0;
                request = new URLRequest(this.LOGGER_URL);
                request.method = URLRequestMethod.POST;
                request.data = urlVars;
                urlLoader.load(request);
                _local_4 = true;
                return (_local_4);
            }
            catch(error:Error)
            {
            }
            finally
            {
            };
            return (true);
        }

        private function onWebLoggerPOSTComplete(event:Event):void
        {
        }

        private function onWebLoggerPOSTError(event:IOErrorEvent):void
        {
        }

        private function getItemCategory(itemName:String):String
        {
            if (containsPrefix(itemName, "oops"))
            {
                itemName = "oops";
            };
            return (this._webLoggerContext.categoryIndexMap[this._webLoggerContext.categoryMap[itemName]]);
        }

        private function parseCustomDataToString(customData:Array=null):String
        {
            var strCustomData:String = "";
            if (((customData == null) || (customData.length == 0)))
            {
                return (strCustomData);
            };
            var i:Number = 0;
            while (i < customData.length)
            {
                strCustomData = (strCustomData + ("|" + String(customData[i])));
                i++;
            };
            return (strCustomData);
        }

        override public function toString():String
        {
            return ("[WebLoggerAnalytics]");
        }


    }
}//package com.clubpenguin.main.analytics
