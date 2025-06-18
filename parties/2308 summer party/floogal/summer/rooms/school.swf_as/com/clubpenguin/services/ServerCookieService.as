dynamic class com.clubpenguin.services.ServerCookieService
{
    var _airtower;
    var _airtowerListeners;
    var _cookies;
    var _shell;

    function ServerCookieService()
    {
        this.init();
    }

    function init()
    {
        this._airtowerListeners = {};
        if (this._airtower != null) 
        {
            this.removeAirtowerListeners();
        }
        this._airtower = _global.getCurrentAirtower();
        this._shell = _global.getCurrentShell();
        this._cookies = {};
    }

    function registerCookieVO(cookieId, cookieVO)
    {
        if (this._cookies[cookieId] != null) 
        {
            return false;
        }
        this._cookies[cookieId] = cookieVO;
        if (this._airtowerListeners[cookieVO.getReceiveCommandName()] != true) 
        {
            this._airtowerListeners[cookieVO.getReceiveCommandName()] = true;
            this._airtower.addListener(cookieVO.getReceiveCommandName(), com.clubpenguin.util.Delegate.create(this, this.onServerCookieReceived, cookieId), this);
        }
        return true;
    }

    function getCookieVO(cookieId)
    {
        return this._cookies[cookieId];
    }

    function requestCookieFromServer(cookieId)
    {
        var __reg2 = this.getCookieVO(cookieId);
        if (__reg2 != null) 
        {
            this._airtower.send(this._airtower.PLAY_EXT, __reg2.getCookieHandlerName() + "#" + __reg2.getReceiveCommandName(), [], "str", this._shell.getCurrentServerRoomId());
        }
    }

    function sendCookieToServer(cookieId)
    {
        var __reg2 = this.getCookieVO(cookieId);
        if (__reg2 != null) 
        {
            this._airtower.send(this._airtower.PLAY_EXT, __reg2.getCookieHandlerName() + "#" + __reg2.getSendCommandName(), [__reg2.serialize()], "str", this._shell.getCurrentServerRoomId());
        }
    }

    function onServerCookieReceived(data, cookieId)
    {
        var __reg5 = data[0];
        var __reg3 = data[1];
        var __reg2 = this._cookies[cookieId];
        if (__reg2 != null) 
        {
            __reg2.deserialize(__reg3);
        }
    }

    function removeAirtowerListeners()
    {
        for (var __reg2 in this._airtowerListeners) 
        {
            this._airtower.removeListener(__reg2, this.onServerCookieReceived);
        }
    }

}
