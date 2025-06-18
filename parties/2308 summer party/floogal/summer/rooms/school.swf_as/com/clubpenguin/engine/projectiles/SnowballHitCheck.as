dynamic class com.clubpenguin.engine.projectiles.SnowballHitCheck implements com.clubpenguin.engine.projectiles.ISnowballHitCheck
{

    function SnowballHitCheck()
    {
    }

    function hitCheck(snowballInfo)
    {
        var __reg15 = _global.getCurrentShell();
        var __reg8 = _global.getCurrentEngine();
        var __reg6 = __reg15.getPlayerList();
        var __reg9 = snowballInfo.snowballMC;
        var __reg7 = new Array();
        var __reg11 = undefined;
        var __reg14 = -1;
        if (__reg15.isMyPlayer(snowballInfo.player_id)) 
        {
            __reg8.setPlayerAction("wait");
        }
        if (__reg9._visible) 
        {
            for (var __reg12 in __reg6) 
            {
                var __reg2 = __reg6[__reg12];
                var __reg4 = __reg8.getPlayerMovieClip(__reg2.player_id);
                var __reg3 = __reg4.hitTest(snowballInfo.__get__x(), snowballInfo.__get__y(), true);
                if (__reg3) 
                {
                    __reg7.push(__reg2);
                }
            }
            if (__reg7.length > 0) 
            {
                __reg7.sortOn("y", [Array.NUMERIC | Array.DESCENDING]);
                var __reg10 = __reg7[0];
                var __reg13 = __reg8.getPlayerMovieClip(__reg10.player_id);
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(__reg10.player_id)) 
                {
                    __reg11 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.BOUNCE;
                }
                else 
                {
                    __reg14 = __reg10.player_id;
                    __reg11 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.HIT;
                    __reg9._x = __reg10.x;
                    __reg9._y = __reg10.y;
                    if (__reg9.getDepth() < __reg13.getDepth()) 
                    {
                        __reg9.swapDepths(__reg13);
                    }
                }
            }
            else 
            {
                __reg11 = com.clubpenguin.engine.projectiles.SnowballHitStateConstant.MISS;
            }
            if (__reg9._totalFrames == 4) 
            {
                __reg9.gotoAndStop(__reg11);
            }
            else 
            {
                __reg9.gotoAndStop(2);
            }
            return __reg14;
        }
    }

}
