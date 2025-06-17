package fl.controls
{
    import fl.core.*;
    import fl.managers.*;
    import flash.display.*;

    public class Button extends LabelButton implements IFocusManagerComponent
    {
        protected var _emphasized:Boolean = false;
        protected var emphasizedBorder:DisplayObject;
        private static var defaultStyles:Object = {emphasizedSkin:"Button_emphasizedSkin", emphasizedPadding:2};
        public static var createAccessibilityImplementation:Function;

        public function Button()
        {
            return;
        }// end function

        public function get emphasized() : Boolean
        {
            return this._emphasized;
        }// end function

        public function set emphasized(param1:Boolean) : void
        {
            this._emphasized = param1;
            invalidate(InvalidationType.STYLES);
            return;
        }// end function

        override protected function draw() : void
        {
            if (isInvalid(InvalidationType.STYLES) || isInvalid(InvalidationType.SIZE))
            {
                this.drawEmphasized();
            }
            super.draw();
            if (this.emphasizedBorder != null)
            {
                setChildIndex(this.emphasizedBorder, (numChildren - 1));
            }
            return;
        }// end function

        protected function drawEmphasized() : void
        {
            var _loc_2:* = NaN;
            if (this.emphasizedBorder != null)
            {
                removeChild(this.emphasizedBorder);
            }
            this.emphasizedBorder = null;
            if (!this._emphasized)
            {
                return;
            }
            var _loc_1:* = getStyleValue("emphasizedSkin");
            if (_loc_1 != null)
            {
                this.emphasizedBorder = getDisplayObjectInstance(_loc_1);
            }
            if (this.emphasizedBorder != null)
            {
                addChildAt(this.emphasizedBorder, 0);
                _loc_2 = Number(getStyleValue("emphasizedPadding"));
                var _loc_3:* = -_loc_2;
                this.emphasizedBorder.y = -_loc_2;
                this.emphasizedBorder.x = _loc_3;
                this.emphasizedBorder.width = width + _loc_2 * 2;
                this.emphasizedBorder.height = height + _loc_2 * 2;
            }
            return;
        }// end function

        override public function drawFocus(param1:Boolean) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = undefined;
            super.drawFocus(param1);
            if (param1)
            {
                _loc_2 = Number(getStyleValue("emphasizedPadding"));
                if (_loc_2 < 0 || !this._emphasized)
                {
                    _loc_2 = 0;
                }
                _loc_3 = getStyleValue("focusRectPadding");
                _loc_3 = _loc_3 == null ? (2) : (_loc_3);
                _loc_3 = _loc_3 + _loc_2;
                uiFocusRect.x = -_loc_3;
                uiFocusRect.y = -_loc_3;
                uiFocusRect.width = width + _loc_3 * 2;
                uiFocusRect.height = height + _loc_3 * 2;
            }
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (Button.createAccessibilityImplementation != null)
            {
                Button.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return UIComponent.mergeStyles(LabelButton.getStyleDefinition(), defaultStyles);
        }// end function

    }
}
