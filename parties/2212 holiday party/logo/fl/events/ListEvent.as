//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.events
{
    import flash.events.Event;

    public class ListEvent extends Event 
    {

        public static const ITEM_ROLL_OUT:String = "itemRollOut";
        public static const ITEM_ROLL_OVER:String = "itemRollOver";
        public static const ITEM_CLICK:String = "itemClick";
        public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";

        protected var _rowIndex:int;
        protected var _columnIndex:int;
        protected var _index:int;
        protected var _item:Object;

        public function ListEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:int=-1, _arg_5:int=-1, _arg_6:int=-1, _arg_7:Object=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._rowIndex = _arg_5;
            this._columnIndex = _arg_4;
            this._index = _arg_6;
            this._item = _arg_7;
        }

        public function get rowIndex():Object
        {
            return (this._rowIndex);
        }

        public function get columnIndex():int
        {
            return (this._columnIndex);
        }

        public function get index():int
        {
            return (this._index);
        }

        public function get item():Object
        {
            return (this._item);
        }

        override public function toString():String
        {
            return (formatToString("ListEvent", "type", "bubbles", "cancelable", "columnIndex", "rowIndex", "index", "item"));
        }

        override public function clone():Event
        {
            return (new ListEvent(type, bubbles, cancelable, this._columnIndex, this._rowIndex));
        }


    }
}//package fl.events
