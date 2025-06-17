//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.greensock.plugins.RoundPropsPlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, round, priority, onInitAllProps, _tween, addTween;
        function RoundPropsPlugin () {
            super();
            propName = "roundProps";
            overwriteProps = ["roundProps"];
            round = true;
            priority = -1;
            onInitAllProps = _initAllProps;
        }
        function onInitTween(target, value, tween) {
            _tween = tween;
            var _local_2 = value;
            overwriteProps = overwriteProps.concat(_local_2);
            return(true);
        }
        function _initAllProps() {
            var _local_3;
            var _local_4;
            var _local_6 = _tween.vars.roundProps;
            var _local_2;
            var _local_5 = _local_6.length;
            while (_local_5-- , _local_5 > -1) {
                _local_3 = _local_6[_local_5];
                _local_2 = _tween.cachedPT1;
                while (_local_2) {
                    if (_local_2.name == _local_3) {
                        if (_local_2.isPlugin) {
                            _local_2.target.round = true;
                        } else {
                            add(_local_2.target, _local_3, _local_2.start, _local_2.change);
                            _removePropTween(_local_2);
                            _tween.propTweenLookup[_local_3] = _tween.propTweenLookup.roundProps;
                        }
                    } else if ((_local_2.isPlugin && (_local_2.name == "_MULTIPLE_")) && (!_local_2.target.round)) {
                        _local_4 = (" " + _local_2.target.overwriteProps.join(" ")) + " ";
                        if (_local_4.indexOf((" " + _local_3) + " ") != -1) {
                            _local_2.target.round = true;
                        }
                    }
                    _local_2 = _local_2.nextNode;
                }
            }
        }
        function _removePropTween(propTween) {
            if (propTween.nextNode) {
                propTween.nextNode.prevNode = propTween.prevNode;
            }
            if (propTween.prevNode) {
                propTween.prevNode.nextNode = propTween.nextNode;
            } else if (_tween.cachedPT1 == propTween) {
                _tween.cachedPT1 = propTween.nextNode;
            }
            if (propTween.isPlugin && (propTween.target.onDisable)) {
                propTween.target.onDisable();
            }
        }
        function add(object, propName, start, change) {
            addTween(object, propName, start, start + change, propName);
            overwriteProps[overwriteProps.length] = propName;
        }
        static var API = 1;
    }
