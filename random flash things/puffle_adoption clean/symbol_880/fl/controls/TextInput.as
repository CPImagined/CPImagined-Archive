//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.core.UIComponent;
    import fl.managers.IFocusManagerComponent;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import fl.core.InvalidationType;
    import flash.text.TextLineMetrics;
    import flash.text.TextFieldType;
    import flash.ui.Keyboard;
    import fl.events.ComponentEvent;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.TextEvent;
    import flash.text.TextFormat;
    import fl.managers.IFocusManager;
    import flash.events.FocusEvent;

    [Event(name="change", type="flash.events.Event")]
    [Event(name="enter", type="fl.events.ComponentEvent")]
    [Event(name="textInput", type="flash.events.TextEvent")]
    [Style(name="upSkin", type="Class")]
    [Style(name="textPadding", type="Number", format="Length")]
    [Style(name="disabledSkin", type="Class")]
    [Style(name="embedFonts", type="Boolean")]
    public class TextInput extends UIComponent implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "upSkin":"TextInput_upSkin",
            "disabledSkin":"TextInput_disabledSkin",
            "focusRectSkin":null,
            "focusRectPadding":null,
            "textFormat":null,
            "disabledTextFormat":null,
            "textPadding":0,
            "embedFonts":false
        };
        public static var createAccessibilityImplementation:Function;

        public var textField:TextField;
        protected var _editable:Boolean = true;
        protected var background:DisplayObject;
        protected var _html:Boolean = false;
        protected var _savedHTML:String;


        public static function getStyleDefinition():Object
        {
            return (defaultStyles);
        }


        [Inspectable(defaultValue="")]
        public function get text():String
        {
            return (this.textField.text);
        }

        public function set text(_arg_1:String):void
        {
            this.textField.text = _arg_1;
            this._html = false;
            invalidate(InvalidationType.DATA);
            invalidate(InvalidationType.STYLES);
        }

        [Inspectable(defaultValue="true", verbose="1")]
        override public function get enabled():Boolean
        {
            return (super.enabled);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            this.updateTextFieldType();
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
        }

        public function get alwaysShowSelection():Boolean
        {
            return (this.textField.alwaysShowSelection);
        }

        public function set alwaysShowSelection(_arg_1:Boolean):void
        {
            this.textField.alwaysShowSelection = _arg_1;
        }

        override public function drawFocus(_arg_1:Boolean):void
        {
            if (focusTarget != null)
            {
                focusTarget.drawFocus(_arg_1);
                return;
            };
            super.drawFocus(_arg_1);
        }

        [Inspectable(defaultValue="true")]
        public function get editable():Boolean
        {
            return (this._editable);
        }

        public function set editable(_arg_1:Boolean):void
        {
            this._editable = _arg_1;
            this.updateTextFieldType();
        }

        public function get horizontalScrollPosition():int
        {
            return (this.textField.scrollH);
        }

        public function set horizontalScrollPosition(_arg_1:int):void
        {
            this.textField.scrollH = _arg_1;
        }

        public function get maxHorizontalScrollPosition():int
        {
            return (this.textField.maxScrollH);
        }

        public function get length():int
        {
            return (this.textField.length);
        }

        [Inspectable(defaultValue="0")]
        public function get maxChars():int
        {
            return (this.textField.maxChars);
        }

        public function set maxChars(_arg_1:int):void
        {
            this.textField.maxChars = _arg_1;
        }

        [Inspectable(defaultValue="false")]
        public function get displayAsPassword():Boolean
        {
            return (this.textField.displayAsPassword);
        }

        public function set displayAsPassword(_arg_1:Boolean):void
        {
            this.textField.displayAsPassword = _arg_1;
        }

        [Inspectable(defaultValue="")]
        public function get restrict():String
        {
            return (this.textField.restrict);
        }

        public function set restrict(_arg_1:String):void
        {
            if (((componentInspectorSetting) && (_arg_1 == "")))
            {
                _arg_1 = null;
            };
            this.textField.restrict = _arg_1;
        }

        public function get selectionBeginIndex():int
        {
            return (this.textField.selectionBeginIndex);
        }

        public function get selectionEndIndex():int
        {
            return (this.textField.selectionEndIndex);
        }

        public function get condenseWhite():Boolean
        {
            return (this.textField.condenseWhite);
        }

        public function set condenseWhite(_arg_1:Boolean):void
        {
            this.textField.condenseWhite = _arg_1;
        }

        public function get htmlText():String
        {
            return (this.textField.htmlText);
        }

        public function set htmlText(_arg_1:String):void
        {
            if (_arg_1 == "")
            {
                this.text = "";
                return;
            };
            this._html = true;
            this._savedHTML = _arg_1;
            this.textField.htmlText = _arg_1;
            invalidate(InvalidationType.DATA);
            invalidate(InvalidationType.STYLES);
        }

        public function get textHeight():Number
        {
            return (this.textField.textHeight);
        }

        public function get textWidth():Number
        {
            return (this.textField.textWidth);
        }

        public function setSelection(_arg_1:int, _arg_2:int):void
        {
            this.textField.setSelection(_arg_1, _arg_2);
        }

        public function getLineMetrics(_arg_1:int):TextLineMetrics
        {
            return (this.textField.getLineMetrics(_arg_1));
        }

        public function appendText(_arg_1:String):void
        {
            this.textField.appendText(_arg_1);
        }

        protected function updateTextFieldType():void
        {
            this.textField.type = (((this.enabled) && (this.editable)) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
            this.textField.selectable = this.enabled;
        }

        protected function handleKeyDown(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ENTER)
            {
                dispatchEvent(new ComponentEvent(ComponentEvent.ENTER, true));
            };
        }

        protected function handleChange(_arg_1:Event):void
        {
            _arg_1.stopPropagation();
            dispatchEvent(new Event(Event.CHANGE, true));
        }

        protected function handleTextInput(_arg_1:TextEvent):void
        {
            _arg_1.stopPropagation();
            dispatchEvent(new TextEvent(TextEvent.TEXT_INPUT, true, false, _arg_1.text));
        }

        protected function setEmbedFont():*
        {
            var _local_1:Object = getStyleValue("embedFonts");
            if (_local_1 != null)
            {
                this.textField.embedFonts = _local_1;
            };
        }

        override protected function draw():void
        {
            var _local_1:Object;
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                this.drawTextFormat();
                this.drawBackground();
                _local_1 = getStyleValue("embedFonts");
                if (_local_1 != null)
                {
                    this.textField.embedFonts = _local_1;
                };
                invalidate(InvalidationType.SIZE, false);
            };
            if (isInvalid(InvalidationType.SIZE))
            {
                this.drawLayout();
            };
            super.draw();
        }

        protected function drawBackground():void
        {
            var _local_1:DisplayObject = this.background;
            var _local_2:String = ((this.enabled) ? "upSkin" : "disabledSkin");
            this.background = getDisplayObjectInstance(getStyleValue(_local_2));
            if (this.background == null)
            {
                return;
            };
            addChildAt(this.background, 0);
            if ((((!(_local_1 == null)) && (!(_local_1 == this.background))) && (contains(_local_1))))
            {
                removeChild(_local_1);
            };
        }

        protected function drawTextFormat():void
        {
            var _local_1:Object = UIComponent.getStyleDefinition();
            var _local_2:TextFormat = ((this.enabled) ? (_local_1.defaultTextFormat as TextFormat) : (_local_1.defaultDisabledTextFormat as TextFormat));
            this.textField.setTextFormat(_local_2);
            var _local_3:TextFormat = (getStyleValue(((this.enabled) ? "textFormat" : "disabledTextFormat")) as TextFormat);
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
            if (this._html)
            {
                this.textField.htmlText = this._savedHTML;
            };
        }

        protected function drawLayout():void
        {
            var _local_1:Number = Number(getStyleValue("textPadding"));
            if (this.background != null)
            {
                this.background.width = width;
                this.background.height = height;
            };
            this.textField.width = (width - (2 * _local_1));
            this.textField.height = (height - (2 * _local_1));
            this.textField.x = (this.textField.y = _local_1);
        }

        override protected function configUI():void
        {
            super.configUI();
            tabChildren = true;
            this.textField = new TextField();
            addChild(this.textField);
            this.updateTextFieldType();
            this.textField.addEventListener(TextEvent.TEXT_INPUT, this.handleTextInput, false, 0, true);
            this.textField.addEventListener(Event.CHANGE, this.handleChange, false, 0, true);
            this.textField.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown, false, 0, true);
        }

        override public function setFocus():void
        {
            stage.focus = this.textField;
        }

        override protected function isOurFocus(_arg_1:DisplayObject):Boolean
        {
            return ((_arg_1 == this.textField) || (super.isOurFocus(_arg_1)));
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            if (_arg_1.target == this)
            {
                stage.focus = this.textField;
            };
            var _local_2:IFocusManager = focusManager;
            if (((this.editable) && (_local_2)))
            {
                _local_2.showFocusIndicator = true;
                if (((this.textField.selectable) && (this.textField.selectionBeginIndex == this.textField.selectionBeginIndex)))
                {
                    this.setSelection(0, this.textField.length);
                };
            };
            super.focusInHandler(_arg_1);
            if (this.editable)
            {
                setIMEMode(true);
            };
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            super.focusOutHandler(_arg_1);
            if (this.editable)
            {
                setIMEMode(false);
            };
        }


    }
}//package fl.controls
