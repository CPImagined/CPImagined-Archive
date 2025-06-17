//Created by Action Script Viewer - https://www.buraks.com/asv
package com.playdom.util
{
    import flash.net.URLVariables;

    public class NameValuesContainer 
    {

        protected static var _instance:NameValuesContainer;

        protected var _length:uint = 0;
        protected var _names:Array;
        protected var _values:Array;

        public function NameValuesContainer(... rest):void
        {
            this._names = new Array();
            this._values = new Array();
            this._length = 0;
            var cntx:uint;
            while (cntx < rest.length)
            {
                if (((!(rest[cntx] == null)) && (!(rest[(cntx + 1)] == null))))
                {
                    this._names[this._length] = rest[cntx++];
                    var _local_3:* = this._length++;
                    this._values[_local_3] = rest[cntx++];
                }
                else
                {
                    cntx = (cntx + 2);
                };
            };
        }

        public static function getInstance(... rest):NameValuesContainer
        {
            var cntx:uint;
            if (_instance)
            {
                _instance._values = new Array();
                _instance._length = 0;
            }
            else
            {
                _instance = new (NameValuesContainer)();
            };
            cntx = 0;
            while (cntx < rest.length)
            {
                _instance._names[_instance._length] = rest[cntx++];
                var _local_3:* = _instance._length++;
                _instance._values[_local_3] = rest[cntx++];
            };
            return (_instance);
        }


        public function getNameAt(index:uint):String
        {
            return (this._names[index]);
        }

        public function getValueAt(index:uint):String
        {
            return (this._values[index]);
        }

        public function setNewUniqueId(_id:String):void
        {
            this._values[1] = _id;
        }

        public function addObject(obj:Object, title:String=""):void
        {
            this.parseToNameValue(obj, title);
        }

        public function addPair(name:String, value:String):Boolean
        {
            if (((!(name == "")) && (!(value == ""))))
            {
                this._names[this._length] = name;
                var _local_3:* = this._length++;
                this._values[_local_3] = value;
                return (true);
            };
            return (false);
        }

        public function addNVC(nvc:NameValuesContainer):void
        {
            var cntx:uint;
            if (nvc)
            {
                cntx = 0;
                while (cntx < nvc.length)
                {
                    this._names[this._length] = nvc.getNameAt(cntx);
                    var _local_3:* = this._length++;
                    this._values[_local_3] = nvc.getValueAt(cntx);
                    cntx++;
                };
            };
        }

        public function get length():uint
        {
            return (this._length);
        }

        public function addByPairs(... rest):void
        {
            var cntx:uint;
            while (cntx < rest.length)
            {
                this._names[this._length] = rest[cntx++];
                var _local_3:* = this._length++;
                this._values[_local_3] = rest[cntx++];
            };
        }

        protected function parseToNameValue(obj:Object, title:String=""):void
        {
            var sKey:String;
            if (title != "")
            {
                title = (title + "_");
            };
            for (sKey in obj)
            {
                if (((((obj[sKey] is Number) || (obj[sKey] is String)) || (obj[sKey] is uint)) || (obj[sKey] is int)))
                {
                    if (((!(obj[sKey] == "")) && (!(obj[sKey] == null))))
                    {
                        this._names[this._length] = (title + sKey);
                        var _local_6:* = this._length++;
                        this._values[_local_6] = obj[sKey];
                    };
                }
                else
                {
                    this.parseToNameValue(obj[sKey], title);
                };
            };
        }

        public function toURLVariables():URLVariables
        {
            var variablesObj:URLVariables = new URLVariables();
            var i:int;
            while (i < this._names.length)
            {
                if (this._names[i] != "")
                {
                    variablesObj[this._names[i]] = this._values[i];
                };
                i++;
            };
            return (variablesObj);
        }

        public function toString():String
        {
            var retString:String;
            var cntx:uint;
            var first:uint;
            while (((this._names[first] == "") || (this._values[first] == "")))
            {
                first++;
            };
            if (this.length > first)
            {
                retString = ((this._names[first] + "=") + this._values[first]);
                cntx = 1;
                while (cntx < this.length)
                {
                    if (((!(this._names[cntx] == "")) && (!(this._values[cntx] == ""))))
                    {
                        retString = (retString + ((("&" + this._names[cntx]) + "=") + this._values[cntx]));
                    };
                    cntx++;
                };
                return (retString);
            };
            return ("NVC is empty");
        }


    }
}//package com.playdom.util
