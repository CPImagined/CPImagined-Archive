//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.FilterPlugin extends com.greensock.plugins.TweenPlugin
    {
        var _target, _index, _type, _filter, _remove, onComplete, propName, _tweens, addTween, __get__changeFactor;
        function FilterPlugin () {
            super();
        }
        function initFilter(props, defaultFilter, propNames) {
            var filters = _target.filters;
            var p;
            var i;
            var colorTween;
            var extras = ((props instanceof flash.filters.BitmapFilter) ? ({}) : (props));
            _index = -1;
            if (extras.index != undefined) {
                _index = extras.index;
            } else {
                i = filters.length;
                while (i--) {
                    if (filters[i] instanceof _type) {
                        _index = i;
                        break;
                    }
                }
            }
            if (((_index == -1) || (filters[_index] == undefined)) || (extras.addFilter == true)) {
                _index = ((extras.index != undefined) ? (extras.index) : (filters.length));
                filters[_index] = defaultFilter;
                _target.filters = filters;
            }
            _filter = filters[_index];
            if (extras.remove == true) {
                _remove = true;
                onComplete = onCompleteTween;
            }
            i = propNames.length;
            while (i--) {
                p = propNames[i];
                if ((props[p] != undefined) && (_filter[p] != props[p])) {
                    if (((p == "color") || (p == "highlightColor")) || (p == "shadowColor")) {
                        colorTween = new com.greensock.plugins.HexColorsPlugin();
                        colorTween.initColor(_filter, p, _filter[p], props[p]);
                        _tweens[_tweens.length] = new com.greensock.core.PropTween(colorTween, "changeFactor", 0, 1, propName);
                    } else if ((((p == "quality") || (p == "inner")) || (p == "knockout")) || (p == "hideObject")) {
                        _filter[p] = props[p];
                    } else {
                        addTween(_filter, p, _filter[p], props[p], propName);
                    }
                }
            }
        }
        function onCompleteTween() {
            if (_remove) {
                var filters = _target.filters;
                if (!(filters[_index] instanceof _type)) {
                    var i = filters.length;
                    while (i--) {
                        if (filters[i] instanceof _type) {
                            filters.splice(i, 1);
                            break;
                        }
                    }
                } else {
                    filters.splice(_index, 1);
                }
                _target.filters = filters;
            }
        }
        function set changeFactor(n) {
            var i = _tweens.length;
            var pt;
            var filters = _target.filters;
            while (i--) {
                pt = _tweens[i];
                pt.target[pt.property] = pt.start + (pt.change * n);
            }
            if (!(filters[_index] instanceof _type)) {
                i = (_index = filters.length);
                while (i--) {
                    if (filters[i] instanceof _type) {
                        _index = i;
                        break;
                    }
                }
            }
            filters[_index] = _filter;
            _target.filters = filters;
            //return(__get__changeFactor());
        }
        static var VERSION = 2.03;
        static var API = 1;
    }
