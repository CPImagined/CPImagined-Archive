//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.managers.IFocusManagerComponent;
    import flash.display.DisplayObject;
    import fl.core.UIComponent;
    import fl.core.InvalidationType;

    [Style(name="emphasizedSkin", type="Class")]
    [Style(name="emphasizedPadding", type="Number", format="Length")]
    public class Button extends LabelButton implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "emphasizedSkin":"Button_emphasizedSkin",
            "emphasizedPadding":2
        };
        public static var createAccessibilityImplementation:Function;

        protected var _emphasized:Boolean = false;
        protected var emphasizedBorder:DisplayObject;


        public static function getStyleDefinition():Object
        {
            return (UIComponent.mergeStyles(LabelButton.getStyleDefinition(), defaultStyles));
        }


        [Inspectable(defaultValue="false")]
        public function get emphasized():Boolean
        {
            return (this._emphasized);
        }

        public function set emphasized(_arg_1:Boolean):void
        {
            this._emphasized = _arg_1;
            invalidate(InvalidationType.STYLES);
        }

        override protected function draw():void
        {
            if (((isInvalid(InvalidationType.STYLES)) || (isInvalid(InvalidationType.SIZE))))
            {
                this.drawEmphasized();
            };
            super.draw();
            if (this.emphasizedBorder != null)
            {
                setChildIndex(this.emphasizedBorder, (numChildren - 1));
            };
        }

        protected function drawEmphasized():void
        {
            var _local_2:Number;
            if (this.emphasizedBorder != null)
            {
                removeChild(this.emphasizedBorder);
            };
            this.emphasizedBorder = null;
            if ((!(this._emphasized)))
            {
                return;
            };
            var _local_1:Object = getStyleValue("emphasizedSkin");
            if (_local_1 != null)
            {
                this.emphasizedBorder = getDisplayObjectInstance(_local_1);
            };
            if (this.emphasizedBorder != null)
            {
                addChildAt(this.emphasizedBorder, 0);
                _local_2 = Number(getStyleValue("emphasizedPadding"));
                this.emphasizedBorder.x = (this.emphasizedBorder.y = -(_local_2));
                this.emphasizedBorder.width = (width + (_local_2 * 2));
                this.emphasizedBorder.height = (height + (_local_2 * 2));
            };
        }

        override public function drawFocus(_arg_1:Boolean):void
        {
            var _local_2:Number;
            var _local_3:*;
            super.drawFocus(_arg_1);
            if (_arg_1)
            {
                _local_2 = Number(getStyleValue("emphasizedPadding"));
                if (((_local_2 < 0) || (!(this._emphasized))))
                {
                    _local_2 = 0;
                };
                _local_3 = getStyleValue("focusRectPadding");
                _local_3 = ((_local_3 == null) ? 2 : _local_3);
                _local_3 = (_local_3 + _local_2);
                uiFocusRect.x = -(_local_3);
                uiFocusRect.y = -(_local_3);
                uiFocusRect.width = (width + (_local_3 * 2));
                uiFocusRect.height = (height + (_local_3 * 2));
            };
        }

        override protected function initializeAccessibility():void
        {
            if (Button.createAccessibilityImplementation != null)
            {
                Button.createAccessibilityImplementation(this);
            };
        }


    }
}//package fl.controls
