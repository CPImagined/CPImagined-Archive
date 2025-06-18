//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.metrics
{
    public class BridgeMetricVO 
    {

        public var msgId:int;
        public var msgType:String;
        public var sentTS:int;
        public var receivedTS:int;
        public var lag:int;

        public function BridgeMetricVO(msgId:int, msgType:String, sentTS:int, receivedTS:int, lag:int)
        {
            this.msgId = msgId;
            this.msgType = msgType;
            this.sentTS = sentTS;
            this.receivedTS = receivedTS;
            this.lag = lag;
        }

    }
}//package com.clubpenguin.lib.vo.metrics
