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
            var a = value;
            overwriteProps = overwriteProps.concat(a);
            return(true);
        }
        function _initAllProps() {
            var prop;
            var multiProps;
            var rp = _tween.vars.roundProps;
            var pt;
            var i = rp.length;
            while ((--i) > -1) {
                prop = rp[i];
                pt = _tween.cachedPT1;
                while (pt) {
                    if (pt.name == prop) {
                        if (pt.isPlugin) {
                            pt.target.round = true;
                        } else {
                            add(pt.target, prop, pt.start, pt.change);
                            _removePropTween(pt);
                            _tween.propTweenLookup[prop] = _tween.propTweenLookup.roundProps;
                        }
                    } else if ((pt.isPlugin && (pt.name == "_MULTIPLE_")) && (!pt.target.round)) {
                        multiProps = (" " + pt.target.overwriteProps.join(" ")) + " ";
                        if (multiProps.indexOf((" " + prop) + " ") != -1) {
                            pt.target.round = true;
                        }
                    }
                    pt = pt.nextNode;
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
