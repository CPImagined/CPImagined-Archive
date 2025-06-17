//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.managers.IFocusManagerComponent;
    import fl.core.InvalidationType;
    import fl.controls.listClasses.ICellRenderer;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import fl.controls.listClasses.ListData;
    import fl.core.UIComponent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;

    public class List extends SelectableList implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "focusRectSkin":null,
            "focusRectPadding":null
        };
        public static var createAccessibilityImplementation:Function;

        protected var _rowHeight:Number = 20;
        protected var _cellRenderer:Object;
        protected var _labelField:String = "label";
        protected var _labelFunction:Function;
        protected var _iconField:String = "icon";
        protected var _iconFunction:Function;


        public static function getStyleDefinition():Object
        {
            return (mergeStyles(defaultStyles, SelectableList.getStyleDefinition()));
        }


        public function get labelField():String
        {
            return (this._labelField);
        }

        public function set labelField(_arg_1:String):void
        {
            if (_arg_1 == this._labelField)
            {
                return;
            };
            this._labelField = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get labelFunction():Function
        {
            return (this._labelFunction);
        }

        public function set labelFunction(_arg_1:Function):void
        {
            if (this._labelFunction == _arg_1)
            {
                return;
            };
            this._labelFunction = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get iconField():String
        {
            return (this._iconField);
        }

        public function set iconField(_arg_1:String):void
        {
            if (_arg_1 == this._iconField)
            {
                return;
            };
            this._iconField = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get iconFunction():Function
        {
            return (this._iconFunction);
        }

        public function set iconFunction(_arg_1:Function):void
        {
            if (this._iconFunction == _arg_1)
            {
                return;
            };
            this._iconFunction = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        override public function get rowCount():uint
        {
            return (Math.ceil((this.calculateAvailableHeight() / this.rowHeight)));
        }

        public function set rowCount(_arg_1:uint):void
        {
            var _local_2:Number = Number(getStyleValue("contentPadding"));
            var _local_3:Number = (((_horizontalScrollPolicy == ScrollPolicy.ON) || ((_horizontalScrollPolicy == ScrollPolicy.AUTO) && (_maxHorizontalScrollPosition > 0))) ? 15 : 0);
            height = (((this.rowHeight * _arg_1) + (2 * _local_2)) + _local_3);
        }

        public function get rowHeight():Number
        {
            return (this._rowHeight);
        }

        public function set rowHeight(_arg_1:Number):void
        {
            this._rowHeight = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        override public function scrollToIndex(_arg_1:int):void
        {
            drawNow();
            var _local_2:uint = uint((Math.floor(((_verticalScrollPosition + availableHeight) / this.rowHeight)) - 1));
            var _local_3:uint = uint(Math.ceil((_verticalScrollPosition / this.rowHeight)));
            if (_arg_1 < _local_3)
            {
                verticalScrollPosition = (_arg_1 * this.rowHeight);
            }
            else
            {
                if (_arg_1 > _local_2)
                {
                    verticalScrollPosition = (((_arg_1 + 1) * this.rowHeight) - availableHeight);
                };
            };
        }

        override protected function configUI():void
        {
            useFixedHorizontalScrolling = true;
            _horizontalScrollPolicy = ScrollPolicy.AUTO;
            _verticalScrollPolicy = ScrollPolicy.AUTO;
            super.configUI();
        }

        protected function calculateAvailableHeight():Number
        {
            var _local_1:Number = Number(getStyleValue("contentPadding"));
            return ((height - (_local_1 * 2)) - (((_horizontalScrollPolicy == ScrollPolicy.ON) || ((_horizontalScrollPolicy == ScrollPolicy.AUTO) && (_maxHorizontalScrollPosition > 0))) ? 15 : 0));
        }

        override protected function setHorizontalScrollPosition(_arg_1:Number, _arg_2:Boolean=false):void
        {
            list.x = -(_arg_1);
            super.setHorizontalScrollPosition(_arg_1, true);
        }

        override protected function setVerticalScrollPosition(_arg_1:Number, _arg_2:Boolean=false):void
        {
            invalidate(InvalidationType.SCROLL);
            super.setVerticalScrollPosition(_arg_1, true);
        }

        override protected function draw():void
        {
            var _local_1:Boolean = (!(contentHeight == (this.rowHeight * length)));
            contentHeight = (this.rowHeight * length);
            if (isInvalid(InvalidationType.STYLES))
            {
                setStyles();
                drawBackground();
                if (contentPadding != getStyleValue("contentPadding"))
                {
                    invalidate(InvalidationType.SIZE, false);
                };
                if (this._cellRenderer != getStyleValue("cellRenderer"))
                {
                    _invalidateList();
                    this._cellRenderer = getStyleValue("cellRenderer");
                };
            };
            if (((isInvalid(InvalidationType.SIZE, InvalidationType.STATE)) || (_local_1)))
            {
                drawLayout();
            };
            if (isInvalid(InvalidationType.RENDERER_STYLES))
            {
                updateRendererStyles();
            };
            if (isInvalid(InvalidationType.STYLES, InvalidationType.SIZE, InvalidationType.DATA, InvalidationType.SCROLL, InvalidationType.SELECTED))
            {
                this.drawList();
            };
            updateChildren();
            validate();
        }

        override protected function drawList():void
        {
            var _local_4:uint;
            var _local_5:Object;
            var _local_6:ICellRenderer;
            var _local_9:Boolean;
            var _local_10:String;
            var _local_11:Object;
            var _local_12:Sprite;
            var _local_13:String;
            listHolder.x = (listHolder.y = contentPadding);
            var _local_1:Rectangle = listHolder.scrollRect;
            _local_1.x = _horizontalScrollPosition;
            _local_1.y = (Math.floor(_verticalScrollPosition) % this.rowHeight);
            listHolder.scrollRect = _local_1;
            listHolder.cacheAsBitmap = useBitmapScrolling;
            var _local_2:uint = uint(Math.floor((_verticalScrollPosition / this.rowHeight)));
            var _local_3:uint = Math.min(length, ((_local_2 + this.rowCount) + 1));
            var _local_7:Dictionary = (renderedItems = new Dictionary(true));
            _local_4 = _local_2;
            while (_local_4 < _local_3)
            {
                _local_7[_dataProvider.getItemAt(_local_4)] = true;
                _local_4++;
            };
            var _local_8:Dictionary = new Dictionary(true);
            while (activeCellRenderers.length > 0)
            {
                _local_6 = (activeCellRenderers.pop() as ICellRenderer);
                _local_5 = _local_6.data;
                if (((_local_7[_local_5] == null) || (invalidItems[_local_5] == true)))
                {
                    availableCellRenderers.push(_local_6);
                }
                else
                {
                    _local_8[_local_5] = _local_6;
                    invalidItems[_local_5] = true;
                };
                list.removeChild((_local_6 as DisplayObject));
            };
            invalidItems = new Dictionary(true);
            _local_4 = _local_2;
            while (_local_4 < _local_3)
            {
                _local_9 = false;
                _local_5 = _dataProvider.getItemAt(_local_4);
                if (_local_8[_local_5] != null)
                {
                    _local_9 = true;
                    _local_6 = _local_8[_local_5];
                    delete _local_8[_local_5];
                }
                else
                {
                    if (availableCellRenderers.length > 0)
                    {
                        _local_6 = (availableCellRenderers.pop() as ICellRenderer);
                    }
                    else
                    {
                        _local_6 = (getDisplayObjectInstance(getStyleValue("cellRenderer")) as ICellRenderer);
                        _local_12 = (_local_6 as Sprite);
                        if (_local_12 != null)
                        {
                            _local_12.addEventListener(MouseEvent.CLICK, handleCellRendererClick, false, 0, true);
                            _local_12.addEventListener(MouseEvent.ROLL_OVER, handleCellRendererMouseEvent, false, 0, true);
                            _local_12.addEventListener(MouseEvent.ROLL_OUT, handleCellRendererMouseEvent, false, 0, true);
                            _local_12.addEventListener(Event.CHANGE, handleCellRendererChange, false, 0, true);
                            _local_12.doubleClickEnabled = true;
                            _local_12.addEventListener(MouseEvent.DOUBLE_CLICK, handleCellRendererDoubleClick, false, 0, true);
                            if (_local_12.hasOwnProperty("setStyle"))
                            {
                                for (_local_13 in rendererStyles)
                                {
                                    var _local_16:* = _local_12;
                                    (_local_16["setStyle"](_local_13, rendererStyles[_local_13]));
                                };
                            };
                        };
                    };
                };
                list.addChild((_local_6 as Sprite));
                activeCellRenderers.push(_local_6);
                _local_6.y = (this.rowHeight * (_local_4 - _local_2));
                _local_6.setSize((availableWidth + _maxHorizontalScrollPosition), this.rowHeight);
                _local_10 = this.itemToLabel(_local_5);
                _local_11 = null;
                if (this._iconFunction != null)
                {
                    _local_11 = this._iconFunction(_local_5);
                }
                else
                {
                    if (this._iconField != null)
                    {
                        _local_11 = _local_5[this._iconField];
                    };
                };
                if ((!(_local_9)))
                {
                    _local_6.data = _local_5;
                };
                _local_6.listData = new ListData(_local_10, _local_11, this, _local_4, _local_4, 0);
                _local_6.selected = (!(_selectedIndices.indexOf(_local_4) == -1));
                if ((_local_6 is UIComponent))
                {
                    (_local_6 as UIComponent).drawNow();
                };
                _local_4++;
            };
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:int;
            if ((!(selectable)))
            {
                return;
            };
            switch (_arg_1.keyCode)
            {
                case Keyboard.UP:
                case Keyboard.DOWN:
                case Keyboard.END:
                case Keyboard.HOME:
                case Keyboard.PAGE_UP:
                case Keyboard.PAGE_DOWN:
                    this.moveSelectionVertically(_arg_1.keyCode, ((_arg_1.shiftKey) && (_allowMultipleSelection)), ((_arg_1.ctrlKey) && (_allowMultipleSelection)));
                    break;
                case Keyboard.LEFT:
                case Keyboard.RIGHT:
                    this.moveSelectionHorizontally(_arg_1.keyCode, ((_arg_1.shiftKey) && (_allowMultipleSelection)), ((_arg_1.ctrlKey) && (_allowMultipleSelection)));
                    break;
                case Keyboard.SPACE:
                    if (caretIndex == -1)
                    {
                        caretIndex = 0;
                    };
                    this.doKeySelection(caretIndex, _arg_1.shiftKey, _arg_1.ctrlKey);
                    scrollToSelected();
                    break;
                default:
                    _local_2 = getNextIndexAtLetter(String.fromCharCode(_arg_1.keyCode), selectedIndex);
                    if (_local_2 > -1)
                    {
                        selectedIndex = _local_2;
                        scrollToSelected();
                    };
            };
            _arg_1.stopPropagation();
        }

        override protected function moveSelectionHorizontally(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
        }

        override protected function moveSelectionVertically(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:int = int(Math.max(Math.floor((this.calculateAvailableHeight() / this.rowHeight)), 1));
            var _local_5:int = -1;
            var _local_6:int;
            switch (_arg_1)
            {
                case Keyboard.UP:
                    if (caretIndex > 0)
                    {
                        _local_5 = (caretIndex - 1);
                    };
                    break;
                case Keyboard.DOWN:
                    if (caretIndex < (length - 1))
                    {
                        _local_5 = (caretIndex + 1);
                    };
                    break;
                case Keyboard.PAGE_UP:
                    if (caretIndex > 0)
                    {
                        _local_5 = Math.max((caretIndex - _local_4), 0);
                    };
                    break;
                case Keyboard.PAGE_DOWN:
                    if (caretIndex < (length - 1))
                    {
                        _local_5 = Math.min((caretIndex + _local_4), (length - 1));
                    };
                    break;
                case Keyboard.HOME:
                    if (caretIndex > 0)
                    {
                        _local_5 = 0;
                    };
                    break;
                case Keyboard.END:
                    if (caretIndex < (length - 1))
                    {
                        _local_5 = (length - 1);
                    };
                    break;
            };
            if (_local_5 >= 0)
            {
                this.doKeySelection(_local_5, _arg_2, _arg_3);
                scrollToSelected();
            };
        }

        protected function doKeySelection(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_5:int;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:int;
            var _local_4:Boolean;
            if (_arg_2)
            {
                _local_6 = [];
                _local_7 = lastCaretIndex;
                _local_8 = _arg_1;
                if (_local_7 == -1)
                {
                    _local_7 = ((!(caretIndex == -1)) ? caretIndex : _arg_1);
                };
                if (_local_7 > _local_8)
                {
                    _local_8 = _local_7;
                    _local_7 = _arg_1;
                };
                _local_5 = _local_7;
                while (_local_5 <= _local_8)
                {
                    _local_6.push(_local_5);
                    _local_5++;
                };
                selectedIndices = _local_6;
                caretIndex = _arg_1;
                _local_4 = true;
            }
            else
            {
                selectedIndex = _arg_1;
                caretIndex = (lastCaretIndex = _arg_1);
                _local_4 = true;
            };
            if (_local_4)
            {
                dispatchEvent(new Event(Event.CHANGE));
            };
            invalidate(InvalidationType.DATA);
        }

        override public function itemToLabel(_arg_1:Object):String
        {
            if (this._labelFunction != null)
            {
                return (String(this._labelFunction(_arg_1)));
            };
            return ((_arg_1[this._labelField] != null) ? String(_arg_1[this._labelField]) : "");
        }

        override protected function initializeAccessibility():void
        {
            if (List.createAccessibilityImplementation != null)
            {
                List.createAccessibilityImplementation(this);
            };
        }


    }
}//package fl.controls
