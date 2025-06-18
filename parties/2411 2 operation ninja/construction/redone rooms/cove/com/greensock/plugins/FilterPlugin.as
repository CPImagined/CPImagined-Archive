//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.FilterPlugin extends com.greensock.plugins.TweenPlugin
    {
        var _target, _index, _type, _filter, _remove, onComplete, propName, _tweens, addTween, __get__changeFactor;
        function FilterPlugin () {
            super();
        }
        function initFilter(props, defaultFilter, propNames) {
            var _local_6 = _target.filters;
            var _local_2;
            var _local_3;
            var _local_5;
            var _local_7 = ((props instanceof flash.filters.BitmapFilter) ? ({}) : (props));
            _index = -1;
            if (_local_7.index != undefined) {
                _index = _local_7.index;
            } else {
                _local_3 = _local_6.length;
                while (_local_3--) {
                    if (_local_6[_local_3] instanceof _type) {
                        _index = _local_3;
                        break;
                    }
                }
            }
            if (((_index == -1) || (_local_6[_index] == undefined)) || (_local_7.addFilter == true)) {
                _index = ((_local_7.index != undefined) ? (_local_7.index) : (_local_6.length));
                _local_6[_index] = defaultFilter;
                _target.filters = _local_6;
            }
            _filter = _local_6[_index];
            if (_local_7.remove == true) {
                _remove = true;
                onComplete = onCompleteTween;
            }
            _local_3 = propNames.length;
            while (_local_3--) {
                _local_2 = propNames[_local_3];
                if ((props[_local_2] != undefined) && (_filter[_local_2] != props[_local_2])) {
                    if (((_local_2 == "color") || (_local_2 == "highlightColor")) || (_local_2 == "shadowColor")) {
                        _local_5 = new com.greensock.plugins.HexColorsPlugin();
                        _local_5.initColor(_filter, _local_2, _filter[_local_2], props[_local_2]);
                        _tweens[_tweens.length] = new com.greensock.core.PropTween(_local_5, "changeFactor", 0, 1, propName);
                    } else if ((((_local_2 == "quality") || (_local_2 == "inner")) || (_local_2 == "knockout")) || (_local_2 == "hideObject")) {
                        _filter[_local_2] = props[_local_2];
                    } else {
                        addTween(_filter, _local_2, _filter[_local_2], props[_local_2], propName);
                    }
                }
            }
        }
        function onCompleteTween() {
            if (_remove) {
                var _local_3 = _target.filters;
                if (!(_local_3[_index] instanceof _type)) {
                    var _local_2 = _local_3.length;
                    while (_local_2--) {
                        if (_local_3[_local_2] instanceof _type) {
                            _local_3.splice(_local_2, 1);
                            break;
                        }
                    }
                } else {
                    _local_3.splice(_index, 1);
                }
                _target.filters = _local_3;
            }
        }
        function set changeFactor(n) {
            var _local_2 = _tweens.length;
            var _local_3;
            var _local_4 = _target.filters;
            while (_local_2--) {
                _local_3 = _tweens[_local_2];
                _local_3.target[_local_3.property] = _local_3.start + (_local_3.change * n);
            }
            if (!(_local_4[_index] instanceof _type)) {
                _local_2 = (_index = _local_4.length);
                while (_local_2--) {
                    if (_local_4[_local_2] instanceof _type) {
                        _index = _local_2;
                        break;
                    }
                }
            }
            _local_4[_index] = _filter;
            _target.filters = _local_4;
            //return(__get__changeFactor());
        }
        static var VERSION = 2.03;
        static var API = 1;
    }
