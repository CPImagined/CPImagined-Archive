dynamic class com.clubpenguin.model.vo.PlayerVO implements com.clubpenguin.util.IVO
{
    var isUsingSlide: Boolean = false;
    var hasNotMovedSince: Number = -1;
    var lastFrame: Number = -1;
    var avatarVO;
    var nickname;
    var player_id;

    function PlayerVO()
    {
    }

    function get avatar_id()
    {
        return this.avatarVO.avatar_id;
    }

    function set avatar_id(value)
    {
    }

    function destroy()
    {
        false;
    }

    function isReadyToBeBitmapCached()
    {
        return this.hasNotMovedSince > 0 && getTimer() - this.hasNotMovedSince > 3000;
    }

    function setIsBitmapCacheable(isCacheable)
    {
        if (isCacheable && this.hasNotMovedSince == -1) 
        {
            this.hasNotMovedSince = getTimer();
            return;
        }
        if (isCacheable) 
        {
            return;
        }
        this.hasNotMovedSince = -1;
    }

    function getID()
    {
        return String(this.player_id);
    }

    function update(vo)
    {
        for (var __reg3 in vo) 
        {
            this[__reg3] = vo[__reg3];
        }
    }

    function toString()
    {
        return "PlayerVO{player_id:" + this.player_id + ", nickname:" + this.nickname + ", avatar_id:" + this.avatarVO.avatar_id + "}";
    }

    function toDetailedString()
    {
        var __reg2 = "\n*** PlayerVO ***\n";
        for (var __reg3 in this) 
        {
            __reg2 = __reg2 + (__reg3 + " : " + this[__reg3] + " | ");
        }
        __reg2 = __reg2 + "\n****************\n";
        return __reg2;
    }

    function equals(vo)
    {
        if (this === vo) 
        {
            return true;
        }
        return false;
    }

}
