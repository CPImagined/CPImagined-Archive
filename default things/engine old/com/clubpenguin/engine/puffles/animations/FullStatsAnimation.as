class com.clubpenguin.engine.puffles.animations.FullStatsAnimation
{
    var _SHELL, _ENGINE;
    function FullStatsAnimation(shell_mc, engine_mc)
    {
        _SHELL = shell_mc;
        _ENGINE = engine_mc;
    } // End of the function
    function playFullStatsAnimation(playerID)
    {
        var _loc3 = _SHELL.getPlayerObjectById(playerID).attachedPuffle;
        if (_loc3)
        {
            var _loc4 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerID, _loc3.id, _SHELL, _ENGINE);
            var _loc2 = _SHELL.getPath(com.clubpenguin.engine.puffles.animations.FullStatsAnimation.ASSET_PATH);
            _loc2 = _loc3.getFormattedAssetURL(_loc2);
            _loc4.playPuffleAnimation(_loc2);
        } // end if
    } // End of the function
    static var ASSET_PATH = "w.puffle.sprite.fullstats";
} // End of Class
