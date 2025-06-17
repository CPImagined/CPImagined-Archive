package fl.controls
{
    import fl.core.*;
    import fl.events.*;
    import fl.managers.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;

    public class LabelButton extends BaseButton implements IFocusManagerComponent
    {
        public var textField:TextField;
        protected var _labelPlacement:String = "right";
        protected var _toggle:Boolean = false;
        protected var icon:DisplayObject;
        protected var oldMouseState:String;
        protected var _label:String = "Label";
        protected var mode:String = "center";
        private static var defaultStyles:Object = {icon:null, upIcon:null, downIcon:null, overIcon:null, disabledIcon:null, selectedDisabledIcon:null, selectedUpIcon:null, selectedDownIcon:null, selectedOverIcon:null, textFormat:null, disabledTextFormat:null, textPadding:5, embedFonts:false};
        public static var createAccessibilityImplementation:Function;

        public function LabelButton()
        {
            return;
        }// end function

        public function get label() : String
        {
            return this._label;
        }// end function

        public function set label(param1:String) : void
        {
            this._label = param1;
            if (this.textField.text != this._label)
            {
                this.textField.text = this._label;
                dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
            }
            invalidate(InvalidationType.SIZE);
            invalidate(InvalidationType.STYLES);
            return;
        }// end function

        public function get labelPlacement() : String
        {
            return this._labelPlacement;
        }// end function

        public function set labelPlacement(param1:String) : void
        {
            this._labelPlacement = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function get toggle() : Boolean
        {
            return this._toggle;
        }// end function

        public function set toggle(param1:Boolean) : void
        {
            if (!param1 && super.selected)
            {
                this.selected = false;
            }
            this._toggle = param1;
            if (this._toggle)
            {
                addEventListener(MouseEvent.CLICK, this.toggleSelected, false, 0, true);
            }
            else
            {
                removeEventListener(MouseEvent.CLICK, this.toggleSelected);
            }
            invalidate(InvalidationType.STATE);
            return;
        }// end function

        protected function toggleSelected(event:MouseEvent) : void
        {
            this.selected = !this.selected;
            dispatchEvent(new Event(Event.CHANGE, true));
            return;
        }// end function

        override public function get selected() : Boolean
        {
            return this._toggle ? (_selected) : (false);
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            _selected = param1;
            if (this._toggle)
            {
                invalidate(InvalidationType.STATE);
            }
            return;
        }// end function

        override protected function configUI() : void
        {
            super.configUI();
            this.textField = new TextField();
            this.textField.type = TextFieldType.DYNAMIC;
            this.textField.selectable = false;
            addChild(this.textField);
            return;
        }// end function

        override protected function draw() : void
        {
            if (this.textField.text != this._label)
            {
                this.label = this._label;
            }
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                drawBackground();
                this.drawIcon();
                this.drawTextFormat();
                invalidate(InvalidationType.SIZE, false);
            }
            if (isInvalid(InvalidationType.SIZE))
            {
                this.drawLayout();
            }
            if (isInvalid(InvalidationType.SIZE, InvalidationType.STYLES))
            {
                if (isFocused && focusManager.showFocusIndicator)
                {
                    drawFocus(true);
                }
            }
            validate();
            return;
        }// end function

        protected function drawIcon() : void
        {
            var _loc_1:* = this.icon;
            var _loc_2:* = enabled ? (mouseState) : ("disabled");
            if (this.selected)
            {
                _loc_2 = "selected" + _loc_2.substr(0, 1).toUpperCase() + _loc_2.substr(1);
            }
            _loc_2 = _loc_2 + "Icon";
            var _loc_3:* = getStyleValue(_loc_2);
            if (_loc_3 == null)
            {
                _loc_3 = getStyleValue("icon");
            }
            if (_loc_3 != null)
            {
                this.icon = getDisplayObjectInstance(_loc_3);
            }
            if (this.icon != null)
            {
                addChildAt(this.icon, 1);
            }
            if (_loc_1 != null && _loc_1 != this.icon)
            {
                removeChild(_loc_1);
            }
            return;
        }// end function

        protected function drawTextFormat() : void
        {
            var _loc_1:* = UIComponent.getStyleDefinition();
            var _loc_2:* = enabled ? (_loc_1.defaultTextFormat as TextFormat) : (_loc_1.defaultDisabledTextFormat as TextFormat);
            this.textField.setTextFormat(_loc_2);
            var _loc_3:* = getStyleValue(enabled ? ("textFormat") : ("disabledTextFormat")) as TextFormat;
            if (_loc_3 != null)
            {
                this.textField.setTextFormat(_loc_3);
            }
            else
            {
                _loc_3 = _loc_2;
            }
            this.textField.defaultTextFormat = _loc_3;
            this.setEmbedFont();
            return;
        }// end function

        protected function setEmbedFont()
        {
            var _loc_1:* = getStyleValue("embedFonts");
            if (_loc_1 != null)
            {
                this.textField.embedFonts = _loc_1;
            }
            return;
        }// end function

        override protected function drawLayout() : void
        {
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_1:* = Number(getStyleValue("textPadding"));
            var _loc_2:* = this.icon == null && this.mode == "center" ? (ButtonLabelPlacement.TOP) : (this._labelPlacement);
            this.textField.height = this.textField.textHeight + 4;
            var _loc_3:* = this.textField.textWidth + 4;
            var _loc_4:* = this.textField.textHeight + 4;
            var _loc_5:* = this.icon == null ? (0) : (this.icon.width + _loc_1);
            var _loc_6:* = this.icon == null ? (0) : (this.icon.height + _loc_1);
            this.textField.visible = this.label.length > 0;
            if (this.icon != null)
            {
                this.icon.x = Math.round((width - this.icon.width) / 2);
                this.icon.y = Math.round((height - this.icon.height) / 2);
            }
            if (this.textField.visible == false)
            {
                this.textField.width = 0;
                this.textField.height = 0;
            }
            else if (_loc_2 == ButtonLabelPlacement.BOTTOM || _loc_2 == ButtonLabelPlacement.TOP)
            {
                _loc_7 = Math.max(0, Math.min(_loc_3, width - 2 * _loc_1));
                if (height - 2 > _loc_4)
                {
                    _loc_8 = _loc_4;
                }
                else
                {
                    _loc_8 = height - 2;
                }
                var _loc_9:* = _loc_7;
                _loc_3 = _loc_7;
                this.textField.width = _loc_9;
                var _loc_9:* = _loc_8;
                _loc_4 = _loc_8;
                this.textField.height = _loc_9;
                this.textField.x = Math.round((width - _loc_3) / 2);
                this.textField.y = Math.round((height - this.textField.height - _loc_6) / 2 + (_loc_2 == ButtonLabelPlacement.BOTTOM ? (_loc_6) : (0)));
                if (this.icon != null)
                {
                    this.icon.y = Math.round(_loc_2 == ButtonLabelPlacement.BOTTOM ? (this.textField.y - _loc_6) : (this.textField.y + this.textField.height + _loc_1));
                }
            }
            else
            {
                _loc_7 = Math.max(0, Math.min(_loc_3, width - _loc_5 - 2 * _loc_1));
                var _loc_9:* = _loc_7;
                _loc_3 = _loc_7;
                this.textField.width = _loc_9;
                this.textField.x = Math.round((width - _loc_3 - _loc_5) / 2 + (_loc_2 != ButtonLabelPlacement.LEFT ? (_loc_5) : (0)));
                this.textField.y = Math.round((height - this.textField.height) / 2);
                if (this.icon != null)
                {
                    this.icon.x = Math.round(_loc_2 != ButtonLabelPlacement.LEFT ? (this.textField.x - _loc_5) : (this.textField.x + _loc_3 + _loc_1));
                }
            }
            super.drawLayout();
            return;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!enabled)
            {
                return;
            }
            if (event.keyCode == Keyboard.SPACE)
            {
                if (this.oldMouseState == null)
                {
                    this.oldMouseState = mouseState;
                }
                setMouseState("down");
                startPress();
            }
            return;
        }// end function

        override protected function keyUpHandler(event:KeyboardEvent) : void
        {
            if (!enabled)
            {
                return;
            }
            if (event.keyCode == Keyboard.SPACE)
            {
                setMouseState(this.oldMouseState);
                this.oldMouseState = null;
                endPress();
                dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (LabelButton.createAccessibilityImplementation != null)
            {
                LabelButton.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return mergeStyles(defaultStyles, BaseButton.getStyleDefinition());
        }// end function

    }
}
