//Created by Action Script Viewer - https://www.buraks.com/asv
package com.adobe.serialization.json
{
    public class JSONToken 
    {

        private var _type:int;
        private var _value:Object;

        public function JSONToken(_arg_1:int=-1, value:Object=null)
        {
            this._type = _arg_1;
            this._value = value;
        }

        public function get type():int
        {
            return (this._type);
        }

        public function set type(value:int):void
        {
            this._type = value;
        }

        public function get value():Object
        {
            return (this._value);
        }

        public function set value(v:Object):void
        {
            this._value = v;
        }


    }
}//package com.adobe.serialization.json
