    class mx.styles.CSSSetStyle
    {
        var styleName, stylecache, _color, setColor, invalidateStyle;
        function CSSSetStyle () {
        }
        function _setStyle(styleProp, newValue) {
            this[styleProp] = newValue;
            if (mx.styles.StyleManager.TextStyleMap[styleProp] != undefined) {
                if (styleProp == "color") {
                    if (isNaN(newValue)) {
                        newValue = mx.styles.StyleManager.getColorName(newValue);
                        this[styleProp] = newValue;
                        if (newValue == undefined) {
                            return(undefined);
                        }
                    }
                }
                _level0.changeTextStyleInChildren(styleProp);
                return(undefined);
            }
            if (mx.styles.StyleManager.isColorStyle(styleProp)) {
                if (isNaN(newValue)) {
                    newValue = mx.styles.StyleManager.getColorName(newValue);
                    this[styleProp] = newValue;
                    if (newValue == undefined) {
                        return(undefined);
                    }
                }
                if (styleProp == "themeColor") {
                    var _local_7 = mx.styles.StyleManager.colorNames.haloBlue;
                    var _local_6 = mx.styles.StyleManager.colorNames.haloGreen;
                    var _local_8 = mx.styles.StyleManager.colorNames.haloOrange;
                    var _local_4 = {};
                    _local_4[_local_7] = 12188666 /* 0xB9FBFA */;
                    _local_4[_local_6] = 13500353 /* 0xCDFFC1 */;
                    _local_4[_local_8] = 16766319 /* 0xFFD56F */;
                    var _local_5 = {};
                    _local_5[_local_7] = 13958653 /* 0xD4FDFD */;
                    _local_5[_local_6] = 14942166 /* 0xE3FFD6 */;
                    _local_5[_local_8] = 16772787 /* 0xFFEEB3 */;
                    var _local_9 = _local_4[newValue];
                    var _local_10 = _local_5[newValue];
                    if (_local_9 == undefined) {
                        _local_9 = newValue;
                    }
                    if (_local_10 == undefined) {
                        _local_10 = newValue;
                    }
                    setStyle("selectionColor", _local_9);
                    setStyle("rollOverColor", _local_10);
                }
                _level0.changeColorStyleInChildren(styleName, styleProp, newValue);
            } else {
                if ((styleProp == "backgroundColor") && (isNaN(newValue))) {
                    newValue = mx.styles.StyleManager.getColorName(newValue);
                    this[styleProp] = newValue;
                    if (newValue == undefined) {
                        return(undefined);
                    }
                }
                _level0.notifyStyleChangeInChildren(styleName, styleProp, newValue);
            }
        }
        function changeTextStyleInChildren(styleProp) {
            var _local_4 = getTimer();
            var _local_5;
            for (_local_5 in this) {
                var _local_2 = this[_local_5];
                if (_local_2._parent == this) {
                    if (_local_2.searchKey != _local_4) {
                        if (_local_2.stylecache != undefined) {
                            delete _local_2.stylecache.tf;
                            delete _local_2.stylecache[styleProp];
                        }
                        _local_2.invalidateStyle(styleProp);
                        _local_2.changeTextStyleInChildren(styleProp);
                        _local_2.searchKey = _local_4;
                    }
                }
            }
        }
        function changeColorStyleInChildren(sheetName, colorStyle, newValue) {
            var _local_6 = getTimer();
            var _local_7;
            for (_local_7 in this) {
                var _local_2 = this[_local_7];
                if (_local_2._parent == this) {
                    if (_local_2.searchKey != _local_6) {
                        if (((_local_2.getStyleName() == sheetName) || (sheetName == undefined)) || (sheetName == "_global")) {
                            if (_local_2.stylecache != undefined) {
                                delete _local_2.stylecache[colorStyle];
                            }
                            if (typeof(_local_2._color) == "string") {
                                if (_local_2._color == colorStyle) {
                                    var _local_4 = _local_2.getStyle(colorStyle);
                                    if (colorStyle == "color") {
                                        if (stylecache.tf["color"] != undefined) {
                                            stylecache.tf["color"] = _local_4;
                                        }
                                    }
                                    _local_2.setColor(_local_4);
                                }
                            } else if (_local_2._color[colorStyle] != undefined) {
                                if (typeof(_local_2) != "movieclip") {
                                    _local_2._parent.invalidateStyle();
                                } else {
                                    _local_2.invalidateStyle(colorStyle);
                                }
                            }
                        }
                        _local_2.changeColorStyleInChildren(sheetName, colorStyle, newValue);
                        _local_2.searchKey = _local_6;
                    }
                }
            }
        }
        function notifyStyleChangeInChildren(sheetName, styleProp, newValue) {
            var _local_5 = getTimer();
            var _local_6;
            for (_local_6 in this) {
                var _local_2 = this[_local_6];
                if (_local_2._parent == this) {
                    if (_local_2.searchKey != _local_5) {
                        if (((_local_2.styleName == sheetName) || ((_local_2.styleName != undefined) && (typeof(_local_2.styleName) == "movieclip"))) || (sheetName == undefined)) {
                            if (_local_2.stylecache != undefined) {
                                delete _local_2.stylecache[styleProp];
                                delete _local_2.stylecache.tf;
                            }
                            delete _local_2.enabledColor;
                            _local_2.invalidateStyle(styleProp);
                        }
                        _local_2.notifyStyleChangeInChildren(sheetName, styleProp, newValue);
                        _local_2.searchKey = _local_5;
                    }
                }
            }
        }
        function setStyle(styleProp, newValue) {
            if (stylecache != undefined) {
                delete stylecache[styleProp];
                delete stylecache.tf;
            }
            this[styleProp] = newValue;
            if (mx.styles.StyleManager.isColorStyle(styleProp)) {
                if (isNaN(newValue)) {
                    newValue = mx.styles.StyleManager.getColorName(newValue);
                    this[styleProp] = newValue;
                    if (newValue == undefined) {
                        return(undefined);
                    }
                }
                if (styleProp == "themeColor") {
                    var _local_10 = mx.styles.StyleManager.colorNames.haloBlue;
                    var _local_9 = mx.styles.StyleManager.colorNames.haloGreen;
                    var _local_11 = mx.styles.StyleManager.colorNames.haloOrange;
                    var _local_6 = {};
                    _local_6[_local_10] = 12188666 /* 0xB9FBFA */;
                    _local_6[_local_9] = 13500353 /* 0xCDFFC1 */;
                    _local_6[_local_11] = 16766319 /* 0xFFD56F */;
                    var _local_7 = {};
                    _local_7[_local_10] = 13958653 /* 0xD4FDFD */;
                    _local_7[_local_9] = 14942166 /* 0xE3FFD6 */;
                    _local_7[_local_11] = 16772787 /* 0xFFEEB3 */;
                    var _local_12 = _local_6[newValue];
                    var _local_13 = _local_7[newValue];
                    if (_local_12 == undefined) {
                        _local_12 = newValue;
                    }
                    if (_local_13 == undefined) {
                        _local_13 = newValue;
                    }
                    setStyle("selectionColor", _local_12);
                    setStyle("rollOverColor", _local_13);
                }
                if (typeof(_color) == "string") {
                    if (_color == styleProp) {
                        if (styleProp == "color") {
                            if (stylecache.tf["color"] != undefined) {
                                stylecache.tf["color"] = newValue;
                            }
                        }
                        setColor(newValue);
                    }
                } else if (_color[styleProp] != undefined) {
                    invalidateStyle(styleProp);
                }
                changeColorStyleInChildren(undefined, styleProp, newValue);
            } else {
                if ((styleProp == "backgroundColor") && (isNaN(newValue))) {
                    newValue = mx.styles.StyleManager.getColorName(newValue);
                    this[styleProp] = newValue;
                    if (newValue == undefined) {
                        return(undefined);
                    }
                }
                invalidateStyle(styleProp);
            }
            if (mx.styles.StyleManager.isInheritingStyle(styleProp) || (styleProp == "styleName")) {
                var _local_8;
                var _local_5 = newValue;
                if (styleProp == "styleName") {
                    _local_8 = ((typeof(newValue) == "string") ? (_global.styles[newValue]) : (_local_5));
                    _local_5 = _local_8.themeColor;
                    if (_local_5 != undefined) {
                        _local_8.rollOverColor = (_local_8.selectionColor = _local_5);
                    }
                }
                notifyStyleChangeInChildren(undefined, styleProp, newValue);
            }
        }
        static function enableRunTimeCSS() {
        }
        static function classConstruct() {
            var _local_2 = MovieClip.prototype;
            var _local_3 = mx.styles.CSSSetStyle.prototype;
            mx.styles.CSSStyleDeclaration.prototype.setStyle = _local_3._setStyle;
            _local_2.changeTextStyleInChildren = _local_3.changeTextStyleInChildren;
            _local_2.changeColorStyleInChildren = _local_3.changeColorStyleInChildren;
            _local_2.notifyStyleChangeInChildren = _local_3.notifyStyleChangeInChildren;
            _local_2.setStyle = _local_3.setStyle;
            _global.ASSetPropFlags(_local_2, "changeTextStyleInChildren", 1);
            _global.ASSetPropFlags(_local_2, "changeColorStyleInChildren", 1);
            _global.ASSetPropFlags(_local_2, "notifyStyleChangeInChildren", 1);
            _global.ASSetPropFlags(_local_2, "setStyle", 1);
            var _local_4 = TextField.prototype;
            _local_4.setStyle = _local_2.setStyle;
            _local_4.changeTextStyleInChildren = _local_3.changeTextStyleInChildren;
            return(true);
        }
        static var classConstructed = classConstruct();
        static var CSSStyleDeclarationDependency = mx.styles.CSSStyleDeclaration;
    }
