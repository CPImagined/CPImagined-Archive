//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.controls.Button extends mx.controls.SimpleButton
    {
        var initializing, labelPath, initIcon, getState, enabled, phase, idNames, __width, __height, setState, invalidate, iconName, refresh, createLabel, _iconLinkageName, removeIcons, hitArea_mc, createEmptyObject;
        function Button () {
            super();
        }
        function init(Void) {
            super.init();
        }
        function draw() {
            if (initializing) {
                labelPath.visible = true;
            }
            super.draw();
            if (initIcon != undefined) {
                _setIcon(initIcon);
            }
            delete initIcon;
        }
        function onRelease(Void) {
            super.onRelease();
        }
        function createChildren(Void) {
            super.createChildren();
        }
        function setSkin(tag, linkageName, initobj) {
            return(super.setSkin(tag, linkageName, initobj));
        }
        function viewSkin(varName) {
            var _local_3 = (getState() ? "true" : "false");
            _local_3 = _local_3 + (enabled ? (phase) : "disabled");
            super.viewSkin(varName, {styleName:this, borderStyle:_local_3});
        }
        function invalidateStyle(c) {
            labelPath.invalidateStyle(c);
            super.invalidateStyle(c);
        }
        function setColor(c) {
            var _local_2 = 0;
            while (_local_2 < 8) {
                this[idNames[_local_2]].redraw(true);
                _local_2++;
            }
        }
        function setEnabled(enable) {
            labelPath.enabled = enable;
            super.setEnabled(enable);
        }
        function calcSize(tag, ref) {
            if ((__width == undefined) || (__height == undefined)) {
                return(undefined);
            }
            if (tag < 7) {
                ref.setSize(__width, __height, true);
            }
        }
        function size(Void) {
            setState(getState());
            setHitArea(__width, __height);
            var _local_3 = 0;
            while (_local_3 < 8) {
                var _local_4 = idNames[_local_3];
                if (typeof(this[_local_4]) == "movieclip") {
                    this[_local_4].setSize(__width, __height, true);
                }
                _local_3++;
            }
            super.size();
        }
        function set labelPlacement(val) {
            __labelPlacement = val;
            invalidate();
            //return(labelPlacement);
        }
        function get labelPlacement() {
            return(__labelPlacement);
        }
        function getLabelPlacement(Void) {
            return(__labelPlacement);
        }
        function setLabelPlacement(val) {
            __labelPlacement = val;
            invalidate();
        }
        function getBtnOffset(Void) {
            if (getState()) {
                var _local_2 = btnOffset;
            } else if (phase == "down") {
                var _local_2 = btnOffset;
            } else {
                var _local_2 = 0;
            }
            return(_local_2);
        }
        function setView(offset) {
            var _local_16 = (offset ? (btnOffset) : 0);
            var _local_12 = getLabelPlacement();
            var _local_7 = 0;
            var _local_6 = 0;
            var _local_9 = 0;
            var _local_8 = 0;
            var _local_5 = 0;
            var _local_4 = 0;
            var _local_3 = labelPath;
            var _local_2 = iconName;
            var _local_15 = _local_3.textWidth;
            var _local_14 = _local_3.textHeight;
            var _local_10 = (__width - borderW) - borderW;
            var _local_11 = (__height - borderW) - borderW;
            if (_local_2 != undefined) {
                _local_7 = _local_2._width;
                _local_6 = _local_2._height;
            }
            if ((_local_12 == "left") || (_local_12 == "right")) {
                if (_local_3 != undefined) {
                    _local_9 = Math.min(_local_10 - _local_7, _local_15 + 5);
                    _local_3._width = _local_9;
                    _local_8 = Math.min(_local_11, _local_14 + 5);
                    _local_3._height = _local_8;
                }
                if (_local_12 == "right") {
                    _local_5 = _local_7;
                    if (centerContent) {
                        _local_5 = _local_5 + (((_local_10 - _local_9) - _local_7) / 2);
                    }
                    _local_2._x = _local_5 - _local_7;
                } else {
                    _local_5 = (_local_10 - _local_9) - _local_7;
                    if (centerContent) {
                        _local_5 = _local_5 / 2;
                    }
                    _local_2._x = _local_5 + _local_9;
                }
                _local_4 = 0;
                _local_2._y = _local_4;
                if (centerContent) {
                    _local_2._y = (_local_11 - _local_6) / 2;
                    _local_4 = (_local_11 - _local_8) / 2;
                }
                if (!centerContent) {
                    _local_2._y = _local_2._y + Math.max(0, (_local_8 - _local_6) / 2);
                }
            } else {
                if (_local_3 != undefined) {
                    _local_9 = Math.min(_local_10, _local_15 + 5);
                    _local_3._width = _local_9;
                    _local_8 = Math.min(_local_11 - _local_6, _local_14 + 5);
                    _local_3._height = _local_8;
                }
                _local_5 = (_local_10 - _local_9) / 2;
                _local_2._x = (_local_10 - _local_7) / 2;
                if (_local_12 == "top") {
                    _local_4 = (_local_11 - _local_8) - _local_6;
                    if (centerContent) {
                        _local_4 = _local_4 / 2;
                    }
                    _local_2._y = _local_4 + _local_8;
                } else {
                    _local_4 = _local_6;
                    if (centerContent) {
                        _local_4 = _local_4 + (((_local_11 - _local_8) - _local_6) / 2);
                    }
                    _local_2._y = _local_4 - _local_6;
                }
            }
            var _local_13 = borderW + _local_16;
            _local_3._x = _local_5 + _local_13;
            _local_3._y = _local_4 + _local_13;
            _local_2._x = _local_2._x + _local_13;
            _local_2._y = _local_2._y + _local_13;
        }
        function set label(lbl) {
            setLabel(lbl);
            //return(label);
        }
        function setLabel(label) {
            if (label == "") {
                labelPath.removeTextField();
                refresh();
                return(undefined);
            }
            if (labelPath == undefined) {
                var _local_2 = createLabel("labelPath", 200, label);
                _local_2._width = _local_2.textWidth + 5;
                _local_2._height = _local_2.textHeight + 5;
                if (initializing) {
                    _local_2.visible = false;
                }
            } else {
                delete labelPath.__text;
                labelPath.text = label;
                refresh();
            }
        }
        function getLabel(Void) {
            return(((labelPath.__text != undefined) ? (labelPath.__text) : (labelPath.text)));
        }
        function get label() {
            return(getLabel());
        }
        function _getIcon(Void) {
            return(_iconLinkageName);
        }
        function get icon() {
            if (initializing) {
                return(initIcon);
            }
            return(_iconLinkageName);
        }
        function _setIcon(linkage) {
            if (initializing) {
                if (linkage == "") {
                    return(undefined);
                }
                initIcon = linkage;
            } else {
                if (linkage == "") {
                    removeIcons();
                    return(undefined);
                }
                super.changeIcon(0, linkage);
                super.changeIcon(1, linkage);
                super.changeIcon(3, linkage);
                super.changeIcon(4, linkage);
                super.changeIcon(5, linkage);
                _iconLinkageName = linkage;
                refresh();
            }
        }
        function set icon(linkage) {
            _setIcon(linkage);
            //return(icon);
        }
        function setHitArea(w, h) {
            if (hitArea_mc == undefined) {
                createEmptyObject("hitArea_mc", 100);
            }
            var _local_2 = hitArea_mc;
            _local_2.clear();
            _local_2.beginFill(16711680);
            _local_2.drawRect(0, 0, w, h);
            _local_2.endFill();
            _local_2.setVisible(false);
        }
        static var symbolName = "Button";
        static var symbolOwner = mx.controls.Button;
        var className = "Button";
        static var version = "2.0.2.127";
        var btnOffset = 0;
        var _color = "buttonColor";
        var __label = "default value";
        var __labelPlacement = "right";
        var falseUpSkin = "ButtonSkin";
        var falseDownSkin = "ButtonSkin";
        var falseOverSkin = "ButtonSkin";
        var falseDisabledSkin = "ButtonSkin";
        var trueUpSkin = "ButtonSkin";
        var trueDownSkin = "ButtonSkin";
        var trueOverSkin = "ButtonSkin";
        var trueDisabledSkin = "ButtonSkin";
        var falseUpIcon = "";
        var falseDownIcon = "";
        var falseOverIcon = "";
        var falseDisabledIcon = "";
        var trueUpIcon = "";
        var trueDownIcon = "";
        var trueOverIcon = "";
        var trueDisabledIcon = "";
        var clipParameters = {labelPlacement:1, icon:1, toggle:1, selected:1, label:1};
        static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.controls.Button.prototype.clipParameters, mx.controls.SimpleButton.prototype.clipParameters);
        var centerContent = true;
        var borderW = 1;
    }
