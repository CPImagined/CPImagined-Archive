dynamic class com.greensock.plugins.RoundPropsPlugin extends com.greensock.plugins.TweenPlugin
{
    static var API: Number = 1;
    var _tween;
    var addTween;
    var onInitAllProps;
    var overwriteProps;
    var priority;
    var propName;
    var round;

    function RoundPropsPlugin()
    {
        super();
        this.propName = "roundProps";
        this.overwriteProps = ["roundProps"];
        this.round = true;
        this.priority = -1;
        this.onInitAllProps = this._initAllProps;
    }

    function onInitTween(target, value, tween)
    {
        this._tween = tween;
        var __reg2 = value;
        this.overwriteProps = this.overwriteProps.concat(__reg2);
        return true;
    }

    function _initAllProps()
    {
        var __reg3 = undefined;
        var __reg4 = undefined;
        var __reg6 = this._tween.vars.roundProps;
        var __reg2 = undefined;
        var __reg5 = __reg6.length;
        for (;;) 
        {
            if (--__reg5 <= -1) 
            {
                return;
            }
            __reg3 = __reg6[__reg5];
            __reg2 = this._tween.cachedPT1;
            while (__reg2) 
            {
                if (__reg2.name == __reg3) 
                {
                    if (__reg2.isPlugin) 
                    {
                        __reg2.target.round = true;
                    }
                    else 
                    {
                        this.add(__reg2.target, __reg3, __reg2.start, __reg2.change);
                        this._removePropTween(__reg2);
                        this._tween.propTweenLookup[__reg3] = this._tween.propTweenLookup.roundProps;
                    }
                }
                else if (__reg2.isPlugin && __reg2.name == "_MULTIPLE_" && !__reg2.target.round) 
                {
                    __reg4 = " " + __reg2.target.overwriteProps.join(" ") + " ";
                    if (__reg4.indexOf(" " + __reg3 + " ") != -1) 
                    {
                        __reg2.target.round = true;
                    }
                }
                __reg2 = __reg2.nextNode;
            }
        }
    }

    function _removePropTween(propTween)
    {
        if (propTween.nextNode) 
        {
            propTween.nextNode.prevNode = propTween.prevNode;
        }
        if (propTween.prevNode) 
        {
            propTween.prevNode.nextNode = propTween.nextNode;
        }
        else if (this._tween.cachedPT1 == propTween) 
        {
            this._tween.cachedPT1 = propTween.nextNode;
        }
        if (propTween.isPlugin && propTween.target.onDisable) 
        {
            propTween.target.onDisable();
        }
    }

    function add(object, propName, start, change)
    {
        this.addTween(object, propName, start, start + change, propName);
        this.overwriteProps[this.overwriteProps.length] = propName;
    }

}
