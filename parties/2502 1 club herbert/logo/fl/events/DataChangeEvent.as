//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.events
{
    import flash.events.Event;

    public class DataChangeEvent extends Event 
    {

        public static const DATA_CHANGE:String = "dataChange";
        public static const PRE_DATA_CHANGE:String = "preDataChange";

        protected var _startIndex:uint;
        protected var _endIndex:uint;
        protected var _changeType:String;
        protected var _items:Array;

        public function DataChangeEvent(_arg_1:String, _arg_2:String, _arg_3:Array, _arg_4:int=-1, _arg_5:int=-1):void
        {
            super(_arg_1);
            this._changeType = _arg_2;
            this._startIndex = _arg_4;
            this._items = _arg_3;
            this._endIndex = ((_arg_5 == -1) ? this._startIndex : _arg_5);
        }

        public function get changeType():String
        {
            return (this._changeType);
        }

        public function get items():Array
        {
            return (this._items);
        }

        public function get startIndex():uint
        {
            return (this._startIndex);
        }

        public function get endIndex():uint
        {
            return (this._endIndex);
        }

        override public function toString():String
        {
            return (formatToString("DataChangeEvent", "type", "changeType", "startIndex", "endIndex", "bubbles", "cancelable"));
        }

        override public function clone():Event
        {
            return (new DataChangeEvent(type, this._changeType, this._items, this._startIndex, this._endIndex));
        }


    }
}//package fl.events
