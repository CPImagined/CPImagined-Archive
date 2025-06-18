dynamic class com.clubpenguin.util.QueryParams
{

    function QueryParams()
    {
    }

    static function getQueryParams(testingQueryString)
    {
        var __reg8 = undefined;
        if (testingQueryString) 
        {
            __reg8 = testingQueryString;
        }
        else 
        {
            __reg8 = String(flash.external.ExternalInterface.call("parent.window.location.search.substring", 1));
        }
        var __reg7 = {};
        var __reg6 = __reg8.split("&");
        var __reg3 = 0;
        var __reg4 = -1;
        while (__reg3 < __reg6.length) 
        {
            var __reg1 = __reg6[__reg3];
            if ((__reg4 = __reg1.indexOf("=")) > 0) 
            {
                var __reg2 = __reg1.substring(0, __reg4);
                __reg2.toLowerCase();
                var __reg5 = __reg1.substring(__reg4 + 1);
                __reg7[__reg2] = __reg5;
            }
            ++__reg3;
        }
        return __reg7;
    }

}
