    class mx.core.ext.UIObjectExtensions
    {
        function UIObjectExtensions () {
        }
        static function addGeometry(tf, ui) {
            tf.addProperty("width", ui.__get__width, null);
            tf.addProperty("height", ui.__get__height, null);
            tf.addProperty("left", ui.__get__left, null);
            tf.addProperty("x", ui.__get__x, null);
            tf.addProperty("top", ui.__get__top, null);
            tf.addProperty("y", ui.__get__y, null);
            tf.addProperty("right", ui.__get__right, null);
            tf.addProperty("bottom", ui.__get__bottom, null);
            tf.addProperty("visible", ui.__get__visible, ui.__set__visible);
        }
        static function Extensions() {
            if (bExtended == true) {
                return(true);
            }
            bExtended = true;
            var _local_6 = mx.core.UIObject.prototype;
            var _local_9 = mx.skins.SkinElement.prototype;
            addGeometry(_local_9, _local_6);
            mx.events.UIEventDispatcher.initialize(_local_6);
            var _local_13 = mx.skins.ColoredSkinElement;
            mx.styles.CSSTextStyles.addTextStyles(_local_6);
            var _local_5 = MovieClip.prototype;
            _local_5.getTopLevel = _local_6.getTopLevel;
            _local_5.createLabel = _local_6.createLabel;
            _local_5.createObject = _local_6.createObject;
            _local_5.createClassObject = _local_6.createClassObject;
            _local_5.createEmptyObject = _local_6.createEmptyObject;
            _local_5.destroyObject = _local_6.destroyObject;
            _global.ASSetPropFlags(_local_5, "getTopLevel", 1);
            _global.ASSetPropFlags(_local_5, "createLabel", 1);
            _global.ASSetPropFlags(_local_5, "createObject", 1);
            _global.ASSetPropFlags(_local_5, "createClassObject", 1);
            _global.ASSetPropFlags(_local_5, "createEmptyObject", 1);
            _global.ASSetPropFlags(_local_5, "destroyObject", 1);
            _local_5.__getTextFormat = _local_6.__getTextFormat;
            _local_5._getTextFormat = _local_6._getTextFormat;
            _local_5.getStyleName = _local_6.getStyleName;
            _local_5.getStyle = _local_6.getStyle;
            _global.ASSetPropFlags(_local_5, "__getTextFormat", 1);
            _global.ASSetPropFlags(_local_5, "_getTextFormat", 1);
            _global.ASSetPropFlags(_local_5, "getStyleName", 1);
            _global.ASSetPropFlags(_local_5, "getStyle", 1);
            var _local_7 = TextField.prototype;
            addGeometry(_local_7, _local_6);
            _local_7.addProperty("enabled", function () {
                return(this.__enabled);
            }, function (x) {
                this.__enabled = x;
                this.invalidateStyle();
            });
            _local_7.move = _local_9.move;
            _local_7.setSize = _local_9.setSize;
            _local_7.invalidateStyle = function () {
                this.invalidateFlag = true;
            };
            _local_7.draw = function () {
                if (this.invalidateFlag) {
                    this.invalidateFlag = false;
                    var _local_2 = this._getTextFormat();
                    this.setTextFormat(_local_2);
                    this.setNewTextFormat(_local_2);
                    this.embedFonts = _local_2.embedFonts == true;
                    if (this.__text != undefined) {
                        if (this.text == "") {
                            this.text = this.__text;
                        }
                        delete this.__text;
                    }
                    this._visible = true;
                }
            };
            _local_7.setColor = function (color) {
                this.textColor = color;
            };
            _local_7.getStyle = _local_5.getStyle;
            _local_7.__getTextFormat = _local_6.__getTextFormat;
            _local_7.setValue = function (v) {
                this.text = v;
            };
            _local_7.getValue = function () {
                return(this.text);
            };
            _local_7.addProperty("value", function () {
                return(this.getValue());
            }, function (v) {
                this.setValue(v);
            });
            _local_7._getTextFormat = function () {
                var _local_2 = this.stylecache.tf;
                if (_local_2 != undefined) {
                    return(_local_2);
                }
                _local_2 = new TextFormat();
                this.__getTextFormat(_local_2);
                this.stylecache.tf = _local_2;
                if (this.__enabled == false) {
                    if (this.enabledColor == undefined) {
                        var _local_4 = this.getTextFormat();
                        this.enabledColor = _local_4["color"];
                    }
                    var _local_3 = this.getStyle("disabledColor");
                    _local_2["color"] = _local_3;
                } else if (this.enabledColor != undefined) {
                    if (_local_2["color"] == undefined) {
                        _local_2["color"] = this.enabledColor;
                    }
                }
                return(_local_2);
            };
            _local_7.getPreferredWidth = function () {
                this.draw();
                return(this.textWidth + 4);
            };
            _local_7.getPreferredHeight = function () {
                this.draw();
                return(this.textHeight + 4);
            };
            TextFormat.prototype.getTextExtent2 = function (s) {
                var _local_3 = _root._getTextExtent;
                if (_local_3 == undefined) {
                    _root.createTextField("_getTextExtent", -2, 0, 0, 1000, 100);
                    _local_3 = _root._getTextExtent;
                    _local_3._visible = false;
                }
                _root._getTextExtent.text = s;
                var _local_4 = this.align;
                this.align = "left";
                _root._getTextExtent.setTextFormat(this);
                this.align = _local_4;
                return({width:_local_3.textWidth, height:_local_3.textHeight});
            };
            if (_global.style == undefined) {
                _global.style = new mx.styles.CSSStyleDeclaration();
                _global.cascadingStyles = true;
                _global.styles = new Object();
                _global.skinRegistry = new Object();
                if (_global._origWidth == undefined) {
                    _global.origWidth = Stage.width;
                    _global.origHeight = Stage.height;
                }
            }
            var _local_4 = _root;
            while (_local_4._parent != undefined) {
                _local_4 = _local_4._parent;
            }
            _local_4.addProperty("width", function () {
                return(Stage.width);
            }, null);
            _local_4.addProperty("height", function () {
                return(Stage.height);
            }, null);
            _global.ASSetPropFlags(_local_4, "width", 1);
            _global.ASSetPropFlags(_local_4, "height", 1);
            return(true);
        }
        static var bExtended = false;
        static var UIObjectExtended = Extensions();
        static var UIObjectDependency = mx.core.UIObject;
        static var SkinElementDependency = mx.skins.SkinElement;
        static var CSSTextStylesDependency = mx.styles.CSSTextStyles;
        static var UIEventDispatcherDependency = mx.events.UIEventDispatcher;
    }
