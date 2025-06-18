dynamic class com.greensock.OverwriteManager
{
    static var version: Number = 6.1;
    static var NONE: Number = 0;
    static var ALL_IMMEDIATE: Number = 1;
    static var AUTO: Number = 2;
    static var CONCURRENT: Number = 3;
    static var ALL_ONSTART: Number = 4;
    static var PREEXISTING: Number = 5;

    function OverwriteManager()
    {
    }

    static function init(defaultMode)
    {
        com.greensock.TweenLite.version >= 11.6;
        com.greensock.TweenLite.overwriteManager = com.greensock.OverwriteManager;
        com.greensock.OverwriteManager.mode = defaultMode == undefined ? 2 : defaultMode;
        com.greensock.OverwriteManager.enabled = true;
        return com.greensock.OverwriteManager.mode;
    }

    static function manageOverwrites(tween, props, targetTweens, mode)
    {
        var __reg3 = undefined;
        var __reg10 = undefined;
        var __reg1 = undefined;
        if (mode >= 4) 
        {
            var __reg17 = targetTweens.length;
            __reg3 = 0;
            while (__reg3 < __reg17) 
            {
                __reg1 = targetTweens[__reg3];
                if (__reg1 == tween) 
                {
                    if (mode == 5) 
                    {
                        break;
                    }
                }
                else if (__reg1.setEnabled(false, false)) 
                {
                    __reg10 = true;
                }
                ++__reg3;
            }
            return __reg10;
        }
        var __reg5 = tween.cachedStartTime + 1e-010;
        var __reg9 = [];
        var __reg13 = [];
        var __reg15 = 0;
        var __reg12 = 0;
        __reg3 = targetTweens.length;
        while (--__reg3 > -1) 
        {
            __reg1 = targetTweens[__reg3];
            if (!(__reg1 == tween || __reg1.gc || !__reg1.initted && __reg5 - __reg1.cachedStartTime <= 2e-010)) 
            {
                if (__reg1.timeline == tween.timeline) 
                {
                    if (__reg1.cachedStartTime <= __reg5 && __reg1.cachedStartTime + __reg1.__get__totalDuration() + 1e-010 > __reg5 && !__reg1.cachedPaused && !(tween.cachedDuration == 0 && __reg5 - __reg1.cachedStartTime <= 2e-010)) 
                    {
                        __reg9[__reg12++] = __reg1;
                    }
                }
                else if (!com.greensock.OverwriteManager.getGlobalPaused(__reg1)) 
                {
                    __reg13[__reg15++] = __reg1;
                }
            }
        }
        if (__reg15 != 0) 
        {
            var __reg6 = tween.cachedTimeScale;
            var __reg7 = __reg5;
            var __reg4 = undefined;
            var __reg11 = undefined;
            var __reg2 = undefined;
            __reg2 = tween.timeline;
            while (__reg2) 
            {
                __reg6 = __reg6 * __reg2.cachedTimeScale;
                __reg7 = __reg7 + __reg2.cachedStartTime;
                __reg2 = __reg2.timeline;
            }
            __reg5 = __reg6 * __reg7;
            __reg3 = __reg15;
            while (--__reg3 > -1) 
            {
                __reg4 = __reg13[__reg3];
                __reg6 = __reg4.cachedTimeScale;
                __reg7 = __reg4.cachedStartTime;
                __reg2 = __reg4.timeline;
                while (__reg2) 
                {
                    __reg6 = __reg6 * __reg2.cachedTimeScale;
                    __reg7 = __reg7 + __reg2.cachedStartTime;
                    __reg2 = __reg2.timeline;
                }
                __reg11 = __reg6 * __reg7;
                if (__reg11 <= __reg5 && (__reg11 + __reg4.__get__totalDuration() * __reg6 + 1e-010 > __reg5 || __reg4.cachedDuration == 0)) 
                {
                    __reg9[__reg12++] = __reg4;
                }
            }
        }
        if (__reg12 == 0) 
        {
            return __reg10;
        }
        __reg3 = __reg12;
        if (mode == 2) 
        {
            while (--__reg3 > -1) 
            {
                __reg1 = __reg9[__reg3];
                if (__reg1.killVars(props)) 
                {
                    __reg10 = true;
                }
                if (__reg1.cachedPT1 == undefined && __reg1.initted) 
                {
                    __reg1.setEnabled(false, false);
                }
            }
        }
        else 
        {
            while (--__reg3 > -1) 
            {
                if (__reg9[__reg3].setEnabled(false, false)) 
                {
                    __reg10 = true;
                }
            }
        }
        return __reg10;
    }

    static function getGlobalPaused(tween)
    {
        while (tween) 
        {
            if (tween.cachedPaused) 
            {
                return true;
            }
            tween = tween.timeline;
        }
        return false;
    }

}
