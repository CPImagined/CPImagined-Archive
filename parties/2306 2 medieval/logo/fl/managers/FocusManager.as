package fl.managers
{
    import fl.controls.*;
    import fl.core.*;
    import fl.managers.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;

    public class FocusManager extends Object implements IFocusManager
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

        public function FocusManager(param1:DisplayObjectContainer)
        {
            this.focusableObjects = new Dictionary(true);
            if (param1 != null)
            {
                this._form = param1;
                this.activate();
            }
            return;
        }// end function

        private function addedHandler(event:Event) : void
        {
            var _loc_2:* = DisplayObject(event.target);
            if (_loc_2.stage)
            {
                this.addFocusables(DisplayObject(event.target));
            }
            return;
        }// end function

        private function removedHandler(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = null;
            var _loc_3:* = DisplayObject(event.target);
            if (_loc_3 is IFocusManagerComponent && this.focusableObjects[_loc_3] == true)
            {
                if (_loc_3 == this.lastFocus)
                {
                    IFocusManagerComponent(this.lastFocus).drawFocus(false);
                    this.lastFocus = null;
                }
                _loc_3.removeEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false);
                delete this.focusableObjects[_loc_3];
                this.calculateCandidates = true;
            }
            else if (_loc_3 is InteractiveObject && this.focusableObjects[_loc_3] == true)
            {
                _loc_4 = _loc_3 as InteractiveObject;
                if (_loc_4)
                {
                    if (_loc_4 == this.lastFocus)
                    {
                        this.lastFocus = null;
                    }
                    delete this.focusableObjects[_loc_4];
                    this.calculateCandidates = true;
                }
                _loc_3.addEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false, 0, true);
            }
            this.removeFocusables(_loc_3);
            return;
        }// end function

        private function addFocusables(param1:DisplayObject, param2:Boolean = false) : void
        {
            var focusable:IFocusManagerComponent;
            var io:InteractiveObject;
            var doc:DisplayObjectContainer;
            var docParent:DisplayObjectContainer;
            var i:int;
            var child:DisplayObject;
            var o:* = param1;
            var skipTopLevel:* = param2;
            if (!skipTopLevel)
            {
                if (o is IFocusManagerComponent)
                {
                    focusable = IFocusManagerComponent(o);
                    if (focusable.focusEnabled)
                    {
                        if (focusable.tabEnabled && this.isTabVisible(o))
                        {
                            this.focusableObjects[o] = true;
                            this.calculateCandidates = true;
                        }
                        o.addEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false, 0, true);
                        o.addEventListener(Event.TAB_INDEX_CHANGE, this.tabIndexChangeHandler, false, 0, true);
                    }
                }
                else if (o is InteractiveObject)
                {
                    io = o as InteractiveObject;
                    if (io && io.tabEnabled && this.findFocusManagerComponent(io) == io)
                    {
                        this.focusableObjects[io] = true;
                        this.calculateCandidates = true;
                    }
                    io.addEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false, 0, true);
                    io.addEventListener(Event.TAB_INDEX_CHANGE, this.tabIndexChangeHandler, false, 0, true);
                }
            }
            if (o is DisplayObjectContainer)
            {
                doc = DisplayObjectContainer(o);
                o.addEventListener(Event.TAB_CHILDREN_CHANGE, this.tabChildrenChangeHandler, false, 0, true);
                docParent;
                try
                {
                    docParent = doc.parent;
                }
                catch (se:SecurityError)
                {
                    docParent;
                }
                if (doc is Stage || docParent is Stage || doc.tabChildren)
                {
                    i;
                    while (i < doc.numChildren)
                    {
                        
                        try
                        {
                            child = doc.getChildAt(i);
                            if (child != null)
                            {
                                this.addFocusables(doc.getChildAt(i));
                            }
                        }
                        catch (error:SecurityError)
                        {
                        }
                        i = (i + 1);
                    }
                }
            }
            return;
        }// end function

        private function removeFocusables(param1:DisplayObject) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 is DisplayObjectContainer)
            {
                param1.removeEventListener(Event.TAB_CHILDREN_CHANGE, this.tabChildrenChangeHandler, false);
                param1.removeEventListener(Event.TAB_INDEX_CHANGE, this.tabIndexChangeHandler, false);
                for (_loc_2 in this.focusableObjects)
                {
                    
                    _loc_3 = DisplayObject(_loc_2);
                    if (DisplayObjectContainer(param1).contains(_loc_3))
                    {
                        if (_loc_3 == this.lastFocus)
                        {
                            this.lastFocus = null;
                        }
                        _loc_3.removeEventListener(Event.TAB_ENABLED_CHANGE, this.tabEnabledChangeHandler, false);
                        delete _loc_5[_loc_2];
                        this.calculateCandidates = true;
                    }
                }
            }
            return;
        }// end function

        private function isTabVisible(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = null;
            try
            {
                _loc_2 = param1.parent;
                while (_loc_2 && !(_loc_2 is Stage) && !(_loc_2.parent && _loc_2.parent is Stage))
                {
                    
                    if (!_loc_2.tabChildren)
                    {
                        return false;
                    }
                    _loc_2 = _loc_2.parent;
                }
            }
            catch (se:SecurityError)
            {
            }
            return true;
        }// end function

        private function isValidFocusCandidate(param1:DisplayObject, param2:String) : Boolean
        {
            var _loc_3:* = null;
            if (!this.isEnabledAndVisible(param1))
            {
                return false;
            }
            if (param1 is IFocusManagerGroup)
            {
                _loc_3 = IFocusManagerGroup(param1);
                if (param2 == _loc_3.groupName)
                {
                    return false;
                }
            }
            return true;
        }// end function

        private function isEnabledAndVisible(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            try
            {
                _loc_2 = DisplayObject(this.form).parent;
                while (param1 != _loc_2)
                {
                    
                    if (param1 is UIComponent)
                    {
                        if (!UIComponent(param1).enabled)
                        {
                            return false;
                        }
                    }
                    else if (param1 is TextField)
                    {
                        _loc_3 = TextField(param1);
                        if (_loc_3.type == TextFieldType.DYNAMIC || !_loc_3.selectable)
                        {
                            return false;
                        }
                    }
                    else if (param1 is SimpleButton)
                    {
                        _loc_4 = SimpleButton(param1);
                        if (!_loc_4.enabled)
                        {
                            return false;
                        }
                    }
                    if (!param1.visible)
                    {
                        return false;
                    }
                    param1 = param1.parent;
                }
            }
            catch (se:SecurityError)
            {
            }
            return true;
        }// end function

        private function tabEnabledChangeHandler(event:Event) : void
        {
            this.calculateCandidates = true;
            var _loc_2:* = InteractiveObject(event.target);
            var _loc_3:* = this.focusableObjects[_loc_2] == true;
            if (_loc_2.tabEnabled)
            {
                if (!_loc_3 && this.isTabVisible(_loc_2))
                {
                    if (!(_loc_2 is IFocusManagerComponent))
                    {
                        _loc_2.focusRect = false;
                    }
                    this.focusableObjects[_loc_2] = true;
                }
            }
            else if (_loc_3)
            {
                delete this.focusableObjects[_loc_2];
            }
            return;
        }// end function

        private function tabIndexChangeHandler(event:Event) : void
        {
            this.calculateCandidates = true;
            return;
        }// end function

        private function tabChildrenChangeHandler(event:Event) : void
        {
            if (event.target != event.currentTarget)
            {
                return;
            }
            this.calculateCandidates = true;
            var _loc_2:* = DisplayObjectContainer(event.target);
            if (_loc_2.tabChildren)
            {
                this.addFocusables(_loc_2, true);
            }
            else
            {
                this.removeFocusables(_loc_2);
            }
            return;
        }// end function

        public function activate() : void
        {
            if (this.activated)
            {
                return;
            }
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
            catch (se:SecurityError)
            {
                form.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
                form.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
                form.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
                form.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
            }
            this.form.addEventListener(FocusEvent.FOCUS_IN, this.focusInHandler, true, 0, true);
            this.form.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHandler, true, 0, true);
            this.form.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler, false, 0, true);
            this.form.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler, true, 0, true);
            this.activated = true;
            if (this.lastFocus)
            {
                this.setFocus(this.lastFocus);
            }
            return;
        }// end function

        public function deactivate() : void
        {
            if (!this.activated)
            {
                return;
            }
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
            catch (se:SecurityError)
            {
            }
            this.form.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.mouseFocusChangeHandler, false);
            this.form.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.keyFocusChangeHandler, false);
            this.form.removeEventListener(Event.ACTIVATE, this.activateHandler, false);
            this.form.removeEventListener(Event.DEACTIVATE, this.deactivateHandler, false);
            this.form.removeEventListener(FocusEvent.FOCUS_IN, this.focusInHandler, true);
            this.form.removeEventListener(FocusEvent.FOCUS_OUT, this.focusOutHandler, true);
            this.form.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler, false);
            this.form.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler, true);
            this.activated = false;
            return;
        }// end function

        private function focusInHandler(event:FocusEvent) : void
        {
            var _loc_3:* = null;
            if (!this.activated)
            {
                return;
            }
            var _loc_2:* = InteractiveObject(event.target);
            if (this.form.contains(_loc_2))
            {
                this.lastFocus = this.findFocusManagerComponent(InteractiveObject(_loc_2));
                if (this.lastFocus is Button)
                {
                    _loc_3 = Button(this.lastFocus);
                    if (this.defButton)
                    {
                        this.defButton.emphasized = false;
                        this.defButton = _loc_3;
                        _loc_3.emphasized = true;
                    }
                }
                else if (this.defButton && this.defButton != this._defaultButton)
                {
                    this.defButton.emphasized = false;
                    this.defButton = this._defaultButton;
                    this._defaultButton.emphasized = true;
                }
            }
            return;
        }// end function

        private function focusOutHandler(event:FocusEvent) : void
        {
            if (!this.activated)
            {
                return;
            }
            var _loc_2:* = event.target as InteractiveObject;
            return;
        }// end function

        private function activateHandler(event:Event) : void
        {
            if (!this.activated)
            {
                return;
            }
            var _loc_2:* = InteractiveObject(event.target);
            if (this.lastFocus)
            {
                if (this.lastFocus is IFocusManagerComponent)
                {
                    IFocusManagerComponent(this.lastFocus).setFocus();
                }
                else
                {
                    this.form.stage.focus = this.lastFocus;
                }
            }
            this.lastAction = "ACTIVATE";
            return;
        }// end function

        private function deactivateHandler(event:Event) : void
        {
            if (!this.activated)
            {
                return;
            }
            var _loc_2:* = InteractiveObject(event.target);
            return;
        }// end function

        private function mouseFocusChangeHandler(event:FocusEvent) : void
        {
            if (!this.activated)
            {
                return;
            }
            if (event.relatedObject is TextField)
            {
                return;
            }
            event.preventDefault();
            return;
        }// end function

        private function keyFocusChangeHandler(event:FocusEvent) : void
        {
            if (!this.activated)
            {
                return;
            }
            this.showFocusIndicator = true;
            if ((event.keyCode == Keyboard.TAB || event.keyCode == 0) && !event.isDefaultPrevented())
            {
                this.setFocusToNextObject(event);
                event.preventDefault();
            }
            return;
        }// end function

        private function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!this.activated)
            {
                return;
            }
            if (event.keyCode == Keyboard.TAB)
            {
                this.lastAction = "KEY";
                if (this.calculateCandidates)
                {
                    this.sortFocusableObjects();
                    this.calculateCandidates = false;
                }
            }
            if (this.defaultButtonEnabled && event.keyCode == Keyboard.ENTER && this.defaultButton && this.defButton.enabled)
            {
                this.sendDefaultButtonEvent();
            }
            return;
        }// end function

        private function mouseDownHandler(event:MouseEvent) : void
        {
            if (!this.activated)
            {
                return;
            }
            if (event.isDefaultPrevented())
            {
                return;
            }
            var _loc_2:* = this.getTopLevelFocusTarget(InteractiveObject(event.target));
            if (!_loc_2)
            {
                return;
            }
            this.showFocusIndicator = false;
            if ((_loc_2 != this.lastFocus || this.lastAction == "ACTIVATE") && !(_loc_2 is TextField))
            {
                this.setFocus(_loc_2);
            }
            this.lastAction = "MOUSEDOWN";
            return;
        }// end function

        public function get defaultButton() : Button
        {
            return this._defaultButton;
        }// end function

        public function set defaultButton(param1:Button) : void
        {
            var _loc_2:* = param1 ? (Button(param1)) : (null);
            if (_loc_2 != this._defaultButton)
            {
                if (this._defaultButton)
                {
                    this._defaultButton.emphasized = false;
                }
                if (this.defButton)
                {
                    this.defButton.emphasized = false;
                }
                this._defaultButton = _loc_2;
                this.defButton = _loc_2;
                if (_loc_2)
                {
                    _loc_2.emphasized = true;
                }
            }
            return;
        }// end function

        public function sendDefaultButtonEvent() : void
        {
            this.defButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        private function setFocusToNextObject(event:FocusEvent) : void
        {
            if (!this.hasFocusableObjects())
            {
                return;
            }
            var _loc_2:* = this.getNextFocusManagerComponent(event.shiftKey);
            if (_loc_2)
            {
                this.setFocus(_loc_2);
            }
            return;
        }// end function

        private function hasFocusableObjects() : Boolean
        {
            var _loc_1:* = null;
            for (_loc_1 in this.focusableObjects)
            {
                
                return true;
            }
            return false;
        }// end function

        public function getNextFocusManagerComponent(param1:Boolean = false) : InteractiveObject
        {
            var _loc_8:* = null;
            if (!this.hasFocusableObjects())
            {
                return null;
            }
            if (this.calculateCandidates)
            {
                this.sortFocusableObjects();
                this.calculateCandidates = false;
            }
            var _loc_2:* = this.form.stage.focus;
            _loc_2 = DisplayObject(this.findFocusManagerComponent(InteractiveObject(_loc_2)));
            var _loc_3:* = "";
            if (_loc_2 is IFocusManagerGroup)
            {
                _loc_8 = IFocusManagerGroup(_loc_2);
                _loc_3 = _loc_8.groupName;
            }
            var _loc_4:* = this.getIndexOfFocusedObject(_loc_2);
            var _loc_5:* = false;
            var _loc_6:* = _loc_4;
            if (_loc_4 == -1)
            {
                if (param1)
                {
                    _loc_4 = this.focusableCandidates.length;
                }
                _loc_5 = true;
            }
            var _loc_7:* = this.getIndexOfNextObject(_loc_4, param1, _loc_5, _loc_3);
            return this.findFocusManagerComponent(this.focusableCandidates[_loc_7]);
        }// end function

        private function getIndexOfFocusedObject(param1:DisplayObject) : int
        {
            var _loc_2:* = this.focusableCandidates.length;
            var _loc_3:* = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this.focusableCandidates[_loc_3] == param1)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        private function getIndexOfNextObject(param1:int, param2:Boolean, param3:Boolean, param4:String) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_5:* = this.focusableCandidates.length;
            var _loc_6:* = param1;
            while (true)
            {
                
                if (param2)
                {
                    param1 = param1 - 1;
                }
                else
                {
                    param1++;
                }
                if (param3)
                {
                    if (param2 && param1 < 0)
                    {
                        break;
                    }
                    if (!param2 && param1 == _loc_5)
                    {
                        break;
                    }
                }
                else
                {
                    param1 = (param1 + _loc_5) % _loc_5;
                    if (_loc_6 == param1)
                    {
                        break;
                    }
                }
                if (this.isValidFocusCandidate(this.focusableCandidates[param1], param4))
                {
                    _loc_7 = DisplayObject(this.findFocusManagerComponent(this.focusableCandidates[param1]));
                    if (_loc_7 is IFocusManagerGroup)
                    {
                        _loc_8 = IFocusManagerGroup(_loc_7);
                        _loc_9 = 0;
                        while (_loc_9 < this.focusableCandidates.length)
                        {
                            
                            _loc_10 = this.focusableCandidates[_loc_9];
                            if (_loc_10 is IFocusManagerGroup)
                            {
                                _loc_11 = IFocusManagerGroup(_loc_10);
                                if (_loc_11.groupName == _loc_8.groupName && _loc_11.selected)
                                {
                                    param1 = _loc_9;
                                    break;
                                }
                            }
                            _loc_9++;
                        }
                    }
                    return param1;
                }
            }
            return param1;
        }// end function

        private function sortFocusableObjects() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.focusableCandidates = [];
            for (_loc_1 in this.focusableObjects)
            {
                
                _loc_2 = InteractiveObject(_loc_1);
                if (_loc_2.tabIndex && !isNaN(Number(_loc_2.tabIndex)) && _loc_2.tabIndex > 0)
                {
                    this.sortFocusableObjectsTabIndex();
                    return;
                }
                this.focusableCandidates.push(_loc_2);
            }
            this.focusableCandidates.sort(this.sortByDepth);
            return;
        }// end function

        private function sortFocusableObjectsTabIndex() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.focusableCandidates = [];
            for (_loc_1 in this.focusableObjects)
            {
                
                _loc_2 = InteractiveObject(_loc_1);
                if (_loc_2.tabIndex && !isNaN(Number(_loc_2.tabIndex)))
                {
                    this.focusableCandidates.push(_loc_2);
                }
            }
            this.focusableCandidates.sort(this.sortByTabIndex);
            return;
        }// end function

        private function sortByDepth(param1:InteractiveObject, param2:InteractiveObject) : Number
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = "";
            var _loc_4:* = "";
            var _loc_8:* = "0000";
            var _loc_9:* = DisplayObject(param1);
            var _loc_10:* = DisplayObject(param2);
            try
            {
                while (_loc_9 != DisplayObject(this.form) && _loc_9.parent)
                {
                    
                    _loc_5 = this.getChildIndex(_loc_9.parent, _loc_9);
                    _loc_6 = _loc_5.toString(16);
                    if (_loc_6.length < 4)
                    {
                        _loc_7 = _loc_8.substring(0, 4 - _loc_6.length) + _loc_6;
                    }
                    _loc_3 = _loc_7 + _loc_3;
                    _loc_9 = _loc_9.parent;
                }
            }
            catch (se1:SecurityError)
            {
            }
            try
            {
                while (_loc_10 != DisplayObject(this.form) && _loc_10.parent)
                {
                    
                    _loc_5 = this.getChildIndex(_loc_10.parent, _loc_10);
                    _loc_6 = _loc_5.toString(16);
                    if (_loc_6.length < 4)
                    {
                        _loc_7 = _loc_8.substring(0, 4 - _loc_6.length) + _loc_6;
                    }
                    _loc_4 = _loc_7 + _loc_4;
                    _loc_10 = _loc_10.parent;
                }
            }
            catch (se2:SecurityError)
            {
            }
            return _loc_3 > _loc_4 ? (1) : (_loc_3 < _loc_4 ? (-1) : (0));
        }// end function

        private function getChildIndex(param1:DisplayObjectContainer, param2:DisplayObject) : int
        {
            return param1.getChildIndex(param2);
        }// end function

        private function sortByTabIndex(param1:InteractiveObject, param2:InteractiveObject) : int
        {
            return param1.tabIndex > param2.tabIndex ? (1) : (param1.tabIndex < param2.tabIndex ? (-1) : (this.sortByDepth(param1, param2)));
        }// end function

        public function get defaultButtonEnabled() : Boolean
        {
            return this._defaultButtonEnabled;
        }// end function

        public function set defaultButtonEnabled(param1:Boolean) : void
        {
            this._defaultButtonEnabled = param1;
            return;
        }// end function

        public function get nextTabIndex() : int
        {
            return 0;
        }// end function

        public function get showFocusIndicator() : Boolean
        {
            return this._showFocusIndicator;
        }// end function

        public function set showFocusIndicator(param1:Boolean) : void
        {
            this._showFocusIndicator = param1;
            return;
        }// end function

        public function get form() : DisplayObjectContainer
        {
            return this._form;
        }// end function

        public function set form(param1:DisplayObjectContainer) : void
        {
            this._form = param1;
            return;
        }// end function

        public function getFocus() : InteractiveObject
        {
            var _loc_1:* = this.form.stage.focus;
            return this.findFocusManagerComponent(_loc_1);
        }// end function

        public function setFocus(param1:InteractiveObject) : void
        {
            if (param1 is IFocusManagerComponent)
            {
                IFocusManagerComponent(param1).setFocus();
            }
            else
            {
                this.form.stage.focus = param1;
            }
            return;
        }// end function

        public function showFocus() : void
        {
            return;
        }// end function

        public function hideFocus() : void
        {
            return;
        }// end function

        public function findFocusManagerComponent(param1:InteractiveObject) : InteractiveObject
        {
            var _loc_2:* = param1;
            try
            {
                while (param1)
                {
                    
                    if (param1 is IFocusManagerComponent && IFocusManagerComponent(param1).focusEnabled)
                    {
                        return param1;
                    }
                    param1 = _loc_2.parent;
                }
            }
            catch (se:SecurityError)
            {
            }
            return _loc_2;
        }// end function

        private function getTopLevelFocusTarget(param1:InteractiveObject) : InteractiveObject
        {
            try
            {
                while (param1 != InteractiveObject(this.form))
                {
                    
                    if (param1 is IFocusManagerComponent && IFocusManagerComponent(param1).focusEnabled && IFocusManagerComponent(param1).mouseFocusEnabled && UIComponent(param1).enabled)
                    {
                        return param1;
                    }
                    param1 = param1.parent;
                    if (param1 == null)
                    {
                        break;
                    }
                }
            }
            catch (se:SecurityError)
            {
            }
            return null;
        }// end function

    }
}
