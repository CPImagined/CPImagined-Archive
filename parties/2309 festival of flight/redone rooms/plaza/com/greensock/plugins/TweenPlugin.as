//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.TweenPlugin
    {
        var _tweens, _changeFactor, propName, round, overwriteProps;
        function TweenPlugin () {
            _tweens = [];
            _changeFactor = 0;
        }
        function onInitTween(target, value, tween) {
            addTween(target, propName, target[propName], value, propName);
            return(true);
        }
        function addTween(object, propName, start, end, overwriteProp) {
            if (end != undefined) {
                var _local_3 = ((typeof(end) == "number") ? (Number(end) - start) : (Number(end)));
                if (_local_3 != 0) {
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(object, propName, start, _local_3, overwriteProp || (propName));
                }
            }
        }
        function updateTweens(changeFactor) {
            var _local_3 = _tweens.length;
            var _local_2;
            if (round) {
                var _local_4;
                while (_local_3-- , _local_3 > -1) {
                    _local_2 = _tweens[_local_3];
                    _local_4 = _local_2.start + (_local_2.change * changeFactor);
                    if (_local_4 > 0) {
                        _local_2.target[_local_2.property] = (_local_4 + 0.5) >> 0;
                    } else {
                        _local_2.target[_local_2.property] = (_local_4 - 0.5) >> 0;
                    }
                }
            } else {
                while (_local_3-- , _local_3 > -1) {
                    _local_2 = _tweens[_local_3];
                    _local_2.target[_local_2.property] = _local_2.start + (_local_2.change * changeFactor);
                }
            }
        }
        function get changeFactor() {
            return(_changeFactor);
        }
        function set changeFactor(n) {
            updateTweens(n);
            _changeFactor = n;
            //return(changeFactor);
        }
        function killProps(lookup) {
            var _local_2 = overwriteProps.length;
            while (_local_2-- , _local_2 > -1) {
                if (lookup[overwriteProps[_local_2]]) {
                    overwriteProps.splice(_local_2, 1);
                }
            }
            _local_2 = _tweens.length;
            while (_local_2-- , _local_2 > -1) {
                if (lookup[_tweens[_local_2].name]) {
                    _tweens.splice(_local_2, 1);
                }
            }
        }
        static function onTweenEvent(type, tween) {
            var _local_1 = tween.cachedPT1;
            var _local_5;
            if (type == "onInitAllProps") {
                var _local_3 = [];
                var _local_2 = 0;
                while (_local_1) {
                    _local_3[_local_2++] = _local_1;
                    _local_1 = _local_1.nextNode;
                }
                _local_3.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
                while (_local_2-- , _local_2 > -1) {
                    _local_3[_local_2].nextNode = _local_3[_local_2 + 1];
                    _local_3[_local_2].prevNode = _local_3[_local_2 - 1];
                }
                _local_1 = (tween.cachedPT1 = _local_3[0]);
            }
            while (_local_1) {
                if (_local_1.isPlugin && (_local_1.target[type])) {
                    if (_local_1.target.activeDisable) {
                        _local_5 = true;
                    }
                    _local_1.target[type]();
                }
                _local_1 = _local_1.nextNode;
            }
            return(_local_5);
        }
        static function activate(plugins) {
            com.greensock.TweenLite.onPluginEvent = onTweenEvent;
            var _local_1 = plugins.length;
            var _local_3;
            while (_local_1--) {
                if (plugins[_local_1].API == 1) {
                    _local_3 = new plugins[_local_1]();
                    com.greensock.TweenLite.plugins[_local_3.propName] = plugins[_local_1];
                }
            }
            return(true);
        }
        static var VERSION = 1.4;
        static var API = 1;
        var priority = 0;
    }
