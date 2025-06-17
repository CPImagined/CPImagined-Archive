//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component.filters
{
    import com.clubpenguin.tools.localtext.component.controlpanel.LTCjsfl;
    import __AS3__.vec.Vector;

    public class FilterDefinition 
    {

        public static const NUM_PARAMS_PER_RAW_FILTER:uint = 19;
        public static const RAW_PARAMETER_NAME_INDICES:Object = {
            "name":0,
            "angle":1,
            "blurX":2,
            "blurY":3,
            "brightness":4,
            "color":5,
            "contrast":6,
            "distance":7,
            "enabled":8,
            "hideObject":9,
            "highlightColor":10,
            "hue":11,
            "inner":12,
            "knockout":13,
            "quality":14,
            "saturation":15,
            "shadowColor":16,
            "strength":17,
            "type":18
        };

        private var _filterType:FilterType;
        private var _parameterValues:Array;

        public function FilterDefinition(_arg_1:FilterType, _arg_2:Array)
        {
            this._filterType = _arg_1;
            this._parameterValues = _arg_2;
        }

        public static function fromRawArray(_arg_1:Array):FilterDefinition
        {
            var _local_4:String;
            var _local_5:uint;
            var _local_6:String;
            var _local_7:*;
            if (_arg_1.length != NUM_PARAMS_PER_RAW_FILTER)
            {
                throw (new Error(((("Expected rawDefinition to have " + NUM_PARAMS_PER_RAW_FILTER) + " values, got ") + _arg_1.length)));
            };
            var _local_2:FilterType = FilterType.getTypeForJSFLName(_arg_1[0]);
            var _local_3:Array = [];
            for each (_local_4 in _local_2.parameterNames)
            {
                _local_5 = RAW_PARAMETER_NAME_INDICES[_local_4];
                _local_6 = _arg_1[_local_5];
                if (((_local_6 == "true") || (_local_6 == "false")))
                {
                    _local_7 = Boolean((_local_6 == "true"));
                }
                else
                {
                    if (_local_6.indexOf("#") == 0)
                    {
                        _local_7 = LTCjsfl.hexRGBAToUInt(_local_6);
                    }
                    else
                    {
                        if ((!(isNaN(Number(_local_6)))))
                        {
                            _local_7 = Number(_local_6);
                        }
                        else
                        {
                            _local_7 = String(_local_6);
                        };
                    };
                };
                _local_3.push(_local_7);
            };
            return (new FilterDefinition(_local_2, _local_3));
        }


        public function get filterType():FilterType
        {
            return (this._filterType);
        }

        public function get parameterValues():Array
        {
            return (this._parameterValues);
        }

        public function toString():String
        {
            var _local_1:String = (("FilterDefintion:{ FilterType: " + this._filterType.jsflName) + ", {");
            var _local_2:Vector.<String> = this._filterType.parameterNames;
            var _local_3:uint;
            while (_local_3 < _local_2.length)
            {
                _local_1 = (_local_1 + ((_local_2[_local_3] + " = ") + this._parameterValues[_local_3]));
                if (_local_3 < (_local_2.length - 1))
                {
                    _local_1 = (_local_1 + ", ");
                };
                _local_3++;
            };
            return (_local_1 + "}}");
        }


    }
}//package com.clubpenguin.tools.localtext.component.filters
