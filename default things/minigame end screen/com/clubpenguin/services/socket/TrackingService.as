//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket
{
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.services.AVMBridgeService;
    import com.clubpenguin.main.analytics.WebLoggerAnalytics;
    import com.clubpenguin.main.analytics.OmnitureAnalytics;
    import com.clubpenguin.lib.util.StringUtils;
    import com.adobe.serialization.json.JSON;

    public class TrackingService 
    {

        [Inject]
        public var tracker:Tracker;
        public var bridgeService:AVMBridgeService;
        public var webLogger:WebLoggerAnalytics;
        public var omniture:OmnitureAnalytics;
        private var _readyToTrack:Boolean = false;


        public function init(bridgeService:AVMBridgeService, webLogger:WebLoggerAnalytics, omniture:OmnitureAnalytics):void
        {
            this.webLogger = webLogger;
            bridgeService.trackingDataReceived.add(this.onAS2TrackingDataReceived);
            this._readyToTrack = true;
        }

        private function onAS2TrackingDataReceived(trackingKey:String, paramsJSONString:String=""):void
        {
            var params:Object;
            if (!this._readyToTrack)
            {
                return;
            };
            if (((StringUtils.isValidString(paramsJSONString)) && (!(paramsJSONString == "params"))))
            {
                params = com.adobe.serialization.json.JSON.decode(paramsJSONString);
            };
            this.webLogger.track(trackingKey, (params as Array));
        }


    }
}//package com.clubpenguin.services.socket
