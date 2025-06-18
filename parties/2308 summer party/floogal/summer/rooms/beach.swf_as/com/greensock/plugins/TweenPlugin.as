dynamic class com.greensock.plugins.TweenPlugin
{
    static var VERSION: Number = 1.4;
    static var API: Number = 1;
    var priority: Number = 0;
    var _changeFactor;
    var _tweens;
    var overwriteProps;
    var propName;
    var round;

    function TweenPlugin()
    {
        this._tweens = [];
        this._changeFactor = 0;
    }

    function onInitTween(target, value, tween)
    {
        this.addTween(target, this.propName, target[this.propName], value, this.propName);
        return true;
    }

    function addTween(object, propName, start, end, overwriteProp)
    {
        if (end != undefined) 
        {
            var __reg3 = typeof end == "number" ? Number(end) - start : Number(end);
            if (__reg3 != 0) 
            {
                this._tweens[this._tweens.length] = new com.greensock.core.PropTween(object, propName, start, __reg3, overwriteProp || propName);
            }
        }
    }

    function updateTweens(changeFactor)
    {
        var __reg3 = this._tweens.length;
        var __reg2 = undefined;
        if (this.round) 
        {
            var __reg4 = undefined;
            while (--__reg3 > -1) 
            {
                __reg2 = this._tweens[__reg3];
                __reg4 = __reg2.start + __reg2.change * changeFactor;
                if (__reg4 > 0) 
                {
                    __reg2.target[__reg2.property] = __reg4 + 0.5 >> 0;
                }
                else 
                {
                    __reg2.target[__reg2.property] = __reg4 - 0.5 >> 0;
                }
            }
            return;
        }
        for (;;) 
        {
            if (--__reg3 <= -1) 
            {
                return;
            }
            __reg2 = this._tweens[__reg3];
            __reg2.target[__reg2.property] = __reg2.start + __reg2.change * changeFactor;
        }
    }

    function get changeFactor()
    {
        return this._changeFactor;
    }

    function set changeFactor(n)
    {
        this.updateTweens(n);
        this._changeFactor = n;
    }

    function killProps(lookup)
    {
        var __reg2 = this.overwriteProps.length;
        while (--__reg2 > -1) 
        {
            if (lookup[this.overwriteProps[__reg2]]) 
            {
                this.overwriteProps.splice(__reg2, 1);
            }
        }
        __reg2 = this._tweens.length;
        for (;;) 
        {
            if (--__reg2 <= -1) 
            {
                return;
            }
            if (lookup[this._tweens[__reg2].name]) 
            {
                this._tweens.splice(__reg2, 1);
            }
        }
    }

    static function onTweenEvent(type, tween)
    {
        var __reg1 = tween.cachedPT1;
        var __reg5 = undefined;
        if (type == "onInitAllProps") 
        {
            var __reg3 = [];
            var __reg2 = 0;
            while (__reg1) 
            {
                __reg3[__reg2++] = __reg1;
                __reg1 = __reg1.nextNode;
            }
            __reg3.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
            while (--__reg2 > -1) 
            {
                __reg3[__reg2].nextNode = __reg3[__reg2 + 1];
                __reg3[__reg2].prevNode = __reg3[__reg2 - 1];
            }
            __reg1 = tween.cachedPT1 = __reg3[0];
        }
        while (__reg1) 
        {
            if (__reg1.isPlugin && __reg1.target[type]) 
            {
                if (__reg1.target.activeDisable) 
                {
                    __reg5 = true;
                }
                __reg1.target[type]();
            }
            __reg1 = __reg1.nextNode;
        }
        return __reg5;
    }

    static function activate(plugins)
    {
        com.greensock.TweenLite.onPluginEvent = com.greensock.plugins.TweenPlugin.onTweenEvent;
        var __reg1 = plugins.length;
        var __reg3 = undefined;
        while (__reg1--) 
        {
            if (plugins[__reg1].API == 1) 
            {
                __reg3 = new plugins[__reg1]();
                com.greensock.TweenLite.plugins[__reg3.propName] = plugins[__reg1];
            }
        }
        return true;
    }

}
