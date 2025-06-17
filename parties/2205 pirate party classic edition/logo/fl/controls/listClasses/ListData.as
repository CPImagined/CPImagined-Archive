//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls.listClasses
{
    import fl.core.UIComponent;

    public class ListData 
    {

        protected var _icon:Object = null;
        protected var _label:String;
        protected var _owner:UIComponent;
        protected var _index:uint;
        protected var _row:uint;
        protected var _column:uint;

        public function ListData(_arg_1:String, _arg_2:Object, _arg_3:UIComponent, _arg_4:uint, _arg_5:uint, _arg_6:uint=0)
        {
            this._label = _arg_1;
            this._icon = _arg_2;
            this._owner = _arg_3;
            this._index = _arg_4;
            this._row = _arg_5;
            this._column = _arg_6;
        }

        public function get label():String
        {
            return (this._label);
        }

        public function get icon():Object
        {
            return (this._icon);
        }

        public function get owner():UIComponent
        {
            return (this._owner);
        }

        public function get index():uint
        {
            return (this._index);
        }

        public function get row():uint
        {
            return (this._row);
        }

        public function get column():uint
        {
            return (this._column);
        }


    }
}//package fl.controls.listClasses
