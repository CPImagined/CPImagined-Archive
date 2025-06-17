package fl.controls
{
    import fl.core.*;
    import fl.events.*;
    import flash.display.*;
    import flash.events.*;

    public class ScrollBar extends UIComponent
    {
        private var _pageSize:Number = 10;
        private var _pageScrollSize:Number = 0;
        private var _lineScrollSize:Number = 1;
        private var _minScrollPosition:Number = 0;
        private var _maxScrollPosition:Number = 0;
        private var _scrollPosition:Number = 0;
        private var _direction:String = "vertical";
        private var thumbScrollOffset:Number;
        protected var inDrag:Boolean = false;
        protected var upArrow:BaseButton;
        protected var downArrow:BaseButton;
        protected var thumb:LabelButton;
        protected var track:BaseButton;
        public static const WIDTH:Number = 15;
        private static var defaultStyles:Object = {downArrowDisabledSkin:"ScrollArrowDown_disabledSkin", downArrowDownSkin:"ScrollArrowDown_downSkin", downArrowOverSkin:"ScrollArrowDown_overSkin", downArrowUpSkin:"ScrollArrowDown_upSkin", thumbDisabledSkin:"ScrollThumb_upSkin", thumbDownSkin:"ScrollThumb_downSkin", thumbOverSkin:"ScrollThumb_overSkin", thumbUpSkin:"ScrollThumb_upSkin", trackDisabledSkin:"ScrollTrack_skin", trackDownSkin:"ScrollTrack_skin", trackOverSkin:"ScrollTrack_skin", trackUpSkin:"ScrollTrack_skin", upArrowDisabledSkin:"ScrollArrowUp_disabledSkin", upArrowDownSkin:"ScrollArrowUp_downSkin", upArrowOverSkin:"ScrollArrowUp_overSkin", upArrowUpSkin:"ScrollArrowUp_upSkin", thumbIcon:"ScrollBar_thumbIcon", repeatDelay:500, repeatInterval:35};
        static const DOWN_ARROW_STYLES:Object = {disabledSkin:"downArrowDisabledSkin", downSkin:"downArrowDownSkin", overSkin:"downArrowOverSkin", upSkin:"downArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
        static const THUMB_STYLES:Object = {disabledSkin:"thumbDisabledSkin", downSkin:"thumbDownSkin", overSkin:"thumbOverSkin", upSkin:"thumbUpSkin", icon:"thumbIcon", textPadding:0};
        static const TRACK_STYLES:Object = {disabledSkin:"trackDisabledSkin", downSkin:"trackDownSkin", overSkin:"trackOverSkin", upSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
        static const UP_ARROW_STYLES:Object = {disabledSkin:"upArrowDisabledSkin", downSkin:"upArrowDownSkin", overSkin:"upArrowOverSkin", upSkin:"upArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};

        public function ScrollBar()
        {
            this.setStyles();
            focusEnabled = false;
            return;
        }// end function

        override public function setSize(param1:Number, param2:Number) : void
        {
            if (this._direction == ScrollBarDirection.HORIZONTAL)
            {
                super.setSize(param2, param1);
            }
            else
            {
                super.setSize(param1, param2);
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return this._direction == ScrollBarDirection.HORIZONTAL ? (super.height) : (super.width);
        }// end function

        override public function get height() : Number
        {
            return this._direction == ScrollBarDirection.HORIZONTAL ? (super.width) : (super.height);
        }// end function

        override public function get enabled() : Boolean
        {
            return super.enabled;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            var _loc_2:* = this.enabled && this._maxScrollPosition > this._minScrollPosition;
            this.upArrow.enabled = this.enabled && this._maxScrollPosition > this._minScrollPosition;
            this.thumb.enabled = _loc_2;
            this.track.enabled = _loc_2;
            this.downArrow.enabled = _loc_2;
            this.updateThumb();
            return;
        }// end function

        public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
        {
            this.pageSize = param1;
            this._minScrollPosition = param2;
            this._maxScrollPosition = param3;
            if (param4 >= 0)
            {
                this._pageScrollSize = param4;
            }
            this.enabled = this._maxScrollPosition > this._minScrollPosition;
            this.setScrollPosition(this._scrollPosition, false);
            this.updateThumb();
            return;
        }// end function

        public function get scrollPosition() : Number
        {
            return this._scrollPosition;
        }// end function

        public function set scrollPosition(param1:Number) : void
        {
            this.setScrollPosition(param1, true);
            return;
        }// end function

        public function get minScrollPosition() : Number
        {
            return this._minScrollPosition;
        }// end function

        public function set minScrollPosition(param1:Number) : void
        {
            this.setScrollProperties(this._pageSize, param1, this._maxScrollPosition);
            return;
        }// end function

        public function get maxScrollPosition() : Number
        {
            return this._maxScrollPosition;
        }// end function

        public function set maxScrollPosition(param1:Number) : void
        {
            this.setScrollProperties(this._pageSize, this._minScrollPosition, param1);
            return;
        }// end function

        public function get pageSize() : Number
        {
            return this._pageSize;
        }// end function

        public function set pageSize(param1:Number) : void
        {
            if (param1 > 0)
            {
                this._pageSize = param1;
            }
            return;
        }// end function

        public function get pageScrollSize() : Number
        {
            return this._pageScrollSize == 0 ? (this._pageSize) : (this._pageScrollSize);
        }// end function

        public function set pageScrollSize(param1:Number) : void
        {
            if (param1 >= 0)
            {
                this._pageScrollSize = param1;
            }
            return;
        }// end function

        public function get lineScrollSize() : Number
        {
            return this._lineScrollSize;
        }// end function

        public function set lineScrollSize(param1:Number) : void
        {
            if (param1 > 0)
            {
                this._lineScrollSize = param1;
            }
            return;
        }// end function

        public function get direction() : String
        {
            return this._direction;
        }// end function

        public function set direction(param1:String) : void
        {
            if (this._direction == param1)
            {
                return;
            }
            this._direction = param1;
            if (isLivePreview)
            {
                return;
            }
            setScaleY(1);
            var _loc_2:* = this._direction == ScrollBarDirection.HORIZONTAL;
            if (_loc_2 && componentInspectorSetting)
            {
                if (rotation == 90)
                {
                    return;
                }
                setScaleX(-1);
                rotation = -90;
            }
            if (!componentInspectorSetting)
            {
                if (_loc_2 && rotation == 0)
                {
                    rotation = -90;
                    setScaleX(-1);
                }
                else if (!_loc_2 && rotation == -90)
                {
                    rotation = 0;
                    setScaleX(1);
                }
            }
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        override protected function configUI() : void
        {
            super.configUI();
            this.track = new BaseButton();
            this.track.move(0, 14);
            this.track.useHandCursor = false;
            this.track.autoRepeat = true;
            this.track.focusEnabled = false;
            addChild(this.track);
            this.thumb = new LabelButton();
            this.thumb.label = "";
            this.thumb.setSize(WIDTH, 15);
            this.thumb.move(0, 15);
            this.thumb.focusEnabled = false;
            addChild(this.thumb);
            this.downArrow = new BaseButton();
            this.downArrow.setSize(WIDTH, 14);
            this.downArrow.autoRepeat = true;
            this.downArrow.focusEnabled = false;
            addChild(this.downArrow);
            this.upArrow = new BaseButton();
            this.upArrow.setSize(WIDTH, 14);
            this.upArrow.move(0, 0);
            this.upArrow.autoRepeat = true;
            this.upArrow.focusEnabled = false;
            addChild(this.upArrow);
            this.upArrow.addEventListener(ComponentEvent.BUTTON_DOWN, this.scrollPressHandler, false, 0, true);
            this.downArrow.addEventListener(ComponentEvent.BUTTON_DOWN, this.scrollPressHandler, false, 0, true);
            this.track.addEventListener(ComponentEvent.BUTTON_DOWN, this.scrollPressHandler, false, 0, true);
            this.thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.thumbPressHandler, false, 0, true);
            this.enabled = false;
            return;
        }// end function

        override protected function draw() : void
        {
            var _loc_1:* = NaN;
            if (isInvalid(InvalidationType.SIZE))
            {
                _loc_1 = super.height;
                this.downArrow.move(0, Math.max(this.upArrow.height, _loc_1 - this.downArrow.height));
                this.track.setSize(WIDTH, Math.max(0, _loc_1 - (this.downArrow.height + this.upArrow.height)));
                this.updateThumb();
            }
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                this.setStyles();
            }
            this.downArrow.drawNow();
            this.upArrow.drawNow();
            this.track.drawNow();
            this.thumb.drawNow();
            validate();
            return;
        }// end function

        protected function scrollPressHandler(event:ComponentEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            event.stopImmediatePropagation();
            if (event.currentTarget == this.upArrow)
            {
                this.setScrollPosition(this._scrollPosition - this._lineScrollSize);
            }
            else if (event.currentTarget == this.downArrow)
            {
                this.setScrollPosition(this._scrollPosition + this._lineScrollSize);
            }
            else
            {
                _loc_2 = this.track.mouseY / this.track.height * (this._maxScrollPosition - this._minScrollPosition) + this._minScrollPosition;
                _loc_3 = this.pageScrollSize == 0 ? (this.pageSize) : (this.pageScrollSize);
                if (this._scrollPosition < _loc_2)
                {
                    this.setScrollPosition(Math.min(_loc_2, this._scrollPosition + _loc_3));
                }
                else if (this._scrollPosition > _loc_2)
                {
                    this.setScrollPosition(Math.max(_loc_2, this._scrollPosition - _loc_3));
                }
            }
            return;
        }// end function

        protected function thumbPressHandler(event:MouseEvent) : void
        {
            this.inDrag = true;
            this.thumbScrollOffset = mouseY - this.thumb.y;
            this.thumb.mouseStateLocked = true;
            mouseChildren = false;
            var _loc_2:* = focusManager.form;
            _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, this.handleThumbDrag, false, 0, true);
            _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.thumbReleaseHandler, false, 0, true);
            return;
        }// end function

        protected function handleThumbDrag(event:MouseEvent) : void
        {
            var _loc_2:* = Math.max(0, Math.min(this.track.height - this.thumb.height, mouseY - this.track.y - this.thumbScrollOffset));
            this.setScrollPosition(_loc_2 / (this.track.height - this.thumb.height) * (this._maxScrollPosition - this._minScrollPosition) + this._minScrollPosition);
            return;
        }// end function

        protected function thumbReleaseHandler(event:MouseEvent) : void
        {
            this.inDrag = false;
            mouseChildren = true;
            this.thumb.mouseStateLocked = false;
            var _loc_2:* = focusManager.form;
            _loc_2.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleThumbDrag);
            _loc_2.removeEventListener(MouseEvent.MOUSE_UP, this.thumbReleaseHandler);
            return;
        }// end function

        public function setScrollPosition(param1:Number, param2:Boolean = true) : void
        {
            var _loc_3:* = this.scrollPosition;
            this._scrollPosition = Math.max(this._minScrollPosition, Math.min(this._maxScrollPosition, param1));
            if (_loc_3 == this._scrollPosition)
            {
                return;
            }
            if (param2)
            {
                dispatchEvent(new ScrollEvent(this._direction, this.scrollPosition - _loc_3, this.scrollPosition));
            }
            this.updateThumb();
            return;
        }// end function

        protected function setStyles() : void
        {
            copyStylesToChild(this.downArrow, DOWN_ARROW_STYLES);
            copyStylesToChild(this.thumb, THUMB_STYLES);
            copyStylesToChild(this.track, TRACK_STYLES);
            copyStylesToChild(this.upArrow, UP_ARROW_STYLES);
            return;
        }// end function

        protected function updateThumb() : void
        {
            var _loc_1:* = this._maxScrollPosition - this._minScrollPosition + this._pageSize;
            if (this.track.height <= 12 || this._maxScrollPosition <= this._minScrollPosition || (_loc_1 == 0 || isNaN(_loc_1)))
            {
                this.thumb.height = 12;
                this.thumb.visible = false;
            }
            else
            {
                this.thumb.height = Math.max(13, this._pageSize / _loc_1 * this.track.height);
                this.thumb.y = this.track.y + (this.track.height - this.thumb.height) * ((this._scrollPosition - this._minScrollPosition) / (this._maxScrollPosition - this._minScrollPosition));
                this.thumb.visible = this.enabled;
            }
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return defaultStyles;
        }// end function

    }
}
