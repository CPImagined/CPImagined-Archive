//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.vo
{
    public class ComplexPromptVO 
    {

        private var _style:String;
        private var _data:Object;

        public function ComplexPromptVO(style:String, data:Object)
        {
            this._style = style;
            this._data = data;
        }

        public function get style():String
        {
            return (this._style);
        }

        public function get data():Object
        {
            return (this._data);
        }


    }
}//package com.clubpenguin.main.vo
