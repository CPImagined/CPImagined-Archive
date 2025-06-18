//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.core.UIObject extends MovieClip
    {
        var _width, _height, _x, _y, _parent, _minHeight, _minWidth, _visible, dispatchEvent, _xscale, _yscale, methodTable, onEnterFrame, tfList, __width, __height, moveTo, lineTo, createTextField, attachMovie, buildDepthTable, findNextAvailableDepth, idNames, childrenCreated, _name, createAccessibilityImplementation, _endInit, validateNow, hasOwnProperty, initProperties, stylecache, className, ignoreClassStyleDeclaration, _tf, fontFamily, fontSize, color, marginLeft, marginRight, fontStyle, fontWeight, textAlign, textIndent, textDecoration, embedFonts, styleName, enabled;
        function UIObject () {
            super();
            constructObject();
        }
        function get width() {
            return(_width);
        }
        function get height() {
            return(_height);
        }
        function get left() {
            return(_x);
        }
        function get x() {
            return(_x);
        }
        function get top() {
            return(_y);
        }
        function get y() {
            return(_y);
        }
        function get right() {
            return(_parent.width - (_x + width));
        }
        function get bottom() {
            return(_parent.height - (_y + height));
        }
        function getMinHeight(Void) {
            return(_minHeight);
        }
        function setMinHeight(h) {
            _minHeight = h;
        }
        function get minHeight() {
            return(getMinHeight());
        }
        function set minHeight(h) {
            setMinHeight(h);
            //return(minHeight);
        }
        function getMinWidth(Void) {
            return(_minWidth);
        }
        function setMinWidth(w) {
            _minWidth = w;
        }
        function get minWidth() {
            return(getMinWidth());
        }
        function set minWidth(w) {
            setMinWidth(w);
            //return(minWidth);
        }
        function setVisible(x, noEvent) {
            if (x != _visible) {
                _visible = x;
                if (noEvent != true) {
                    dispatchEvent({type:(x ? "reveal" : "hide")});
                }
            }
        }
        function get visible() {
            return(_visible);
        }
        function set visible(x) {
            setVisible(x, false);
            //return(visible);
        }
        function get scaleX() {
            return(_xscale);
        }
        function set scaleX(x) {
            _xscale = x;
            //return(scaleX);
        }
        function get scaleY() {
            return(_yscale);
        }
        function set scaleY(y) {
            _yscale = y;
            //return(scaleY);
        }
        function doLater(obj, fn) {
            if (methodTable == undefined) {
                methodTable = new Array();
            }
            methodTable.push({obj:obj, fn:fn});
            onEnterFrame = doLaterDispatcher;
        }
        function doLaterDispatcher(Void) {
            delete onEnterFrame;
            if (invalidateFlag) {
                redraw();
            }
            var _local_3 = methodTable;
            methodTable = new Array();
            if (_local_3.length > 0) {
                var _local_2;
                while (_local_2 = _local_3.shift() , _local_2 != undefined) {
                    _local_2.obj[_local_2.fn]();
                }
            }
        }
        function cancelAllDoLaters(Void) {
            delete onEnterFrame;
            methodTable = new Array();
        }
        function invalidate(Void) {
            invalidateFlag = true;
            onEnterFrame = doLaterDispatcher;
        }
        function invalidateStyle(Void) {
            invalidate();
        }
        function redraw(bAlways) {
            if (invalidateFlag || (bAlways)) {
                invalidateFlag = false;
                var _local_2;
                for (_local_2 in tfList) {
                    tfList[_local_2].draw();
                }
                draw();
                dispatchEvent({type:"draw"});
            }
        }
        function draw(Void) {
        }
        function move(x, y, noEvent) {
            var _local_3 = _x;
            var _local_2 = _y;
            _x = x;
            _y = y;
            if (noEvent != true) {
                dispatchEvent({type:"move", oldX:_local_3, oldY:_local_2});
            }
        }
        function setSize(w, h, noEvent) {
            var _local_2 = __width;
            var _local_3 = __height;
            __width = w;
            __height = h;
            this.size();
            if (noEvent != true) {
                dispatchEvent({type:"resize", oldWidth:_local_2, oldHeight:_local_3});
            }
        }
        function size(Void) {
            _width = __width;
            _height = __height;
        }
        function drawRect(x1, y1, x2, y2) {
            this.moveTo(x1, y1);
            this.lineTo(x2, y1);
            this.lineTo(x2, y2);
            this.lineTo(x1, y2);
            this.lineTo(x1, y1);
        }
        function createLabel(name, depth, text) {
            this.createTextField(name, depth, 0, 0, 0, 0);
            var _local_2 = this[name];
            _local_2._color = textColorList;
            _local_2._visible = false;
            _local_2.__text = text;
            if (tfList == undefined) {
                tfList = new Object();
            }
            tfList[name] = _local_2;
            _local_2.invalidateStyle();
            invalidate();
            _local_2.styleName = this;
            return(_local_2);
        }
        function createObject(linkageName, id, depth, initobj) {
            return(this.attachMovie(linkageName, id, depth, initobj));
        }
        function createClassObject(className, id, depth, initobj) {
            var _local_3 = className.symbolName == undefined;
            if (_local_3) {
                Object.registerClass(className.symbolOwner.symbolName, className);
            }
            var _local_4 = createObject(className.symbolOwner.symbolName, id, depth, initobj);
            if (_local_3) {
                Object.registerClass(className.symbolOwner.symbolName, className.symbolOwner);
            }
            return(_local_4);
        }
        function createEmptyObject(id, depth) {
            return(createClassObject(mx.core.UIObject, id, depth));
        }
        function destroyObject(id) {
            var _local_2 = this[id];
            if (_local_2.getDepth() < 0) {
                var _local_4 = buildDepthTable();
                var _local_5 = findNextAvailableDepth(0, _local_4, "up");
                var _local_3 = _local_5;
                _local_2.swapDepths(_local_3);
            }
            _local_2.removeMovieClip();
            delete this[id];
        }
        function getSkinIDName(tag) {
            return(idNames[tag]);
        }
        function setSkin(tag, linkageName, initObj) {
            if (_global.skinRegistry[linkageName] == undefined) {
                mx.skins.SkinElement.registerElement(linkageName, mx.skins.SkinElement);
            }
            return(createObject(linkageName, getSkinIDName(tag), tag, initObj));
        }
        function createSkin(tag) {
            var _local_2 = getSkinIDName(tag);
            createEmptyObject(_local_2, tag);
            return(this[_local_2]);
        }
        function createChildren(Void) {
        }
        function _createChildren(Void) {
            createChildren();
            childrenCreated = true;
        }
        function constructObject(Void) {
            if (_name == undefined) {
                return(undefined);
            }
            init();
            _createChildren();
            createAccessibilityImplementation();
            _endInit();
            if (validateNow) {
                redraw(true);
            } else {
                invalidate();
            }
        }
        function initFromClipParameters(Void) {
            var _local_4 = false;
            var _local_2;
            for (_local_2 in clipParameters) {
                if (hasOwnProperty(_local_2)) {
                    _local_4 = true;
                    this["def_" + _local_2] = this[_local_2];
                    delete this[_local_2];
                }
            }
            if (_local_4) {
                for (_local_2 in clipParameters) {
                    var _local_3 = this["def_" + _local_2];
                    if (_local_3 != undefined) {
                        this[_local_2] = _local_3;
                    }
                }
            }
        }
        function init(Void) {
            __width = _width;
            __height = _height;
            if (initProperties == undefined) {
                initFromClipParameters();
            } else {
                initProperties();
            }
            if (_global.cascadingStyles == true) {
                stylecache = new Object();
            }
        }
        function getClassStyleDeclaration(Void) {
            var _local_4 = this;
            var _local_3 = className;
            while (_local_3 != undefined) {
                if (ignoreClassStyleDeclaration[_local_3] == undefined) {
                    if (_global.styles[_local_3] != undefined) {
                        return(_global.styles[_local_3]);
                    }
                }
                _local_4 = _local_4.__proto__;
                _local_3 = _local_4.className;
            }
        }
        function setColor(color) {
        }
        function __getTextFormat(tf, bAll) {
            var _local_8 = stylecache.tf;
            if (_local_8 != undefined) {
                var _local_3;
                for (_local_3 in mx.styles.StyleManager.TextFormatStyleProps) {
                    if (bAll || (mx.styles.StyleManager.TextFormatStyleProps[_local_3])) {
                        if (tf[_local_3] == undefined) {
                            tf[_local_3] = _local_8[_local_3];
                        }
                    }
                }
                return(false);
            }
            var _local_6 = false;
            for (var _local_3 in mx.styles.StyleManager.TextFormatStyleProps) {
                if (bAll || (mx.styles.StyleManager.TextFormatStyleProps[_local_3])) {
                    if (tf[_local_3] == undefined) {
                        var _local_5 = _tf[_local_3];
                        if (_local_5 != undefined) {
                            tf[_local_3] = _local_5;
                        } else if ((_local_3 == "font") && (fontFamily != undefined)) {
                            tf[_local_3] = fontFamily;
                        } else if ((_local_3 == "size") && (fontSize != undefined)) {
                            tf[_local_3] = fontSize;
                        } else if ((_local_3 == "color") && (color != undefined)) {
                            tf[_local_3] = color;
                        } else if ((_local_3 == "leftMargin") && (marginLeft != undefined)) {
                            tf[_local_3] = marginLeft;
                        } else if ((_local_3 == "rightMargin") && (marginRight != undefined)) {
                            tf[_local_3] = marginRight;
                        } else if ((_local_3 == "italic") && (fontStyle != undefined)) {
                            tf[_local_3] = fontStyle == _local_3;
                        } else if ((_local_3 == "bold") && (fontWeight != undefined)) {
                            tf[_local_3] = fontWeight == _local_3;
                        } else if ((_local_3 == "align") && (textAlign != undefined)) {
                            tf[_local_3] = textAlign;
                        } else if ((_local_3 == "indent") && (textIndent != undefined)) {
                            tf[_local_3] = textIndent;
                        } else if ((_local_3 == "underline") && (textDecoration != undefined)) {
                            tf[_local_3] = textDecoration == _local_3;
                        } else if ((_local_3 == "embedFonts") && (embedFonts != undefined)) {
                            tf[_local_3] = embedFonts;
                        } else {
                            _local_6 = true;
                        }
                    }
                }
            }
            if (_local_6) {
                var _local_9 = styleName;
                if (_local_9 != undefined) {
                    if (typeof(_local_9) != "string") {
                        _local_6 = _local_9.__getTextFormat(tf, true, this);
                    } else if (_global.styles[_local_9] != undefined) {
                        _local_6 = _global.styles[_local_9].__getTextFormat(tf, true, this);
                    }
                }
            }
            if (_local_6) {
                var _local_10 = getClassStyleDeclaration();
                if (_local_10 != undefined) {
                    _local_6 = _local_10.__getTextFormat(tf, true, this);
                }
            }
            if (_local_6) {
                if (_global.cascadingStyles) {
                    if (_parent != undefined) {
                        _local_6 = _parent.__getTextFormat(tf, false);
                    }
                }
            }
            if (_local_6) {
                _local_6 = _global.style.__getTextFormat(tf, true, this);
            }
            return(_local_6);
        }
        function _getTextFormat(Void) {
            var _local_2 = stylecache.tf;
            if (_local_2 != undefined) {
                return(_local_2);
            }
            _local_2 = new TextFormat();
            __getTextFormat(_local_2, true);
            stylecache.tf = _local_2;
            if (enabled == false) {
                var _local_3 = getStyle("disabledColor");
                _local_2["color"] = _local_3;
            }
            return(_local_2);
        }
        function getStyleName(Void) {
            var _local_2 = styleName;
            if (_local_2 != undefined) {
                if (typeof(_local_2) != "string") {
                    return(_local_2.getStyleName());
                } else {
                    return(_local_2);
                }
            }
            if (_parent != undefined) {
                return(_parent.getStyleName());
            } else {
                return(undefined);
            }
        }
        function getStyle(styleProp) {
            var _local_3;
            _global.getStyleCounter++;
            if (this[styleProp] != undefined) {
                return(this[styleProp]);
            }
            var _local_6 = styleName;
            if (_local_6 != undefined) {
                if (typeof(_local_6) != "string") {
                    _local_3 = _local_6.getStyle(styleProp);
                } else {
                    var _local_7 = _global.styles[_local_6];
                    _local_3 = _local_7.getStyle(styleProp);
                }
            }
            if (_local_3 != undefined) {
                return(_local_3);
            }
            var _local_7 = getClassStyleDeclaration();
            if (_local_7 != undefined) {
                _local_3 = _local_7[styleProp];
            }
            if (_local_3 != undefined) {
                return(_local_3);
            }
            if (_global.cascadingStyles) {
                if (mx.styles.StyleManager.isInheritingStyle(styleProp) || (mx.styles.StyleManager.isColorStyle(styleProp))) {
                    var _local_5 = stylecache;
                    if (_local_5 != undefined) {
                        if (_local_5[styleProp] != undefined) {
                            return(_local_5[styleProp]);
                        }
                    }
                    if (_parent != undefined) {
                        _local_3 = _parent.getStyle(styleProp);
                    } else {
                        _local_3 = _global.style[styleProp];
                    }
                    if (_local_5 != undefined) {
                        _local_5[styleProp] = _local_3;
                    }
                    return(_local_3);
                }
            }
            if (_local_3 == undefined) {
                _local_3 = _global.style[styleProp];
            }
            return(_local_3);
        }
        static function mergeClipParameters(o, p) {
            for (var _local_3 in p) {
                o[_local_3] = p[_local_3];
            }
            return(true);
        }
        static var symbolName = "UIObject";
        static var symbolOwner = mx.core.UIObject;
        static var version = "2.0.2.127";
        static var textColorList = {color:1, disabledColor:1};
        var invalidateFlag = false;
        var lineWidth = 1;
        var lineColor = 0;
        var tabEnabled = false;
        var clipParameters = {visible:1, minHeight:1, minWidth:1, maxHeight:1, maxWidth:1, preferredHeight:1, preferredWidth:1};
    }
