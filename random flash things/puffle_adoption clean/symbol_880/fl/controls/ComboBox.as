//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls
{
    import fl.core.UIComponent;
    import fl.managers.IFocusManagerComponent;
    import fl.data.SimpleCollectionItem;
    import fl.core.InvalidationType;
    import fl.data.DataProvider;
    import fl.events.DataChangeEvent;
    import flash.events.Event;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import fl.events.ListEvent;
    import flash.events.FocusEvent;
    import flash.text.TextFormat;
    import flash.geom.Point;
    import fl.events.ComponentEvent;
    import flash.display.DisplayObject;
    import fl.controls.listClasses.ICellRenderer;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;

    [Event(name="change", type="flash.events.Event")]
    [Event(name="itemRollOver", type="fl.events.ListEvent")]
    [Event(name="itemRollOut", type="fl.events.ListEvent")]
    [Event(name="close", type="flash.events.Event")]
    [Event(name="enter", type="fl.events.ComponentEvent")]
    [Event(name="open", type="flash.events.Event")]
    [Event(name="scroll", type="fl.events.ScrollEvent")]
    [Style(name="buttonWidth", type="Number", format="Length")]
    [Style(name="textPadding", type="Number", format="Length")]
    [Style(name="upSkin", type="Class")]
    [Style(name="overSkin", type="Class")]
    [Style(name="downSkin", type="Class")]
    [Style(name="disabledSkin", type="Class")]
    [Style(name="cellRenderer", type="Class")]
    [Style(name="contentPadding", type="Number", format="Length")]
    [Style(name="disabledAlpha", type="Class")]
    [Style(name="downArrowDisabledSkin", type="Class")]
    [Style(name="downArrowDownSkin", type="Class")]
    [Style(name="downArrowOverSkin", type="Class")]
    [Style(name="downArrowUpSkin", type="Class")]
    [Style(name="thumbDisabledSkin", type="Class")]
    [Style(name="thumbDownSkin", type="Class")]
    [Style(name="thumbOverSkin", type="Class")]
    [Style(name="thumbArrowUpSkin", type="Class")]
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
    [Style(name="embedFonts", type="Boolean")]
    public class ComboBox extends UIComponent implements IFocusManagerComponent 
    {

        private static var defaultStyles:Object = {
            "upSkin":"ComboBox_upSkin",
            "downSkin":"ComboBox_downSkin",
            "overSkin":"ComboBox_overSkin",
            "disabledSkin":"ComboBox_disabledSkin",
            "focusRectSkin":null,
            "focusRectPadding":null,
            "textFormat":null,
            "disabledTextFormat":null,
            "textPadding":3,
            "buttonWidth":24,
            "disabledAlpha":null,
            "listSkin":null
        };
        protected static const LIST_STYLES:Object = {
            "upSkin":"comboListUpSkin",
            "overSkin":"comboListOverSkin",
            "downSkin":"comobListDownSkin",
            "disabledSkin":"comboListDisabledSkin",
            "downArrowDisabledSkin":"downArrowDisabledSkin",
            "downArrowDownSkin":"downArrowDownSkin",
            "downArrowOverSkin":"downArrowOverSkin",
            "downArrowUpSkin":"downArrowUpSkin",
            "upArrowDisabledSkin":"upArrowDisabledSkin",
            "upArrowDownSkin":"upArrowDownSkin",
            "upArrowOverSkin":"upArrowOverSkin",
            "upArrowUpSkin":"upArrowUpSkin",
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
            "repeatInterval":"repeatInterval",
            "textFormat":"textFormat",
            "disabledAlpha":"disabledAlpha",
            "skin":"listSkin"
        };
        protected static const BACKGROUND_STYLES:Object = {
            "overSkin":"overSkin",
            "downSkin":"downSkin",
            "upSkin":"upSkin",
            "disabledSkin":"disabledSkin",
            "repeatInterval":"repeatInterval"
        };
        public static var createAccessibilityImplementation:Function;

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


        public static function getStyleDefinition():Object
        {
            return (mergeStyles(defaultStyles, List.getStyleDefinition()));
        }


        [Inspectable(defaultValue="false")]
        public function get editable():Boolean
        {
            return (this._editable);
        }

        public function set editable(_arg_1:Boolean):void
        {
            this._editable = _arg_1;
            this.drawTextField();
        }

        [Inspectable(defaultValue="5")]
        public function get rowCount():uint
        {
            return (this._rowCount);
        }

        public function set rowCount(_arg_1:uint):void
        {
            this._rowCount = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        [Inspectable(verbose="1")]
        public function get restrict():String
        {
            return (this.inputField.restrict);
        }

        public function set restrict(_arg_1:String):void
        {
            if (((componentInspectorSetting) && (_arg_1 == "")))
            {
                _arg_1 = null;
            };
            if ((!(this._editable)))
            {
                return;
            };
            this.inputField.restrict = _arg_1;
        }

        public function get selectedIndex():int
        {
            return (this.list.selectedIndex);
        }

        public function set selectedIndex(_arg_1:int):void
        {
            this.list.selectedIndex = _arg_1;
            this.highlightCell();
            invalidate(InvalidationType.SELECTED);
        }

        public function get text():String
        {
            return (this.inputField.text);
        }

        public function set text(_arg_1:String):void
        {
            if ((!(this.editable)))
            {
                return;
            };
            this.inputField.text = _arg_1;
        }

        public function get labelField():String
        {
            return (this.list.labelField);
        }

        public function set labelField(_arg_1:String):void
        {
            this.list.labelField = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get labelFunction():Function
        {
            return (this.list.labelFunction);
        }

        public function set labelFunction(_arg_1:Function):void
        {
            this.list.labelFunction = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function itemToLabel(_arg_1:Object):String
        {
            if (_arg_1 == null)
            {
                return ("");
            };
            return (this.list.itemToLabel(_arg_1));
        }

        public function get selectedItem():Object
        {
            return (this.list.selectedItem);
        }

        public function set selectedItem(_arg_1:Object):void
        {
            this.list.selectedItem = _arg_1;
            invalidate(InvalidationType.SELECTED);
        }

        public function get dropdown():List
        {
            return (this.list);
        }

        public function get length():int
        {
            return (this.list.length);
        }

        public function get textField():TextInput
        {
            return (this.inputField);
        }

        public function get value():String
        {
            var _local_1:Object;
            if (this.editableValue != null)
            {
                return (this.editableValue);
            };
            _local_1 = this.selectedItem;
            if (((!(this._editable)) && (!(_local_1.data == null))))
            {
                return (_local_1.data);
            };
            return (this.itemToLabel(_local_1));
        }

        [Collection(collectionClass="fl.data.DataProvider", identifier="item", collectionItem="fl.data.SimpleCollectionItem")]
        public function get dataProvider():DataProvider
        {
            return (this.list.dataProvider);
        }

        public function set dataProvider(_arg_1:DataProvider):void
        {
            _arg_1.addEventListener(DataChangeEvent.DATA_CHANGE, this.handleDataChange, false, 0, true);
            this.list.dataProvider = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get dropdownWidth():Number
        {
            return (this.list.width);
        }

        public function set dropdownWidth(_arg_1:Number):void
        {
            this._dropdownWidth = _arg_1;
            invalidate(InvalidationType.SIZE);
        }

        public function addItem(_arg_1:Object):void
        {
            this.list.addItem(_arg_1);
            invalidate(InvalidationType.DATA);
        }

        [Inspectable(defaultValue="")]
        public function get prompt():String
        {
            return (this._prompt);
        }

        public function set prompt(_arg_1:String):void
        {
            if (_arg_1 == "")
            {
                this._prompt = null;
            }
            else
            {
                this._prompt = _arg_1;
            };
            invalidate(InvalidationType.STATE);
        }

        public function get imeMode():String
        {
            return (this.inputField.imeMode);
        }

        public function set imeMode(_arg_1:String):void
        {
            this.inputField.imeMode = _arg_1;
        }

        public function addItemAt(_arg_1:Object, _arg_2:uint):void
        {
            this.list.addItemAt(_arg_1, _arg_2);
            invalidate(InvalidationType.DATA);
        }

        public function removeAll():void
        {
            this.list.removeAll();
            this.inputField.text = "";
            invalidate(InvalidationType.DATA);
        }

        public function removeItem(_arg_1:Object):Object
        {
            return (this.list.removeItem(_arg_1));
        }

        public function removeItemAt(_arg_1:uint):void
        {
            this.list.removeItemAt(_arg_1);
            invalidate(InvalidationType.DATA);
        }

        public function getItemAt(_arg_1:uint):Object
        {
            return (this.list.getItemAt(_arg_1));
        }

        public function replaceItemAt(_arg_1:Object, _arg_2:uint):Object
        {
            return (this.list.replaceItemAt(_arg_1, _arg_2));
        }

        public function sortItems(... _args):*
        {
            return (this.list.sortItems.apply(this.list, _args));
        }

        public function sortItemsOn(_arg_1:String, _arg_2:Object=null):*
        {
            return (this.list.sortItemsOn(_arg_1, _arg_2));
        }

        public function open():void
        {
            this.currentIndex = this.selectedIndex;
            if (((this.isOpen) || (this.length == 0)))
            {
                return;
            };
            dispatchEvent(new Event(Event.OPEN));
            this.isOpen = true;
            addEventListener(Event.ENTER_FRAME, this.addCloseListener, false, 0, true);
            this.positionList();
            this.list.scrollToSelected();
            focusManager.form.addChild(this.list);
        }

        public function close():void
        {
            this.highlightCell();
            this.highlightedCell = -1;
            if ((!(this.isOpen)))
            {
                return;
            };
            dispatchEvent(new Event(Event.CLOSE));
            var _local_1:DisplayObjectContainer = focusManager.form;
            _local_1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageClick);
            this.isOpen = false;
            _local_1.removeChild(this.list);
        }

        public function get selectedLabel():String
        {
            if (this.editableValue != null)
            {
                return (this.editableValue);
            };
            if (this.selectedIndex == -1)
            {
                return (null);
            };
            return (this.itemToLabel(this.selectedItem));
        }

        override protected function configUI():void
        {
            super.configUI();
            this.background = new BaseButton();
            this.background.focusEnabled = false;
            copyStylesToChild(this.background, BACKGROUND_STYLES);
            this.background.addEventListener(MouseEvent.MOUSE_DOWN, this.onToggleListVisibility, false, 0, true);
            addChild(this.background);
            this.inputField = new TextInput();
            this.inputField.focusTarget = (this as IFocusManagerComponent);
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
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            super.focusInHandler(_arg_1);
            if (this.editable)
            {
                stage.focus = this.inputField.textField;
            };
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            this.isKeyDown = false;
            if (this.isOpen)
            {
                if (((!(_arg_1.relatedObject)) || (!(this.list.contains(_arg_1.relatedObject)))))
                {
                    if (((!(this.highlightedCell == -1)) && (!(this.highlightedCell == this.selectedIndex))))
                    {
                        this.selectedIndex = this.highlightedCell;
                        dispatchEvent(new Event(Event.CHANGE));
                    };
                    this.close();
                };
            };
            super.focusOutHandler(_arg_1);
        }

        protected function handleDataChange(_arg_1:DataChangeEvent):void
        {
            invalidate(InvalidationType.DATA);
        }

        override protected function draw():void
        {
            var _local_1:* = this.selectedIndex;
            if (((_local_1 == -1) && (((!(this.prompt == null)) || (this.editable)) || (this.length == 0))))
            {
                _local_1 = Math.max(-1, Math.min(_local_1, (this.length - 1)));
            }
            else
            {
                this.editableValue = null;
                _local_1 = Math.max(0, Math.min(_local_1, (this.length - 1)));
            };
            if (this.list.selectedIndex != _local_1)
            {
                this.list.selectedIndex = _local_1;
                invalidate(InvalidationType.SELECTED, false);
            };
            if (isInvalid(InvalidationType.STYLES))
            {
                this.setStyles();
                this.setEmbedFonts();
                invalidate(InvalidationType.SIZE, false);
            };
            if (isInvalid(InvalidationType.SIZE, InvalidationType.DATA, InvalidationType.STATE))
            {
                this.drawTextFormat();
                this.drawLayout();
                invalidate(InvalidationType.DATA);
            };
            if (isInvalid(InvalidationType.DATA))
            {
                this.drawList();
                invalidate(InvalidationType.SELECTED, true);
            };
            if (isInvalid(InvalidationType.SELECTED))
            {
                if (((_local_1 == -1) && (!(this.editableValue == null))))
                {
                    this.inputField.text = this.editableValue;
                }
                else
                {
                    if (_local_1 > -1)
                    {
                        if (this.length > 0)
                        {
                            this.inputField.horizontalScrollPosition = 0;
                            this.inputField.text = this.itemToLabel(this.list.selectedItem);
                        };
                    }
                    else
                    {
                        if (((_local_1 == -1) && (!(this._prompt == null))))
                        {
                            this.showPrompt();
                        }
                        else
                        {
                            this.inputField.text = "";
                        };
                    };
                };
                if ((((this.editable) && (this.selectedIndex > -1)) && (stage.focus == this.inputField.textField)))
                {
                    this.inputField.setSelection(0, this.inputField.length);
                };
            };
            this.drawTextField();
            super.draw();
        }

        protected function setEmbedFonts():void
        {
            var _local_1:Object = getStyleValue("embedFonts");
            if (_local_1 != null)
            {
                this.inputField.textField.embedFonts = _local_1;
            };
        }

        protected function showPrompt():void
        {
            this.inputField.text = this._prompt;
        }

        protected function setStyles():void
        {
            copyStylesToChild(this.background, BACKGROUND_STYLES);
            copyStylesToChild(this.list, LIST_STYLES);
        }

        protected function drawLayout():void
        {
            var _local_1:Number = (getStyleValue("buttonWidth") as Number);
            var _local_2:Number = (getStyleValue("textPadding") as Number);
            this.background.setSize(width, height);
            this.inputField.x = (this.inputField.y = _local_2);
            this.inputField.setSize(((width - _local_1) - _local_2), (height - _local_2));
            this.list.width = ((isNaN(this._dropdownWidth)) ? width : this._dropdownWidth);
            this.background.enabled = enabled;
            this.background.drawNow();
        }

        protected function drawTextFormat():void
        {
            var _local_1:TextFormat = (getStyleValue(((_enabled) ? "textFormat" : "disabledTextFormat")) as TextFormat);
            if (_local_1 == null)
            {
                _local_1 = new TextFormat();
            };
            this.inputField.textField.defaultTextFormat = _local_1;
            this.inputField.textField.setTextFormat(_local_1);
            this.setEmbedFonts();
        }

        protected function drawList():void
        {
            this.list.rowCount = Math.max(0, Math.min(this._rowCount, this.list.dataProvider.length));
        }

        protected function positionList():void
        {
            var myForm:DisplayObjectContainer;
            var theStageHeight:Number;
            var p:Point = localToGlobal(new Point(0, 0));
            myForm = focusManager.form;
            p = myForm.globalToLocal(p);
            this.list.x = p.x;
            try
            {
                theStageHeight = stage.stageHeight;
            }
            catch(se:SecurityError)
            {
                theStageHeight = myForm.height;
            };
            if (((p.y + height) + this.list.height) > theStageHeight)
            {
                this.list.y = (p.y - this.list.height);
            }
            else
            {
                this.list.y = (p.y + height);
            };
        }

        protected function drawTextField():void
        {
            this.inputField.setStyle("upSkin", "");
            this.inputField.setStyle("disabledSkin", "");
            this.inputField.enabled = enabled;
            this.inputField.editable = this._editable;
            this.inputField.textField.selectable = ((enabled) && (this._editable));
            this.inputField.mouseEnabled = (this.inputField.mouseChildren = ((enabled) && (this._editable)));
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
            };
        }

        protected function onInputFieldFocus(_arg_1:FocusEvent):void
        {
            this.inputField.addEventListener(ComponentEvent.ENTER, this.onEnter, false, 0, true);
            this.close();
        }

        protected function onInputFieldFocusOut(_arg_1:FocusEvent):void
        {
            this.inputField.removeEventListener(ComponentEvent.ENTER, this.onEnter);
            this.selectedIndex = this.selectedIndex;
        }

        protected function onEnter(_arg_1:ComponentEvent):void
        {
            _arg_1.stopPropagation();
        }

        protected function onToggleListVisibility(_arg_1:MouseEvent):void
        {
            _arg_1.stopPropagation();
            dispatchEvent(_arg_1);
            if (this.isOpen)
            {
                this.close();
            }
            else
            {
                this.open();
                focusManager.form.addEventListener(MouseEvent.MOUSE_UP, this.onListItemUp, false, 0, true);
            };
        }

        protected function onListItemUp(_arg_1:MouseEvent):void
        {
            focusManager.form.removeEventListener(MouseEvent.MOUSE_UP, this.onListItemUp);
            if (((!(_arg_1.target is ICellRenderer)) || (!(this.list.contains((_arg_1.target as DisplayObject))))))
            {
                return;
            };
            this.editableValue = null;
            var _local_2:* = this.selectedIndex;
            this.selectedIndex = _arg_1.target.listData.index;
            if (_local_2 != this.selectedIndex)
            {
                dispatchEvent(new Event(Event.CHANGE));
            };
            this.close();
        }

        protected function onListChange(_arg_1:Event):void
        {
            this.editableValue = null;
            dispatchEvent(_arg_1);
            invalidate(InvalidationType.SELECTED);
            if (this.isKeyDown)
            {
                return;
            };
            this.close();
        }

        protected function onStageClick(_arg_1:MouseEvent):void
        {
            if ((!(this.isOpen)))
            {
                return;
            };
            if (((!(contains((_arg_1.target as DisplayObject)))) && (!(this.list.contains((_arg_1.target as DisplayObject))))))
            {
                if (this.highlightedCell != -1)
                {
                    this.selectedIndex = this.highlightedCell;
                    dispatchEvent(new Event(Event.CHANGE));
                };
                this.close();
            };
        }

        protected function passEvent(_arg_1:Event):void
        {
            dispatchEvent(_arg_1);
        }

        private function addCloseListener(_arg_1:Event):*
        {
            removeEventListener(Event.ENTER_FRAME, this.addCloseListener);
            if ((!(this.isOpen)))
            {
                return;
            };
            focusManager.form.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageClick, false, 0, true);
        }

        protected function onTextInput(_arg_1:Event):void
        {
            _arg_1.stopPropagation();
            if ((!(this._editable)))
            {
                return;
            };
            this.editableValue = this.inputField.text;
            this.selectedIndex = -1;
            dispatchEvent(new Event(Event.CHANGE));
        }

        protected function calculateAvailableHeight():Number
        {
            var _local_1:Number = Number(getStyleValue("contentPadding"));
            return (this.list.height - (_local_1 * 2));
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            this.isKeyDown = true;
            if (_arg_1.ctrlKey)
            {
                switch (_arg_1.keyCode)
                {
                    case Keyboard.UP:
                        if (this.highlightedCell > -1)
                        {
                            this.selectedIndex = this.highlightedCell;
                            dispatchEvent(new Event(Event.CHANGE));
                        };
                        this.close();
                        return;
                    case Keyboard.DOWN:
                        this.open();
                        return;
                };
                return;
            };
            _arg_1.stopPropagation();
            var _local_2:int = int(Math.max(((this.calculateAvailableHeight() / this.list.rowHeight) << 0), 1));
            var _local_3:uint = this.selectedIndex;
            var _local_4:Number = ((this.highlightedCell == -1) ? this.selectedIndex : this.highlightedCell);
            var _local_5:int = -1;
            switch (_arg_1.keyCode)
            {
                case Keyboard.SPACE:
                    if (this.isOpen)
                    {
                        this.close();
                    }
                    else
                    {
                        this.open();
                    };
                    return;
                case Keyboard.ESCAPE:
                    if (this.isOpen)
                    {
                        if (this.highlightedCell > -1)
                        {
                            this.selectedIndex = this.selectedIndex;
                        };
                        this.close();
                    };
                    return;
                case Keyboard.UP:
                    _local_5 = Math.max(0, (_local_4 - 1));
                    break;
                case Keyboard.DOWN:
                    _local_5 = Math.min((this.length - 1), (_local_4 + 1));
                    break;
                case Keyboard.PAGE_UP:
                    _local_5 = Math.max((_local_4 - _local_2), 0);
                    break;
                case Keyboard.PAGE_DOWN:
                    _local_5 = Math.min((_local_4 + _local_2), (this.length - 1));
                    break;
                case Keyboard.HOME:
                    _local_5 = 0;
                    break;
                case Keyboard.END:
                    _local_5 = (this.length - 1);
                    break;
                case Keyboard.ENTER:
                    if (((this._editable) && (this.highlightedCell == -1)))
                    {
                        this.editableValue = this.inputField.text;
                        this.selectedIndex = -1;
                    }
                    else
                    {
                        if (((this.isOpen) && (this.highlightedCell > -1)))
                        {
                            this.editableValue = null;
                            this.selectedIndex = this.highlightedCell;
                            dispatchEvent(new Event(Event.CHANGE));
                        };
                    };
                    dispatchEvent(new ComponentEvent(ComponentEvent.ENTER));
                    this.close();
                    return;
                default:
                    if (this.editable) break;
                    _local_5 = this.list.getNextIndexAtLetter(String.fromCharCode(_arg_1.keyCode), _local_4);
            };
            if (_local_5 > -1)
            {
                if (this.isOpen)
                {
                    this.highlightCell(_local_5);
                    this.inputField.text = this.list.itemToLabel(this.getItemAt(_local_5));
                }
                else
                {
                    this.highlightCell();
                    this.selectedIndex = _local_5;
                    dispatchEvent(new Event(Event.CHANGE));
                };
            };
        }

        protected function highlightCell(_arg_1:int=-1):void
        {
            var _local_2:ICellRenderer;
            if (this.highlightedCell > -1)
            {
                _local_2 = this.list.itemToCellRenderer(this.getItemAt(this.highlightedCell));
                if (_local_2 != null)
                {
                    _local_2.setMouseState("up");
                };
            };
            if (_arg_1 == -1)
            {
                return;
            };
            this.list.scrollToIndex(_arg_1);
            this.list.drawNow();
            _local_2 = this.list.itemToCellRenderer(this.getItemAt(_arg_1));
            if (_local_2 != null)
            {
                _local_2.setMouseState("over");
                this.highlightedCell = _arg_1;
            };
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            this.isKeyDown = false;
        }

        override protected function initializeAccessibility():void
        {
            if (ComboBox.createAccessibilityImplementation != null)
            {
                ComboBox.createAccessibilityImplementation(this);
            };
        }


    }
}//package fl.controls
