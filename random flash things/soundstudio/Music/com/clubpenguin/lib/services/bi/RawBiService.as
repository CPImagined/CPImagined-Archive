//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.bi
{
    import com.clubpenguin.lib.module.IAppSignalBus;
    import org.osflash.signals.Signal;

    public class RawBiService 
    {

        private static const EVENT_TYPE_GENERAL_ERROR:String = "15e";
        private static const EVENT_TYPE_GENERAL_WARNING:String = "15w";
        private static const EVENT_TYPE_GENERAL_INFO:String = "15i";
        private static const EVENT_TYPE_FRAME_RATE:String = "16w";
        private static const EVENT_TYPE_CONTENT_LOAD_FAIL:String = "17w";

        [Inject]
        public var signalBus:IAppSignalBus;


        public function logErrorEvent(message:String):void
        {
            var params:Object = {};
            params.c = EVENT_TYPE_GENERAL_ERROR;
            params.b = message;
            Signal(this.signalBus.getLogRawBiEvent()).dispatch(params);
        }

        public function logWarningEvent(message:String):void
        {
            var params:Object = {};
            params.c = EVENT_TYPE_GENERAL_WARNING;
            params.b = message;
            Signal(this.signalBus.getLogRawBiEvent()).dispatch(params);
        }

        public function logInfoEvent(message:String):void
        {
            var params:Object = {};
            params.c = EVENT_TYPE_GENERAL_INFO;
            params.b = message;
            Signal(this.signalBus.getLogRawBiEvent()).dispatch(params);
        }

        public function logFrameRate(fps:int, currentRoomId:int, playerCount:int):void
        {
            var params:Object = {};
            params.c = EVENT_TYPE_FRAME_RATE;
            params.b = ((((currentRoomId + "|") + fps) + "|") + playerCount);
            Signal(this.signalBus.getLogRawBiEvent()).dispatch(params);
        }

        public function logContentLoadFailure(path:String, containerName:String, optionalDescription:String=null):void
        {
            var params:Object = {};
            params.c = EVENT_TYPE_CONTENT_LOAD_FAIL;
            params.b = (((path + "|") + containerName) + "|");
            if (optionalDescription != null)
            {
                params.b = (params.b + optionalDescription);
            };
            Signal(this.signalBus.getLogRawBiEvent()).dispatch(params);
        }


    }
}//package com.clubpenguin.lib.services.bi
