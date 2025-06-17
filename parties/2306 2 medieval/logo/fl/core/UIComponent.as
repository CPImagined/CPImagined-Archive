package fl.core
{
    import fl.events.*;
    import fl.managers.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class UIComponent extends Sprite
    {
        public const version:String = "3.0.3.1";
        public var focusTarget:IFocusManagerComponent;
        protected var isLivePreview:Boolean = false;
        private var tempText:TextField;
        protected var instanceStyles:Object;
        protected var sharedStyles:Object;
        protected var callLaterMethods:Dictionary;
        protected var invalidateFlag:Boolean = false;
        protected var _enabled:Boolean = true;
        protected var invalidHash:Object;
        protected var uiFocusRect:DisplayObject;
        protected var isFocused:Boolean = false;
        private var _focusEnabled:Boolean = true;
        private var _mouseFocusEnabled:Boolean = true;
        protected var _width:Number;
        protected var _height:Number;
        protected var _x:Number;
        protected var _y:Number;
        protected var startWidth:Number;
        protected var startHeight:Number;
        protected var _imeMode:String = null;
        protected var _oldIMEMode:String = null;
        protected var errorCaught:Boolean = false;
        protected var _inspector:Boolean = false;
        public static var inCallLaterPhase:Boolean = false;
        private static var defaultStyles:Object = {focusRectSkin:"focusRectSkin", focusRectPadding:2, textFormat:new TextFormat("_sans", 11, 0, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0), disabledTextFormat:new TextFormat("_sans", 11, 10066329, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0), defaultTextFormat:new TextFormat("_sans", 11, 0, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0), defaultDisabledTextFormat:new TextFormat("_sans", 11, 10066329, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0)};
        private static var focusManagers:Dictionary = new Dictionary(true);
        private static var focusManagerUsers:Dictionary = new Dictionary(true);
        public static var createAccessibilityImplementation:Function;

        public function UIComponent()
        {
            this.instanceStyles = {};
            this.sharedStyles = {};
            this.invalidHash = {};
            this.callLaterMethods = new Dictionary();
            StyleManager.registerInstance(this);
            this.configUI();
            this.invalidate(InvalidationType.ALL);
            tabEnabled = this is IFocusManagerComponent;
            focusRect = false;
            if (tabEnabled)
            {
                addEventListener(FocusEvent.FOCUS_IN, this.focusInHandler);
                addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHandler);
                addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler);
                addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
            }
            this.initializeFocusManager();
            addEventListener(Event.ENTER_FRAME, this.hookAccessibility, false, 0, true);
            return;
        }// end function

        public function get componentInspectorSetting() : Boolean
        {
            return this._inspector;
        }// end function

        public function set componentInspectorSetting(param1:Boolean) : void
        {
            this._inspector = param1;
            if (this._inspector)
            {
                this.beforeComponentParameters();
            }
            else
            {
                this.afterComponentParameters();
            }
            return;
        }// end function

        protected function beforeComponentParameters() : void
        {
            return;
        }// end function

        protected function afterComponentParameters() : void
        {
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this._enabled;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            if (param1 == this._enabled)
            {
                return;
            }
            this._enabled = param1;
            this.invalidate(InvalidationType.STATE);
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            this._width = param1;
            this._height = param2;
            this.invalidate(InvalidationType.SIZE);
            dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE, false));
            return;
        }// end function

        override public function get width() : Number
        {
            return this._width;
        }// end function

        override public function set width(param1:Number) : void
        {
            if (this._width == param1)
            {
                return;
            }
            this.setSize(param1, this.height);
            return;
        }// end function

        override public function get height() : Number
        {
            return this._height;
        }// end function

        override public function set height(param1:Number) : void
        {
            if (this._height == param1)
            {
                return;
            }
            this.setSize(this.width, param1);
            return;
        }// end function

        public function setStyle(param1:String, param2:Object) : void
        {
            if (this.instanceStyles[param1] === param2 && !(param2 is TextFormat))
            {
                return;
            }
            this.instanceStyles[param1] = param2;
            this.invalidate(InvalidationType.STYLES);
            return;
        }// end function

        public function clearStyle(param1:String) : void
        {
            this.setStyle(param1, null);
            return;
        }// end function

        public function getStyle(param1:String) : Object
        {
            return this.instanceStyles[param1];
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            this._x = param1;
            this._y = param2;
            super.x = Math.round(param1);
            super.y = Math.round(param2);
            dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
            return;
        }// end function

        override public function get x() : Number
        {
            return isNaN(this._x) ? (super.x) : (this._x);
        }// end function

        override public function set x(param1:Number) : void
        {
            this.move(param1, this._y);
            return;
        }// end function

        override public function get y() : Number
        {
            return isNaN(this._y) ? (super.y) : (this._y);
        }// end function

        override public function set y(param1:Number) : void
        {
            this.move(this._x, param1);
            return;
        }// end function

        override public function get scaleX() : Number
        {
            return this.width / this.startWidth;
        }// end function

        override public function set scaleX(param1:Number) : void
        {
            this.setSize(this.startWidth * param1, this.height);
            return;
        }// end function

        override public function get scaleY() : Number
        {
            return this.height / this.startHeight;
        }// end function

        override public function set scaleY(param1:Number) : void
        {
            this.setSize(this.width, this.startHeight * param1);
            return;
        }// end function

        protected function getScaleY() : Number
        {
            return super.scaleY;
        }// end function

        protected function setScaleY(param1:Number) : void
        {
            super.scaleY = param1;
            return;
        }// end function

        protected function getScaleX() : Number
        {
            return super.scaleX;
        }// end function

        protected function setScaleX(param1:Number) : void
        {
            super.scaleX = param1;
            return;
        }// end function

        override public function get visible() : Boolean
        {
            return super.visible;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            if (super.visible == param1)
            {
                return;
            }
            super.visible = param1;
            var _loc_2:* = param1 ? (ComponentEvent.SHOW) : (ComponentEvent.HIDE);
            dispatchEvent(new ComponentEvent(_loc_2, true));
            return;
        }// end function

        public function validateNow() : void
        {
            this.invalidate(InvalidationType.ALL, false);
            this.draw();
            return;
        }// end function

        public function invalidate(param1:String = "all", param2:Boolean = true) : void
        {
            this.invalidHash[param1] = true;
            if (param2)
            {
                this.callLater(this.draw);
            }
            return;
        }// end function

        public function setSharedStyle(param1:String, param2:Object) : void
        {
            if (this.sharedStyles[param1] === param2 && !(param2 is TextFormat))
            {
                return;
            }
            this.sharedStyles[param1] = param2;
            if (this.instanceStyles[param1] == null)
            {
                this.invalidate(InvalidationType.STYLES);
            }
            return;
        }// end function

        public function get focusEnabled() : Boolean
        {
            return this._focusEnabled;
        }// end function

        public function set focusEnabled(param1:Boolean) : void
        {
            this._focusEnabled = param1;
            return;
        }// end function

        public function get mouseFocusEnabled() : Boolean
        {
            return this._mouseFocusEnabled;
        }// end function

        public function set mouseFocusEnabled(param1:Boolean) : void
        {
            this._mouseFocusEnabled = param1;
            return;
        }// end function

        public function get focusManager() : IFocusManager
        {
            var o:DisplayObject;
            do
            {
                
                if (UIComponent.focusManagers[o] != null)
                {
                    return IFocusManager(UIComponent.focusManagers[o]);
                }
                try
                {
                    o = o.parent;
                }
                catch (se:SecurityError)
                {
                    return null;
                }
            }while (o)
            return null;
        }// end function

        public function set focusManager(param1:IFocusManager) : void
        {
            UIComponent.focusManagers[this] = param1;
            return;
        }// end function

        public function drawFocus(param1:Boolean) : void
        {
            var _loc_2:* = NaN;
            this.isFocused = param1;
            if (this.uiFocusRect != null && contains(this.uiFocusRect))
            {
                removeChild(this.uiFocusRect);
                this.uiFocusRect = null;
            }
            if (param1)
            {
                this.uiFocusRect = this.getDisplayObjectInstance(this.getStyleValue("focusRectSkin")) as Sprite;
                if (this.uiFocusRect == null)
                {
                    return;
                }
                _loc_2 = Number(this.getStyleValue("focusRectPadding"));
                this.uiFocusRect.x = -_loc_2;
                this.uiFocusRect.y = -_loc_2;
                this.uiFocusRect.width = this.width + _loc_2 * 2;
                this.uiFocusRect.height = this.height + _loc_2 * 2;
                addChildAt(this.uiFocusRect, 0);
            }
            return;
        }// end function

        public function setFocus() : void
        {
            if (stage)
            {
                stage.focus = this;
            }
            return;
        }// end function

        public function getFocus() : InteractiveObject
        {
            if (stage)
            {
                return stage.focus;
            }
            return null;
        }// end function

        protected function setIMEMode(param1:Boolean)
        {
            var enabled:* = param1;
            if (this._imeMode != null)
            {
                if (enabled)
                {
                    IME.enabled = true;
                    this._oldIMEMode = IME.conversionMode;
                    try
                    {
                        if (!this.errorCaught && IME.conversionMode != IMEConversionMode.UNKNOWN)
                        {
                            IME.conversionMode = this._imeMode;
                        }
                        this.errorCaught = false;
                    }
                    catch (e:Error)
                    {
                        errorCaught = true;
                        throw new Error("IME mode not supported: " + _imeMode);
                    }
                }
                else
                {
                    if (IME.conversionMode != IMEConversionMode.UNKNOWN && this._oldIMEMode != IMEConversionMode.UNKNOWN)
                    {
                        IME.conversionMode = this._oldIMEMode;
                    }
                    IME.enabled = false;
                }
            }
            return;
        }// end function

        public function drawNow() : void
        {
            this.draw();
            return;
        }// end function

        protected function configUI() : void
        {
            this.isLivePreview = this.checkLivePreview();
            var _loc_1:* = rotation;
            rotation = 0;
            var _loc_2:* = super.width;
            var _loc_3:* = super.height;
            var _loc_4:* = 1;
            super.scaleY = 1;
            super.scaleX = _loc_4;
            this.setSize(_loc_2, _loc_3);
            this.move(super.x, super.y);
            rotation = _loc_1;
            this.startWidth = _loc_2;
            this.startHeight = _loc_3;
            if (numChildren > 0)
            {
                removeChildAt(0);
            }
            return;
        }// end function

        protected function checkLivePreview() : Boolean
        {
            var _loc_1:* = null;
            if (parent == null)
            {
                return false;
            }
            try
            {
                _loc_1 = getQualifiedClassName(parent);
            }
            catch (e:Error)
            {
            }
            return _loc_1 == "fl.livepreview::LivePreviewParent";
        }// end function

        protected function isInvalid(param1:String, ... args) : Boolean
        {
            if (this.invalidHash[param1] || this.invalidHash[InvalidationType.ALL])
            {
                return true;
            }
            while (args.length > 0)
            {
                
                if (this.invalidHash[args.pop()])
                {
                    return true;
                }
            }
            return false;
        }// end function

        protected function validate() : void
        {
            this.invalidHash = {};
            return;
        }// end function

        protected function draw() : void
        {
            if (this.isInvalid(InvalidationType.SIZE, InvalidationType.STYLES))
            {
                if (this.isFocused && this.focusManager.showFocusIndicator)
                {
                    this.drawFocus(true);
                }
            }
            this.validate();
            return;
        }// end function

        protected function getDisplayObjectInstance(param1:Object) : DisplayObject
        {
            var skin:* = param1;
            var classDef:Object;
            if (skin is Class)
            {
                return new skin as DisplayObject;
            }
            if (skin is DisplayObject)
            {
                (skin as DisplayObject).x = 0;
                (skin as DisplayObject).y = 0;
                return skin as DisplayObject;
            }
            try
            {
                classDef = getDefinitionByName(skin.toString());
            }
            catch (e:Error)
            {
                try
                {
                    classDef = loaderInfo.applicationDomain.getDefinition(skin.toString()) as Object;
                }
                catch (e:Error)
                {
                }
                if (classDef == null)
                {
                    return null;
                }
                return new classDef as DisplayObject;
        }// end function

        protected function getStyleValue(param1:String) : Object
        {
            return this.instanceStyles[param1] == null ? (this.sharedStyles[param1]) : (this.instanceStyles[param1]);
        }// end function

        protected function copyStylesToChild(param1:UIComponent, param2:Object) : void
        {
            var _loc_3:* = null;
            for (_loc_3 in param2)
            {
                
                param1.setStyle(_loc_3, this.getStyleValue(_loc_5[_loc_3]));
            }
            return;
        }// end function

        protected function callLater(param1:Function) : void
        {
            var fn:* = param1;
            if (inCallLaterPhase)
            {
                return;
            }
            this.callLaterMethods[fn] = true;
            if (stage != null)
            {
                try
                {
                    stage.addEventListener(Event.RENDER, this.callLaterDispatcher, false, 0, true);
                    stage.invalidate();
                }
                catch (se:SecurityError)
                {
                    addEventListener(Event.ENTER_FRAME, callLaterDispatcher, false, 0, true);
                }
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, this.callLaterDispatcher, false, 0, true);
            }
            return;
        }// end function

        private function callLaterDispatcher(event:Event) : void
        {
            var method:Object;
            var event:* = event;
            if (event.type == Event.ADDED_TO_STAGE)
            {
                try
                {
                    removeEventListener(Event.ADDED_TO_STAGE, this.callLaterDispatcher);
                    stage.addEventListener(Event.RENDER, this.callLaterDispatcher, false, 0, true);
                    stage.invalidate();
                    return;
                }
                catch (se1:SecurityError)
                {
                    addEventListener(Event.ENTER_FRAME, callLaterDispatcher, false, 0, true);
                }
            }
            else
            {
                event.target.removeEventListener(Event.RENDER, this.callLaterDispatcher);
                event.target.removeEventListener(Event.ENTER_FRAME, this.callLaterDispatcher);
                try
                {
                    if (stage == null)
                    {
                        addEventListener(Event.ADDED_TO_STAGE, this.callLaterDispatcher, false, 0, true);
                        return;
                    }
                }
                catch (se2:SecurityError)
                {
                }
            }
            inCallLaterPhase = true;
            var methods:* = this.callLaterMethods;
            var _loc_3:* = 0;
            var _loc_4:* = methods;
            while (_loc_4 in _loc_3)
            {
                
                method = _loc_4[_loc_3];
                this.method();
                delete _loc_4[method];
            }
            inCallLaterPhase = false;
            return;
        }// end function

        private function initializeFocusManager() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (stage == null)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.addedHandler, false, 0, true);
            }
            else
            {
                this.createFocusManager();
                _loc_1 = this.focusManager;
                if (_loc_1 != null)
                {
                    _loc_2 = focusManagerUsers[_loc_1];
                    if (_loc_2 == null)
                    {
                        _loc_2 = new Dictionary(true);
                        focusManagerUsers[_loc_1] = _loc_2;
                    }
                    _loc_2[this] = true;
                }
            }
            addEventListener(Event.REMOVED_FROM_STAGE, this.removedHandler);
            return;
        }// end function

        private function addedHandler(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.addedHandler);
            this.initializeFocusManager();
            return;
        }// end function

        private function removedHandler(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            removeEventListener(Event.REMOVED_FROM_STAGE, this.removedHandler);
            addEventListener(Event.ADDED_TO_STAGE, this.addedHandler);
            var _loc_2:* = this.focusManager;
            if (_loc_2 != null)
            {
                _loc_3 = focusManagerUsers[_loc_2];
                if (_loc_3 != null)
                {
                    delete _loc_3[this];
                    _loc_4 = true;
                    for (_loc_5 in _loc_3)
                    {
                        
                        _loc_4 = false;
                        break;
                    }
                    if (_loc_4)
                    {
                        delete focusManagerUsers[_loc_2];
                        _loc_3 = null;
                    }
                }
                if (_loc_3 == null)
                {
                    _loc_2.deactivate();
                    for (_loc_6 in focusManagers)
                    {
                        
                        _loc_7 = _loc_9[_loc_6];
                        if (_loc_2 == _loc_7)
                        {
                            delete _loc_9[_loc_6];
                        }
                    }
                }
            }
            return;
        }// end function

        protected function createFocusManager() : void
        {
            var stageAccessOK:Boolean;
            try
            {
                stage.getChildAt(0);
            }
            catch (se:SecurityError)
            {
                stageAccessOK;
            }
            var myTopLevel:DisplayObjectContainer;
            if (stageAccessOK)
            {
                myTopLevel = stage;
            }
            else
            {
                myTopLevel;
                try
                {
                    while (myTopLevel.parent != null)
                    {
                        
                        myTopLevel = myTopLevel.parent;
                    }
                }
                catch (se:SecurityError)
                {
                }
            }
            if (focusManagers[myTopLevel] == null)
            {
                focusManagers[myTopLevel] = new FocusManager(myTopLevel);
            }
            return;
        }// end function

        protected function isOurFocus(param1:DisplayObject) : Boolean
        {
            return param1 == this;
        }// end function

        protected function focusInHandler(event:FocusEvent) : void
        {
            var _loc_2:* = null;
            if (this.isOurFocus(event.target as DisplayObject))
            {
                _loc_2 = this.focusManager;
                if (_loc_2 && _loc_2.showFocusIndicator)
                {
                    this.drawFocus(true);
                    this.isFocused = true;
                }
            }
            return;
        }// end function

        protected function focusOutHandler(event:FocusEvent) : void
        {
            if (this.isOurFocus(event.target as DisplayObject))
            {
                this.drawFocus(false);
                this.isFocused = false;
            }
            return;
        }// end function

        protected function keyDownHandler(event:KeyboardEvent) : void
        {
            return;
        }// end function

        protected function keyUpHandler(event:KeyboardEvent) : void
        {
            return;
        }// end function

        protected function hookAccessibility(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, this.hookAccessibility);
            this.initializeAccessibility();
            return;
        }// end function

        protected function initializeAccessibility() : void
        {
            if (UIComponent.createAccessibilityImplementation != null)
            {
                UIComponent.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        public static function getStyleDefinition() : Object
        {
            return defaultStyles;
        }// end function

        public static function mergeStyles(... args) : Object
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            args = {};
            var _loc_3:* = args.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = args[_loc_4];
                for (_loc_6 in _loc_5)
                {
                    
                    if (args[_loc_6] != null)
                    {
                        continue;
                    }
                    args[_loc_6] = _loc_5[_loc_6];
                }
                _loc_4 = _loc_4 + 1;
            }
            return args;
        }// end function

    }
}
