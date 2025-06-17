//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.core.UIComponent;
    import fl.core.InvalidationType;
    import fl.events.ComponentEvent;
    import flash.events.MouseEvent;
    import flash.display.DisplayObjectContainer;
    import fl.events.ScrollEvent;

    [Event(name="scroll", type="fl.events.ScrollEvent")]
    [Style(name="downArrowDisabledSkin", type="Class")]
    [Style(name="downArrowDownSkin", type="Class")]
    [Style(name="downArrowOverSkin", type="Class")]
    [Style(name="downArrowUpSkin", type="Class")]
    [Style(name="thumbDisabledSkin", type="Class")]
    [Style(name="thumbDownSkin", type="Class")]
    [Style(name="thumbOverSkin", type="Class")]
    [Style(name="thumbUpSkin", type="Class")]
    [Style(name="trackDisabledSkin", type="Class")]
    [Style(name="trackDownSkin", type="Class")]
    [Style(name="trackOverSkin", type="Class")]
    [Style(name="trackUpSkin", type="Class")]
    [Style(name="upArrowDisabledSkin", type="Class")]
    [Style(name="upArrowDownSkin", type="Class")]
    [Style(name="upArrowOverSkin", type="Class")]
    [Style(name="upArrowUpSkin", type="Class")]
    [Style(name="thumbIcon", type="Class")]
    [Style(name="repeatDelay", type="Number", format="Time")]
    [Style(name="repeatInterval", type="Number", format="Time")]
    public class ScrollBar extends UIComponent 
    {

        public static const WIDTH:Number = 15;
        private static var defaultStyles:Object = {
            "downArrowDisabledSkin":"ScrollArrowDown_disabledSkin",
            "downArrowDownSkin":"ScrollArrowDown_downSkin",
            "downArrowOverSkin":"ScrollArrowDown_overSkin",
            "downArrowUpSkin":"ScrollArrowDown_upSkin",
            "thumbDisabledSkin":"ScrollThumb_upSkin",
            "thumbDownSkin":"ScrollThumb_downSkin",
            "thumbOverSkin":"ScrollThumb_overSkin",
            "thumbUpSkin":"ScrollThumb_upSkin",
            "trackDisabledSkin":"ScrollTrack_skin",
            "trackDownSkin":"ScrollTrack_skin",
            "trackOverSkin":"ScrollTrack_skin",
            "trackUpSkin":"ScrollTrack_skin",
            "upArrowDisabledSkin":"ScrollArrowUp_disabledSkin",
            "upArrowDownSkin":"ScrollArrowUp_downSkin",
            "upArrowOverSkin":"ScrollArrowUp_overSkin",
            "upArrowUpSkin":"ScrollArrowUp_upSkin",
            "thumbIcon":"ScrollBar_thumbIcon",
            "repeatDelay":500,
            "repeatInterval":35
        };
        protected static const DOWN_ARROW_STYLES:Object = {
            "disabledSkin":"downArrowDisabledSkin",
            "downSkin":"downArrowDownSkin",
            "overSkin":"downArrowOverSkin",
            "upSkin":"downArrowUpSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval"
        };
        protected static const THUMB_STYLES:Object = {
            "disabledSkin":"thumbDisabledSkin",
            "downSkin":"thumbDownSkin",
            "overSkin":"thumbOverSkin",
            "upSkin":"thumbUpSkin",
            "icon":"thumbIcon",
            "textPadding":0
        };
        protected static const TRACK_STYLES:Object = {
            "disabledSkin":"trackDisabledSkin",
            "downSkin":"trackDownSkin",
            "overSkin":"trackOverSkin",
            "upSkin":"trackUpSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval"
        };
        protected static const UP_ARROW_STYLES:Object = {
            "disabledSkin":"upArrowDisabledSkin",
            "downSkin":"upArrowDownSkin",
            "overSkin":"upArrowOverSkin",
            "upSkin":"upArrowUpSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval"
        };

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

        public function ScrollBar()
        {
            this.setStyles();
            focusEnabled = false;
        }

        public static function getStyleDefinition():Object
        {
            return (defaultStyles);
        }


        override public function setSize(_arg_1:Number, _arg_2:Number):void
        {
            if (this._direction == ScrollBarDirection.HORIZONTAL)
            {
                super.setSize(_arg_2, _arg_1);
            }
            else
            {
                super.setSize(_arg_1, _arg_2);
            };
        }

        override public function get width():Number
        {
            return ((this._direction == ScrollBarDirection.HORIZONTAL) ? super.height : super.width);
        }

        override public function get height():Number
        {
            return ((this._direction == ScrollBarDirection.HORIZONTAL) ? super.width : super.height);
        }

        override public function get enabled():Boolean
        {
            return (super.enabled);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            this.downArrow.enabled = (this.track.enabled = (this.thumb.enabled = (this.upArrow.enabled = ((this.enabled) && (this._maxScrollPosition > this._minScrollPosition)))));
            this.updateThumb();
        }

        public function setScrollProperties(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number=0):void
        {
            this.pageSize = _arg_1;
            this._minScrollPosition = _arg_2;
            this._maxScrollPosition = _arg_3;
            if (_arg_4 >= 0)
            {
                this._pageScrollSize = _arg_4;
            };
            this.enabled = (this._maxScrollPosition > this._minScrollPosition);
            this.setScrollPosition(this._scrollPosition, false);
            this.updateThumb();
        }

        public function get scrollPosition():Number
        {
            return (this._scrollPosition);
        }

        public function set scrollPosition(_arg_1:Number):void
        {
            this.setScrollPosition(_arg_1, true);
        }

        public function get minScrollPosition():Number
        {
            return (this._minScrollPosition);
        }

        public function set minScrollPosition(_arg_1:Number):void
        {
            this.setScrollProperties(this._pageSize, _arg_1, this._maxScrollPosition);
        }

        public function get maxScrollPosition():Number
        {
            return (this._maxScrollPosition);
        }

        public function set maxScrollPosition(_arg_1:Number):void
        {
            this.setScrollProperties(this._pageSize, this._minScrollPosition, _arg_1);
        }

        public function get pageSize():Number
        {
            return (this._pageSize);
        }

        public function set pageSize(_arg_1:Number):void
        {
            if (_arg_1 > 0)
            {
                this._pageSize = _arg_1;
            };
        }

        public function get pageScrollSize():Number
        {
            return ((this._pageScrollSize == 0) ? this._pageSize : this._pageScrollSize);
        }

        public function set pageScrollSize(_arg_1:Number):void
        {
            if (_arg_1 >= 0)
            {
                this._pageScrollSize = _arg_1;
            };
        }

        public function get lineScrollSize():Number
        {
            return (this._lineScrollSize);
        }

        public function set lineScrollSize(_arg_1:Number):void
        {
            if (_arg_1 > 0)
            {
                this._lineScrollSize = _arg_1;
            };
        }

        public function get direction():String
        {
            return (this._direction);
        }

        public function set direction(_arg_1:String):void
        {
            if (this._direction == _arg_1)
            {
                return;
            };
            this._direction = _arg_1;
            if (isLivePreview)
            {
                return;
            };
            setScaleY(1);
            var _local_2:Boolean = (this._direction == ScrollBarDirection.HORIZONTAL);
            if (((_local_2) && (componentInspectorSetting)))
            {
                if (rotation == 90)
                {
                    return;
                };
                setScaleX(-1);
                rotation = -90;
            };
            if ((!(componentInspectorSetting)))
            {
                if (((_local_2) && (rotation == 0)))
                {
                    rotation = -90;
                    setScaleX(-1);
                }
                else
                {
                    if (((!(_local_2)) && (rotation == -90)))
                    {
                        rotation = 0;
                        setScaleX(1);
                    };
                };
            };
            invalidate(InvalidationType.SIZE);
        }

        override protected function configUI():void
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
        }

        override protected function draw():void
        {
            var _local_1:Number;
            if (isInvalid(InvalidationType.SIZE))
            {
                _local_1 = super.height;
                this.downArrow.move(0, Math.max(this.upArrow.height, (_local_1 - this.downArrow.height)));
                this.track.setSize(WIDTH, Math.max(0, (_local_1 - (this.downArrow.height + this.upArrow.height))));
                this.updateThumb();
            };
            if (isInvalid(InvalidationType.STYLES, InvalidationType.STATE))
            {
                this.setStyles();
            };
            this.downArrow.drawNow();
            this.upArrow.drawNow();
            this.track.drawNow();
            this.thumb.drawNow();
            validate();
        }

        protected function scrollPressHandler(_arg_1:ComponentEvent):void
        {
            var _local_2:Number;
            var _local_3:Number;
            _arg_1.stopImmediatePropagation();
            if (_arg_1.currentTarget == this.upArrow)
            {
                this.setScrollPosition((this._scrollPosition - this._lineScrollSize));
            }
            else
            {
                if (_arg_1.currentTarget == this.downArrow)
                {
                    this.setScrollPosition((this._scrollPosition + this._lineScrollSize));
                }
                else
                {
                    _local_2 = (((this.track.mouseY / this.track.height) * (this._maxScrollPosition - this._minScrollPosition)) + this._minScrollPosition);
                    _local_3 = ((this.pageScrollSize == 0) ? this.pageSize : this.pageScrollSize);
                    if (this._scrollPosition < _local_2)
                    {
                        this.setScrollPosition(Math.min(_local_2, (this._scrollPosition + _local_3)));
                    }
                    else
                    {
                        if (this._scrollPosition > _local_2)
                        {
                            this.setScrollPosition(Math.max(_local_2, (this._scrollPosition - _local_3)));
                        };
                    };
                };
            };
        }

        protected function thumbPressHandler(_arg_1:MouseEvent):void
        {
            this.inDrag = true;
            this.thumbScrollOffset = (mouseY - this.thumb.y);
            this.thumb.mouseStateLocked = true;
            mouseChildren = false;
            var _local_2:DisplayObjectContainer = focusManager.form;
            _local_2.addEventListener(MouseEvent.MOUSE_MOVE, this.handleThumbDrag, false, 0, true);
            _local_2.addEventListener(MouseEvent.MOUSE_UP, this.thumbReleaseHandler, false, 0, true);
        }

        protected function handleThumbDrag(_arg_1:MouseEvent):void
        {
            var _local_2:Number = Math.max(0, Math.min((this.track.height - this.thumb.height), ((mouseY - this.track.y) - this.thumbScrollOffset)));
            this.setScrollPosition((((_local_2 / (this.track.height - this.thumb.height)) * (this._maxScrollPosition - this._minScrollPosition)) + this._minScrollPosition));
        }

        protected function thumbReleaseHandler(_arg_1:MouseEvent):void
        {
            this.inDrag = false;
            mouseChildren = true;
            this.thumb.mouseStateLocked = false;
            var _local_2:DisplayObjectContainer = focusManager.form;
            _local_2.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleThumbDrag);
            _local_2.removeEventListener(MouseEvent.MOUSE_UP, this.thumbReleaseHandler);
        }

        public function setScrollPosition(_arg_1:Number, _arg_2:Boolean=true):void
        {
            var _local_3:Number = this.scrollPosition;
            this._scrollPosition = Math.max(this._minScrollPosition, Math.min(this._maxScrollPosition, _arg_1));
            if (_local_3 == this._scrollPosition)
            {
                return;
            };
            if (_arg_2)
            {
                dispatchEvent(new ScrollEvent(this._direction, (this.scrollPosition - _local_3), this.scrollPosition));
            };
            this.updateThumb();
        }

        protected function setStyles():void
        {
            copyStylesToChild(this.downArrow, DOWN_ARROW_STYLES);
            copyStylesToChild(this.thumb, THUMB_STYLES);
            copyStylesToChild(this.track, TRACK_STYLES);
            copyStylesToChild(this.upArrow, UP_ARROW_STYLES);
        }

        protected function updateThumb():void
        {
            var _local_1:Number = ((this._maxScrollPosition - this._minScrollPosition) + this._pageSize);
            if ((((this.track.height <= 12) || (this._maxScrollPosition <= this._minScrollPosition)) || ((_local_1 == 0) || (isNaN(_local_1)))))
            {
                this.thumb.height = 12;
                this.thumb.visible = false;
            }
            else
            {
                this.thumb.height = Math.max(13, ((this._pageSize / _local_1) * this.track.height));
                this.thumb.y = (this.track.y + ((this.track.height - this.thumb.height) * ((this._scrollPosition - this._minScrollPosition) / (this._maxScrollPosition - this._minScrollPosition))));
                this.thumb.visible = this.enabled;
            };
        }


    }
}//package fl.controls
