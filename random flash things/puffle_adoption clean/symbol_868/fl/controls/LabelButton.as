//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.managers.IFocusManagerComponent;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import fl.events.ComponentEvent;
    import fl.core.InvalidationType;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.TextFieldType;
    import fl.core.UIComponent;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;

    public class LabelButton extends BaseButton implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "icon":null,
            "upIcon":null,
            "downIcon":null,
            "overIcon":null,
            "disabledIcon":null,
            "selectedDisabledIcon":null,
            "selectedUpIcon":null,
            "selectedDownIcon":null,
            "selectedOverIcon":null,
            "textFormat":null,
            "disabledTextFormat":null,
            "textPadding":5,
            "embedFonts":false
        };
        public static var createAccessibilityImplementation:Function;

        public var textField:TextField;
        protected var _labelPlacement:String = "right";
        protected var _toggle:Boolean = false;
        protected var icon:DisplayObject;
        protected var oldMouseState:String;
        protected var _label:String = "Label";
        protected var mode:String = "center";


        public static function getStyleDefinition():Object
        {
            return (mergeStyles(defaultStyles, BaseButton.getStyleDefinition()));
        }


        public function get label():String
        {
            return (this._label);
        }

        public function set label(_arg_1:String):void
        {
            this._label = _arg_1;
            if (this.textField.text != this._label)
            {
                this.textField.text = this._label;
                dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
            };
            invalidate(InvalidationType.SIZE);
            invalidate(InvalidationType.STYLES);
        }

        public function get labelPlacement():String
        {
            return (this._labelPlacement);
        }

        public function set labelPlacement(_arg_1:String):void
        {
            this._labelPlacement = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function get toggle():Boolean
        {
            return (this._toggle);
        }

        public function set toggle(_arg_1:Boolean):void
        {
            if (((!(_arg_1)) && (super.selected)))
            {
                this.selected = false;
            };
            this._toggle = _arg_1;
            if (this._toggle)
            {
                addEventListener(MouseEvent.CLICK, this.toggleSelected, false, 0, true);
            }
            else
            {
                removeEventListener(MouseEvent.CLICK, this.toggleSelected);
            };
            invalidate(InvalidationType.STATE);
        }

        protected function toggleSelected(_arg_1:MouseEvent):void
        {
            this.selected = (!(this.selected));
            dispatchEvent(new Event(Event.CHANGE, true));
        }

        override public function get selected():Boolean
        {
            return ((this._toggle) ? _selected : false);
        }

        override public function set selected(_arg_1:Boolean):void
        {
            _selected = _arg_1;
            if (this._toggle)
            {
                invalidate(InvalidationType.STATE);
            };
        }

        override protected function configUI():void
        {
            super.configUI();
            this.textField = new TextField();
            this.textField.type = TextFieldType.DYNAMIC;
            this.textField.selectable = false;
            addChild(this.textField);
        }

        override protected function draw():void
        {
            if (this.textField.text != this._label)
            {
                this.label = this._label;
            };
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                drawBackground();
                this.drawIcon();
                this.drawTextFormat();
                invalidate(InvalidationType.SIZE, false);
            };
            if (isInvalid(InvalidationType.SIZE))
            {
                this.drawLayout();
            };
            if (isInvalid(InvalidationType.SIZE, InvalidationType.STYLES))
            {
                if (((isFocused) && (focusManager.showFocusIndicator)))
                {
                    drawFocus(true);
                };
            };
            validate();
        }

        protected function drawIcon():void
        {
            var _local_1:DisplayObject = this.icon;
            var _local_2:String = ((enabled) ? mouseState : "disabled");
            if (this.selected)
            {
                _local_2 = (("selected" + _local_2.substr(0, 1).toUpperCase()) + _local_2.substr(1));
            };
            _local_2 = (_local_2 + "Icon");
            var _local_3:Object = getStyleValue(_local_2);
            if (_local_3 == null)
            {
                _local_3 = getStyleValue("icon");
            };
            if (_local_3 != null)
            {
                this.icon = getDisplayObjectInstance(_local_3);
            };
            if (this.icon != null)
            {
                addChildAt(this.icon, 1);
            };
            if (((!(_local_1 == null)) && (!(_local_1 == this.icon))))
            {
                removeChild(_local_1);
            };
        }

        protected function drawTextFormat():void
        {
            var _local_1:Object = UIComponent.getStyleDefinition();
            var _local_2:TextFormat = ((enabled) ? (_local_1.defaultTextFormat as TextFormat) : (_local_1.defaultDisabledTextFormat as TextFormat));
            this.textField.setTextFormat(_local_2);
            var _local_3:TextFormat = (getStyleValue(((enabled) ? "textFormat" : "disabledTextFormat")) as TextFormat);
            if (_local_3 != null)
            {
                this.textField.setTextFormat(_local_3);
            }
            else
            {
                _local_3 = _local_2;
            };
            this.textField.defaultTextFormat = _local_3;
            this.setEmbedFont();
        }

        protected function setEmbedFont():*
        {
            var _local_1:Object = getStyleValue("embedFonts");
            if (_local_1 != null)
            {
                this.textField.embedFonts = _local_1;
            };
        }

        override protected function drawLayout():void
        {
            var _local_7:Number;
            var _local_8:Number;
            var _local_1:Number = Number(getStyleValue("textPadding"));
            var _local_2:String = (((this.icon == null) && (this.mode == "center")) ? ButtonLabelPlacement.TOP : this._labelPlacement);
            this.textField.height = (this.textField.textHeight + 4);
            var _local_3:Number = (this.textField.textWidth + 4);
            var _local_4:Number = (this.textField.textHeight + 4);
            var _local_5:Number = ((this.icon == null) ? 0 : (this.icon.width + _local_1));
            var _local_6:Number = ((this.icon == null) ? 0 : (this.icon.height + _local_1));
            this.textField.visible = (this.label.length > 0);
            if (this.icon != null)
            {
                this.icon.x = Math.round(((width - this.icon.width) / 2));
                this.icon.y = Math.round(((height - this.icon.height) / 2));
            };
            if (this.textField.visible == false)
            {
                this.textField.width = 0;
                this.textField.height = 0;
            }
            else
            {
                if (((_local_2 == ButtonLabelPlacement.BOTTOM) || (_local_2 == ButtonLabelPlacement.TOP)))
                {
                    _local_7 = Math.max(0, Math.min(_local_3, (width - (2 * _local_1))));
                    if ((height - 2) > _local_4)
                    {
                        _local_8 = _local_4;
                    }
                    else
                    {
                        _local_8 = (height - 2);
                    };
                    this.textField.width = (_local_3 = _local_7);
                    this.textField.height = (_local_4 = _local_8);
                    this.textField.x = Math.round(((width - _local_3) / 2));
                    this.textField.y = Math.round(((((height - this.textField.height) - _local_6) / 2) + ((_local_2 == ButtonLabelPlacement.BOTTOM) ? _local_6 : 0)));
                    if (this.icon != null)
                    {
                        this.icon.y = Math.round(((_local_2 == ButtonLabelPlacement.BOTTOM) ? (this.textField.y - _local_6) : ((this.textField.y + this.textField.height) + _local_1)));
                    };
                }
                else
                {
                    _local_7 = Math.max(0, Math.min(_local_3, ((width - _local_5) - (2 * _local_1))));
                    this.textField.width = (_local_3 = _local_7);
                    this.textField.x = Math.round(((((width - _local_3) - _local_5) / 2) + ((_local_2 != ButtonLabelPlacement.LEFT) ? _local_5 : 0)));
                    this.textField.y = Math.round(((height - this.textField.height) / 2));
                    if (this.icon != null)
                    {
                        this.icon.x = Math.round(((_local_2 != ButtonLabelPlacement.LEFT) ? (this.textField.x - _local_5) : ((this.textField.x + _local_3) + _local_1)));
                    };
                };
            };
            super.drawLayout();
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (!enabled)
            {
                return;
            };
            if (_arg_1.keyCode == Keyboard.SPACE)
            {
                if (this.oldMouseState == null)
                {
                    this.oldMouseState = mouseState;
                };
                setMouseState("down");
                startPress();
            };
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            if (!enabled)
            {
                return;
            };
            if (_arg_1.keyCode == Keyboard.SPACE)
            {
                setMouseState(this.oldMouseState);
                this.oldMouseState = null;
                endPress();
                dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
        }

        override protected function initializeAccessibility():void
        {
            if (LabelButton.createAccessibilityImplementation != null)
            {
                LabelButton.createAccessibilityImplementation(this);
            };
        }


    }
}//package fl.controls
