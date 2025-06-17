//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component.filters
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class LTCFilterUtils 
    {


        public static function getFilterDefsFromRaw(_arg_1:String):Vector.<FilterDefinition>
        {
            var _local_4:Array;
            var _local_5:FilterDefinition;
            if (_arg_1 == "")
            {
                return (new Vector.<FilterDefinition>());
            };
            var _local_2:Array = _arg_1.split(",");
            if ((_local_2.length % FilterDefinition.NUM_PARAMS_PER_RAW_FILTER) != 0)
            {
                throw (new Error(((("Invalid number of filter parameters fetched via jsfl. Expected multiple of " + FilterDefinition.NUM_PARAMS_PER_RAW_FILTER) + ", but got ") + _local_2.length)));
            };
            var _local_3:Vector.<FilterDefinition> = new Vector.<FilterDefinition>();
            while (((_local_2.length) && ((_local_4 = _local_2.splice(0, FilterDefinition.NUM_PARAMS_PER_RAW_FILTER)).length)))
            {
                _local_5 = FilterDefinition.fromRawArray(_local_4);
                _local_3.push(_local_5);
            };
            return (_local_3);
        }


    }
}//package com.clubpenguin.tools.localtext.component.filters
