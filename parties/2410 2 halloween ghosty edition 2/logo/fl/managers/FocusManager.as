//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.managers
{
    import flash.display.DisplayObjectContainer;
    import flash.utils.Dictionary;
    import flash.display.InteractiveObject;
    import fl.controls.Button;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.display.Stage;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import fl.core.UIComponent;
    import flash.text.TextFieldType;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.utils.*;

    public class FocusManager implements IFocusManager 
    {

        private var _form:DisplayObjectContainer;
        private var focusableObjects:Dictionary;
        private var focusableCandidates:Array;
        private var activated:Boolean = false;
        private var calculateCandidates:Boolean = true;
        private var lastFocus:InteractiveObject;
        private var _showFocusIndicator:Boolean = true;
        private var lastAction:String;
        private var defButton:Button;
        private var _defaultButton:Button;
        private var _defaultButtonEnabled:Boolean = true;

        public function FocusManager(_arg_1:DisplayObjectContainer)
        {
            this.focusableObjects = new Dictionary(true);
            if (_arg_1 != null)
            {
                this._form = _arg_1;
                this.activate();
            };
        }

        private function addedHandler(_arg_1:Event):void
        {
            var _local_2:DisplayObject = DisplayObject(_arg_1.target);
            if (_local_2.stage)
            {
                this.addFocusables(DisplayObject(_arg_1.target));
            };
        }

        private function removedHandler(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_4:InteractiveObject;
            var _local_3:DisplayObject = DisplayObject(_arg_1.target);
            if (((_local_3 is IFocusManagerComponent) && (this.focusableObjects[_local_3] == true)))
            {
                if (_local_3 == this.lastFocus)
                {
                    IFocusManagerComponent(this.lastFocus).drawFocus(false);
                    this.lastFocus = null;
                };
                _local_3.removeEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false);
                delete this.focusableObjects[_local_3];
                this.calculateCandidates = true;
            }
            else
            {
                if (((_local_3 is InteractiveObject) && (this.focusableObjects[_local_3] == true)))
                {
                    _local_4 = (_local_3 as InteractiveObject);
                    if (_local_4)
                    {
                        if (_local_4 == this.lastFocus)
                        {
                            this.lastFocus = null;
                        };
                        delete this.focusableObjects[_local_4];
                        this.calculateCandidates = true;
                    };
                    _local_3.addEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false, 0, true);
                };
            };
            this.removeFocusables(_local_3);
        }

        private function addFocusables(o:DisplayObject, skipTopLevel:Boolean=false):void
        {
            var focusable:IFocusManagerComponent;
            var io:InteractiveObject;
            var doc:DisplayObjectContainer;
            var docParent:DisplayObjectContainer;
            var i:int;
            var child:DisplayObject;
            if (!skipTopLevel)
            {
                if ((o is IFocusManagerComponent))
                {
                    focusable = IFocusManagerComponent(o);
                    if (focusable.focusEnabled)
                    {
                        if (((focusable.tabEnabled) && (this.isTabVisible(o))))
                        {
                            this.focusableObjects[o] = true;
                            this.calculateCandidates = true;
                        };
                        o.addEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false, 0, true);
                        o.addEventListener(Event.TAB_INDEX_CHANGE, this.tabIndexChangeHandler, false, 0, true);
                    };
                }
                else
                {
                    if ((o is InteractiveObject))
                    {
                        io = (o as InteractiveObject);
                        if ((((io) && (io.tabEnabled)) && (this.findFocusManagerComponent(io) == io)))
                        {
                            this.focusableObjects[io] = true;
                            this.calculateCandidates = true;
                        };
                        io.addEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false, 0, true);
                        io.addEventListener(Event.TAB_INDEX_CHANGE, this.tabIndexChangeHandler, false, 0, true);
                    };
                };
            };
            if ((o is DisplayObjectContainer))
            {
                doc = DisplayObjectContainer(o);
                o.addEventListener(Event.TAB_CHILDREN_CHANGE, this.tabChildrenChangeHandler, false, 0, true);
                docParent = null;
                try
                {
                    docParent = doc.parent;
                }
                catch(se:SecurityError)
                {
                    docParent = null;
                };
                if ((((doc is Stage) || (docParent is Stage)) || (doc.tabChildren)))
                {
                    i = 0;
                    while (i < doc.numChildren)
                    {
                        try
                        {
                            child = doc.getChildAt(i);
                            if (child != null)
                            {
                                this.addFocusables(doc.getChildAt(i));
                            };
                        }
                        catch(error:SecurityError)
                        {
                        };
                        i = (i + 1);
                    };
                };
            };
        }

        private function removeFocusables(_arg_1:DisplayObject):void
        {
            var _local_2:Object;
            var _local_3:DisplayObject;
            if ((_arg_1 is DisplayObjectContainer))
            {
                _arg_1.removeEventListener(Event.TAB_CHILDREN_CHANGE, this.tabChildrenChangeHandler, false);
                _arg_1.removeEventListener(Event.TAB_INDEX_CHANGE, this.tabIndexChangeHandler, false);
                for (_local_2 in this.focusableObjects)
                {
                    _local_3 = DisplayObject(_local_2);
                    if (DisplayObjectContainer(_arg_1).contains(_local_3))
                    {
                        if (_local_3 == this.lastFocus)
                        {
                            this.lastFocus = null;
                        };
                        _local_3.removeEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false);
                        delete this.focusableObjects[_local_2];
                        this.calculateCandidates = true;
                    };
                };
            };
        }

        private function isTabVisible(_arg_1:DisplayObject):Boolean
        {
            var _local_2:DisplayObjectContainer;
            try
            {
                _local_2 = _arg_1.parent;
                while ((((_local_2) && (!(_local_2 is Stage))) && (!((_local_2.parent) && (_local_2.parent is Stage)))))
                {
                    if (!_local_2.tabChildren)
                    {
                        return (false);
                    };
                    _local_2 = _local_2.parent;
                };
            }
            catch(se:SecurityError)
            {
            };
            return (true);
        }

        private function isValidFocusCandidate(_arg_1:DisplayObject, _arg_2:String):Boolean
        {
            var _local_3:IFocusManagerGroup;
            if (!this.isEnabledAndVisible(_arg_1))
            {
                return (false);
            };
            if ((_arg_1 is IFocusManagerGroup))
            {
                _local_3 = IFocusManagerGroup(_arg_1);
                if (_arg_2 == _local_3.groupName)
                {
                    return (false);
                };
            };
            return (true);
        }

        private function isEnabledAndVisible(_arg_1:DisplayObject):Boolean
        {
            var _local_2:DisplayObjectContainer;
            var _local_3:TextField;
            var _local_4:SimpleButton;
            try
            {
                _local_2 = DisplayObject(this.form).parent;
                while (_arg_1 != _local_2)
                {
                    if ((_arg_1 is UIComponent))
                    {
                        if (!UIComponent(_arg_1).enabled)
                        {
                            return (false);
                        };
                    }
                    else
                    {
                        if ((_arg_1 is TextField))
                        {
                            _local_3 = TextField(_arg_1);
                            if (((_local_3.type == TextFieldType.DYNAMIC) || (!(_local_3.selectable))))
                            {
                                return (false);
                            };
                        }
                        else
                        {
                            if ((_arg_1 is SimpleButton))
                            {
                                _local_4 = SimpleButton(_arg_1);
                                if (!_local_4.enabled)
                                {
                                    return (false);
                                };
                            };
                        };
                    };
                    if (!_arg_1.visible)
                    {
                        return (false);
                    };
                    _arg_1 = _arg_1.parent;
                };
            }
            catch(se:SecurityError)
            {
            };
            return (true);
        }

        private function tabEnabledChangeHandler(_arg_1:Event):void
        {
            this.calculateCandidates = true;
            var _local_2:InteractiveObject = InteractiveObject(_arg_1.target);
            var _local_3:* = (this.focusableObjects[_local_2] == true);
            if (_local_2.tabEnabled)
            {
                if (((!(_local_3)) && (this.isTabVisible(_local_2))))
                {
                    if (!(_local_2 is IFocusManagerComponent))
                    {
                        _local_2.focusRect = false;
                    };
                    this.focusableObjects[_local_2] = true;
                };
            }
            else
            {
                if (_local_3)
                {
                    delete this.focusableObjects[_local_2];
                };
            };
        }

        private function tabIndexChangeHandler(_arg_1:Event):void
        {
            this.calculateCandidates = true;
        }

        private function tabChildrenChangeHandler(_arg_1:Event):void
        {
            if (_arg_1.target != _arg_1.currentTarget)
            {
                return;
            };
            this.calculateCandidates = true;
            var _local_2:DisplayObjectContainer = DisplayObjectContainer(_arg_1.target);
            if (_local_2.tabChildren)
            {
                this.addFocusables(_local_2, true);
            }
            else
            {
                this.removeFocusables(_local_2);
            };
        }

        public function activate():void
        {
            if (this.activated)
            {
                return;
            };
            this.addFocusables(this.form);
            this.form.addEventListener(Event.ADDED, this.addedHandler, false, 0, true);
            this.form.addEventListener(Event.REMOVED, this.removedHandler, false, 0, true);
            try
            {
                this.form.stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.mouseFocusChangeHandler, false, 0, true);
                this.form.stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.keyFocusChangeHandler, false, 0, true);
                this.form.stage.addEventListener(Event.ACTIVATE, this.activateHandler, false, 0, true);
                this.form.stage.addEventListener(Event.DEACTIVATE, this.deactivateHandler, false, 0, true);
            }
            catch(se:SecurityError)
            {
                form.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
                form.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
                form.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
                form.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
            };
            this.form.addEventListener(FocusEvent.FOCUS_IN, this.focusInHandler, true, 0, true);
            this.form.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHandler, true, 0, true);
            this.form.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler, false, 0, true);
            this.form.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler, true, 0, true);
            this.activated = true;
            if (this.lastFocus)
            {
                this.setFocus(this.lastFocus);
            };
        }

        public function deactivate():void
        {
            if (!this.activated)
            {
                return;
            };
            this.focusableObjects = new Dictionary(true);
            this.focusableCandidates = null;
            this.lastFocus = null;
            this.defButton = null;
            this.form.removeEventListener(Event.ADDED, this.addedHandler, false);
            this.form.removeEventListener(Event.REMOVED, this.removedHandler, false);
            try
            {
                this.form.stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.mouseFocusChangeHandler, false);
                this.form.stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.keyFocusChangeHandler, false);
                this.form.stage.removeEventListener(Event.ACTIVATE, this.activateHandler, false);
                this.form.stage.removeEventListener(Event.DEACTIVATE, this.deactivateHandler, false);
            }
            catch(se:SecurityError)
            {
            };
            this.form.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.mouseFocusChangeHandler, false);
            this.form.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.keyFocusChangeHandler, false);
            this.form.removeEventListener(Event.ACTIVATE, this.activateHandler, false);
            this.form.removeEventListener(Event.DEACTIVATE, this.deactivateHandler, false);
            this.form.removeEventListener(FocusEvent.FOCUS_IN, this.focusInHandler, true);
            this.form.removeEventListener(FocusEvent.FOCUS_OUT, this.focusOutHandler, true);
            this.form.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler, false);
            this.form.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler, true);
            this.activated = false;
        }

        private function focusInHandler(_arg_1:FocusEvent):void
        {
            var _local_3:Button;
            if (!this.activated)
            {
                return;
            };
            var _local_2:InteractiveObject = InteractiveObject(_arg_1.target);
            if (this.form.contains(_local_2))
            {
                this.lastFocus = this.findFocusManagerComponent(InteractiveObject(_local_2));
                if ((this.lastFocus is Button))
                {
                    _local_3 = Button(this.lastFocus);
                    if (this.defButton)
                    {
                        this.defButton.emphasized = false;
                        this.defButton = _local_3;
                        _local_3.emphasized = true;
                    };
                }
                else
                {
                    if (((this.defButton) && (!(this.defButton == this._defaultButton))))
                    {
                        this.defButton.emphasized = false;
                        this.defButton = this._defaultButton;
                        this._defaultButton.emphasized = true;
                    };
                };
            };
        }

        private function focusOutHandler(_arg_1:FocusEvent):void
        {
            if (!this.activated)
            {
                return;
            };
            var _local_2:InteractiveObject = (_arg_1.target as InteractiveObject);
        }

        private function activateHandler(_arg_1:Event):void
        {
            if (!this.activated)
            {
                return;
            };
            var _local_2:InteractiveObject = InteractiveObject(_arg_1.target);
            if (this.lastFocus)
            {
                if ((this.lastFocus is IFocusManagerComponent))
                {
                    IFocusManagerComponent(this.lastFocus).setFocus();
                }
                else
                {
                    this.form.stage.focus = this.lastFocus;
                };
            };
            this.lastAction = "ACTIVATE";
        }

        private function deactivateHandler(_arg_1:Event):void
        {
            if (!this.activated)
            {
                return;
            };
            var _local_2:InteractiveObject = InteractiveObject(_arg_1.target);
        }

        private function mouseFocusChangeHandler(_arg_1:FocusEvent):void
        {
            if (!this.activated)
            {
                return;
            };
            if ((_arg_1.relatedObject is TextField))
            {
                return;
            };
            _arg_1.preventDefault();
        }

        private function keyFocusChangeHandler(_arg_1:FocusEvent):void
        {
            if (!this.activated)
            {
                return;
            };
            this.showFocusIndicator = true;
            if ((((_arg_1.keyCode == Keyboard.TAB) || (_arg_1.keyCode == 0)) && (!(_arg_1.isDefaultPrevented()))))
            {
                this.setFocusToNextObject(_arg_1);
                _arg_1.preventDefault();
            };
        }

        private function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (!this.activated)
            {
                return;
            };
            if (_arg_1.keyCode == Keyboard.TAB)
            {
                this.lastAction = "KEY";
                if (this.calculateCandidates)
                {
                    this.sortFocusableObjects();
                    this.calculateCandidates = false;
                };
            };
            if (((((this.defaultButtonEnabled) && (_arg_1.keyCode == Keyboard.ENTER)) && (this.defaultButton)) && (this.defButton.enabled)))
            {
                this.sendDefaultButtonEvent();
            };
        }

        private function mouseDownHandler(_arg_1:MouseEvent):void
        {
            if (!this.activated)
            {
                return;
            };
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            var _local_2:InteractiveObject = this.getTopLevelFocusTarget(InteractiveObject(_arg_1.target));
            if (!_local_2)
            {
                return;
            };
            this.showFocusIndicator = false;
            if ((((!(_local_2 == this.lastFocus)) || (this.lastAction == "ACTIVATE")) && (!(_local_2 is TextField))))
            {
                this.setFocus(_local_2);
            };
            this.lastAction = "MOUSEDOWN";
        }

        public function get defaultButton():Button
        {
            return (this._defaultButton);
        }

        public function set defaultButton(_arg_1:Button):void
        {
            var _local_2:Button = ((_arg_1) ? Button(_arg_1) : null);
            if (_local_2 != this._defaultButton)
            {
                if (this._defaultButton)
                {
                    this._defaultButton.emphasized = false;
                };
                if (this.defButton)
                {
                    this.defButton.emphasized = false;
                };
                this._defaultButton = _local_2;
                this.defButton = _local_2;
                if (_local_2)
                {
                    _local_2.emphasized = true;
                };
            };
        }

        public function sendDefaultButtonEvent():void
        {
            this.defButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }

        private function setFocusToNextObject(_arg_1:FocusEvent):void
        {
            if (!this.hasFocusableObjects())
            {
                return;
            };
            var _local_2:InteractiveObject = this.getNextFocusManagerComponent(_arg_1.shiftKey);
            if (_local_2)
            {
                this.setFocus(_local_2);
            };
        }

        private function hasFocusableObjects():Boolean
        {
            var _local_1:Object;
            for (_local_1 in this.focusableObjects)
            {
                return (true);
            };
            return (false);
        }

        public function getNextFocusManagerComponent(_arg_1:Boolean=false):InteractiveObject
        {
            var _local_8:IFocusManagerGroup;
            if (!this.hasFocusableObjects())
            {
                return (null);
            };
            if (this.calculateCandidates)
            {
                this.sortFocusableObjects();
                this.calculateCandidates = false;
            };
            var _local_2:DisplayObject = this.form.stage.focus;
            _local_2 = DisplayObject(this.findFocusManagerComponent(InteractiveObject(_local_2)));
            var _local_3:* = "";
            if ((_local_2 is IFocusManagerGroup))
            {
                _local_8 = IFocusManagerGroup(_local_2);
                _local_3 = _local_8.groupName;
            };
            var _local_4:int = this.getIndexOfFocusedObject(_local_2);
            var _local_5:Boolean;
            var _local_6:int = _local_4;
            if (_local_4 == -1)
            {
                if (_arg_1)
                {
                    _local_4 = this.focusableCandidates.length;
                };
                _local_5 = true;
            };
            var _local_7:int = this.getIndexOfNextObject(_local_4, _arg_1, _local_5, _local_3);
            return (this.findFocusManagerComponent(this.focusableCandidates[_local_7]));
        }

        private function getIndexOfFocusedObject(_arg_1:DisplayObject):int
        {
            var _local_2:int = this.focusableCandidates.length;
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                if (this.focusableCandidates[_local_3] == _arg_1)
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (-1);
        }

        private function getIndexOfNextObject(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:String):int
        {
            var _local_7:DisplayObject;
            var _local_8:IFocusManagerGroup;
            var _local_9:int;
            var _local_10:DisplayObject;
            var _local_11:IFocusManagerGroup;
            var _local_5:int = this.focusableCandidates.length;
            var _local_6:int = _arg_1;
            while (true)
            {
                if (_arg_2)
                {
                    _arg_1--;
                }
                else
                {
                    _arg_1++;
                };
                if (_arg_3)
                {
                    if (((_arg_2) && (_arg_1 < 0))) break;
                    if (((!(_arg_2)) && (_arg_1 == _local_5))) break;
                }
                else
                {
                    _arg_1 = ((_arg_1 + _local_5) % _local_5);
                    if (_local_6 == _arg_1) break;
                };
                if (this.isValidFocusCandidate(this.focusableCandidates[_arg_1], _arg_4))
                {
                    _local_7 = DisplayObject(this.findFocusManagerComponent(this.focusableCandidates[_arg_1]));
                    if ((_local_7 is IFocusManagerGroup))
                    {
                        _local_8 = IFocusManagerGroup(_local_7);
                        _local_9 = 0;
                        while (_local_9 < this.focusableCandidates.length)
                        {
                            _local_10 = this.focusableCandidates[_local_9];
                            if ((_local_10 is IFocusManagerGroup))
                            {
                                _local_11 = IFocusManagerGroup(_local_10);
                                if (((_local_11.groupName == _local_8.groupName) && (_local_11.selected)))
                                {
                                    _arg_1 = _local_9;
                                    break;
                                };
                            };
                            _local_9++;
                        };
                    };
                    return (_arg_1);
                };
            };
            return (_arg_1);
        }

        private function sortFocusableObjects():void
        {
            var _local_1:Object;
            var _local_2:InteractiveObject;
            this.focusableCandidates = [];
            for (_local_1 in this.focusableObjects)
            {
                _local_2 = InteractiveObject(_local_1);
                if ((((_local_2.tabIndex) && (!(isNaN(Number(_local_2.tabIndex))))) && (_local_2.tabIndex > 0)))
                {
                    this.sortFocusableObjectsTabIndex();
                    return;
                };
                this.focusableCandidates.push(_local_2);
            };
            this.focusableCandidates.sort(this.sortByDepth);
        }

        private function sortFocusableObjectsTabIndex():void
        {
            var _local_1:Object;
            var _local_2:InteractiveObject;
            this.focusableCandidates = [];
            for (_local_1 in this.focusableObjects)
            {
                _local_2 = InteractiveObject(_local_1);
                if (((_local_2.tabIndex) && (!(isNaN(Number(_local_2.tabIndex))))))
                {
                    this.focusableCandidates.push(_local_2);
                };
            };
            this.focusableCandidates.sort(this.sortByTabIndex);
        }

        private function sortByDepth(_arg_1:InteractiveObject, _arg_2:InteractiveObject):Number
        {
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_3:* = "";
            var _local_4:* = "";
            var _local_8:* = "0000";
            var _local_9:DisplayObject = DisplayObject(_arg_1);
            var _local_10:DisplayObject = DisplayObject(_arg_2);
            try
            {
                while (((!(_local_9 == DisplayObject(this.form))) && (_local_9.parent)))
                {
                    _local_5 = this.getChildIndex(_local_9.parent, _local_9);
                    _local_6 = _local_5.toString(16);
                    if (_local_6.length < 4)
                    {
                        _local_7 = (_local_8.substring(0, (4 - _local_6.length)) + _local_6);
                    };
                    _local_3 = (_local_7 + _local_3);
                    _local_9 = _local_9.parent;
                };
            }
            catch(se1:SecurityError)
            {
            };
            try
            {
                while (((!(_local_10 == DisplayObject(this.form))) && (_local_10.parent)))
                {
                    _local_5 = this.getChildIndex(_local_10.parent, _local_10);
                    _local_6 = _local_5.toString(16);
                    if (_local_6.length < 4)
                    {
                        _local_7 = (_local_8.substring(0, (4 - _local_6.length)) + _local_6);
                    };
                    _local_4 = (_local_7 + _local_4);
                    _local_10 = _local_10.parent;
                };
            }
            catch(se2:SecurityError)
            {
            };
            return ((_local_3 > _local_4) ? 1 : ((_local_3 < _local_4) ? -1 : 0));
        }

        private function getChildIndex(_arg_1:DisplayObjectContainer, _arg_2:DisplayObject):int
        {
            return (_arg_1.getChildIndex(_arg_2));
        }

        private function sortByTabIndex(_arg_1:InteractiveObject, _arg_2:InteractiveObject):int
        {
            return ((_arg_1.tabIndex > _arg_2.tabIndex) ? 1 : ((_arg_1.tabIndex < _arg_2.tabIndex) ? -1 : this.sortByDepth(_arg_1, _arg_2)));
        }

        public function get defaultButtonEnabled():Boolean
        {
            return (this._defaultButtonEnabled);
        }

        public function set defaultButtonEnabled(_arg_1:Boolean):void
        {
            this._defaultButtonEnabled = _arg_1;
        }

        public function get nextTabIndex():int
        {
            return (0);
        }

        public function get showFocusIndicator():Boolean
        {
            return (this._showFocusIndicator);
        }

        public function set showFocusIndicator(_arg_1:Boolean):void
        {
            this._showFocusIndicator = _arg_1;
        }

        public function get form():DisplayObjectContainer
        {
            return (this._form);
        }

        public function set form(_arg_1:DisplayObjectContainer):void
        {
            this._form = _arg_1;
        }

        public function getFocus():InteractiveObject
        {
            var _local_1:InteractiveObject = this.form.stage.focus;
            return (this.findFocusManagerComponent(_local_1));
        }

        public function setFocus(_arg_1:InteractiveObject):void
        {
            if ((_arg_1 is IFocusManagerComponent))
            {
                IFocusManagerComponent(_arg_1).setFocus();
            }
            else
            {
                this.form.stage.focus = _arg_1;
            };
        }

        public function showFocus():void
        {
        }

        public function hideFocus():void
        {
        }

        public function findFocusManagerComponent(_arg_1:InteractiveObject):InteractiveObject
        {
            var _local_2:InteractiveObject = _arg_1;
            try
            {
                while (_arg_1)
                {
                    if (((_arg_1 is IFocusManagerComponent) && (IFocusManagerComponent(_arg_1).focusEnabled)))
                    {
                        return (_arg_1);
                    };
                    _arg_1 = _arg_1.parent;
                };
            }
            catch(se:SecurityError)
            {
            };
            return (_local_2);
        }

        private function getTopLevelFocusTarget(_arg_1:InteractiveObject):InteractiveObject
        {
            try
            {
                while (_arg_1 != InteractiveObject(this.form))
                {
                    if (((((_arg_1 is IFocusManagerComponent) && (IFocusManagerComponent(_arg_1).focusEnabled)) && (IFocusManagerComponent(_arg_1).mouseFocusEnabled)) && (UIComponent(_arg_1).enabled)))
                    {
                        return (_arg_1);
                    };
                    _arg_1 = _arg_1.parent;
                    if (_arg_1 == null) break;
                };
            }
            catch(se:SecurityError)
            {
            };
            return (null);
        }


    }
}//package fl.managers
