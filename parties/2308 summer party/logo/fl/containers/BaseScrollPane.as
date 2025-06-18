package fl.containers
{
    import fl.controls.*;
    import fl.core.*;
    import fl.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class BaseScrollPane extends UIComponent
    {
        protected var _verticalScrollBar:ScrollBar;
        protected var _horizontalScrollBar:ScrollBar;
        protected var contentScrollRect:Rectangle;
        protected var disabledOverlay:Shape;
        protected var background:DisplayObject;
        protected var contentWidth:Number = 0;
        protected var contentHeight:Number = 0;
        protected var _horizontalScrollPolicy:String;
        protected var _verticalScrollPolicy:String;
        protected var contentPadding:Number = 0;
        protected var availableWidth:Number;
        protected var availableHeight:Number;
        protected var vOffset:Number = 0;
        protected var vScrollBar:Boolean;
        protected var hScrollBar:Boolean;
        protected var _maxHorizontalScrollPosition:Number = 0;
        protected var _horizontalPageScrollSize:Number = 0;
        protected var _verticalPageScrollSize:Number = 0;
        protected var defaultLineScrollSize:Number = 4;
        protected var useFixedHorizontalScrolling:Boolean = false;
        protected var _useBitmpScrolling:Boolean = false;
        private static var defaultStyles:Object = {repeatDelay:500, repeatInterval:35, skin:"ScrollPane_upSkin", contentPadding:0, disabledAlpha:0.5};
        static const SCROLL_BAR_STYLES:Object = {upArrowDisabledSkin:"upArrowDisabledSkin", upArrowDownSkin:"upArrowDownSkin", upArrowOverSkin:"upArrowOverSkin", upArrowUpSkin:"upArrowUpSkin", downArrowDisabledSkin:"downArrowDisabledSkin", downArrowDownSkin:"downArrowDownSkin", downArrowOverSkin:"downArrowOverSkin", downArrowUpSkin:"downArrowUpSkin", thumbDisabledSkin:"thumbDisabledSkin", thumbDownSkin:"thumbDownSkin", thumbOverSkin:"thumbOverSkin", thumbUpSkin:"thumbUpSkin", thumbIcon:"thumbIcon", trackDisabledSkin:"trackDisabledSkin", trackDownSkin:"trackDownSkin", trackOverSkin:"trackOverSkin", trackUpSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};

        public function BaseScrollPane()
        {
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (enabled == param1)
            {
                return;
            }
            this._verticalScrollBar.enabled = param1;
            this._horizontalScrollBar.enabled = param1;
            super.enabled = param1;
            return;
        }// end function

        public function get horizontalScrollPolicy() : String
        {
            return this._horizontalScrollPolicy;
        }// end function

        public function set horizontalScrollPolicy(param1:String) : void
        {
            this._horizontalScrollPolicy = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function get verticalScrollPolicy() : String
        {
            return this._verticalScrollPolicy;
        }// end function

        public function set verticalScrollPolicy(param1:String) : void
        {
            this._verticalScrollPolicy = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function get horizontalLineScrollSize() : Number
        {
            return this._horizontalScrollBar.lineScrollSize;
        }// end function

        public function set horizontalLineScrollSize(param1:Number) : void
        {
            this._horizontalScrollBar.lineScrollSize = param1;
            return;
        }// end function

        public function get verticalLineScrollSize() : Number
        {
            return this._verticalScrollBar.lineScrollSize;
        }// end function

        public function set verticalLineScrollSize(param1:Number) : void
        {
            this._verticalScrollBar.lineScrollSize = param1;
            return;
        }// end function

        public function get horizontalScrollPosition() : Number
        {
            return this._horizontalScrollBar.scrollPosition;
        }// end function

        public function set horizontalScrollPosition(param1:Number) : void
        {
            drawNow();
            this._horizontalScrollBar.scrollPosition = param1;
            this.setHorizontalScrollPosition(this._horizontalScrollBar.scrollPosition, false);
            return;
        }// end function

        public function get verticalScrollPosition() : Number
        {
            return this._verticalScrollBar.scrollPosition;
        }// end function

        public function set verticalScrollPosition(param1:Number) : void
        {
            drawNow();
            this._verticalScrollBar.scrollPosition = param1;
            this.setVerticalScrollPosition(this._verticalScrollBar.scrollPosition, false);
            return;
        }// end function

        public function get maxHorizontalScrollPosition() : Number
        {
            drawNow();
            return Math.max(0, this.contentWidth - this.availableWidth);
        }// end function

        public function get maxVerticalScrollPosition() : Number
        {
            drawNow();
            return Math.max(0, this.contentHeight - this.availableHeight);
        }// end function

        public function get useBitmapScrolling() : Boolean
        {
            return this._useBitmpScrolling;
        }// end function

        public function set useBitmapScrolling(param1:Boolean) : void
        {
            this._useBitmpScrolling = param1;
            invalidate(InvalidationType.STATE);
            return;
        }// end function

        public function get horizontalPageScrollSize() : Number
        {
            if (isNaN(this.availableWidth))
            {
                drawNow();
            }
            return this._horizontalPageScrollSize == 0 && !isNaN(this.availableWidth) ? (this.availableWidth) : (this._horizontalPageScrollSize);
        }// end function

        public function set horizontalPageScrollSize(param1:Number) : void
        {
            this._horizontalPageScrollSize = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function get verticalPageScrollSize() : Number
        {
            if (isNaN(this.availableHeight))
            {
                drawNow();
            }
            return this._verticalPageScrollSize == 0 && !isNaN(this.availableHeight) ? (this.availableHeight) : (this._verticalPageScrollSize);
        }// end function

        public function set verticalPageScrollSize(param1:Number) : void
        {
            this._verticalPageScrollSize = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function get horizontalScrollBar() : ScrollBar
        {
            return this._horizontalScrollBar;
        }// end function

        public function get verticalScrollBar() : ScrollBar
        {
            return this._verticalScrollBar;
        }// end function

        override protected function configUI() : void
        {
            super.configUI();
            this.contentScrollRect = new Rectangle(0, 0, 85, 85);
            this._verticalScrollBar = new ScrollBar();
            this._verticalScrollBar.addEventListener(ScrollEvent.SCROLL, this.handleScroll, false, 0, true);
            this._verticalScrollBar.visible = false;
            this._verticalScrollBar.lineScrollSize = this.defaultLineScrollSize;
            addChild(this._verticalScrollBar);
            copyStylesToChild(this._verticalScrollBar, SCROLL_BAR_STYLES);
            this._horizontalScrollBar = new ScrollBar();
            this._horizontalScrollBar.direction = ScrollBarDirection.HORIZONTAL;
            this._horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, this.handleScroll, false, 0, true);
            this._horizontalScrollBar.visible = false;
            this._horizontalScrollBar.lineScrollSize = this.defaultLineScrollSize;
            addChild(this._horizontalScrollBar);
            copyStylesToChild(this._horizontalScrollBar, SCROLL_BAR_STYLES);
            this.disabledOverlay = new Shape();
            var _loc_1:* = this.disabledOverlay.graphics;
            _loc_1.beginFill(16777215);
            _loc_1.drawRect(0, 0, width, height);
            _loc_1.endFill();
            addEventListener(MouseEvent.MOUSE_WHEEL, this.handleWheel, false, 0, true);
            return;
        }// end function

        protected function setContentSize(param1:Number, param2:Number) : void
        {
            if ((this.contentWidth == param1 || this.useFixedHorizontalScrolling) && this.contentHeight == param2)
            {
                return;
            }
            this.contentWidth = param1;
            this.contentHeight = param2;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        protected function handleScroll(event:ScrollEvent) : void
        {
            if (event.target == this._verticalScrollBar)
            {
                this.setVerticalScrollPosition(event.position);
            }
            else
            {
                this.setHorizontalScrollPosition(event.position);
            }
            return;
        }// end function

        protected function handleWheel(event:MouseEvent) : void
        {
            if (!enabled || !this._verticalScrollBar.visible || this.contentHeight <= this.availableHeight)
            {
                return;
            }
            this._verticalScrollBar.scrollPosition = this._verticalScrollBar.scrollPosition - event.delta * this.verticalLineScrollSize;
            this.setVerticalScrollPosition(this._verticalScrollBar.scrollPosition);
            dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, event.delta, this.horizontalScrollPosition));
            return;
        }// end function

        protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void
        {
            return;
        }// end function

        protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void
        {
            return;
        }// end function

        override protected function draw() : void
        {
            if (isInvalid(InvalidationType.STYLES))
            {
                this.setStyles();
                this.drawBackground();
                if (this.contentPadding != getStyleValue("contentPadding"))
                {
                    invalidate(InvalidationType.SIZE, false);
                }
            }
            if (isInvalid(InvalidationType.SIZE, InvalidationType.STATE))
            {
                this.drawLayout();
            }
            this.updateChildren();
            super.draw();
            return;
        }// end function

        protected function setStyles() : void
        {
            copyStylesToChild(this._verticalScrollBar, SCROLL_BAR_STYLES);
            copyStylesToChild(this._horizontalScrollBar, SCROLL_BAR_STYLES);
            return;
        }// end function

        protected function drawBackground() : void
        {
            var _loc_1:* = this.background;
            this.background = getDisplayObjectInstance(getStyleValue("skin"));
            _loc_1.width = width;
            _loc_1.height = height;
            addChildAt(this.background, 0);
            if (_loc_1 != null && _loc_1 != this.background)
            {
                removeChild(_loc_1);
            }
            return;
        }// end function

        protected function drawLayout() : void
        {
            this.calculateAvailableSize();
            this.calculateContentWidth();
            this.background.width = width;
            this.background.height = height;
            if (this.vScrollBar)
            {
                this._verticalScrollBar.visible = true;
                this._verticalScrollBar.x = width - ScrollBar.WIDTH - this.contentPadding;
                this._verticalScrollBar.y = this.contentPadding;
                this._verticalScrollBar.height = this.availableHeight;
            }
            else
            {
                this._verticalScrollBar.visible = false;
            }
            this._verticalScrollBar.setScrollProperties(this.availableHeight, 0, this.contentHeight - this.availableHeight, this.verticalPageScrollSize);
            this.setVerticalScrollPosition(this._verticalScrollBar.scrollPosition, false);
            if (this.hScrollBar)
            {
                this._horizontalScrollBar.visible = true;
                this._horizontalScrollBar.x = this.contentPadding;
                this._horizontalScrollBar.y = height - ScrollBar.WIDTH - this.contentPadding;
                this._horizontalScrollBar.width = this.availableWidth;
            }
            else
            {
                this._horizontalScrollBar.visible = false;
            }
            this._horizontalScrollBar.setScrollProperties(this.availableWidth, 0, this.useFixedHorizontalScrolling ? (this._maxHorizontalScrollPosition) : (this.contentWidth - this.availableWidth), this.horizontalPageScrollSize);
            this.setHorizontalScrollPosition(this._horizontalScrollBar.scrollPosition, false);
            this.drawDisabledOverlay();
            return;
        }// end function

        protected function drawDisabledOverlay() : void
        {
            if (enabled)
            {
                if (contains(this.disabledOverlay))
                {
                    removeChild(this.disabledOverlay);
                }
            }
            else
            {
                var _loc_1:* = this.contentPadding;
                this.disabledOverlay.y = this.contentPadding;
                this.disabledOverlay.x = _loc_1;
                this.disabledOverlay.width = this.availableWidth;
                this.disabledOverlay.height = this.availableHeight;
                this.disabledOverlay.alpha = getStyleValue("disabledAlpha") as Number;
                addChild(this.disabledOverlay);
            }
            return;
        }// end function

        protected function calculateAvailableSize() : void
        {
            var _loc_1:* = ScrollBar.WIDTH;
            var _loc_6:* = Number(getStyleValue("contentPadding"));
            this.contentPadding = Number(getStyleValue("contentPadding"));
            var _loc_2:* = _loc_6;
            var _loc_3:* = height - 2 * _loc_2 - this.vOffset;
            this.vScrollBar = this._verticalScrollPolicy == ScrollPolicy.ON || this._verticalScrollPolicy == ScrollPolicy.AUTO && this.contentHeight > _loc_3;
            var _loc_4:* = width - (this.vScrollBar ? (_loc_1) : (0)) - 2 * _loc_2;
            var _loc_5:* = this.useFixedHorizontalScrolling ? (this._maxHorizontalScrollPosition) : (this.contentWidth - _loc_4);
            this.hScrollBar = this._horizontalScrollPolicy == ScrollPolicy.ON || this._horizontalScrollPolicy == ScrollPolicy.AUTO && _loc_5 > 0;
            if (this.hScrollBar)
            {
                _loc_3 = _loc_3 - _loc_1;
            }
            if (this.hScrollBar && !this.vScrollBar && this._verticalScrollPolicy == ScrollPolicy.AUTO && this.contentHeight > _loc_3)
            {
                this.vScrollBar = true;
                _loc_4 = _loc_4 - _loc_1;
            }
            this.availableHeight = _loc_3 + this.vOffset;
            this.availableWidth = _loc_4;
            return;
        }// end function

        protected function calculateContentWidth() : void
        {
            return;
        }// end function

        protected function updateChildren() : void
        {
            var _loc_1:* = enabled;
            this._horizontalScrollBar.enabled = enabled;
            this._verticalScrollBar.enabled = _loc_1;
            this._verticalScrollBar.drawNow();
            this._horizontalScrollBar.drawNow();
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return mergeStyles(defaultStyles, ScrollBar.getStyleDefinition());
        }// end function

    }
}
