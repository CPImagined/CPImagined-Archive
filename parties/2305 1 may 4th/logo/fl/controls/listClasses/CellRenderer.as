package fl.controls.listClasses
{
    import fl.controls.*;
    import fl.controls.listClasses.*;
    import flash.events.*;

    public class CellRenderer extends LabelButton implements ICellRenderer
    {
        protected var _listData:ListData;
        protected var _data:Object;
        private static var defaultStyles:Object = {upSkin:"CellRenderer_upSkin", downSkin:"CellRenderer_downSkin", overSkin:"CellRenderer_overSkin", disabledSkin:"CellRenderer_disabledSkin", selectedDisabledSkin:"CellRenderer_selectedDisabledSkin", selectedUpSkin:"CellRenderer_selectedUpSkin", selectedDownSkin:"CellRenderer_selectedDownSkin", selectedOverSkin:"CellRenderer_selectedOverSkin", textFormat:null, disabledTextFormat:null, embedFonts:null, textPadding:5};

        public function CellRenderer() : void
        {
            toggle = true;
            focusEnabled = false;
            return;
        }// end function

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1, param2);
            return;
        }// end function

        public function get listData() : ListData
        {
            return this._listData;
        }// end function

        public function set listData(param1:ListData) : void
        {
            this._listData = param1;
            label = this._listData.label;
            setStyle("icon", this._listData.icon);
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            return;
        }// end function

        override public function get selected() : Boolean
        {
            return super.selected;
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            super.selected = param1;
            return;
        }// end function

        override protected function toggleSelected(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function drawLayout() : void
        {
            var _loc_3:* = NaN;
            var _loc_1:* = Number(getStyleValue("textPadding"));
            var _loc_2:* = 0;
            if (icon != null)
            {
                icon.x = _loc_1;
                icon.y = Math.round(height - icon.height >> 1);
                _loc_2 = icon.width + _loc_1;
            }
            if (label.length > 0)
            {
                textField.visible = true;
                _loc_3 = Math.max(0, width - _loc_2 - _loc_1 * 2);
                textField.width = _loc_3;
                textField.height = textField.textHeight + 4;
                textField.x = _loc_2 + _loc_1;
                textField.y = Math.round(height - textField.height >> 1);
            }
            else
            {
                textField.visible = false;
            }
            background.width = width;
            background.height = height;
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return defaultStyles;
        }// end function

    }
}
