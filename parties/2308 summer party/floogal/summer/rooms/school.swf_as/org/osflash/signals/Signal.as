dynamic class org.osflash.signals.Signal implements org.osflash.signals.ISignal, org.osflash.signals.IDispatcher
{
    var listenersNeedCloning: Boolean = false;
    var _valueClasses;
    var listenerBoxes;

    function Signal()
    {
        this.listenerBoxes = [];
        this.setValueClasses(arguments);
    }

    function getNumListeners()
    {
        return this.listenerBoxes.length;
    }

    function getValueClasses()
    {
        return this._valueClasses;
    }

    function add(listener, scope)
    {
        this.registerListener(listener, scope, false);
    }

    function addOnce(listener, scope)
    {
        this.registerListener(listener, scope, true);
    }

    function remove(listener, scope)
    {
        if (this.listenersNeedCloning) 
        {
            this.listenerBoxes = this.listenerBoxes.slice();
            this.listenersNeedCloning = false;
        }
        var __reg2 = this.listenerBoxes.length;
        for (;;) 
        {
            if (!(__reg2--)) 
            {
                return undefined;
            }
            if (this.listenerBoxes[__reg2].listener == listener && this.listenerBoxes[__reg2].scope == scope) 
            {
                this.listenerBoxes.splice(__reg2, 1);
                return undefined;
            }
        }
    }

    function removeAll()
    {
        var __reg2 = this.listenerBoxes.length;
        for (;;) 
        {
            if (!(__reg2--)) 
            {
                return undefined;
            }
            this.remove(this.listenerBoxes[__reg2].listener, this.listenerBoxes[__reg2].scope);
        }
    }

    function dispatch()
    {
        var __reg6 = undefined;
        var __reg4 = 0;
        while (__reg4 < this._valueClasses.length) 
        {
            if (!this.primitiveMatchesValueClass(arguments[__reg4], this._valueClasses[__reg4])) 
            {
                !((__reg6 = arguments[__reg4]) == null || __reg6 instanceof this._valueClasses[__reg4]);
            }
            ++__reg4;
        }
        var __reg7 = this.listenerBoxes;
        var __reg8 = __reg7.length;
        var __reg3 = undefined;
        var __reg9 = undefined;
        this.listenersNeedCloning = true;
        var __reg5 = 0;
        while (__reg5 < __reg8) 
        {
            __reg3 = __reg7[__reg5];
            if (__reg3.once) 
            {
                this.remove(__reg3.listener, __reg3.scope);
            }
            __reg3.listener.apply(__reg3.scope, arguments);
            ++__reg5;
        }
        this.listenersNeedCloning = false;
    }

    function primitiveMatchesValueClass(primitive, valueClass)
    {
        if ((typeof primitive == "string" && valueClass == String) || (typeof primitive == "number" && valueClass == Number) || typeof primitive == "boolean" && valueClass == Boolean) 
        {
            return true;
        }
        return false;
    }

    function setValueClasses(valueClasses)
    {
        this._valueClasses = valueClasses || [];
        var __reg2 = this._valueClasses.length;
        for (;;) 
        {
            if (!(__reg2--)) 
            {
                return undefined;
            }
            this._valueClasses[__reg2] instanceof Function;
        }
    }

    function registerListener(listener, scope, once)
    {
        var __reg2 = 0;
        while (__reg2 < this.listenerBoxes.length) 
        {
            if (this.listenerBoxes[__reg2].listener == listener && this.listenerBoxes[__reg2].scope == scope) 
            {
                return undefined;
            }
            ++__reg2;
        }
        if (this.listenersNeedCloning) 
        {
            this.listenerBoxes = this.listenerBoxes.slice();
        }
        this.listenerBoxes.push({listener: listener, scope: scope, once: once});
    }

}
