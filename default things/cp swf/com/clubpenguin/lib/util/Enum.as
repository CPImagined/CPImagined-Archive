//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util
{
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    import flash.utils.*;

    public class Enum 
    {

        private static const EMPTY_VALUE:int = -1;
        private static var _classNameToEnumCount:Dictionary = new Dictionary();

        protected var _value:int;

        public function Enum(value:int=-1)
        {
            var className:String = getQualifiedClassName(this);
            var enumCount:int = ((_classNameToEnumCount[className] == undefined) ? EMPTY_VALUE : _classNameToEnumCount[className]);
            if (value == EMPTY_VALUE)
            {
                this._value = ((enumCount == EMPTY_VALUE) ? 0 : (enumCount + 1));
                _classNameToEnumCount[className] = this._value;
            }
            else
            {
                this._value = value;
                if (((enumCount == EMPTY_VALUE) || (value > enumCount)))
                {
                    _classNameToEnumCount[className] = value;
                };
            };
        }

        public static function createList(enumClass:Class):Array
        {
            var result:Array;
            var constantsList:XMLList;
            var constant:XML;
            result = [];
            constantsList = describeType(enumClass).constant.(@type == getQualifiedClassName(enumClass));
            for each (constant in constantsList)
            {
                result.push(enumClass[constant.@name]);
            };
            return (result);
        }

        public static function getEnum(enumList:Array, value:int):Enum
        {
            var _local_4:Enum;
            var i:uint;
            while (i < enumList.length)
            {
                _local_4 = (enumList[i] as Enum);
                if (_local_4.value == value)
                {
                    return (_local_4);
                };
                i++;
            };
            return (null);
        }


        public function get value():int
        {
            return (this._value);
        }


    }
}//package com.clubpenguin.lib.util
