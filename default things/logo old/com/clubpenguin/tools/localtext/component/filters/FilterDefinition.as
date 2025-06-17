package com.clubpenguin.tools.localtext.component.filters
{
    import __AS3__.vec.*;
    import com.clubpenguin.tools.localtext.component.controlpanel.*;

    public class FilterDefinition extends Object
    {
        private var _filterType:FilterType;
        private var _parameterValues:Array;
        public static const NUM_PARAMS_PER_RAW_FILTER:uint = 19;
        public static const RAW_PARAMETER_NAME_INDICES:Object = {name:0, angle:1, blurX:2, blurY:3, brightness:4, color:5, contrast:6, distance:7, enabled:8, hideObject:9, highlightColor:10, hue:11, inner:12, knockout:13, quality:14, saturation:15, shadowColor:16, strength:17, type:18};

        public function FilterDefinition(param1:FilterType, param2:Array)
        {
            this._filterType = param1;
            this._parameterValues = param2;
            return;
        }// end function

        public function get filterType() : FilterType
        {
            return this._filterType;
        }// end function

        public function get parameterValues() : Array
        {
            return this._parameterValues;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = "FilterDefintion:{ FilterType: " + this._filterType.jsflName + ", {";
            var _loc_2:* = this._filterType.parameterNames;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_1 = _loc_1 + (_loc_2[_loc_3] + " = " + this._parameterValues[_loc_3]);
                if (_loc_3 < (_loc_2.length - 1))
                {
                    _loc_1 = _loc_1 + ", ";
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_1 = _loc_1 + "}}";
            return _loc_1;
        }// end function

        public static function fromRawArray(param1:Array) : FilterDefinition
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            if (param1.length != NUM_PARAMS_PER_RAW_FILTER)
            {
                throw new Error("Expected rawDefinition to have " + NUM_PARAMS_PER_RAW_FILTER + " values, got " + param1.length);
            }
            var _loc_2:* = FilterType.getTypeForJSFLName(param1[0]);
            var _loc_3:* = [];
            for each (_loc_4 in _loc_2.parameterNames)
            {
                
                _loc_5 = RAW_PARAMETER_NAME_INDICES[_loc_4];
                _loc_6 = param1[_loc_5];
                if (_loc_6 == "true" || _loc_6 == "false")
                {
                    _loc_7 = Boolean(_loc_6 == "true");
                }
                else if (_loc_6.indexOf("#") == 0)
                {
                    _loc_7 = LTCjsfl.hexRGBAToUInt(_loc_6);
                }
                else if (!isNaN(Number(_loc_6)))
                {
                    _loc_7 = Number(_loc_6);
                }
                else
                {
                    _loc_7 = String(_loc_6);
                }
                _loc_3.push(_loc_7);
            }
            return new FilterDefinition(_loc_2, _loc_3);
        }// end function

    }
}
