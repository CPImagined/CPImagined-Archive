package fl.controls
{
    import fl.containers.*;
    import fl.controls.listClasses.*;
    import fl.core.*;
    import fl.data.*;
    import fl.events.*;
    import fl.managers.*;
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;

    public class SelectableList extends BaseScrollPane implements IFocusManagerComponent
    {
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
        private static var defaultStyles:Object = {skin:"List_skin", cellRenderer:CellRenderer, contentPadding:null, disabledAlpha:null};
        public static var createAccessibilityImplementation:Function;

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
            }
            verticalScrollPolicy = ScrollPolicy.AUTO;
            this.rendererStyles = {};
            this.updatedRendererStyles = {};
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.list.mouseChildren = _enabled;
            return;
        }// end function

        public function get dataProvider() : DataProvider
        {
            return this._dataProvider;
        }// end function

        public function set dataProvider(param1:DataProvider) : void
        {
            if (this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, this.handleDataChange);
                this._dataProvider.removeEventListener(DataChangeEvent.PRE_DATA_CHANGE, this.onPreChange);
            }
            this._dataProvider = param1;
            this._dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, this.handleDataChange, false, 0, true);
            this._dataProvider.addEventListener(DataChangeEvent.PRE_DATA_CHANGE, this.onPreChange, false, 0, true);
            this.clearSelection();
            this.invalidateList();
            return;
        }// end function

        override public function get maxHorizontalScrollPosition() : Number
        {
            return _maxHorizontalScrollPosition;
        }// end function

        public function set maxHorizontalScrollPosition(param1:Number) : void
        {
            _maxHorizontalScrollPosition = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function get length() : uint
        {
            return this._dataProvider.length;
        }// end function

        public function get allowMultipleSelection() : Boolean
        {
            return this._allowMultipleSelection;
        }// end function

        public function set allowMultipleSelection(param1:Boolean) : void
        {
            if (param1 == this._allowMultipleSelection)
            {
                return;
            }
            this._allowMultipleSelection = param1;
            if (!param1 && this._selectedIndices.length > 1)
            {
                this._selectedIndices = [this._selectedIndices.pop()];
                invalidate(InvalidationType.DATA);
            }
            return;
        }// end function

        public function get selectable() : Boolean
        {
            return this._selectable;
        }// end function

        public function set selectable(param1:Boolean) : void
        {
            if (param1 == this._selectable)
            {
                return;
            }
            if (!param1)
            {
                this.selectedIndices = [];
            }
            this._selectable = param1;
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this._selectedIndices.length == 0 ? (-1) : (this._selectedIndices[(this._selectedIndices.length - 1)]);
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            this.selectedIndices = param1 == -1 ? (null) : ([param1]);
            return;
        }// end function

        public function get selectedIndices() : Array
        {
            return this._selectedIndices.concat();
        }// end function

        public function set selectedIndices(param1:Array) : void
        {
            if (!this._selectable)
            {
                return;
            }
            this._selectedIndices = param1 == null ? ([]) : (param1.concat());
            invalidate(InvalidationType.SELECTED);
            return;
        }// end function

        public function get selectedItem() : Object
        {
            return this._selectedIndices.length == 0 ? (null) : (this._dataProvider.getItemAt(this.selectedIndex));
        }// end function

        public function set selectedItem(param1:Object) : void
        {
            var _loc_2:* = this._dataProvider.getItemIndex(param1);
            this.selectedIndex = _loc_2;
            return;
        }// end function

        public function get selectedItems() : Array
        {
            var _loc_1:* = [];
            var _loc_2:* = 0;
            while (_loc_2 < this._selectedIndices.length)
            {
                
                _loc_1.push(this._dataProvider.getItemAt(this._selectedIndices[_loc_2]));
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        public function set selectedItems(param1:Array) : void
        {
            var _loc_4:* = 0;
            if (param1 == null)
            {
                this.selectedIndices = null;
                return;
            }
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = this._dataProvider.getItemIndex(param1[_loc_3]);
                if (_loc_4 != -1)
                {
                    _loc_2.push(_loc_4);
                }
                _loc_3 = _loc_3 + 1;
            }
            this.selectedIndices = _loc_2;
            return;
        }// end function

        public function get rowCount() : uint
        {
            return 0;
        }// end function

        public function clearSelection() : void
        {
            this.selectedIndex = -1;
            return;
        }// end function

        public function itemToCellRenderer(param1:Object) : ICellRenderer
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            if (param1 != null)
            {
                for (_loc_2 in this.activeCellRenderers)
                {
                    
                    _loc_3 = _loc_5[_loc_2] as ICellRenderer;
                    if (_loc_3.data == param1)
                    {
                        return _loc_3;
                    }
                }
            }
            return null;
        }// end function

        public function addItem(param1:Object) : void
        {
            this._dataProvider.addItem(param1);
            this.invalidateList();
            return;
        }// end function

        public function addItemAt(param1:Object, param2:uint) : void
        {
            this._dataProvider.addItemAt(param1, param2);
            this.invalidateList();
            return;
        }// end function

        public function removeAll() : void
        {
            this._dataProvider.removeAll();
            return;
        }// end function

        public function getItemAt(param1:uint) : Object
        {
            return this._dataProvider.getItemAt(param1);
        }// end function

        public function removeItem(param1:Object) : Object
        {
            return this._dataProvider.removeItem(param1);
        }// end function

        public function removeItemAt(param1:uint) : Object
        {
            return this._dataProvider.removeItemAt(param1);
        }// end function

        public function replaceItemAt(param1:Object, param2:uint) : Object
        {
            return this._dataProvider.replaceItemAt(param1, param2);
        }// end function

        public function invalidateList() : void
        {
            this._invalidateList();
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function invalidateItem(param1:Object) : void
        {
            if (this.renderedItems[param1] == null)
            {
                return;
            }
            this.invalidItems[param1] = true;
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function invalidateItemAt(param1:uint) : void
        {
            var _loc_2:* = this._dataProvider.getItemAt(param1);
            if (_loc_2 != null)
            {
                this.invalidateItem(_loc_2);
            }
            return;
        }// end function

        public function sortItems(... args)
        {
            return this._dataProvider.sort.apply(this._dataProvider, args);
        }// end function

        public function sortItemsOn(param1:String, param2:Object = null)
        {
            return this._dataProvider.sortOn(param1, param2);
        }// end function

        public function isItemSelected(param1:Object) : Boolean
        {
            return this.selectedItems.indexOf(param1) > -1;
        }// end function

        public function scrollToSelected() : void
        {
            this.scrollToIndex(this.selectedIndex);
            return;
        }// end function

        public function scrollToIndex(param1:int) : void
        {
            return;
        }// end function

        public function getNextIndexAtLetter(param1:String, param2:int = -1) : int
        {
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this.length == 0)
            {
                return -1;
            }
            param1 = param1.toUpperCase();
            var _loc_3:* = this.length - 1;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = (param2 + 1) + _loc_4;
                if (_loc_5 > (this.length - 1))
                {
                    _loc_5 = _loc_5 - this.length;
                }
                _loc_6 = this.getItemAt(_loc_5);
                if (_loc_6 == null)
                {
                    break;
                }
                _loc_7 = this.itemToLabel(_loc_6);
                if (_loc_7 == null)
                {
                }
                else if (_loc_7.charAt(0).toUpperCase() == param1)
                {
                    return _loc_5;
                }
                _loc_4 = _loc_4 + 1;
            }
            return -1;
        }// end function

        public function itemToLabel(param1:Object) : String
        {
            return param1["label"];
        }// end function

        public function setRendererStyle(param1:String, param2:Object, param3:uint = 0) : void
        {
            if (this.rendererStyles[param1] == param2)
            {
                return;
            }
            this.updatedRendererStyles[param1] = param2;
            this.rendererStyles[param1] = param2;
            invalidate(InvalidationType.RENDERER_STYLES);
            return;
        }// end function

        public function getRendererStyle(param1:String, param2:int = -1) : Object
        {
            return this.rendererStyles[param1];
        }// end function

        public function clearRendererStyle(param1:String, param2:int = -1) : void
        {
            delete this.rendererStyles[param1];
            this.updatedRendererStyles[param1] = null;
            invalidate(InvalidationType.RENDERER_STYLES);
            return;
        }// end function

        override protected function configUI() : void
        {
            super.configUI();
            this.listHolder = new Sprite();
            addChild(this.listHolder);
            this.listHolder.scrollRect = contentScrollRect;
            this.list = new Sprite();
            this.listHolder.addChild(this.list);
            return;
        }// end function

        protected function _invalidateList() : void
        {
            this.availableCellRenderers = [];
            while (this.activeCellRenderers.length > 0)
            {
                
                this.list.removeChild(this.activeCellRenderers.pop() as DisplayObject);
            }
            return;
        }// end function

        protected function handleDataChange(event:DataChangeEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = event.startIndex;
            var _loc_3:* = event.endIndex;
            var _loc_4:* = event.changeType;
            if (event.changeType == DataChangeType.INVALIDATE_ALL)
            {
                this.clearSelection();
                this.invalidateList();
            }
            else if (_loc_4 == DataChangeType.INVALIDATE)
            {
                _loc_5 = 0;
                while (_loc_5 < event.items.length)
                {
                    
                    this.invalidateItem(event.items[_loc_5]);
                    _loc_5 = _loc_5 + 1;
                }
            }
            else if (_loc_4 == DataChangeType.ADD)
            {
                _loc_5 = 0;
                while (_loc_5 < this._selectedIndices.length)
                {
                    
                    if (this._selectedIndices[_loc_5] >= _loc_2)
                    {
                        this._selectedIndices[_loc_5] = this._selectedIndices[_loc_5] + (_loc_2 - _loc_3);
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            else if (_loc_4 == DataChangeType.REMOVE)
            {
                _loc_5 = 0;
                while (_loc_5 < this._selectedIndices.length)
                {
                    
                    if (this._selectedIndices[_loc_5] >= _loc_2)
                    {
                        if (this._selectedIndices[_loc_5] <= _loc_3)
                        {
                            delete this._selectedIndices[_loc_5];
                        }
                        else
                        {
                            this._selectedIndices[_loc_5] = this._selectedIndices[_loc_5] - (_loc_2 - _loc_3 + 1);
                        }
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            else if (_loc_4 == DataChangeType.REMOVE_ALL)
            {
                this.clearSelection();
            }
            else if (_loc_4 == DataChangeType.REPLACE)
            {
            }
            else
            {
                this.selectedItems = this.preChangeItems;
                this.preChangeItems = null;
            }
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        protected function handleCellRendererMouseEvent(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as ICellRenderer;
            var _loc_3:* = event.type == MouseEvent.ROLL_OVER ? (ListEvent.ITEM_ROLL_OVER) : (ListEvent.ITEM_ROLL_OUT);
            dispatchEvent(new ListEvent(_loc_3, false, false, _loc_2.listData.column, _loc_2.listData.row, _loc_2.listData.index, _loc_2.data));
            return;
        }// end function

        protected function handleCellRendererClick(event:MouseEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (!_enabled)
            {
                return;
            }
            var _loc_2:* = event.currentTarget as ICellRenderer;
            var _loc_3:* = _loc_2.listData.index;
            if (!dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK, false, true, _loc_2.listData.column, _loc_2.listData.row, _loc_3, _loc_2.data)) || !this._selectable)
            {
                return;
            }
            var _loc_4:* = this.selectedIndices.indexOf(_loc_3);
            if (!this._allowMultipleSelection)
            {
                if (_loc_4 != -1)
                {
                    return;
                }
                _loc_2.selected = true;
                this._selectedIndices = [_loc_3];
                var _loc_7:* = _loc_3;
                this.caretIndex = _loc_3;
                this.lastCaretIndex = _loc_7;
            }
            else if (event.shiftKey)
            {
                _loc_6 = this._selectedIndices.length > 0 ? (this._selectedIndices[0]) : (_loc_3);
                this._selectedIndices = [];
                if (_loc_6 > _loc_3)
                {
                    _loc_5 = _loc_6;
                    while (_loc_5 >= _loc_3)
                    {
                        
                        this._selectedIndices.push(_loc_5);
                        _loc_5 = _loc_5 - 1;
                    }
                }
                else
                {
                    _loc_5 = _loc_6;
                    while (_loc_5 <= _loc_3)
                    {
                        
                        this._selectedIndices.push(_loc_5);
                        _loc_5++;
                    }
                }
                this.caretIndex = _loc_3;
            }
            else if (event.ctrlKey)
            {
                if (_loc_4 != -1)
                {
                    _loc_2.selected = false;
                    this._selectedIndices.splice(_loc_4, 1);
                }
                else
                {
                    _loc_2.selected = true;
                    this._selectedIndices.push(_loc_3);
                }
                this.caretIndex = _loc_3;
            }
            else
            {
                this._selectedIndices = [_loc_3];
                var _loc_7:* = _loc_3;
                this.caretIndex = _loc_3;
                this.lastCaretIndex = _loc_7;
            }
            dispatchEvent(new Event(Event.CHANGE));
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        protected function handleCellRendererChange(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as ICellRenderer;
            var _loc_3:* = _loc_2.listData.index;
            this._dataProvider.invalidateItemAt(_loc_3);
            return;
        }// end function

        protected function handleCellRendererDoubleClick(event:MouseEvent) : void
        {
            if (!_enabled)
            {
                return;
            }
            var _loc_2:* = event.currentTarget as ICellRenderer;
            var _loc_3:* = _loc_2.listData.index;
            dispatchEvent(new ListEvent(ListEvent.ITEM_DOUBLE_CLICK, false, true, _loc_2.listData.column, _loc_2.listData.row, _loc_3, _loc_2.data));
            return;
        }// end function

        override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void
        {
            if (param1 == this._horizontalScrollPosition)
            {
                return;
            }
            var _loc_3:* = param1 - this._horizontalScrollPosition;
            this._horizontalScrollPosition = param1;
            if (param2)
            {
                dispatchEvent(new ScrollEvent(ScrollBarDirection.HORIZONTAL, _loc_3, param1));
            }
            return;
        }// end function

        override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void
        {
            if (param1 == this._verticalScrollPosition)
            {
                return;
            }
            var _loc_3:* = param1 - this._verticalScrollPosition;
            this._verticalScrollPosition = param1;
            if (param2)
            {
                dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL, _loc_3, param1));
            }
            return;
        }// end function

        override protected function draw() : void
        {
            super.draw();
            return;
        }// end function

        override protected function drawLayout() : void
        {
            super.drawLayout();
            contentScrollRect = this.listHolder.scrollRect;
            contentScrollRect.width = availableWidth;
            contentScrollRect.height = availableHeight;
            this.listHolder.scrollRect = contentScrollRect;
            return;
        }// end function

        protected function updateRendererStyles() : void
        {
            var _loc_4:* = null;
            var _loc_1:* = this.availableCellRenderers.concat(this.activeCellRenderers);
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (_loc_1[_loc_3].setStyle == null)
                {
                }
                else
                {
                    for (_loc_4 in this.updatedRendererStyles)
                    {
                        
                        _loc_1[_loc_3].setStyle(_loc_4, _loc_6[_loc_4]);
                    }
                    _loc_1[_loc_3].drawNow();
                }
                _loc_3 = _loc_3 + 1;
            }
            this.updatedRendererStyles = {};
            return;
        }// end function

        protected function drawList() : void
        {
            return;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!this.selectable)
            {
                return;
            }
            switch(event.keyCode)
            {
                case Keyboard.UP:
                case Keyboard.DOWN:
                case Keyboard.END:
                case Keyboard.HOME:
                case Keyboard.PAGE_UP:
                case Keyboard.PAGE_DOWN:
                {
                    this.moveSelectionVertically(event.keyCode, event.shiftKey && this._allowMultipleSelection, event.ctrlKey && this._allowMultipleSelection);
                    event.stopPropagation();
                    break;
                }
                case Keyboard.LEFT:
                case Keyboard.RIGHT:
                {
                    this.moveSelectionHorizontally(event.keyCode, event.shiftKey && this._allowMultipleSelection, event.ctrlKey && this._allowMultipleSelection);
                    event.stopPropagation();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void
        {
            return;
        }// end function

        protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void
        {
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (SelectableList.createAccessibilityImplementation != null)
            {
                SelectableList.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        protected function onPreChange(event:DataChangeEvent) : void
        {
            switch(event.changeType)
            {
                case DataChangeType.REMOVE:
                case DataChangeType.ADD:
                case DataChangeType.INVALIDATE:
                case DataChangeType.REMOVE_ALL:
                case DataChangeType.REPLACE:
                case DataChangeType.INVALIDATE_ALL:
                {
                    break;
                }
                default:
                {
                    this.preChangeItems = this.selectedItems;
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return mergeStyles(defaultStyles, BaseScrollPane.getStyleDefinition());
        }// end function

    }
}
