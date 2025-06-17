dynamic class com.clubpenguin.world.rooms2012.common.triggers.PlayerAction
{
    static var DRILLING: String = "drilling";
    static var WALKING_PUFFLE: String = "walkingPuffle";
    static var DANCING: String = "dancing";
    static var WAVING: String = "waving";
    static var MOPPING: String = "mopping";
    static var MOVING: String = "moving";
    static var SNACK_SHACK_STAMP_ID: Number = 184;
    static var COFFEE_EMOTE_ID: Number = 13;
    static var PIZZA_EMOTE_ID: Number = 24;
    static var ICE_CREAM_EMOTE_ID: Number = 26;
    static var CHOCOLATE_ICE_CREAM_EMOTE_ID: Number = 27;
    static var CAKE_EMOTE_ID: Number = 28;
    static var POPCORN_EMOTE_ID: Number = 29;

    function PlayerAction()
    {
    }

    static function isPlayer(player, action)
    {
        if ((__reg0 = action) === com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.MOPPING) 
        {
            return com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isMopping(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.DRILLING) 
        {
            return com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isDrilling(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.WALKING_PUFFLE) 
        {
            return com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isWalkingPuffle(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.DANCING) 
        {
            return com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isDancing(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.WAVING) 
        {
            return com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isWaving(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.MOVING) 
        {
            return com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.isMoving(player.player_id);
        }
        return false;
    }

    static function isMoving(playerID)
    {
        var __reg3 = _global.getCurrentEngine();
        var __reg2 = __reg3.getPlayerMovieClip(playerID);
        if (__reg2) 
        {
            return __reg2.is_moving;
        }
        return false;
    }

    static function isLocalPlayer(player)
    {
        var __reg2 = _global.getCurrentShell();
        return player.player_id == __reg2.getMyPlayerId();
    }

    static function isDancing(player)
    {
        return player.frame == 26;
    }

    static function isWaving(player)
    {
        return player.frame == player.wave_frame;
    }

    static function isMopping(player)
    {
        var __reg3 = _global.getCurrentShell();
        if (player.hand == 5084) 
        {
            if (player.frame == 26 && __reg3.getSecretFrame(player.player_id, player.frame) != 26) 
            {
                return true;
            }
        }
        return false;
    }

    static function isDrilling(player)
    {
        var __reg3 = _global.getCurrentShell();
        if (player.head == 403 || player.head == 10403 || player.head == 429 || player.head == 10429 || player.head == 674 || player.head == 1133) 
        {
            if (player.frame == 26 && __reg3.getSecretFrame(player.player_id, player.frame) != 26) 
            {
                return true;
            }
        }
        return false;
    }

    static function isWalkingPuffle(player)
    {
        return player.hand >= 750 && player.hand <= 759;
    }

}
