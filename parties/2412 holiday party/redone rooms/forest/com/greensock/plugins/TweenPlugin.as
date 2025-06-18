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
                var change = ((typeof(end) == "number") ? (Number(end) - start) : (Number(end)));
                if (change != 0) {
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(object, propName, start, change, overwriteProp || (propName));
                }
            }
        }
        function updateTweens(changeFactor) {
            var i = _tweens.length;
            var pt;
            if (round) {
                var val;
                while ((--i) > -1) {
                    pt = _tweens[i];
                    val = pt.start + (pt.change * changeFactor);
                    if (val > 0) {
                        pt.target[pt.property] = (val + 0.5) >> 0;
                    } else {
                        pt.target[pt.property] = (val - 0.5) >> 0;
                    }
                }
            } else {
                while ((--i) > -1) {
                    pt = _tweens[i];
                    pt.target[pt.property] = pt.start + (pt.change * changeFactor);
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
            var i = overwriteProps.length;
            while ((--i) > -1) {
                if (lookup[overwriteProps[i]]) {
                    overwriteProps.splice(i, 1);
                }
            }
            i = _tweens.length;
            while ((--i) > -1) {
                if (lookup[_tweens[i].name]) {
                    _tweens.splice(i, 1);
                }
            }
        }
        static function onTweenEvent(type, tween) {
            var pt = tween.cachedPT1;
            var changed;
            if (type == "onInitAllProps") {
                var tweens = [];
                var i = 0;
                while (pt) {
                    tweens[i++] = pt;
                    pt = pt.nextNode;
                }
                tweens.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
                while ((--i) > -1) {
                    tweens[i].nextNode = tweens[i + 1];
                    tweens[i].prevNode = tweens[i - 1];
                }
                pt = (tween.cachedPT1 = tweens[0]);
            }
            while (pt) {
                if (pt.isPlugin && (pt.target[type])) {
                    if (pt.target.activeDisable) {
                        changed = true;
                    }
                    pt.target[type]();
                }
                pt = pt.nextNode;
            }
            return(changed);
        }
        static function activate(plugins) {
            com.greensock.TweenLite.onPluginEvent = onTweenEvent;
            var i = plugins.length;
            var instance;
            while (i--) {
                if (plugins[i].API == 1) {
                    instance = new plugins[i]();
                    com.greensock.TweenLite.plugins[instance.propName] = plugins[i];
                }
            }
            return(true);
        }
        static var VERSION = 1.4;
        static var API = 1;
        var priority = 0;
    }
