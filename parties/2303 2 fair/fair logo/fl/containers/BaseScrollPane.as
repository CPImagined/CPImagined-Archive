//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.containers
{
    import fl.core.UIComponent;
    import fl.controls.ScrollBar;
    import flash.geom.Rectangle;
    import flash.display.Shape;
    import flash.display.DisplayObject;
    import fl.core.InvalidationType;
    import fl.events.ScrollEvent;
    import fl.controls.ScrollBarDirection;
    import flash.display.Graphics;
    import flash.events.MouseEvent;
    import fl.controls.ScrollPolicy;

    public class BaseScrollPane extends UIComponent 
    {

        private static var defaultStyles:Object = {
            "repeatDelay":500,
            "repeatInterval":35,
            "skin":"ScrollPane_upSkin",
            "contentPadding":0,
            "disabledAlpha":0.5
        };
        protected static const SCROLL_BAR_STYLES:Object = {
            "upArrowDisabledSkin":"upArrowDisabledSkin",
            "upArrowDownSkin":"upArrowDownSkin",
            "upArrowOverSkin":"upArrowOverSkin",
            "upArrowUpSkin":"upArrowUpSkin",
            "downArrowDisabledSkin":"downArrowDisabledSkin",
            "downArrowDownSkin":"downArrowDownSkin",
            "downArrowOverSkin":"downArrowOverSkin",
            "downArrowUpSkin":"downArrowUpSkin",
            "thumbDisabledSkin":"thumbDisabledSkin",
            "thumbDownSkin":"thumbDownSkin",
            "thumbOverSkin":"thumbOverSkin",
            "thumbUpSkin":"thumbUpSkin",
            "thumbIcon":"thumbIcon",
            "trackDisabledSkin":"trackDisabledSkin",
            "trackDownSkin":"trackDownSkin",
            "trackOverSkin":"trackOverSkin",
            "trackUpSkin":"trackUpSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval"
        };

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


        public static function getStyleDefinition():Object
        {
            return (mergeStyles(defaultStyles, ScrollBar.getStyleDefinition()));
        }


        override public function set enabled(_arg_1:Boolean):void
        {
            if (enabled == _arg_1)
            {
                return;
            };
            this._verticalScrollBar.enabled = _arg_1;
            this._horizontalScrollBar.enabled = _arg_1;
            super.enabled = _arg_1;
        }

        public function get horizontalScrollPolicy():String
        {
            return (this._horizontalScrollPolicy);
        }

        public function set horizontalScrollPolicy(_arg_1:String):void
        {
            this._horizontalScrollPolicy = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function get verticalScrollPolicy():String
        {
            return (this._verticalScrollPolicy);
        }

        public function set verticalScrollPolicy(_arg_1:String):void
        {
            this._verticalScrollPolicy = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function get horizontalLineScrollSize():Number
        {
            return (this._horizontalScrollBar.lineScrollSize);
        }

        public function set horizontalLineScrollSize(_arg_1:Number):void
        {
            this._horizontalScrollBar.lineScrollSize = _arg_1;
        }

        public function get verticalLineScrollSize():Number
        {
            return (this._verticalScrollBar.lineScrollSize);
        }

        public function set verticalLineScrollSize(_arg_1:Number):void
        {
            this._verticalScrollBar.lineScrollSize = _arg_1;
        }

        public function get horizontalScrollPosition():Number
        {
            return (this._horizontalScrollBar.scrollPosition);
        }

        public function set horizontalScrollPosition(_arg_1:Number):void
        {
            drawNow();
            this._horizontalScrollBar.scrollPosition = _arg_1;
            this.setHorizontalScrollPosition(this._horizontalScrollBar.scrollPosition, false);
        }

        public function get verticalScrollPosition():Number
        {
            return (this._verticalScrollBar.scrollPosition);
        }

        public function set verticalScrollPosition(_arg_1:Number):void
        {
            drawNow();
            this._verticalScrollBar.scrollPosition = _arg_1;
            this.setVerticalScrollPosition(this._verticalScrollBar.scrollPosition, false);
        }

        public function get maxHorizontalScrollPosition():Number
        {
            drawNow();
            return (Math.max(0, (this.contentWidth - this.availableWidth)));
        }

        public function get maxVerticalScrollPosition():Number
        {
            drawNow();
            return (Math.max(0, (this.contentHeight - this.availableHeight)));
        }

        public function get useBitmapScrolling():Boolean
        {
            return (this._useBitmpScrolling);
        }

        public function set useBitmapScrolling(_arg_1:Boolean):void
        {
            this._useBitmpScrolling = _arg_1;
            invalidate(InvalidationType.STATE);
        }

        public function get horizontalPageScrollSize():Number
        {
            if (isNaN(this.availableWidth))
            {
                drawNow();
            };
            return (((this._horizontalPageScrollSize == 0) && (!(isNaN(this.availableWidth)))) ? this.availableWidth : this._horizontalPageScrollSize);
        }

        public function set horizontalPageScrollSize(_arg_1:Number):void
        {
            this._horizontalPageScrollSize = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function get verticalPageScrollSize():Number
        {
            if (isNaN(this.availableHeight))
            {
                drawNow();
            };
            return (((this._verticalPageScrollSize == 0) && (!(isNaN(this.availableHeight)))) ? this.availableHeight : this._verticalPageScrollSize);
        }

        public function set verticalPageScrollSize(_arg_1:Number):void
        {
            this._verticalPageScrollSize = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function get horizontalScrollBar():ScrollBar
        {
            return (this._horizontalScrollBar);
        }

        public function get verticalScrollBar():ScrollBar
        {
            return (this._verticalScrollBar);
        }

        override protected function configUI():void
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
            var _local_1:Graphics = this.disabledOverlay.graphics;
            _local_1.beginFill(0xFFFFFF);
            _local_1.drawRect(0, 0, width, height);
            _local_1.endFill();
            addEventListener(MouseEvent.MOUSE_WHEEL, this.handleWheel, false, 0, true);
        }

        protected function setContentSize(_arg_1:Number, _arg_2:Number):void
        {
            if ((((this.contentWidth == _arg_1) || (this.useFixedHorizontalScrolling)) && (this.contentHeight == _arg_2)))
            {
                return;
            };
            this.contentWidth = _arg_1;
            this.contentHeight = _arg_2;
            invalidate(InvalidationType.SIZE);
        }

        protected function handleScroll(_arg_1:ScrollEvent):void
        {
            if (_arg_1.target == this._verticalScrollBar)
            {
                this.setVerticalScrollPosition(_arg_1.position);
            }
            else
            {
                this.setHorizontalScrollPosition(_arg_1.position);
            };
        }

        protected function handleWheel(_arg_1:MouseEvent):void
        {
            if ((((!(enabled)) || (!(this._verticalScrollBar.visible))) || (this.contentHeight <= this.availableHeight)))
            {
                return;
            };
            this._verticalScrollBar.scrollPosition = (this._verticalScrollBar.scrollPosition - (_arg_1.delta * this.verticalLineScrollSize));
            this.setVerticalScrollPosition(this._verticalScrollBar.scrollPosition);
            dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, _arg_1.delta, this.horizontalScrollPosition));
        }

        protected function setHorizontalScrollPosition(_arg_1:Number, _arg_2:Boolean=false):void
        {
        }

        protected function setVerticalScrollPosition(_arg_1:Number, _arg_2:Boolean=false):void
        {
        }

        override protected function draw():void
        {
            if (isInvalid(InvalidationType.STYLES))
            {
                this.setStyles();
                this.drawBackground();
                if (this.contentPadding != getStyleValue("contentPadding"))
                {
                    invalidate(InvalidationType.SIZE, false);
                };
            };
            if (isInvalid(InvalidationType.SIZE, InvalidationType.STATE))
            {
                this.drawLayout();
            };
            this.updateChildren();
            super.draw();
        }

        protected function setStyles():void
        {
            copyStylesToChild(this._verticalScrollBar, SCROLL_BAR_STYLES);
            copyStylesToChild(this._horizontalScrollBar, SCROLL_BAR_STYLES);
        }

        protected function drawBackground():void
        {
            var _local_1:DisplayObject = this.background;
            this.background = getDisplayObjectInstance(getStyleValue("skin"));
            this.background.width = width;
            this.background.height = height;
            addChildAt(this.background, 0);
            if (((!(_local_1 == null)) && (!(_local_1 == this.background))))
            {
                removeChild(_local_1);
            };
        }

        protected function drawLayout():void
        {
            this.calculateAvailableSize();
            this.calculateContentWidth();
            this.background.width = width;
            this.background.height = height;
            if (this.vScrollBar)
            {
                this._verticalScrollBar.visible = true;
                this._verticalScrollBar.x = ((width - ScrollBar.WIDTH) - this.contentPadding);
                this._verticalScrollBar.y = this.contentPadding;
                this._verticalScrollBar.height = this.availableHeight;
            }
            else
            {
                this._verticalScrollBar.visible = false;
            };
            this._verticalScrollBar.setScrollProperties(this.availableHeight, 0, (this.contentHeight - this.availableHeight), this.verticalPageScrollSize);
            this.setVerticalScrollPosition(this._verticalScrollBar.scrollPosition, false);
            if (this.hScrollBar)
            {
                this._horizontalScrollBar.visible = true;
                this._horizontalScrollBar.x = this.contentPadding;
                this._horizontalScrollBar.y = ((height - ScrollBar.WIDTH) - this.contentPadding);
                this._horizontalScrollBar.width = this.availableWidth;
            }
            else
            {
                this._horizontalScrollBar.visible = false;
            };
            this._horizontalScrollBar.setScrollProperties(this.availableWidth, 0, ((this.useFixedHorizontalScrolling) ? this._maxHorizontalScrollPosition : (this.contentWidth - this.availableWidth)), this.horizontalPageScrollSize);
            this.setHorizontalScrollPosition(this._horizontalScrollBar.scrollPosition, false);
            this.drawDisabledOverlay();
        }

        protected function drawDisabledOverlay():void
        {
            if (enabled)
            {
                if (contains(this.disabledOverlay))
                {
                    removeChild(this.disabledOverlay);
                };
            }
            else
            {
                this.disabledOverlay.x = (this.disabledOverlay.y = this.contentPadding);
                this.disabledOverlay.width = this.availableWidth;
                this.disabledOverlay.height = this.availableHeight;
                this.disabledOverlay.alpha = (getStyleValue("disabledAlpha") as Number);
                addChild(this.disabledOverlay);
            };
        }

        protected function calculateAvailableSize():void
        {
            var _local_1:Number = ScrollBar.WIDTH;
            var _local_2:Number = (this.contentPadding = Number(getStyleValue("contentPadding")));
            var _local_3:Number = ((height - (2 * _local_2)) - this.vOffset);
            this.vScrollBar = ((this._verticalScrollPolicy == ScrollPolicy.ON) || ((this._verticalScrollPolicy == ScrollPolicy.AUTO) && (this.contentHeight > _local_3)));
            var _local_4:Number = ((width - ((this.vScrollBar) ? _local_1 : 0)) - (2 * _local_2));
            var _local_5:Number = ((this.useFixedHorizontalScrolling) ? this._maxHorizontalScrollPosition : (this.contentWidth - _local_4));
            this.hScrollBar = ((this._horizontalScrollPolicy == ScrollPolicy.ON) || ((this._horizontalScrollPolicy == ScrollPolicy.AUTO) && (_local_5 > 0)));
            if (this.hScrollBar)
            {
                _local_3 = (_local_3 - _local_1);
            };
            if (((((this.hScrollBar) && (!(this.vScrollBar))) && (this._verticalScrollPolicy == ScrollPolicy.AUTO)) && (this.contentHeight > _local_3)))
            {
                this.vScrollBar = true;
                _local_4 = (_local_4 - _local_1);
            };
            this.availableHeight = (_local_3 + this.vOffset);
            this.availableWidth = _local_4;
        }

        protected function calculateContentWidth():void
        {
        }

        protected function updateChildren():void
        {
            this._verticalScrollBar.enabled = (this._horizontalScrollBar.enabled = enabled);
            this._verticalScrollBar.drawNow();
            this._horizontalScrollBar.drawNow();
        }


    }
}//package fl.containers
