//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.core.UIComponent extends mx.core.UIObject
    {
        var __width, __height, invalidate, stylecache, removeEventListener, dispatchEvent, drawFocus, addEventListener, _xscale, _yscale, _focusrect, watch, enabled;
        function UIComponent () {
            super();
        }
        function get width() {
            return(__width);
        }
        function get height() {
            return(__height);
        }
        function setVisible(x, noEvent) {
            super.setVisible(x, noEvent);
        }
        function enabledChanged(id, oldValue, newValue) {
            setEnabled(newValue);
            invalidate();
            delete stylecache.tf;
            return(newValue);
        }
        function setEnabled(enabled) {
            invalidate();
        }
        function getFocus() {
            var selFocus = Selection.getFocus();
            return(((selFocus === null) ? null : (eval (selFocus))));
        }
        function setFocus() {
            Selection.setFocus(this);
        }
        function getFocusManager() {
            var _local_2 = this;
            while (_local_2 != undefined) {
                if (_local_2.focusManager != undefined) {
                    return(_local_2.focusManager);
                }
                _local_2 = _local_2._parent;
            }
            return(undefined);
        }
        function onKillFocus(newFocus) {
            removeEventListener("keyDown", this);
            removeEventListener("keyUp", this);
            dispatchEvent({type:"focusOut"});
            drawFocus(false);
        }
        function onSetFocus(oldFocus) {
            addEventListener("keyDown", this);
            addEventListener("keyUp", this);
            dispatchEvent({type:"focusIn"});
            if (getFocusManager().bDrawFocus != false) {
                drawFocus(true);
            }
        }
        function findFocusInChildren(o) {
            if (o.focusTextField != undefined) {
                return(o.focusTextField);
            }
            if (o.tabEnabled == true) {
                return(o);
            }
            return(undefined);
        }
        function findFocusFromObject(o) {
            if (o.tabEnabled != true) {
                if (o._parent == undefined) {
                    return(undefined);
                }
                if (o._parent.tabEnabled == true) {
                    o = o._parent;
                } else if (o._parent.tabChildren) {
                    o = findFocusInChildren(o._parent);
                } else {
                    o = findFocusFromObject(o._parent);
                }
            }
            return(o);
        }
        function pressFocus() {
            var _local_3 = findFocusFromObject(this);
            var _local_2 = this.getFocus();
            if (_local_3 != _local_2) {
                _local_2.drawFocus(false);
                if (getFocusManager().bDrawFocus != false) {
                    _local_3.drawFocus(true);
                }
            }
        }
        function releaseFocus() {
            var _local_2 = findFocusFromObject(this);
            if (_local_2 != this.getFocus()) {
                _local_2.setFocus();
            }
        }
        function isParent(o) {
            while (o != undefined) {
                if (o == this) {
                    return(true);
                }
                o = o._parent;
            }
            return(false);
        }
        function size() {
        }
        function init() {
            super.init();
            _xscale = 100;
            _yscale = 100;
            _focusrect = _global.useFocusRect == false;
            this.watch("enabled", enabledChanged);
            if (enabled == false) {
                setEnabled(false);
            }
        }
        function dispatchValueChangedEvent(value) {
            dispatchEvent({type:"valueChanged", value:value});
        }
        static var symbolName = "UIComponent";
        static var symbolOwner = mx.core.UIComponent;
        static var version = "2.0.2.127";
        static var kStretch = 5000;
        var focusEnabled = true;
        var tabEnabled = true;
        var origBorderStyles = {themeColor:16711680};
        var clipParameters = {};
        static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.core.UIComponent.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
    }
