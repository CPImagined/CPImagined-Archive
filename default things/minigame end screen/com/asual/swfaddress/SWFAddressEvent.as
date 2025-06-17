//Created by Action Script Viewer - https://www.buraks.com/asv
package com.asual.swfaddress
{
    import flash.events.Event;

    public class SWFAddressEvent extends Event 
    {

        public static const INIT:String = "init";
        public static const CHANGE:String = "change";
        public static const INTERNAL_CHANGE:String = "internalChange";
        public static const EXTERNAL_CHANGE:String = "externalChange";

        private var _value:String;
        private var _path:String;
        private var _pathNames:Array;
        private var _parameterNames:Array;
        private var _parameters:Object;

        public function SWFAddressEvent(_arg_1:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(_arg_1, bubbles, cancelable);
        }

        override public function get currentTarget():Object
        {
            return (SWFAddress);
        }

        override public function get type():String
        {
            return (super.type);
        }

        override public function get target():Object
        {
            return (SWFAddress);
        }

        public function get value():String
        {
            if (this._value == null)
            {
                this._value = SWFAddress.getValue();
            };
            return (this._value);
        }

        public function get path():String
        {
            if (this._path == null)
            {
                this._path = SWFAddress.getPath();
            };
            return (this._path);
        }

        public function get pathNames():Array
        {
            if (this._pathNames == null)
            {
                this._pathNames = SWFAddress.getPathNames();
            };
            return (this._pathNames);
        }

        public function get parameters():Object
        {
            var i:int;
            if (this._parameters == null)
            {
                this._parameters = new Object();
                i = 0;
                while (i < this.parameterNames.length)
                {
                    this._parameters[this.parameterNames[i]] = SWFAddress.getParameter(this.parameterNames[i]);
                    i++;
                };
            };
            return (this._parameters);
        }

        public function get parameterNames():Array
        {
            if (this._parameterNames == null)
            {
                this._parameterNames = SWFAddress.getParameterNames();
            };
            return (this._parameterNames);
        }

        override public function clone():Event
        {
            return (new SWFAddressEvent(this.type, bubbles, cancelable));
        }

        override public function toString():String
        {
            return (formatToString("SWFAddressEvent", "type", "bubbles", "cancelable", "eventPhase", "value", "path", "pathNames", "parameterNames", "parameters"));
        }


    }
}//package com.asual.swfaddress
