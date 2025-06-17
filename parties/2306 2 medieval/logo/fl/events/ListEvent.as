package fl.events
{
    import flash.events.*;

    public class ListEvent extends Event
    {
        protected var _rowIndex:int;
        protected var _columnIndex:int;
        protected var _index:int;
        protected var _item:Object;
        public static const ITEM_ROLL_OUT:String = "itemRollOut";
        public static const ITEM_ROLL_OVER:String = "itemRollOver";
        public static const ITEM_CLICK:String = "itemClick";
        public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";

        public function ListEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:int = -1, param6:int = -1, param7:Object = null)
        {
            super(param1, param2, param3);
            this._rowIndex = param5;
            this._columnIndex = param4;
            this._index = param6;
            this._item = param7;
            return;
        }// end function

        public function get rowIndex() : Object
        {
            return this._rowIndex;
        }// end function

        public function get columnIndex() : int
        {
            return this._columnIndex;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function get item() : Object
        {
            return this._item;
        }// end function

        override public function toString() : String
        {
            return formatToString("ListEvent", "type", "bubbles", "cancelable", "columnIndex", "rowIndex", "index", "item");
        }// end function

        override public function clone() : Event
        {
            return new ListEvent(type, bubbles, cancelable, this._columnIndex, this._rowIndex);
        }// end function

    }
}
