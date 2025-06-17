//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.core.UIComponent;
    import flash.display.DisplayObject;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import fl.core.InvalidationType;
    import flash.events.MouseEvent;
    import fl.events.ComponentEvent;

    [Event(name="buttonDown", type="fl.events.ComponentEvent")]
    [Event(name="change", type="flash.events.Event")]
    [Style(name="upSkin", type="Class")]
    [Style(name="downSkin", type="Class")]
    [Style(name="overSkin", type="Class")]
    [Style(name="disabledSkin", type="Class")]
    [Style(name="selectedDisabledSkin", type="Class")]
    [Style(name="selectedUpSkin", type="Class")]
    [Style(name="selectedDownSkin", type="Class")]
    [Style(name="selectedOverSkin", type="Class")]
    [Style(name="repeatDelay", type="Number", format="Time")]
    [Style(name="repeatInterval", type="Number", format="Time")]
    public class BaseButton extends UIComponent 
    {

        private static var defaultStyles:Object = {
            "upSkin":"Button_upSkin",
            "downSkin":"Button_downSkin",
            "overSkin":"Button_overSkin",
            "disabledSkin":"Button_disabledSkin",
            "selectedDisabledSkin":"Button_selectedDisabledSkin",
            "selectedUpSkin":"Button_selectedUpSkin",
            "selectedDownSkin":"Button_selectedDownSkin",
            "selectedOverSkin":"Button_selectedOverSkin",
            "focusRectSkin":null,
            "focusRectPadding":null,
            "repeatDelay":500,
            "repeatInterval":35
        };

        protected var background:DisplayObject;
        protected var mouseState:String;
        protected var _selected:Boolean = false;
        protected var _autoRepeat:Boolean = false;
        protected var pressTimer:Timer;
        private var _mouseStateLocked:Boolean = false;
        private var unlockedMouseState:String;

        public function BaseButton()
        {
            buttonMode = true;
            mouseChildren = false;
            useHandCursor = false;
            this.setupMouseEvents();
            this.setMouseState("up");
            this.pressTimer = new Timer(1, 0);
            this.pressTimer.addEventListener(TimerEvent.TIMER, this.buttonDown, false, 0, true);
        }

        public static function getStyleDefinition():Object
        {
            return (defaultStyles);
        }


        [Inspectable(defaultValue="true", verbose="1")]
        override public function get enabled():Boolean
        {
            return (super.enabled);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            mouseEnabled = _arg_1;
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function set selected(_arg_1:Boolean):void
        {
            if (this._selected == _arg_1)
            {
                return;
            };
            this._selected = _arg_1;
            invalidate(InvalidationType.STATE);
        }

        public function get autoRepeat():Boolean
        {
            return (this._autoRepeat);
        }

        public function set autoRepeat(_arg_1:Boolean):void
        {
            this._autoRepeat = _arg_1;
        }

        public function set mouseStateLocked(_arg_1:Boolean):void
        {
            this._mouseStateLocked = _arg_1;
            if (_arg_1 == false)
            {
                this.setMouseState(this.unlockedMouseState);
            }
            else
            {
                this.unlockedMouseState = this.mouseState;
            };
        }

        public function setMouseState(_arg_1:String):void
        {
            if (this._mouseStateLocked)
            {
                this.unlockedMouseState = _arg_1;
                return;
            };
            if (this.mouseState == _arg_1)
            {
                return;
            };
            this.mouseState = _arg_1;
            invalidate(InvalidationType.STATE);
        }

        protected function setupMouseEvents():void
        {
            addEventListener(MouseEvent.ROLL_OVER, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_UP, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, this.mouseEventHandler, false, 0, true);
        }

        protected function mouseEventHandler(_arg_1:MouseEvent):void
        {
            if (_arg_1.type == MouseEvent.MOUSE_DOWN)
            {
                this.setMouseState("down");
                this.startPress();
            }
            else
            {
                if (((_arg_1.type == MouseEvent.ROLL_OVER) || (_arg_1.type == MouseEvent.MOUSE_UP)))
                {
                    this.setMouseState("over");
                    this.endPress();
                }
                else
                {
                    if (_arg_1.type == MouseEvent.ROLL_OUT)
                    {
                        this.setMouseState("up");
                        this.endPress();
                    };
                };
            };
        }

        protected function startPress():void
        {
            if (this._autoRepeat)
            {
                this.pressTimer.delay = Number(getStyleValue("repeatDelay"));
                this.pressTimer.start();
            };
            dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
        }

        protected function buttonDown(_arg_1:TimerEvent):void
        {
            if ((!(this._autoRepeat)))
            {
                this.endPress();
                return;
            };
            if (this.pressTimer.currentCount == 1)
            {
                this.pressTimer.delay = Number(getStyleValue("repeatInterval"));
            };
            dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
        }

        protected function endPress():void
        {
            this.pressTimer.reset();
        }

        override protected function draw():void
        {
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                this.drawBackground();
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
            var _local_1:String = ((this.enabled) ? this.mouseState : "disabled");
            if (this.selected)
            {
                _local_1 = (("selected" + _local_1.substr(0, 1).toUpperCase()) + _local_1.substr(1));
            };
            _local_1 = (_local_1 + "Skin");
            var _local_2:DisplayObject = this.background;
            this.background = getDisplayObjectInstance(getStyleValue(_local_1));
            addChildAt(this.background, 0);
            if (((!(_local_2 == null)) && (!(_local_2 == this.background))))
            {
                removeChild(_local_2);
            };
        }

        protected function drawLayout():void
        {
            this.background.width = width;
            this.background.height = height;
        }


    }
}//package fl.controls
