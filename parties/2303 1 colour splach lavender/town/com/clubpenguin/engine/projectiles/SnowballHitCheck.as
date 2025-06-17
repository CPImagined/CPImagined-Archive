class com.clubpenguin.engine.projectiles.SnowballHitCheck implements com.clubpenguin.engine.projectiles.ISnowballHitCheck
{
    function SnowballHitCheck()
    {
    } // End of the function
    function hitCheck(snowballInfo)
    {
        var _loc13 = _global.getCurrentShell();
        var _loc9 = _global.getCurrentEngine();
        var _loc6 = _loc13.getPlayerList();
        var _loc8 = snowballInfo.snowballMC;
        var _loc7 = new Array();
        var _loc12;
        var _loc14 = -1;
        if (_loc13.isMyPlayer(snowballInfo.player_id))
        {
            _loc9.setPlayerAction("wait");
        } // end if
        if (!_loc8._visible)
        {
            return;
        } // end if
        for (var _loc11 in _loc6)
        {
            var _loc2 = _loc6[_loc11];
            var _loc3 = _loc9.getPlayerMovieClip(_loc2.player_id);
            var _loc4 = _loc3.hitTest(snowballInfo.__get__x(), snowballInfo.__get__y(), true);
            if (_loc4)
            {
                _loc7.push(_loc2);
            } // end if
        } // end of for...in
        if (_loc7.length > 0)
        {
            _loc7.sortOn("y", [Array.NUMERIC | Array.DESCENDING]);
            var _loc10 = _loc7[0];
            var _loc15 = _loc9.getPlayerMovieClip(_loc10.player_id);
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(_loc10.player_id))
            {
                _loc12 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.BOUNCE;
            }
            else
            {
                _loc14 = _loc10.player_id;
                _loc12 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.HIT;
                _loc8._x = _loc10.x;
                _loc8._y = _loc10.y;
                if (_loc8.getDepth() < _loc15.getDepth())
                {
                    _loc8.swapDepths(_loc15);
                } // end if
            } // end else if
        }
        else
        {
            _loc12 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.MISS;
        } // end else if
        if (_loc8._totalFrames == 4)
        {
            _loc8.gotoAndStop(_loc12);
        }
        else
        {
            _loc8.gotoAndStop(2);
        } // end else if
        return (_loc14);
    } // End of the function
} // End of Class
