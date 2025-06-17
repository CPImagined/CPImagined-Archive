package com.clubpenguin.tools.localtext.component.filters
{
    import __AS3__.vec.*;
    import flash.filters.*;

    public class FilterType extends Object
    {
        private var _parameterNames:Vector.<String>;
        private var _filterClass:Class;
        private var _name:String;
        private var _jsflName:String;
        public static const DROP_SHADOW:FilterType = new FilterType("Drop Shadow", "dropShadowFilter", DropShadowFilter, FilterType.Vector.<String>(["distance", "angle", "color", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"]));
        public static const ALL_TYPES:Vector.<FilterType> = FilterType.Vector.<FilterType>([DROP_SHADOW]);

        public function FilterType(param1:String, param2:String, param3:Class, param4:Vector.<String>)
        {
            this._name = param1;
            this._jsflName = param2;
            this._filterClass = param3;
            this._parameterNames = param4;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get numParamaters() : uint
        {
            return this._parameterNames.length;
        }// end function

        public function get parameterNames() : Vector.<String>
        {
            return this._parameterNames;
        }// end function

        public function get jsflName() : String
        {
            return this._jsflName;
        }// end function

        public static function getTypeForJSFLName(param1:String) : FilterType
        {
            var _loc_2:* = null;
            for each (_loc_2 in ALL_TYPES)
            {
                
                if (_loc_2.jsflName == param1)
                {
                    return _loc_2;
                }
            }
            throw new Error("A FilterType does not exist for jsflName: " + param1);
        }// end function

    }
}
