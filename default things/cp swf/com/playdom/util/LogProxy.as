//Created by Action Script Viewer - https://www.buraks.com/asv
package com.playdom.util
{
    public class LogProxy 
    {

        protected static var _func:Function = traceFunc;


        public static function log(s:String):void
        {
            if (_func != null)
            {
                _func(s);
            };
        }

        public static function set logFunction(f:Function):void
        {
            _func = f;
        }

        public static function get traceFunc():Function
        {
            return (traceIt);
        }

        protected static function traceIt(s:String):void
        {
        }


    }
}//package com.playdom.util
