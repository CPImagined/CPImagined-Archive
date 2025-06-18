//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component.filters
{
    import flash.filters.DropShadowFilter;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class FilterType 
    {

        public static const DROP_SHADOW:FilterType = new FilterType("Drop Shadow", "dropShadowFilter", DropShadowFilter, Vector.<String>(["distance", "angle", "color", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"]));
        public static const ALL_TYPES:Vector.<FilterType> = Vector.<FilterType>([DROP_SHADOW]);

        private var _parameterNames:Vector.<String>;
        private var _filterClass:Class;
        private var _name:String;
        private var _jsflName:String;

        public function FilterType(_arg_1:String, _arg_2:String, _arg_3:Class, _arg_4:Vector.<String>)
        {
            this._name = _arg_1;
            this._jsflName = _arg_2;
            this._filterClass = _arg_3;
            this._parameterNames = _arg_4;
        }

        public static function getTypeForJSFLName(_arg_1:String):FilterType
        {
            var _local_2:FilterType;
            for each (_local_2 in ALL_TYPES)
            {
                if (_local_2.jsflName == _arg_1)
                {
                    return (_local_2);
                };
            };
            throw (new Error(("A FilterType does not exist for jsflName: " + _arg_1)));
        }


        public function get name():String
        {
            return (this._name);
        }

        public function get numParamaters():uint
        {
            return (this._parameterNames.length);
        }

        public function get parameterNames():Vector.<String>
        {
            return (this._parameterNames);
        }

        public function get jsflName():String
        {
            return (this._jsflName);
        }


    }
}//package com.clubpenguin.tools.localtext.component.filters
