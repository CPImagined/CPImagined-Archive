package fl.controls
{
    import fl.core.*;
    import fl.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class BaseButton extends UIComponent
    {
        protected var background:DisplayObject;
        protected var mouseState:String;
        protected var _selected:Boolean = false;
        protected var _autoRepeat:Boolean = false;
        protected var pressTimer:Timer;
        private var _mouseStateLocked:Boolean = false;
        private var unlockedMouseState:String;
        private static var defaultStyles:Object = {upSkin:"Button_upSkin", downSkin:"Button_downSkin", overSkin:"Button_overSkin", disabledSkin:"Button_disabledSkin", selectedDisabledSkin:"Button_selectedDisabledSkin", selectedUpSkin:"Button_selectedUpSkin", selectedDownSkin:"Button_selectedDownSkin", selectedOverSkin:"Button_selectedOverSkin", focusRectSkin:null, focusRectPadding:null, repeatDelay:500, repeatInterval:35};

        public function BaseButton()
        {
            buttonMode = true;
            mouseChildren = false;
            useHandCursor = false;
            this.setupMouseEvents();
            this.setMouseState("up");
            this.pressTimer = new Timer(1, 0);
            this.pressTimer.addEventListener(TimerEvent.TIMER, this.buttonDown, false, 0, true);
            return;
        }// end function

        override public function get enabled() : Boolean
        {
            return super.enabled;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseEnabled = param1;
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            if (this._selected == param1)
            {
                return;
            }
            this._selected = param1;
            invalidate(InvalidationType.STATE);
            return;
        }// end function

        public function get autoRepeat() : Boolean
        {
            return this._autoRepeat;
        }// end function

        public function set autoRepeat(param1:Boolean) : void
        {
            this._autoRepeat = param1;
            return;
        }// end function

        public function set mouseStateLocked(param1:Boolean) : void
        {
            this._mouseStateLocked = param1;
            if (param1 == false)
            {
                this.setMouseState(this.unlockedMouseState);
            }
            else
            {
                this.unlockedMouseState = this.mouseState;
            }
            return;
        }// end function

        public function setMouseState(param1:String) : void
        {
            if (this._mouseStateLocked)
            {
                this.unlockedMouseState = param1;
                return;
            }
            if (this.mouseState == param1)
            {
                return;
            }
            this.mouseState = param1;
            invalidate(InvalidationType.STATE);
            return;
        }// end function

        protected function setupMouseEvents() : void
        {
            addEventListener(MouseEvent.ROLL_OVER, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_UP, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, this.mouseEventHandler, false, 0, true);
            return;
        }// end function

        protected function mouseEventHandler(event:MouseEvent) : void
        {
            if (event.type == MouseEvent.MOUSE_DOWN)
            {
                this.setMouseState("down");
                this.startPress();
            }
            else if (event.type == MouseEvent.ROLL_OVER || event.type == MouseEvent.MOUSE_UP)
            {
                this.setMouseState("over");
                this.endPress();
            }
            else if (event.type == MouseEvent.ROLL_OUT)
            {
                this.setMouseState("up");
                this.endPress();
            }
            return;
        }// end function

        protected function startPress() : void
        {
            if (this._autoRepeat)
            {
                this.pressTimer.delay = Number(getStyleValue("repeatDelay"));
                this.pressTimer.start();
            }
            dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
            return;
        }// end function

        protected function buttonDown(event:TimerEvent) : void
        {
            if (!this._autoRepeat)
            {
                this.endPress();
                return;
            }
            if (this.pressTimer.currentCount == 1)
            {
                this.pressTimer.delay = Number(getStyleValue("repeatInterval"));
            }
            dispatchEvent(new ComponentEvent(ComponentEvent.BUTTON_DOWN, true));
            return;
        }// end function

        protected function endPress() : void
        {
            this.pressTimer.reset();
            return;
        }// end function

        override protected function draw() : void
        {
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                this.drawBackground();
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
            var _loc_1:* = this.enabled ? (this.mouseState) : ("disabled");
            if (this.selected)
            {
                _loc_1 = "selected" + _loc_1.substr(0, 1).toUpperCase() + _loc_1.substr(1);
            }
            _loc_1 = _loc_1 + "Skin";
            var _loc_2:* = this.background;
            this.background = getDisplayObjectInstance(getStyleValue(_loc_1));
            addChildAt(this.background, 0);
            if (_loc_2 != null && _loc_2 != this.background)
            {
                removeChild(_loc_2);
            }
            return;
        }// end function

        protected function drawLayout() : void
        {
            this.background.width = width;
            this.background.height = height;
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return defaultStyles;
        }// end function

    }
}
