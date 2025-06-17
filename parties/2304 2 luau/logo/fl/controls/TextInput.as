package fl.controls
{
    import fl.core.*;
    import fl.events.*;
    import fl.managers.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;

    public class TextInput extends UIComponent implements IFocusManagerComponent
    {
        public var textField:TextField;
        protected var _editable:Boolean = true;
        protected var background:DisplayObject;
        protected var _html:Boolean = false;
        protected var _savedHTML:String;
        private static var defaultStyles:Object = {upSkin:"TextInput_upSkin", disabledSkin:"TextInput_disabledSkin", focusRectSkin:null, focusRectPadding:null, textFormat:null, disabledTextFormat:null, textPadding:0, embedFonts:false};
        public static var createAccessibilityImplementation:Function;

        public function TextInput()
        {
            return;
        }// end function

        public function get text() : String
        {
            return this.textField.text;
        }// end function

        public function set text(param1:String) : void
        {
            this.textField.text = param1;
            this._html = false;
            invalidate(InvalidationType.DATA);
            invalidate(InvalidationType.STYLES);
            return;
        }// end function

        override public function get enabled() : Boolean
        {
            return super.enabled;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.updateTextFieldType();
            return;
        }// end function

        public function get imeMode() : String
        {
            return _imeMode;
        }// end function

        public function set imeMode(param1:String) : void
        {
            _imeMode = param1;
            return;
        }// end function

        public function get alwaysShowSelection() : Boolean
        {
            return this.textField.alwaysShowSelection;
        }// end function

        public function set alwaysShowSelection(param1:Boolean) : void
        {
            this.textField.alwaysShowSelection = param1;
            return;
        }// end function

        override public function drawFocus(param1:Boolean) : void
        {
            if (focusTarget != null)
            {
                focusTarget.drawFocus(param1);
                return;
            }
            super.drawFocus(param1);
            return;
        }// end function

        public function get editable() : Boolean
        {
            return this._editable;
        }// end function

        public function set editable(param1:Boolean) : void
        {
            this._editable = param1;
            this.updateTextFieldType();
            return;
        }// end function

        public function get horizontalScrollPosition() : int
        {
            return this.textField.scrollH;
        }// end function

        public function set horizontalScrollPosition(param1:int) : void
        {
            this.textField.scrollH = param1;
            return;
        }// end function

        public function get maxHorizontalScrollPosition() : int
        {
            return this.textField.maxScrollH;
        }// end function

        public function get length() : int
        {
            return this.textField.length;
        }// end function

        public function get maxChars() : int
        {
            return this.textField.maxChars;
        }// end function

        public function set maxChars(param1:int) : void
        {
            this.textField.maxChars = param1;
            return;
        }// end function

        public function get displayAsPassword() : Boolean
        {
            return this.textField.displayAsPassword;
        }// end function

        public function set displayAsPassword(param1:Boolean) : void
        {
            this.textField.displayAsPassword = param1;
            return;
        }// end function

        public function get restrict() : String
        {
            return this.textField.restrict;
        }// end function

        public function set restrict(param1:String) : void
        {
            if (componentInspectorSetting && param1 == "")
            {
                param1 = null;
            }
            this.textField.restrict = param1;
            return;
        }// end function

        public function get selectionBeginIndex() : int
        {
            return this.textField.selectionBeginIndex;
        }// end function

        public function get selectionEndIndex() : int
        {
            return this.textField.selectionEndIndex;
        }// end function

        public function get condenseWhite() : Boolean
        {
            return this.textField.condenseWhite;
        }// end function

        public function set condenseWhite(param1:Boolean) : void
        {
            this.textField.condenseWhite = param1;
            return;
        }// end function

        public function get htmlText() : String
        {
            return this.textField.htmlText;
        }// end function

        public function set htmlText(param1:String) : void
        {
            if (param1 == "")
            {
                this.text = "";
                return;
            }
            this._html = true;
            this._savedHTML = param1;
            this.textField.htmlText = param1;
            invalidate(InvalidationType.DATA);
            invalidate(InvalidationType.STYLES);
            return;
        }// end function

        public function get textHeight() : Number
        {
            return this.textField.textHeight;
        }// end function

        public function get textWidth() : Number
        {
            return this.textField.textWidth;
        }// end function

        public function setSelection(param1:int, param2:int) : void
        {
            this.textField.setSelection(param1, param2);
            return;
        }// end function

        public function getLineMetrics(param1:int) : TextLineMetrics
        {
            return this.textField.getLineMetrics(param1);
        }// end function

        public function appendText(param1:String) : void
        {
            this.textField.appendText(param1);
            return;
        }// end function

        protected function updateTextFieldType() : void
        {
            this.textField.type = this.enabled && this.editable ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
            this.textField.selectable = this.enabled;
            return;
        }// end function

        protected function handleKeyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == Keyboard.ENTER)
            {
                dispatchEvent(new ComponentEvent(ComponentEvent.ENTER, true));
            }
            return;
        }// end function

        protected function handleChange(event:Event) : void
        {
            event.stopPropagation();
            dispatchEvent(new Event(Event.CHANGE, true));
            return;
        }// end function

        protected function handleTextInput(event:TextEvent) : void
        {
            event.stopPropagation();
            dispatchEvent(new TextEvent(TextEvent.TEXT_INPUT, true, false, event.text));
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

        override protected function draw() : void
        {
            var _loc_1:* = null;
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                this.drawTextFormat();
                this.drawBackground();
                _loc_1 = getStyleValue("embedFonts");
                if (_loc_1 != null)
                {
                    this.textField.embedFonts = _loc_1;
                }
                invalidate(InvalidationType.SIZE, false);
            }
            if (isInvalid(InvalidationType.SIZE))
            {
                this.drawLayout();
            }
            super.draw();
            return;
        }// end function

        protected function drawBackground() : void
        {
            var _loc_1:* = this.background;
            var _loc_2:* = this.enabled ? ("upSkin") : ("disabledSkin");
            this.background = getDisplayObjectInstance(getStyleValue(_loc_2));
            if (this.background == null)
            {
                return;
            }
            addChildAt(this.background, 0);
            if (_loc_1 != null && _loc_1 != this.background && contains(_loc_1))
            {
                removeChild(_loc_1);
            }
            return;
        }// end function

        protected function drawTextFormat() : void
        {
            var _loc_1:* = UIComponent.getStyleDefinition();
            var _loc_2:* = this.enabled ? (_loc_1.defaultTextFormat as TextFormat) : (_loc_1.defaultDisabledTextFormat as TextFormat);
            this.textField.setTextFormat(_loc_2);
            var _loc_3:* = getStyleValue(this.enabled ? ("textFormat") : ("disabledTextFormat")) as TextFormat;
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
            if (this._html)
            {
                this.textField.htmlText = this._savedHTML;
            }
            return;
        }// end function

        protected function drawLayout() : void
        {
            var _loc_1:* = Number(getStyleValue("textPadding"));
            if (this.background != null)
            {
                this.background.width = width;
                this.background.height = height;
            }
            this.textField.width = width - 2 * _loc_1;
            this.textField.height = height - 2 * _loc_1;
            var _loc_2:* = _loc_1;
            this.textField.y = _loc_1;
            this.textField.x = _loc_2;
            return;
        }// end function

        override protected function configUI() : void
        {
            super.configUI();
            tabChildren = true;
            this.textField = new TextField();
            addChild(this.textField);
            this.updateTextFieldType();
            this.textField.addEventListener(TextEvent.TEXT_INPUT, this.handleTextInput, false, 0, true);
            this.textField.addEventListener(Event.CHANGE, this.handleChange, false, 0, true);
            this.textField.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown, false, 0, true);
            return;
        }// end function

        override public function setFocus() : void
        {
            stage.focus = this.textField;
            return;
        }// end function

        override protected function isOurFocus(param1:DisplayObject) : Boolean
        {
            return param1 == this.textField || super.isOurFocus(param1);
        }// end function

        override protected function focusInHandler(event:FocusEvent) : void
        {
            if (event.target == this)
            {
                stage.focus = this.textField;
            }
            var _loc_2:* = focusManager;
            if (this.editable && _loc_2)
            {
                _loc_2.showFocusIndicator = true;
                if (this.textField.selectable && this.textField.selectionBeginIndex == this.textField.selectionBeginIndex)
                {
                    this.setSelection(0, this.textField.length);
                }
            }
            super.focusInHandler(event);
            if (this.editable)
            {
                setIMEMode(true);
            }
            return;
        }// end function

        override protected function focusOutHandler(event:FocusEvent) : void
        {
            super.focusOutHandler(event);
            if (this.editable)
            {
                setIMEMode(false);
            }
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return defaultStyles;
        }// end function

    }
}
