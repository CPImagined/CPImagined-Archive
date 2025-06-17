//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.bi
{
    import com.clubpenguin.lib.module.IAppSignalBus;
    import org.osflash.signals.Signal;

    public class DimgBiService 
    {

        private static const TAG_TIMING:String = "timing";
        private static const TAG_STEP_TIMING:String = "step_timing";

        [Inject]
        public var signalBus:IAppSignalBus;


        public function logTimingEvent(location:String, elapsedTime:Number, optionalResult:String):void
        {
            var params:Object = {};
            params.tag = TAG_TIMING;
            params.location = location;
            params.elapsed_time = elapsedTime;
            if (optionalResult != null)
            {
                params.result = optionalResult;
            };
            Signal(this.signalBus.getLogDimgBiEvent()).dispatch(params);
        }

        public function logStepTimingEvent(context:String, location:String, optionalPathName:String, optionalElapsedTime:Number, optionalResult:String):void
        {
            var params:Object = {};
            params.tag = TAG_STEP_TIMING;
            params.context = context;
            params.location = location;
            if (optionalPathName != null)
            {
                params.path_name = optionalPathName;
            };
            if (optionalElapsedTime >= 0)
            {
                params.elapsed_time_ms = optionalElapsedTime;
            };
            if (optionalResult != null)
            {
                params.result = optionalResult;
            };
            Signal(this.signalBus.getLogDimgBiEvent()).dispatch(params);
        }


    }
}//package com.clubpenguin.lib.services.bi
