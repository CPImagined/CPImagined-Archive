dynamic class com.clubpenguin.services.vo.JsonServerCookieVO extends com.clubpenguin.services.vo.ServerCookieVO
{
    var _jsonObject;
    var deserialized;

    function JsonServerCookieVO(cookieId)
    {
        super(cookieId);
        this.deserialized = new org.osflash.signals.Signal();
        this._jsonObject = new Object();
    }

    function destroy()
    {
        super.destroy();
    }

    function isInitialized()
    {
        return this._jsonObject != null;
    }

    function update(vo)
    {
        this.deserialize(com.clubpenguin.services.vo.JsonServerCookieVO(vo).serialize());
    }

    function toString()
    {
        return "[JsonServerCookie:" + this.serialize() + "]";
    }

    function serialize()
    {
        return com.clubpenguin.util.JSONParser.stringify(this._jsonObject);
    }

    function deserialize(data)
    {
        if (data == undefined || data.length == 0) 
        {
            this._jsonObject = new Object();
        }
        else 
        {
            var __reg2 = com.clubpenguin.util.JSONParser.parse(data);
            if (this._jsonObject == null) 
            {
                this._jsonObject = new Object();
            }
            for (var __reg3 in __reg2) 
            {
                this._jsonObject[__reg3] = __reg2[__reg3];
            }
        }
        this.deserialized.dispatch();
    }

}
