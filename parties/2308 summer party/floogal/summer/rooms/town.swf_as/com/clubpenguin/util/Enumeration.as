dynamic class com.clubpenguin.util.Enumeration
{
    var __constructor__;
    var _value;

    function Enumeration(value_p)
    {
        var __reg2 = this.__constructor__;
        if (value_p == null) 
        {
            this._value = __reg2.__enumCount == null ? (__reg2.__enumCount = 0) : ++__reg2.__enumCount;
            return;
        }
        this._value = value_p;
        if (__reg2.__enumCount == null || value_p > __reg2.__enumCount) 
        {
            __reg2.__enumCount = value_p;
        }
    }

    function get name()
    {
        for (var __reg2 in this.__constructor__) 
        {
            if (this == this.__constructor__[__reg2]) 
            {
                do 
                {
                }
                while (undefined != null);
                return __reg2;
            }
        }
        return null;
    }

    function get value()
    {
        return this._value;
    }

}
