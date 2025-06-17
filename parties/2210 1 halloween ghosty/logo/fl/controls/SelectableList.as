//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.containers.BaseScrollPane;
    import fl.managers.IFocusManagerComponent;
    import fl.controls.listClasses.CellRenderer;
    import flash.display.Sprite;
    import fl.data.DataProvider;
    import flash.utils.Dictionary;
    import fl.data.SimpleCollectionItem;
    import fl.events.DataChangeEvent;
    import fl.core.InvalidationType;
    import fl.controls.listClasses.ICellRenderer;
    import flash.display.DisplayObject;
    import fl.events.DataChangeType;
    import flash.events.MouseEvent;
    import fl.events.ListEvent;
    import flash.events.Event;
    import fl.events.ScrollEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;

    public class SelectableList extends BaseScrollPane implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "skin":"List_skin",
            "cellRenderer":CellRenderer,
            "contentPadding":null,
            "disabledAlpha":null
        };
        public static var createAccessibilityImplementation:Function;

        protected var listHolder:Sprite;
        protected var list:Sprite;
        protected var _dataProvider:DataProvider;
        protected var activeCellRenderers:Array;
        protected var availableCellRenderers:Array;
        protected var renderedItems:Dictionary;
        protected var invalidItems:Dictionary;
        protected var _horizontalScrollPosition:Number;
        protected var _verticalScrollPosition:Number;
        protected var _allowMultipleSelection:Boolean = false;
        protected var _selectable:Boolean = true;
        protected var _selectedIndices:Array;
        protected var caretIndex:int = -1;
        protected var lastCaretIndex:int = -1;
        protected var preChangeItems:Array;
        private var collectionItemImport:SimpleCollectionItem;
        protected var rendererStyles:Object;
        protected var updatedRendererStyles:Object;

        public function SelectableList()
        {
            this.activeCellRenderers = [];
            this.availableCellRenderers = [];
            this.invalidItems = new Dictionary(true);
            this.renderedItems = new Dictionary(true);
            this._selectedIndices = [];
            if (this.dataProvider == null)
            {
                this.dataProvider = new DataProvider();
            };
            verticalScrollPolicy = ScrollPolicy.AUTO;
            this.rendererStyles = {};
            this.updatedRendererStyles = {};
        }

        public static function getStyleDefinition():Object
        {
            return (mergeStyles(defaultStyles, BaseScrollPane.getStyleDefinition()));
        }


        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            this.list.mouseChildren = _enabled;
        }

        public function get dataProvider():DataProvider
        {
            return (this._dataProvider);
        }

        public function set dataProvider(_arg_1:DataProvider):void
        {
            if (this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, this.handleDataChange);
                this._dataProvider.removeEventListener(DataChangeEvent.PRE_DATA_CHANGE, this.onPreChange);
            };
            this._dataProvider = _arg_1;
            this._dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, this.handleDataChange, false, 0, true);
            this._dataProvider.addEventListener(DataChangeEvent.PRE_DATA_CHANGE, this.onPreChange, false, 0, true);
            this.clearSelection();
            this.invalidateList();
        }

        override public function get maxHorizontalScrollPosition():Number
        {
            return (_maxHorizontalScrollPosition);
        }

        public function set maxHorizontalScrollPosition(_arg_1:Number):void
        {
            _maxHorizontalScrollPosition = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function get length():uint
        {
            return (this._dataProvider.length);
        }

        public function get allowMultipleSelection():Boolean
        {
            return (this._allowMultipleSelection);
        }

        public function set allowMultipleSelection(_arg_1:Boolean):void
        {
            if (_arg_1 == this._allowMultipleSelection)
            {
                return;
            };
            this._allowMultipleSelection = _arg_1;
            if (((!(_arg_1)) && (this._selectedIndices.length > 1)))
            {
                this._selectedIndices = [this._selectedIndices.pop()];
                invalidate(InvalidationType.DATA);
            };
        }

        public function get selectable():Boolean
        {
            return (this._selectable);
        }

        public function set selectable(_arg_1:Boolean):void
        {
            if (_arg_1 == this._selectable)
            {
                return;
            };
            if (!_arg_1)
            {
                this.selectedIndices = [];
            };
            this._selectable = _arg_1;
        }

        public function get selectedIndex():int
        {
            return ((this._selectedIndices.length == 0) ? -1 : this._selectedIndices[(this._selectedIndices.length - 1)]);
        }

        public function set selectedIndex(_arg_1:int):void
        {
            this.selectedIndices = ((_arg_1 == -1) ? null : [_arg_1]);
        }

        public function get selectedIndices():Array
        {
            return (this._selectedIndices.concat());
        }

        public function set selectedIndices(_arg_1:Array):void
        {
            if (!this._selectable)
            {
                return;
            };
            this._selectedIndices = ((_arg_1 == null) ? [] : _arg_1.concat());
            invalidate(InvalidationType.SELECTED);
        }

        public function get selectedItem():Object
        {
            return ((this._selectedIndices.length == 0) ? null : this._dataProvider.getItemAt(this.selectedIndex));
        }

        public function set selectedItem(_arg_1:Object):void
        {
            var _local_2:int = this._dataProvider.getItemIndex(_arg_1);
            this.selectedIndex = _local_2;
        }

        public function get selectedItems():Array
        {
            var _local_1:Array = [];
            var _local_2:uint;
            while (_local_2 < this._selectedIndices.length)
            {
                _local_1.push(this._dataProvider.getItemAt(this._selectedIndices[_local_2]));
                _local_2++;
            };
            return (_local_1);
        }

        public function set selectedItems(_arg_1:Array):void
        {
            var _local_4:int;
            if (_arg_1 == null)
            {
                this.selectedIndices = null;
                return;
            };
            var _local_2:Array = [];
            var _local_3:uint;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = this._dataProvider.getItemIndex(_arg_1[_local_3]);
                if (_local_4 != -1)
                {
                    _local_2.push(_local_4);
                };
                _local_3++;
            };
            this.selectedIndices = _local_2;
        }

        public function get rowCount():uint
        {
            return (0);
        }

        public function clearSelection():void
        {
            this.selectedIndex = -1;
        }

        public function itemToCellRenderer(_arg_1:Object):ICellRenderer
        {
            var _local_2:*;
            var _local_3:ICellRenderer;
            if (_arg_1 != null)
            {
                for (_local_2 in this.activeCellRenderers)
                {
                    _local_3 = (this.activeCellRenderers[_local_2] as ICellRenderer);
                    if (_local_3.data == _arg_1)
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }

        public function addItem(_arg_1:Object):void
        {
            this._dataProvider.addItem(_arg_1);
            this.invalidateList();
        }

        public function addItemAt(_arg_1:Object, _arg_2:uint):void
        {
            this._dataProvider.addItemAt(_arg_1, _arg_2);
            this.invalidateList();
        }

        public function removeAll():void
        {
            this._dataProvider.removeAll();
        }

        public function getItemAt(_arg_1:uint):Object
        {
            return (this._dataProvider.getItemAt(_arg_1));
        }

        public function removeItem(_arg_1:Object):Object
        {
            return (this._dataProvider.removeItem(_arg_1));
        }

        public function removeItemAt(_arg_1:uint):Object
        {
            return (this._dataProvider.removeItemAt(_arg_1));
        }

        public function replaceItemAt(_arg_1:Object, _arg_2:uint):Object
        {
            return (this._dataProvider.replaceItemAt(_arg_1, _arg_2));
        }

        public function invalidateList():void
        {
            this._invalidateList();
            invalidate(InvalidationType.DATA);
        }

        public function invalidateItem(_arg_1:Object):void
        {
            if (this.renderedItems[_arg_1] == null)
            {
                return;
            };
            this.invalidItems[_arg_1] = true;
            invalidate(InvalidationType.DATA);
        }

        public function invalidateItemAt(_arg_1:uint):void
        {
            var _local_2:Object = this._dataProvider.getItemAt(_arg_1);
            if (_local_2 != null)
            {
                this.invalidateItem(_local_2);
            };
        }

        public function sortItems(... _args):*
        {
            return (this._dataProvider.sort.apply(this._dataProvider, _args));
        }

        public function sortItemsOn(_arg_1:String, _arg_2:Object=null):*
        {
            return (this._dataProvider.sortOn(_arg_1, _arg_2));
        }

        public function isItemSelected(_arg_1:Object):Boolean
        {
            return (this.selectedItems.indexOf(_arg_1) > -1);
        }

        public function scrollToSelected():void
        {
            this.scrollToIndex(this.selectedIndex);
        }

        public function scrollToIndex(_arg_1:int):void
        {
        }

        public function getNextIndexAtLetter(_arg_1:String, _arg_2:int=-1):int
        {
            var _local_5:Number;
            var _local_6:Object;
            var _local_7:String;
            if (this.length == 0)
            {
                return (-1);
            };
            _arg_1 = _arg_1.toUpperCase();
            var _local_3:int = (this.length - 1);
            var _local_4:Number = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = ((_arg_2 + 1) + _local_4);
                if (_local_5 > (this.length - 1))
                {
                    _local_5 = (_local_5 - this.length);
                };
                _local_6 = this.getItemAt(_local_5);
                if (_local_6 == null) break;
                _local_7 = this.itemToLabel(_local_6);
                if (_local_7 != null)
                {
                    if (_local_7.charAt(0).toUpperCase() == _arg_1)
                    {
                        return (_local_5);
                    };
                };
                _local_4++;
            };
            return (-1);
        }

        public function itemToLabel(_arg_1:Object):String
        {
            return (_arg_1["label"]);
        }

        public function setRendererStyle(_arg_1:String, _arg_2:Object, _arg_3:uint=0):void
        {
            if (this.rendererStyles[_arg_1] == _arg_2)
            {
                return;
            };
            this.updatedRendererStyles[_arg_1] = _arg_2;
            this.rendererStyles[_arg_1] = _arg_2;
            invalidate(InvalidationType.RENDERER_STYLES);
        }

        public function getRendererStyle(_arg_1:String, _arg_2:int=-1):Object
        {
            return (this.rendererStyles[_arg_1]);
        }

        public function clearRendererStyle(_arg_1:String, _arg_2:int=-1):void
        {
            delete this.rendererStyles[_arg_1];
            this.updatedRendererStyles[_arg_1] = null;
            invalidate(InvalidationType.RENDERER_STYLES);
        }

        override protected function configUI():void
        {
            super.configUI();
            this.listHolder = new Sprite();
            addChild(this.listHolder);
            this.listHolder.scrollRect = contentScrollRect;
            this.list = new Sprite();
            this.listHolder.addChild(this.list);
        }

        protected function _invalidateList():void
        {
            this.availableCellRenderers = [];
            while (this.activeCellRenderers.length > 0)
            {
                this.list.removeChild((this.activeCellRenderers.pop() as DisplayObject));
            };
        }

        protected function handleDataChange(_arg_1:DataChangeEvent):void
        {
            var _local_5:uint;
            var _local_2:int = _arg_1.startIndex;
            var _local_3:int = _arg_1.endIndex;
            var _local_4:String = _arg_1.changeType;
            if (_local_4 == DataChangeType.INVALIDATE_ALL)
            {
                this.clearSelection();
                this.invalidateList();
            }
            else
            {
                if (_local_4 == DataChangeType.INVALIDATE)
                {
                    _local_5 = 0;
                    while (_local_5 < _arg_1.items.length)
                    {
                        this.invalidateItem(_arg_1.items[_local_5]);
                        _local_5++;
                    };
                }
                else
                {
                    if (_local_4 == DataChangeType.ADD)
                    {
                        _local_5 = 0;
                        while (_local_5 < this._selectedIndices.length)
                        {
                            if (this._selectedIndices[_local_5] >= _local_2)
                            {
                                this._selectedIndices[_local_5] = (this._selectedIndices[_local_5] + (_local_2 - _local_3));
                            };
                            _local_5++;
                        };
                    }
                    else
                    {
                        if (_local_4 == DataChangeType.REMOVE)
                        {
                            _local_5 = 0;
                            while (_local_5 < this._selectedIndices.length)
                            {
                                if (this._selectedIndices[_local_5] >= _local_2)
                                {
                                    if (this._selectedIndices[_local_5] <= _local_3)
                                    {
                                        delete this._selectedIndices[_local_5];
                                    }
                                    else
                                    {
                                        this._selectedIndices[_local_5] = (this._selectedIndices[_local_5] - ((_local_2 - _local_3) + 1));
                                    };
                                };
                                _local_5++;
                            };
                        }
                        else
                        {
                            if (_local_4 == DataChangeType.REMOVE_ALL)
                            {
                                this.clearSelection();
                            }
                            else
                            {
                                if (_local_4 != DataChangeType.REPLACE)
                                {
                                    this.selectedItems = this.preChangeItems;
                                    this.preChangeItems = null;
                                };
                            };
                        };
                    };
                };
            };
            invalidate(InvalidationType.DATA);
        }

        protected function handleCellRendererMouseEvent(_arg_1:MouseEvent):void
        {
            var _local_2:ICellRenderer = (_arg_1.target as ICellRenderer);
            var _local_3:String = ((_arg_1.type == MouseEvent.ROLL_OVER) ? ListEvent.ITEM_ROLL_OVER : ListEvent.ITEM_ROLL_OUT);
            dispatchEvent(new ListEvent(_local_3, false, false, _local_2.listData.column, _local_2.listData.row, _local_2.listData.index, _local_2.data));
        }

        protected function handleCellRendererClick(_arg_1:MouseEvent):void
        {
            var _local_5:int;
            var _local_6:uint;
            if (!_enabled)
            {
                return;
            };
            var _local_2:ICellRenderer = (_arg_1.currentTarget as ICellRenderer);
            var _local_3:uint = _local_2.listData.index;
            if (((!(dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK, false, true, _local_2.listData.column, _local_2.listData.row, _local_3, _local_2.data)))) || (!(this._selectable))))
            {
                return;
            };
            var _local_4:int = this.selectedIndices.indexOf(_local_3);
            if (!this._allowMultipleSelection)
            {
                if (_local_4 != -1)
                {
                    return;
                };
                _local_2.selected = true;
                this._selectedIndices = [_local_3];
                this.lastCaretIndex = (this.caretIndex = _local_3);
            }
            else
            {
                if (_arg_1.shiftKey)
                {
                    _local_6 = ((this._selectedIndices.length > 0) ? this._selectedIndices[0] : _local_3);
                    this._selectedIndices = [];
                    if (_local_6 > _local_3)
                    {
                        _local_5 = _local_6;
                        while (_local_5 >= _local_3)
                        {
                            this._selectedIndices.push(_local_5);
                            _local_5--;
                        };
                    }
                    else
                    {
                        _local_5 = _local_6;
                        while (_local_5 <= _local_3)
                        {
                            this._selectedIndices.push(_local_5);
                            _local_5++;
                        };
                    };
                    this.caretIndex = _local_3;
                }
                else
                {
                    if (_arg_1.ctrlKey)
                    {
                        if (_local_4 != -1)
                        {
                            _local_2.selected = false;
                            this._selectedIndices.splice(_local_4, 1);
                        }
                        else
                        {
                            _local_2.selected = true;
                            this._selectedIndices.push(_local_3);
                        };
                        this.caretIndex = _local_3;
                    }
                    else
                    {
                        this._selectedIndices = [_local_3];
                        this.lastCaretIndex = (this.caretIndex = _local_3);
                    };
                };
            };
            dispatchEvent(new Event(Event.CHANGE));
            invalidate(InvalidationType.DATA);
        }

        protected function handleCellRendererChange(_arg_1:Event):void
        {
            var _local_2:ICellRenderer = (_arg_1.currentTarget as ICellRenderer);
            var _local_3:uint = _local_2.listData.index;
            this._dataProvider.invalidateItemAt(_local_3);
        }

        protected function handleCellRendererDoubleClick(_arg_1:MouseEvent):void
        {
            if (!_enabled)
            {
                return;
            };
            var _local_2:ICellRenderer = (_arg_1.currentTarget as ICellRenderer);
            var _local_3:uint = _local_2.listData.index;
            dispatchEvent(new ListEvent(ListEvent.ITEM_DOUBLE_CLICK, false, true, _local_2.listData.column, _local_2.listData.row, _local_3, _local_2.data));
        }

        override protected function setHorizontalScrollPosition(_arg_1:Number, _arg_2:Boolean=false):void
        {
            if (_arg_1 == this._horizontalScrollPosition)
            {
                return;
            };
            var _local_3:Number = (_arg_1 - this._horizontalScrollPosition);
            this._horizontalScrollPosition = _arg_1;
            if (_arg_2)
            {
                dispatchEvent(new ScrollEvent(ScrollBarDirection.HORIZONTAL, _local_3, _arg_1));
            };
        }

        override protected function setVerticalScrollPosition(_arg_1:Number, _arg_2:Boolean=false):void
        {
            if (_arg_1 == this._verticalScrollPosition)
            {
                return;
            };
            var _local_3:Number = (_arg_1 - this._verticalScrollPosition);
            this._verticalScrollPosition = _arg_1;
            if (_arg_2)
            {
                dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, _local_3, _arg_1));
            };
        }

        override protected function draw():void
        {
            super.draw();
        }

        override protected function drawLayout():void
        {
            super.drawLayout();
            contentScrollRect = this.listHolder.scrollRect;
            contentScrollRect.width = availableWidth;
            contentScrollRect.height = availableHeight;
            this.listHolder.scrollRect = contentScrollRect;
        }

        protected function updateRendererStyles():void
        {
            var _local_4:String;
            var _local_1:Array = this.availableCellRenderers.concat(this.activeCellRenderers);
            var _local_2:uint = _local_1.length;
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                if (_local_1[_local_3].setStyle != null)
                {
                    for (_local_4 in this.updatedRendererStyles)
                    {
                        _local_1[_local_3].setStyle(_local_4, this.updatedRendererStyles[_local_4]);
                    };
                    _local_1[_local_3].drawNow();
                };
                _local_3++;
            };
            this.updatedRendererStyles = {};
        }

        protected function drawList():void
        {
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (!this.selectable)
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
                    this.moveSelectionVertically(_arg_1.keyCode, ((_arg_1.shiftKey) && (this._allowMultipleSelection)), ((_arg_1.ctrlKey) && (this._allowMultipleSelection)));
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.LEFT:
                case Keyboard.RIGHT:
                    this.moveSelectionHorizontally(_arg_1.keyCode, ((_arg_1.shiftKey) && (this._allowMultipleSelection)), ((_arg_1.ctrlKey) && (this._allowMultipleSelection)));
                    _arg_1.stopPropagation();
                    return;
            };
        }

        protected function moveSelectionHorizontally(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
        }

        protected function moveSelectionVertically(_arg_1:uint, _arg_2:Boolean, _arg_3:Boolean):void
        {
        }

        override protected function initializeAccessibility():void
        {
            if (SelectableList.createAccessibilityImplementation != null)
            {
                SelectableList.createAccessibilityImplementation(this);
            };
        }

        protected function onPreChange(_arg_1:DataChangeEvent):void
        {
            switch (_arg_1.changeType)
            {
                case DataChangeType.REMOVE:
                case DataChangeType.ADD:
                case DataChangeType.INVALIDATE:
                case DataChangeType.REMOVE_ALL:
                case DataChangeType.REPLACE:
                case DataChangeType.INVALIDATE_ALL:
                    return;
                default:
                    this.preChangeItems = this.selectedItems;
            };
        }


    }
}//package fl.controls
