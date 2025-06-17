//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.managers.FocusManager extends mx.core.UIComponent
    {
        var __defaultPushButton, defPushButton, form, move, tabEnabled, _width, _height, _x, _y, _alpha, _parent, tabCapture, watch, lastMouse, _visible, lastFocus, doLater, lastSelFocus, cancelAllDoLaters, _searchKey, _lastTarget, _firstNode, _nextIsNext, _nextNode, _lastx, _prevNode, _needPrev, _foundList, _prevObj, _nextObj, _firstObj, _lastObj, _lastNode, lastTabFocus, findFocusFromObject;
        function FocusManager () {
            super();
        }
        function get defaultPushButton() {
            return(__defaultPushButton);
        }
        function set defaultPushButton(x) {
            if (x != __defaultPushButton) {
                __defaultPushButton.emphasized = false;
                __defaultPushButton = x;
                defPushButton = x;
                x.emphasized = true;
            }
            //return(defaultPushButton);
        }
        function getMaxTabIndex(o) {
            var _local_3 = 0;
            var _local_6;
            for (_local_6 in o) {
                var _local_2 = o[_local_6];
                if (_local_2._parent == o) {
                    if (_local_2.tabIndex != undefined) {
                        if (_local_2.tabIndex > _local_3) {
                            _local_3 = _local_2.tabIndex;
                        }
                    }
                    if (_local_2.tabChildren == true) {
                        var _local_4 = getMaxTabIndex(_local_2);
                        if (_local_4 > _local_3) {
                            _local_3 = _local_4;
                        }
                    }
                }
            }
            return(_local_3);
        }
        function getNextTabIndex(Void) {
            return(getMaxTabIndex(form) + 1);
        }
        function get nextTabIndex() {
            return(getNextTabIndex());
        }
        function relocate(Void) {
            var _local_2 = mx.managers.SystemManager.screen;
            move(_local_2.x - 1, _local_2.y - 1);
        }
        function init(Void) {
            super.init();
            tabEnabled = false;
            _width = (_height = 1);
            _x = (_y = -1);
            _alpha = 0;
            _parent.focusManager = this;
            _parent.tabChildren = true;
            _parent.tabEnabled = false;
            form = _parent;
            _parent.addEventListener("hide", this);
            _parent.addEventListener("reveal", this);
            mx.managers.SystemManager.init();
            mx.managers.SystemManager.addFocusManager(form);
            tabCapture.tabIndex = 0;
            this.watch("enabled", enabledChanged);
            Selection.addListener(this);
            lastMouse = new Object();
            _global.ASSetPropFlags(_parent, "focusManager", 1);
            _global.ASSetPropFlags(_parent, "tabChildren", 1);
            _global.ASSetPropFlags(_parent, "tabEnabled", 1);
        }
        function enabledChanged(id, oldValue, newValue) {
            _visible = newValue;
            return(newValue);
        }
        function activate(Void) {
            Key.addListener(this);
            activated = (_visible = true);
            if (lastFocus != undefined) {
                bNeedFocus = true;
                if (!mx.managers.SystemManager.isMouseDown) {
                    doLater(this, "restoreFocus");
                }
            }
        }
        function deactivate(Void) {
            Key.removeListener(this);
            activated = (_visible = false);
            var _local_2 = getSelectionFocus();
            var _local_3 = getActualFocus(_local_2);
            if (isOurFocus(_local_3)) {
                lastSelFocus = _local_2;
                lastFocus = _local_3;
            }
            cancelAllDoLaters();
        }
        function isOurFocus(o) {
            if (o.focusManager == this) {
                return(true);
            }
            while (o != undefined) {
                if (o.focusManager != undefined) {
                    return(false);
                }
                if (o._parent == _parent) {
                    return(true);
                }
                o = o._parent;
            }
            return(false);
        }
        function onSetFocus(o, n) {
            if (n == null) {
                if (activated) {
                    bNeedFocus = true;
                }
            } else {
                var _local_2 = this.getFocus();
                if (isOurFocus(_local_2)) {
                    bNeedFocus = false;
                    lastFocus = _local_2;
                    lastSelFocus = n;
                }
            }
        }
        function restoreFocus(Void) {
            var _local_2 = lastSelFocus.hscroll;
            if (_local_2 != undefined) {
                var _local_5 = lastSelFocus.scroll;
                var _local_4 = lastSelFocus.background;
            }
            lastFocus.setFocus();
            var _local_3 = Selection;
            Selection.setSelection(_local_3.lastBeginIndex, _local_3.lastEndIndex);
            if (_local_2 != undefined) {
                lastSelFocus.scroll = _local_5;
                lastSelFocus.hscroll = _local_2;
                lastSelFocus.background = _local_4;
            }
        }
        function onUnload(Void) {
            mx.managers.SystemManager.removeFocusManager(form);
        }
        function setFocus(o) {
            if (o == null) {
                Selection.setFocus(null);
            } else if (o.setFocus == undefined) {
                Selection.setFocus(o);
            } else {
                o.setFocus();
            }
        }
        function getActualFocus(o) {
            var _local_1 = o._parent;
            while (_local_1 != undefined) {
                if (_local_1.focusTextField != undefined) {
                    while (_local_1.focusTextField != undefined) {
                        o = _local_1;
                        _local_1 = _local_1._parent;
                        if (_local_1 == undefined) {
                            return(undefined);
                        }
                        if (_local_1.focusTextField == undefined) {
                            return(o);
                        }
                    }
                }
                if (_local_1.tabEnabled != true) {
                    return(o);
                }
                o = _local_1;
                _local_1 = o._parent;
            }
            return(undefined);
        }
        function getSelectionFocus() {
            var m = Selection.getFocus();
            var o = eval (m);
            return(o);
        }
        function getFocus(Void) {
            var _local_2 = getSelectionFocus();
            return(getActualFocus(_local_2));
        }
        function walkTree(p, index, groupName, dir, lookup, firstChild) {
            var _local_5 = true;
            var _local_11;
            for (_local_11 in p) {
                var _local_2 = p[_local_11];
                if ((((_local_2._parent == p) && (_local_2.enabled != false)) && (_local_2._visible != false)) && ((_local_2.tabEnabled == true) || ((_local_2.tabEnabled != false) && ((((((((_local_2.onPress != undefined) || (_local_2.onRelease != undefined)) || (_local_2.onReleaseOutside != undefined)) || (_local_2.onDragOut != undefined)) || (_local_2.onDragOver != undefined)) || (_local_2.onRollOver != undefined)) || (_local_2.onRollOut != undefined)) || (_local_2 instanceof TextField))))) {
                    if (_local_2._searchKey == _searchKey) {
                        continue;
                    }
                    _local_2._searchKey = _searchKey;
                    if (_local_2 != _lastTarget) {
                        if (((_local_2.groupName != undefined) || (groupName != undefined)) && (_local_2.groupName == groupName)) {
                            continue;
                        }
                        if ((_local_2 instanceof TextField) && (_local_2.selectable == false)) {
                            continue;
                        }
                        if (_local_5 || (((_local_2.groupName != undefined) && (_local_2.groupName == _firstNode.groupName)) && (_local_2.selected == true))) {
                            if (firstChild) {
                                _firstNode = _local_2;
                                firstChild = false;
                            }
                        }
                        if (_nextIsNext == true) {
                            if ((((_local_2.groupName != undefined) && (_local_2.groupName == _nextNode.groupName)) && (_local_2.selected == true)) || ((_nextNode == undefined) && ((_local_2.groupName == undefined) || ((_local_2.groupName != undefined) && (_local_2.groupName != groupName))))) {
                                _nextNode = _local_2;
                            }
                        }
                        if ((_local_2.groupName == undefined) || (groupName != _local_2.groupName)) {
                            if (((_lastx.groupName != undefined) && (_local_2.groupName == _lastx.groupName)) && (_lastx.selected == true)) {
                            } else {
                                _lastx = _local_2;
                            }
                        }
                    } else {
                        _prevNode = _lastx;
                        _needPrev = false;
                        _nextIsNext = true;
                    }
                    if (_local_2.tabIndex != undefined) {
                        if (_local_2.tabIndex == index) {
                            if (_foundList[_local_2._name] == undefined) {
                                if (_needPrev) {
                                    _prevObj = _local_2;
                                    _needPrev = false;
                                }
                                _nextObj = _local_2;
                            }
                        }
                        if (dir && (_local_2.tabIndex > index)) {
                            if (((_nextObj == undefined) || ((_nextObj.tabIndex > _local_2.tabIndex) && (((_local_2.groupName == undefined) || (_nextObj.groupName == undefined)) || (_local_2.groupName != _nextObj.groupName)))) || ((((_nextObj.groupName != undefined) && (_nextObj.groupName == _local_2.groupName)) && (_nextObj.selected != true)) && ((_local_2.selected == true) || (_nextObj.tabIndex > _local_2.tabIndex)))) {
                                _nextObj = _local_2;
                            }
                        } else if ((!dir) && (_local_2.tabIndex < index)) {
                            if (((_prevObj == undefined) || ((_prevObj.tabIndex < _local_2.tabIndex) && (((_local_2.groupName == undefined) || (_prevObj.groupName == undefined)) || (_local_2.groupName != _prevObj.groupName)))) || ((((_prevObj.groupName != undefined) && (_prevObj.groupName == _local_2.groupName)) && (_prevObj.selected != true)) && ((_local_2.selected == true) || (_prevObj.tabIndex < _local_2.tabIndex)))) {
                                _prevObj = _local_2;
                            }
                        }
                        if (((_firstObj == undefined) || ((_local_2.tabIndex < _firstObj.tabIndex) && (((_local_2.groupName == undefined) || (_firstObj.groupName == undefined)) || (_local_2.groupName != _firstObj.groupName)))) || ((((_firstObj.groupName != undefined) && (_firstObj.groupName == _local_2.groupName)) && (_firstObj.selected != true)) && ((_local_2.selected == true) || (_local_2.tabIndex < _firstObj.tabIndex)))) {
                            _firstObj = _local_2;
                        }
                        if (((_lastObj == undefined) || ((_local_2.tabIndex > _lastObj.tabIndex) && (((_local_2.groupName == undefined) || (_lastObj.groupName == undefined)) || (_local_2.groupName != _lastObj.groupName)))) || ((((_lastObj.groupName != undefined) && (_lastObj.groupName == _local_2.groupName)) && (_lastObj.selected != true)) && ((_local_2.selected == true) || (_local_2.tabIndex > _lastObj.tabIndex)))) {
                            _lastObj = _local_2;
                        }
                    }
                    if (_local_2.tabChildren) {
                        getTabCandidateFromChildren(_local_2, index, groupName, dir, _local_5 && (firstChild));
                    }
                    _local_5 = false;
                } else if (((_local_2._parent == p) && (_local_2.tabChildren == true)) && (_local_2._visible != false)) {
                    if (_local_2 == _lastTarget) {
                        if (_local_2._searchKey == _searchKey) {
                            continue;
                        }
                        _local_2._searchKey = _searchKey;
                        if (_prevNode == undefined) {
                            var _local_3 = _lastx;
                            var _local_7 = false;
                            while (_local_3 != undefined) {
                                if (_local_3 == _local_2) {
                                    _local_7 = true;
                                    break;
                                }
                                _local_3 = _local_3._parent;
                            }
                            if (_local_7 == false) {
                                _prevNode = _lastx;
                            }
                        }
                        _needPrev = false;
                        if (_nextNode == undefined) {
                            _nextIsNext = true;
                        }
                    } else if (!((_local_2.focusManager != undefined) && (_local_2.focusManager._parent == _local_2))) {
                        if (_local_2._searchKey == _searchKey) {
                            continue;
                        }
                        _local_2._searchKey = _searchKey;
                        getTabCandidateFromChildren(_local_2, index, groupName, dir, _local_5 && (firstChild));
                    }
                    _local_5 = false;
                }
            }
            _lastNode = _lastx;
            if (lookup) {
                if (p._parent != undefined) {
                    if (p != _parent) {
                        if ((_prevNode == undefined) && (dir)) {
                            _needPrev = true;
                        } else if ((_nextNode == undefined) && (!dir)) {
                            _nextIsNext = false;
                        }
                        _lastTarget = _lastTarget._parent;
                        getTabCandidate(p._parent, index, groupName, dir, true);
                    }
                }
            }
        }
        function getTabCandidate(o, index, groupName, dir, firstChild) {
            var _local_2;
            var _local_3 = true;
            if (o == _parent) {
                _local_2 = o;
                _local_3 = false;
            } else {
                _local_2 = o._parent;
                if (_local_2 == undefined) {
                    _local_2 = o;
                    _local_3 = false;
                }
            }
            walkTree(_local_2, index, groupName, dir, _local_3, firstChild);
        }
        function getTabCandidateFromChildren(o, index, groupName, dir, firstChild) {
            walkTree(o, index, groupName, dir, false, firstChild);
        }
        function getFocusManagerFromObject(o) {
            while (o != undefined) {
                if (o.focusManager != undefined) {
                    return(o.focusManager);
                }
                o = o._parent;
            }
            return(undefined);
        }
        function tabHandler(Void) {
            bDrawFocus = true;
            var _local_5 = getSelectionFocus();
            var _local_4 = getActualFocus(_local_5);
            if (_local_4 != _local_5) {
                _local_5 = _local_4;
            }
            if (getFocusManagerFromObject(_local_5) != this) {
                _local_5 == undefined;
            }
            if (_local_5 == undefined) {
                _local_5 = form;
            } else if (_local_5.tabIndex != undefined) {
                if ((_foundList != undefined) || (_foundList.tabIndex != _local_5.tabIndex)) {
                    _foundList = new Object();
                    _foundList.tabIndex = _local_5.tabIndex;
                }
                _foundList[_local_5._name] = _local_5;
            }
            var _local_3 = Key.isDown(16) != true;
            _searchKey = getTimer();
            _needPrev = true;
            _nextIsNext = false;
            _lastx = undefined;
            _firstNode = undefined;
            _lastNode = undefined;
            _nextNode = undefined;
            _prevNode = undefined;
            _firstObj = undefined;
            _lastObj = undefined;
            _nextObj = undefined;
            _prevObj = undefined;
            _lastTarget = _local_5;
            var _local_6 = _local_5;
            getTabCandidate(_local_6, ((_local_5.tabIndex == undefined) ? 0 : (_local_5.tabIndex)), _local_5.groupName, _local_3, true);
            var _local_2;
            if (_local_3) {
                if (_nextObj != undefined) {
                    _local_2 = _nextObj;
                } else {
                    _local_2 = _firstObj;
                }
            } else if (_prevObj != undefined) {
                _local_2 = _prevObj;
            } else {
                _local_2 = _lastObj;
            }
            if (_local_2.tabIndex != _local_5.tabIndex) {
                _foundList = new Object();
                _foundList.tabIndex = _local_2.tabIndex;
                _foundList[_local_2._name] = _local_2;
            } else {
                if (_foundList == undefined) {
                    _foundList = new Object();
                    _foundList.tabIndex = _local_2.tabIndex;
                }
                _foundList[_local_2._name] = _local_2;
            }
            if (_local_2 == undefined) {
                if (_local_3 == false) {
                    if (_nextNode != undefined) {
                        _local_2 = _nextNode;
                    } else {
                        _local_2 = _firstNode;
                    }
                } else if ((_prevNode == undefined) || (_local_5 == form)) {
                    _local_2 = _lastNode;
                } else {
                    _local_2 = _prevNode;
                }
            }
            if (_local_2 == undefined) {
                return(undefined);
            }
            lastTabFocus = _local_2;
            this.setFocus(_local_2);
            if (_local_2.emphasized != undefined) {
                if (defPushButton != undefined) {
                    _local_5 = defPushButton;
                    defPushButton = _local_2;
                    _local_5.emphasized = false;
                    _local_2.emphasized = true;
                }
            } else if ((defPushButton != undefined) && (defPushButton != __defaultPushButton)) {
                _local_5 = defPushButton;
                defPushButton = __defaultPushButton;
                _local_5.emphasized = false;
                __defaultPushButton.emphasized = true;
            }
        }
        function onKeyDown(Void) {
            mx.managers.SystemManager.idleFrames = 0;
            if (defaultPushButtonEnabled) {
                if (Key.getCode() == 13) {
                    if (defaultPushButton != undefined) {
                        doLater(this, "sendDefaultPushButtonEvent");
                    }
                }
            }
        }
        function sendDefaultPushButtonEvent(Void) {
            defPushButton.dispatchEvent({type:"click"});
        }
        function getMousedComponentFromChildren(x, y, o) {
            for (var _local_7 in o) {
                var _local_2 = o[_local_7];
                if (((_local_2._visible && (_local_2.enabled)) && (_local_2._parent == o)) && (_local_2._searchKey != _searchKey)) {
                    _local_2._searchKey = _searchKey;
                    if (_local_2.hitTest(x, y, true)) {
                        if ((_local_2.onPress != undefined) || (_local_2.onRelease != undefined)) {
                            return(_local_2);
                        }
                        var _local_3 = getMousedComponentFromChildren(x, y, _local_2);
                        if (_local_3 != undefined) {
                            return(_local_3);
                        }
                        return(_local_2);
                    }
                }
            }
            return(undefined);
        }
        function mouseActivate(Void) {
            if (!bNeedFocus) {
                return(undefined);
            }
            _searchKey = getTimer();
            var _local_2 = getMousedComponentFromChildren(lastMouse.x, lastMouse.y, form);
            if (_local_2 instanceof mx.core.UIComponent) {
                return(undefined);
            }
            _local_2 = findFocusFromObject(_local_2);
            if (_local_2 == lastFocus) {
                return(undefined);
            }
            if (_local_2 == undefined) {
                doLater(this, "restoreFocus");
                return(undefined);
            }
            var _local_3 = _local_2.hscroll;
            if (_local_3 != undefined) {
                var _local_6 = _local_2.scroll;
                var _local_5 = _local_2.background;
            }
            this.setFocus(_local_2);
            var _local_4 = Selection;
            Selection.setSelection(_local_4.lastBeginIndex, _local_4.lastEndIndex);
            if (_local_3 != undefined) {
                _local_2.scroll = _local_6;
                _local_2.hscroll = _local_3;
                _local_2.background = _local_5;
            }
        }
        function _onMouseDown(Void) {
            bDrawFocus = false;
            if (lastFocus != undefined) {
                lastFocus.drawFocus(false);
            }
            mx.managers.SystemManager.idleFrames = 0;
            var _local_3 = Selection;
            _local_3.lastBeginIndex = Selection.getBeginIndex();
            _local_3.lastEndIndex = Selection.getEndIndex();
            lastMouse.x = _root._xmouse;
            lastMouse.y = _root._ymouse;
            _root.localToGlobal(lastMouse);
        }
        function onMouseUp(Void) {
            if (_visible) {
                doLater(this, "mouseActivate");
            }
        }
        function handleEvent(e) {
            if (e.type == "reveal") {
                mx.managers.SystemManager.activate(form);
            } else {
                mx.managers.SystemManager.deactivate(form);
            }
        }
        static function enableFocusManagement() {
            if (!initialized) {
                initialized = true;
                Object.registerClass("FocusManager", mx.managers.FocusManager);
                if (_root.focusManager == undefined) {
                    _root.createClassObject(mx.managers.FocusManager, "focusManager", mx.managers.DepthManager.highestDepth--);
                }
            }
        }
        static var symbolName = "FocusManager";
        static var symbolOwner = mx.managers.FocusManager;
        static var version = "2.0.2.127";
        var className = "FocusManager";
        var bNeedFocus = false;
        var bDrawFocus = false;
        var defaultPushButtonEnabled = true;
        var activated = true;
        static var initialized = false;
        static var UIObjectExtensionsDependency = mx.core.ext.UIObjectExtensions;
    }
