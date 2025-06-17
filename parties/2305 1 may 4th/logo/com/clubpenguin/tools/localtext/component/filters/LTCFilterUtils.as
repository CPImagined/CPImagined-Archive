package com.clubpenguin.tools.localtext.component.filters
{
    import __AS3__.vec.*;

    public class LTCFilterUtils extends Object
    {

        public function LTCFilterUtils()
        {
            return;
        }// end function

        public static function getFilterDefsFromRaw(param1:String) : Vector.<FilterDefinition>
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1 == "")
            {
                return new Vector.<FilterDefinition>;
            }
            var _loc_2:* = param1.split(",");
            if (_loc_2.length % FilterDefinition.NUM_PARAMS_PER_RAW_FILTER != 0)
            {
                throw new Error("Invalid number of filter parameters fetched via jsfl. Expected multiple of " + FilterDefinition.NUM_PARAMS_PER_RAW_FILTER + ", but got " + _loc_2.length);
            }
            var _loc_3:* = new Vector.<FilterDefinition>;
            do
            {
                
                _loc_5 = FilterDefinition.fromRawArray(_loc_4);
                _loc_3.push(_loc_5);
                var _loc_6:* = _loc_2.splice(0, FilterDefinition.NUM_PARAMS_PER_RAW_FILTER);
                _loc_4 = _loc_2.splice(0, FilterDefinition.NUM_PARAMS_PER_RAW_FILTER);
            }while (_loc_2.length && _loc_6.length)
            return _loc_3;
        }// end function

    }
}
