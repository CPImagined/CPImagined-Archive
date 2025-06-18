package fl.controls
{
    import fl.controls.listClasses.*;
    import fl.core.*;
    import fl.data.*;
    import fl.events.*;
    import fl.managers.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;

    public class ComboBox extends UIComponent implements IFocusManagerComponent
    {
        protected var inputField:TextInput;
        protected var background:BaseButton;
        protected var list:List;
        protected var _rowCount:uint = 5;
        protected var _editable:Boolean = false;
        protected var isOpen:Boolean = false;
        protected var highlightedCell:int = -1;
        protected var editableValue:String;
        protected var _prompt:String;
        protected var isKeyDown:Boolean = false;
        protected var currentIndex:int;
        protected var listOverIndex:uint;
        protected var _dropdownWidth:Number;
        protected var _labels:Array;
        private var collectionItemImport:SimpleCollectionItem;
        private static var defaultStyles:Object = {upSkin:"ComboBox_upSkin", downSkin:"ComboBox_downSkin", overSkin:"ComboBox_overSkin", disabledSkin:"ComboBox_disabledSkin", focusRectSkin:null, focusRectPadding:null, textFormat:null, disabledTextFormat:null, textPadding:3, buttonWidth:24, disabledAlpha:null, listSkin:null};
        static const LIST_STYLES:Object = {upSkin:"comboListUpSkin", overSkin:"comboListOverSkin", downSkin:"comobListDownSkin", disabledSkin:"comboListDisabledSkin", downArrowDisabledSkin:"downArrowDisabledSkin", downArrowDownSkin:"downArrowDownSkin", downArrowOverSkin:"downArrowOverSkin", downArrowUpSkin:"downArrowUpSkin", upArrowDisabledSkin:"upArrowDisabledSkin", upArrowDownSkin:"upArrowDownSkin", upArrowOverSkin:"upArrowOverSkin", upArrowUpSkin:"upArrowUpSkin", thumbDisabledSkin:"thumbDisabledSkin", thumbDownSkin:"thumbDownSkin", thumbOverSkin:"thumbOverSkin", thumbUpSkin:"thumbUpSkin", thumbIcon:"thumbIcon", trackDisabledSkin:"trackDisabledSkin", trackDownSkin:"trackDownSkin", trackOverSkin:"trackOverSkin", trackUpSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval", textFormat:"textFormat", disabledAlpha:"disabledAlpha", skin:"listSkin"};
        static const BACKGROUND_STYLES:Object = {overSkin:"overSkin", downSkin:"downSkin", upSkin:"upSkin", disabledSkin:"disabledSkin", repeatInterval:"repeatInterval"};
        public static var createAccessibilityImplementation:Function;

        public function ComboBox()
        {
            return;
        }// end function

        public function get editable() : Boolean
        {
            return this._editable;
        }// end function

        public function set editable(param1:Boolean) : void
        {
            this._editable = param1;
            this.drawTextField();
            return;
        }// end function

        public function get rowCount() : uint
        {
            return this._rowCount;
        }// end function

        public function set rowCount(param1:uint) : void
        {
            this._rowCount = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function get restrict() : String
        {
            return this.inputField.restrict;
        }// end function

        public function set restrict(param1:String) : void
        {
            if (componentInspectorSetting && param1 == "")
            {
                param1 = null;
            }
            if (!this._editable)
            {
                return;
            }
            this.inputField.restrict = param1;
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this.list.selectedIndex;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            this.list.selectedIndex = param1;
            this.highlightCell();
            invalidate(InvalidationType.SELECTED);
            return;
        }// end function

        public function get text() : String
        {
            return this.inputField.text;
        }// end function

        public function set text(param1:String) : void
        {
            if (!this.editable)
            {
                return;
            }
            this.inputField.text = param1;
            return;
        }// end function

        public function get labelField() : String
        {
            return this.list.labelField;
        }// end function

        public function set labelField(param1:String) : void
        {
            this.list.labelField = param1;
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function get labelFunction() : Function
        {
            return this.list.labelFunction;
        }// end function

        public function set labelFunction(param1:Function) : void
        {
            this.list.labelFunction = param1;
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function itemToLabel(param1:Object) : String
        {
            if (param1 == null)
            {
                return "";
            }
            return this.list.itemToLabel(param1);
        }// end function

        public function get selectedItem() : Object
        {
            return this.list.selectedItem;
        }// end function

        public function set selectedItem(param1:Object) : void
        {
            this.list.selectedItem = param1;
            invalidate(InvalidationType.SELECTED);
            return;
        }// end function

        public function get dropdown() : List
        {
            return this.list;
        }// end function

        public function get length() : int
        {
            return this.list.length;
        }// end function

        public function get textField() : TextInput
        {
            return this.inputField;
        }// end function

        public function get value() : String
        {
            var _loc_1:* = null;
            if (this.editableValue != null)
            {
                return this.editableValue;
            }
            _loc_1 = this.selectedItem;
            if (!this._editable && _loc_1.data != null)
            {
                return _loc_1.data;
            }
            return this.itemToLabel(_loc_1);
        }// end function

        public function get dataProvider() : DataProvider
        {
            return this.list.dataProvider;
        }// end function

        public function set dataProvider(param1:DataProvider) : void
        {
            param1.addEventListener(DataChangeEvent.DATA_CHANGE, this.handleDataChange, false, 0, true);
            this.list.dataProvider = param1;
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function get dropdownWidth() : Number
        {
            return this.list.width;
        }// end function

        public function set dropdownWidth(param1:Number) : void
        {
            this._dropdownWidth = param1;
            invalidate(InvalidationType.SIZE);
            return;
        }// end function

        public function addItem(param1:Object) : void
        {
            this.list.addItem(param1);
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function get prompt() : String
        {
            return this._prompt;
        }// end function

        public function set prompt(param1:String) : void
        {
            if (param1 == "")
            {
                this._prompt = null;
            }
            else
            {
                this._prompt = param1;
            }
            invalidate(InvalidationType.STATE);
            return;
        }// end function

        public function get imeMode() : String
        {
            return this.inputField.imeMode;
        }// end function

        public function set imeMode(param1:String) : void
        {
            this.inputField.imeMode = param1;
            return;
        }// end function

        public function addItemAt(param1:Object, param2:uint) : void
        {
            this.list.addItemAt(param1, param2);
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function removeAll() : void
        {
            this.list.removeAll();
            this.inputField.text = "";
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function removeItem(param1:Object) : Object
        {
            return this.list.removeItem(param1);
        }// end function

        public function removeItemAt(param1:uint) : void
        {
            this.list.removeItemAt(param1);
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        public function getItemAt(param1:uint) : Object
        {
            return this.list.getItemAt(param1);
        }// end function

        public function replaceItemAt(param1:Object, param2:uint) : Object
        {
            return this.list.replaceItemAt(param1, param2);
        }// end function

        public function sortItems(... args)
        {
            return this.list.sortItems.apply(this.list, args);
        }// end function

        public function sortItemsOn(param1:String, param2:Object = null)
        {
            return this.list.sortItemsOn(param1, param2);
        }// end function

        public function open() : void
        {
            this.currentIndex = this.selectedIndex;
            if (this.isOpen || this.length == 0)
            {
                return;
            }
            dispatchEvent(new Event(Event.OPEN));
            this.isOpen = true;
            addEventListener(Event.ENTER_FRAME, this.addCloseListener, false, 0, true);
            this.positionList();
            this.list.scrollToSelected();
            focusManager.form.addChild(this.list);
            return;
        }// end function

        public function close() : void
        {
            this.highlightCell();
            this.highlightedCell = -1;
            if (!this.isOpen)
            {
                return;
            }
            dispatchEvent(new Event(Event.CLOSE));
            var _loc_1:* = focusManager.form;
            _loc_1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageClick);
            this.isOpen = false;
            _loc_1.removeChild(this.list);
            return;
        }// end function

        public function get selectedLabel() : String
        {
            if (this.editableValue != null)
            {
                return this.editableValue;
            }
            if (this.selectedIndex == -1)
            {
                return null;
            }
            return this.itemToLabel(this.selectedItem);
        }// end function

        override protected function configUI() : void
        {
            super.configUI();
            this.background = new BaseButton();
            this.background.focusEnabled = false;
            copyStylesToChild(this.background, BACKGROUND_STYLES);
            this.background.addEventListener(MouseEvent.MOUSE_DOWN, this.onToggleListVisibility, false, 0, true);
            addChild(this.background);
            this.inputField = new TextInput();
            this.inputField.focusTarget = this as IFocusManagerComponent;
            this.inputField.focusEnabled = false;
            this.inputField.addEventListener(Event.CHANGE, this.onTextInput, false, 0, true);
            addChild(this.inputField);
            this.list = new List();
            this.list.focusEnabled = false;
            copyStylesToChild(this.list, LIST_STYLES);
            this.list.addEventListener(Event.CHANGE, this.onListChange, false, 0, true);
            this.list.addEventListener(ListEvent.ITEM_CLICK, this.onListChange, false, 0, true);
            this.list.addEventListener(ListEvent.ITEM_ROLL_OUT, this.passEvent, false, 0, true);
            this.list.addEventListener(ListEvent.ITEM_ROLL_OVER, this.passEvent, false, 0, true);
            this.list.verticalScrollBar.addEventListener(Event.SCROLL, this.passEvent, false, 0, true);
            return;
        }// end function

        override protected function focusInHandler(event:FocusEvent) : void
        {
            super.focusInHandler(event);
            if (this.editable)
            {
                stage.focus = this.inputField.textField;
            }
            return;
        }// end function

        override protected function focusOutHandler(event:FocusEvent) : void
        {
            this.isKeyDown = false;
            if (this.isOpen)
            {
                if (!event.relatedObject || !this.list.contains(event.relatedObject))
                {
                    if (this.highlightedCell != -1 && this.highlightedCell != this.selectedIndex)
                    {
                        this.selectedIndex = this.highlightedCell;
                        dispatchEvent(new Event(Event.CHANGE));
                    }
                    this.close();
                }
            }
            super.focusOutHandler(event);
            return;
        }// end function

        protected function handleDataChange(event:DataChangeEvent) : void
        {
            invalidate(InvalidationType.DATA);
            return;
        }// end function

        override protected function draw() : void
        {
            var _loc_1:* = this.selectedIndex;
            if (_loc_1 == -1 && (this.prompt != null || this.editable || this.length == 0))
            {
                _loc_1 = Math.max(-1, Math.min(_loc_1, (this.length - 1)));
            }
            else
            {
                this.editableValue = null;
                _loc_1 = Math.max(0, Math.min(_loc_1, (this.length - 1)));
            }
            if (this.list.selectedIndex != _loc_1)
            {
                this.list.selectedIndex = _loc_1;
                invalidate(InvalidationType.SELECTED, false);
            }
            if (isInvalid(InvalidationType.STYLES))
            {
                this.setStyles();
                this.setEmbedFonts();
                invalidate(InvalidationType.SIZE, false);
            }
            if (isInvalid(InvalidationType.SIZE, InvalidationType.DATA, InvalidationType.STATE))
            {
                this.drawTextFormat();
                this.drawLayout();
                invalidate(InvalidationType.DATA);
            }
            if (isInvalid(InvalidationType.DATA))
            {
                this.drawList();
                invalidate(InvalidationType.SELECTED, true);
            }
            if (isInvalid(InvalidationType.SELECTED))
            {
                if (_loc_1 == -1 && this.editableValue != null)
                {
                    this.inputField.text = this.editableValue;
                }
                else if (_loc_1 > -1)
                {
                    if (this.length > 0)
                    {
                        this.inputField.horizontalScrollPosition = 0;
                        this.inputField.text = this.itemToLabel(this.list.selectedItem);
                    }
                }
                else if (_loc_1 == -1 && this._prompt != null)
                {
                    this.showPrompt();
                }
                else
                {
                    this.inputField.text = "";
                }
                if (this.editable && this.selectedIndex > -1 && stage.focus == this.inputField.textField)
                {
                    this.inputField.setSelection(0, this.inputField.length);
                }
            }
            this.drawTextField();
            super.draw();
            return;
        }// end function

        protected function setEmbedFonts() : void
        {
            var _loc_1:* = getStyleValue("embedFonts");
            if (_loc_1 != null)
            {
                this.inputField.textField.embedFonts = _loc_1;
            }
            return;
        }// end function

        protected function showPrompt() : void
        {
            this.inputField.text = this._prompt;
            return;
        }// end function

        protected function setStyles() : void
        {
            copyStylesToChild(this.background, BACKGROUND_STYLES);
            copyStylesToChild(this.list, LIST_STYLES);
            return;
        }// end function

        protected function drawLayout() : void
        {
            var _loc_1:* = getStyleValue("buttonWidth") as Number;
            var _loc_2:* = getStyleValue("textPadding") as Number;
            this.background.setSize(width, height);
            var _loc_3:* = _loc_2;
            this.inputField.y = _loc_2;
            this.inputField.x = _loc_3;
            this.inputField.setSize(width - _loc_1 - _loc_2, height - _loc_2);
            this.list.width = isNaN(this._dropdownWidth) ? (width) : (this._dropdownWidth);
            this.background.enabled = enabled;
            this.background.drawNow();
            return;
        }// end function

        protected function drawTextFormat() : void
        {
            var _loc_1:* = getStyleValue(_enabled ? ("textFormat") : ("disabledTextFormat")) as TextFormat;
            if (_loc_1 == null)
            {
                _loc_1 = new TextFormat();
            }
            this.inputField.textField.defaultTextFormat = _loc_1;
            this.inputField.textField.setTextFormat(_loc_1);
            this.setEmbedFonts();
            return;
        }// end function

        protected function drawList() : void
        {
            this.list.rowCount = Math.max(0, Math.min(this._rowCount, this.list.dataProvider.length));
            return;
        }// end function

        protected function positionList() : void
        {
            var myForm:DisplayObjectContainer;
            var theStageHeight:Number;
            var p:* = localToGlobal(new Point(0, 0));
            myForm = focusManager.form;
            p = myForm.globalToLocal(p);
            this.list.x = p.x;
            try
            {
                theStageHeight = stage.stageHeight;
            }
            catch (se:SecurityError)
            {
                theStageHeight = myForm.height;
            }
            if (p.y + height + this.list.height > theStageHeight)
            {
                this.list.y = p.y - this.list.height;
            }
            else
            {
                this.list.y = p.y + height;
            }
            return;
        }// end function

        protected function drawTextField() : void
        {
            this.inputField.setStyle("upSkin", "");
            this.inputField.setStyle("disabledSkin", "");
            this.inputField.enabled = enabled;
            this.inputField.editable = this._editable;
            this.inputField.textField.selectable = enabled && this._editable;
            var _loc_1:* = enabled && this._editable;
            this.inputField.mouseChildren = enabled && this._editable;
            this.inputField.mouseEnabled = _loc_1;
            this.inputField.focusEnabled = false;
            if (this._editable)
            {
                this.inputField.addEventListener(FocusEvent.FOCUS_IN, this.onInputFieldFocus, false, 0, true);
                this.inputField.addEventListener(FocusEvent.FOCUS_OUT, this.onInputFieldFocusOut, false, 0, true);
            }
            else
            {
                this.inputField.removeEventListener(FocusEvent.FOCUS_IN, this.onInputFieldFocus);
                this.inputField.removeEventListener(FocusEvent.FOCUS_OUT, this.onInputFieldFocusOut);
            }
            return;
        }// end function

        protected function onInputFieldFocus(event:FocusEvent) : void
        {
            this.inputField.addEventListener(ComponentEvent.ENTER, this.onEnter, false, 0, true);
            this.close();
            return;
        }// end function

        protected function onInputFieldFocusOut(event:FocusEvent) : void
        {
            this.inputField.removeEventListener(ComponentEvent.ENTER, this.onEnter);
            this.selectedIndex = this.selectedIndex;
            return;
        }// end function

        protected function onEnter(event:ComponentEvent) : void
        {
            event.stopPropagation();
            return;
        }// end function

        protected function onToggleListVisibility(event:MouseEvent) : void
        {
            event.stopPropagation();
            dispatchEvent(event);
            if (this.isOpen)
            {
                this.close();
            }
            else
            {
                this.open();
                focusManager.form.addEventListener(MouseEvent.MOUSE_UP, this.onListItemUp, false, 0, true);
            }
            return;
        }// end function

        protected function onListItemUp(event:MouseEvent) : void
        {
            focusManager.form.removeEventListener(MouseEvent.MOUSE_UP, this.onListItemUp);
            if (!(event.target is ICellRenderer) || !this.list.contains(event.target as DisplayObject))
            {
                return;
            }
            this.editableValue = null;
            var _loc_2:* = this.selectedIndex;
            this.selectedIndex = event.target.listData.index;
            if (_loc_2 != this.selectedIndex)
            {
                dispatchEvent(new Event(Event.CHANGE));
            }
            this.close();
            return;
        }// end function

        protected function onListChange(event:Event) : void
        {
            this.editableValue = null;
            dispatchEvent(event);
            invalidate(InvalidationType.SELECTED);
            if (this.isKeyDown)
            {
                return;
            }
            this.close();
            return;
        }// end function

        protected function onStageClick(event:MouseEvent) : void
        {
            if (!this.isOpen)
            {
                return;
            }
            if (!contains(event.target as DisplayObject) && !this.list.contains(event.target as DisplayObject))
            {
                if (this.highlightedCell != -1)
                {
                    this.selectedIndex = this.highlightedCell;
                    dispatchEvent(new Event(Event.CHANGE));
                }
                this.close();
            }
            return;
        }// end function

        protected function passEvent(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function addCloseListener(event:Event)
        {
            removeEventListener(Event.ENTER_FRAME, this.addCloseListener);
            if (!this.isOpen)
            {
                return;
            }
            focusManager.form.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageClick, false, 0, true);
            return;
        }// end function

        protected function onTextInput(event:Event) : void
        {
            event.stopPropagation();
            if (!this._editable)
            {
                return;
            }
            this.editableValue = this.inputField.text;
            this.selectedIndex = -1;
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        protected function calculateAvailableHeight() : Number
        {
            var _loc_1:* = Number(getStyleValue("contentPadding"));
            return this.list.height - _loc_1 * 2;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            this.isKeyDown = true;
            if (event.ctrlKey)
            {
                switch(event.keyCode)
                {
                    case Keyboard.UP:
                    {
                        if (this.highlightedCell > -1)
                        {
                            this.selectedIndex = this.highlightedCell;
                            dispatchEvent(new Event(Event.CHANGE));
                        }
                        this.close();
                        break;
                    }
                    case Keyboard.DOWN:
                    {
                        this.open();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                return;
            }
            event.stopPropagation();
            var _loc_2:* = Math.max(this.calculateAvailableHeight() / this.list.rowHeight << 0, 1);
            var _loc_3:* = this.selectedIndex;
            var _loc_4:* = this.highlightedCell == -1 ? (this.selectedIndex) : (this.highlightedCell);
            var _loc_5:* = -1;
            switch(event.keyCode)
            {
                case Keyboard.SPACE:
                {
                    if (this.isOpen)
                    {
                        this.close();
                    }
                    else
                    {
                        this.open();
                    }
                    return;
                }
                case Keyboard.ESCAPE:
                {
                    if (this.isOpen)
                    {
                        if (this.highlightedCell > -1)
                        {
                            this.selectedIndex = this.selectedIndex;
                        }
                        this.close();
                    }
                    return;
                }
                case Keyboard.UP:
                {
                    _loc_5 = Math.max(0, (_loc_4 - 1));
                    break;
                }
                case Keyboard.DOWN:
                {
                    _loc_5 = Math.min((this.length - 1), (_loc_4 + 1));
                    break;
                }
                case Keyboard.PAGE_UP:
                {
                    _loc_5 = Math.max(_loc_4 - _loc_2, 0);
                    break;
                }
                case Keyboard.PAGE_DOWN:
                {
                    _loc_5 = Math.min(_loc_4 + _loc_2, (this.length - 1));
                    break;
                }
                case Keyboard.HOME:
                {
                    _loc_5 = 0;
                    break;
                }
                case Keyboard.END:
                {
                    _loc_5 = this.length - 1;
                    break;
                }
                case Keyboard.ENTER:
                {
                    if (this._editable && this.highlightedCell == -1)
                    {
                        this.editableValue = this.inputField.text;
                        this.selectedIndex = -1;
                    }
                    else if (this.isOpen && this.highlightedCell > -1)
                    {
                        this.editableValue = null;
                        this.selectedIndex = this.highlightedCell;
                        dispatchEvent(new Event(Event.CHANGE));
                    }
                    dispatchEvent(new ComponentEvent(ComponentEvent.ENTER));
                    this.close();
                    return;
                }
                default:
                {
                    if (this.editable)
                    {
                        break;
                    }
                    _loc_5 = this.list.getNextIndexAtLetter(String.fromCharCode(event.keyCode), _loc_4);
                    break;
                    break;
                }
            }
            if (_loc_5 > -1)
            {
                if (this.isOpen)
                {
                    this.highlightCell(_loc_5);
                    this.inputField.text = this.list.itemToLabel(this.getItemAt(_loc_5));
                }
                else
                {
                    this.highlightCell();
                    this.selectedIndex = _loc_5;
                    dispatchEvent(new Event(Event.CHANGE));
                }
            }
            return;
        }// end function

        protected function highlightCell(param1:int = -1) : void
        {
            var _loc_2:* = null;
            if (this.highlightedCell > -1)
            {
                _loc_2 = this.list.itemToCellRenderer(this.getItemAt(this.highlightedCell));
                if (_loc_2 != null)
                {
                    _loc_2.setMouseState("up");
                }
            }
            if (param1 == -1)
            {
                return;
            }
            this.list.scrollToIndex(param1);
            this.list.drawNow();
            _loc_2 = this.list.itemToCellRenderer(this.getItemAt(param1));
            if (_loc_2 != null)
            {
                _loc_2.setMouseState("over");
                this.highlightedCell = param1;
            }
            return;
        }// end function

        override protected function keyUpHandler(event:KeyboardEvent) : void
        {
            this.isKeyDown = false;
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (ComboBox.createAccessibilityImplementation != null)
            {
                ComboBox.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return mergeStyles(defaultStyles, List.getStyleDefinition());
        }// end function

    }
}
