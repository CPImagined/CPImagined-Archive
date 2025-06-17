//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls.listClasses
{
    import fl.controls.LabelButton;
    import flash.events.MouseEvent;

    [Style(name="upSkin", type="Class")]
    [Style(name="downSkin", type="Class")]
    [Style(name="overSkin", type="Class")]
    [Style(name="disabledSkin", type="Class")]
    [Style(name="selectedDisabledSkin", type="Class")]
    [Style(name="selectedUpSkin", type="Class")]
    [Style(name="selectedDownSkin", type="Class")]
    [Style(name="selectedOverSkin", type="Class")]
    [Style(name="textFormat", type="flash.text.TextFormat")]
    [Style(name="disabledTextFormat", type="flash.text.TextFormat")]
    [Style(name="textPadding", type="Number", format="Length")]
    public class CellRenderer extends LabelButton implements ICellRenderer 
    {

        private static var defaultStyles:Object = {
            "upSkin":"CellRenderer_upSkin",
            "downSkin":"CellRenderer_downSkin",
            "overSkin":"CellRenderer_overSkin",
            "disabledSkin":"CellRenderer_disabledSkin",
            "selectedDisabledSkin":"CellRenderer_selectedDisabledSkin",
            "selectedUpSkin":"CellRenderer_selectedUpSkin",
            "selectedDownSkin":"CellRenderer_selectedDownSkin",
            "selectedOverSkin":"CellRenderer_selectedOverSkin",
            "textFormat":null,
            "disabledTextFormat":null,
            "embedFonts":null,
            "textPadding":5
        };

        protected var _listData:ListData;
        protected var _data:Object;

        public function CellRenderer():void
        {
            toggle = true;
            focusEnabled = false;
        }

        public static function getStyleDefinition():Object
        {
            return (defaultStyles);
        }


        override public function setSize(_arg_1:Number, _arg_2:Number):void
        {
            super.setSize(_arg_1, _arg_2);
        }

        public function get listData():ListData
        {
            return (this._listData);
        }

        public function set listData(_arg_1:ListData):void
        {
            this._listData = _arg_1;
            label = this._listData.label;
            setStyle("icon", this._listData.icon);
        }

        public function get data():Object
        {
            return (this._data);
        }

        public function set data(_arg_1:Object):void
        {
            this._data = _arg_1;
        }

        override public function get selected():Boolean
        {
            return (super.selected);
        }

        override public function set selected(_arg_1:Boolean):void
        {
            super.selected = _arg_1;
        }

        override protected function toggleSelected(_arg_1:MouseEvent):void
        {
        }

        override protected function drawLayout():void
        {
            var _local_3:Number;
            var _local_1:Number = Number(getStyleValue("textPadding"));
            var _local_2:Number = 0;
            if (icon != null)
            {
                icon.x = _local_1;
                icon.y = Math.round(((height - icon.height) >> 1));
                _local_2 = (icon.width + _local_1);
            };
            if (label.length > 0)
            {
                textField.visible = true;
                _local_3 = Math.max(0, ((width - _local_2) - (_local_1 * 2)));
                textField.width = _local_3;
                textField.height = (textField.textHeight + 4);
                textField.x = (_local_2 + _local_1);
                textField.y = Math.round(((height - textField.height) >> 1));
            }
            else
            {
                textField.visible = false;
            };
            background.width = width;
            background.height = height;
        }


    }
}//package fl.controls.listClasses
