dynamic class com.greensock.plugins.FilterPlugin extends com.greensock.plugins.TweenPlugin
{
    static var VERSION: Number = 2.03;
    static var API: Number = 1;
    var _filter;
    var _index;
    var _remove;
    var _target;
    var _tweens;
    var _type;
    var addTween;
    var onComplete;
    var propName;

    function FilterPlugin()
    {
        super();
    }

    function initFilter(props, defaultFilter, propNames)
    {
        var __reg6 = this._target.filters;
        var __reg2 = undefined;
        var __reg3 = undefined;
        var __reg5 = undefined;
        var __reg7 = props instanceof flash.filters.BitmapFilter ? {} : props;
        this._index = -1;
        if (__reg7.index == undefined) 
        {
            __reg3 = __reg6.length;
            while (__reg3--) 
            {
                if (__reg6[__reg3] instanceof this._type) 
                {
                    this._index = __reg3;
                    break;
                }
            }
        }
        else 
        {
            this._index = __reg7.index;
        }
        if (this._index == -1 || __reg6[this._index] == undefined || __reg7.addFilter == true) 
        {
            this._index = __reg7.index == undefined ? __reg6.length : __reg7.index;
            __reg6[this._index] = defaultFilter;
            this._target.filters = __reg6;
        }
        this._filter = __reg6[this._index];
        if (__reg7.remove == true) 
        {
            this._remove = true;
            this.onComplete = this.onCompleteTween;
        }
        __reg3 = propNames.length;
        for (;;) 
        {
            if (!(__reg3--)) 
            {
                return;
            }
            __reg2 = propNames[__reg3];
            if (props[__reg2] != undefined && this._filter[__reg2] != props[__reg2]) 
            {
                if (__reg2 == "color" || __reg2 == "highlightColor" || __reg2 == "shadowColor") 
                {
                    __reg5 = new com.greensock.plugins.HexColorsPlugin();
                    __reg5.initColor(this._filter, __reg2, this._filter[__reg2], props[__reg2]);
                    this._tweens[this._tweens.length] = new com.greensock.core.PropTween(__reg5, "changeFactor", 0, 1, this.propName);
                }
                else if (__reg2 == "quality" || __reg2 == "inner" || __reg2 == "knockout" || __reg2 == "hideObject") 
                {
                    this._filter[__reg2] = props[__reg2];
                }
                else 
                {
                    this.addTween(this._filter, __reg2, this._filter[__reg2], props[__reg2], this.propName);
                }
            }
        }
    }

    function onCompleteTween()
    {
        if (this._remove) 
        {
            var __reg3 = this._target.filters;
            if (__reg3[this._index] instanceof this._type) 
            {
                __reg3.splice(this._index, 1);
            }
            else 
            {
                var __reg2 = __reg3.length;
                while (__reg2--) 
                {
                    if (__reg3[__reg2] instanceof this._type) 
                    {
                        __reg3.splice(__reg2, 1);
                        break;
                    }
                }
            }
            this._target.filters = __reg3;
        }
    }

    function set changeFactor(n)
    {
        var __reg2 = this._tweens.length;
        var __reg3 = undefined;
        var __reg4 = this._target.filters;
        while (__reg2--) 
        {
            __reg3 = this._tweens[__reg2];
            __reg3.target[__reg3.property] = __reg3.start + __reg3.change * n;
        }
        if (!(__reg4[this._index] instanceof this._type)) 
        {
            __reg2 = this._index = __reg4.length;
            while (__reg2--) 
            {
                if (__reg4[__reg2] instanceof this._type) 
                {
                    this._index = __reg2;
                    break;
                }
            }
        }
        __reg4[this._index] = this._filter;
        this._target.filters = __reg4;
    }

}
