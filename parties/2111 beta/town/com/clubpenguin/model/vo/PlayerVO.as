class com.clubpenguin.model.vo.PlayerVO implements com.clubpenguin.util.IVO
{
    var avatarVO, __get__avatar_id, player_id, _loc3, nickname, __set__avatar_id;
    function PlayerVO()
    {
    } // End of the function
    function get avatar_id()
    {
        return (avatarVO.avatar_id);
    } // End of the function
    function set avatar_id(value)
    {
        //return (this.avatar_id());
        null;
    } // End of the function
    function destroy()
    {
        false;
    } // End of the function
    function isReadyToBeBitmapCached()
    {
        return (hasNotMovedSince > 0 && getTimer() - hasNotMovedSince > 3000);
    } // End of the function
    function setIsBitmapCacheable(isCacheable)
    {
        if (isCacheable && hasNotMovedSince == -1)
        {
            hasNotMovedSince = getTimer();
        }
        else if (!isCacheable)
        {
            hasNotMovedSince = -1;
        } // end else if
    } // End of the function
    function getID()
    {
        return (String(player_id));
    } // End of the function
    function update(vo)
    {
        for (var _loc3 in vo)
        {
            this[_loc3] = vo[_loc3];
        } // end of for...in
    } // End of the function
    function toString()
    {
        return ("PlayerVO{player_id:" + player_id + ", nickname:" + nickname + ", avatar_id:" + avatarVO.avatar_id + "}");
    } // End of the function
    function toDetailedString()
    {
        var _loc2 = "\n*** PlayerVO ***\n";
        for (var _loc3 in this)
        {
            _loc2 = _loc2 + (_loc3 + " : " + this[_loc3] + " | ");
        } // end of for...in
        _loc2 = _loc2 + "\n****************\n";
        return (_loc2);
    } // End of the function
    function equals(vo)
    {
        if (this === vo)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    var isUsingSlide = false;
    var hasNotMovedSince = -1;
    var lastFrame = -1;
} // End of Class
