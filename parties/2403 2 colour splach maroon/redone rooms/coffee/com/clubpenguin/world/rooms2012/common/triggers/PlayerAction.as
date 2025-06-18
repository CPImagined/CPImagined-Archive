class com.clubpenguin.world.rooms2012.common.triggers.PlayerAction
{
    function PlayerAction()
    {
    } // End of the function
    static function isPlayer(player, action)
    {
        switch (action)
        {
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.MOPPING:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isMopping(player));
                break;
            } 
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.DRIVING:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isDriving(player));
                break;
            } 
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.DRILLING:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isDrilling(player));
                break;
            } 
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.WALKING_PUFFLE:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isWalkingPuffle(player));
                break;
            } 
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.DANCING:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isDancing(player));
                break;
            } 
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.WAVING:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isWaving(player));
                break;
            } 
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.MOVING:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isMoving(player.player_id));
                break;
            } 
            case com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.SITTING:
            {
                return (com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isSitting(player));
                break;
            } 
        } // End of switch
        return (false);
    } // End of the function
    static function isMoving(playerID)
    {
        var _loc3 = _global.getCurrentEngine();
        var _loc2 = _loc3.getPlayerMovieClip(playerID);
        if (_loc2)
        {
            return (_loc2.is_moving);
        } // end if
        return (false);
    } // End of the function
    static function isDriving(player)
    {
        return (player.body == 4421 || player.body == 4414 || player.body == 4415 || player.body == 4715 || player.body == 14437);
    } // End of the function
    static function isLocalPlayer(player)
    {
        var _loc2 = _global.getCurrentShell();
        return (player.player_id == _loc2.getMyPlayerId());
    } // End of the function
    static function isDancing(player)
    {
        return (player.frame == 26);
    } // End of the function
    static function isWaving(player)
    {
        return (player.frame == player.wave_frame);
    } // End of the function
    static function isMopping(player)
    {
        var _loc3 = _global.getCurrentShell();
        if (player.hand == 5084)
        {
            if (player.frame == 26 && _loc3.getSecretFrame(player.player_id, player.frame) != 26)
            {
                return (true);
            } // end if
        } // end if
        return (false);
    } // End of the function
    static function isSitting(player)
    {
        return (player.frame >= 17 && player.frame <= 24);
    } // End of the function
    static function isDrilling(player)
    {
        var _loc3 = _global.getCurrentShell();
        if (player.head == 403 || player.head == 10403 || player.head == 429 || player.head == 10429 || player.head == 674 || player.head == 1133)
        {
            if (player.frame == 26 && _loc3.getSecretFrame(player.player_id, player.frame) != 26)
            {
                return (true);
            } // end if
        } // end if
        return (false);
    } // End of the function
    static function isWalkingPuffle(player)
    {
        return (player.hand >= 750 && player.hand <= 759);
    } // End of the function
    static var DRILLING = "drilling";
    static var WALKING_PUFFLE = "walkingPuffle";
    static var DANCING = "dancing";
    static var WAVING = "waving";
    static var MOPPING = "mopping";
    static var MOVING = "moving";
    static var SITTING = "sitting";
    static var DRIVING = "driving";
    static var SNACK_SHACK_STAMP_ID = 184;
    static var COFFEE_EMOTE_ID = 13;
    static var PIZZA_EMOTE_ID = 24;
    static var ICE_CREAM_EMOTE_ID = 26;
    static var CHOCOLATE_ICE_CREAM_EMOTE_ID = 27;
    static var CAKE_EMOTE_ID = 28;
    static var POPCORN_EMOTE_ID = 29;
} // End of Class
