dynamic class com.clubpenguin.world.rooms.common.triggers.PlayerAction
{
    static var DRILLING: String = "drilling";
    static var WALKING_PUFFLE: String = "walkingPuffle";
    static var DANCING: String = "dancing";
    static var WAVING: String = "waving";
    static var MOPPING: String = "mopping";
    static var MOVING: String = "moving";
    static var SITTING: String = "sitting";
    static var DRIVING: String = "driving";
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
        if ((__reg0 = action) === com.clubpenguin.world.rooms.common.triggers.PlayerAction.MOPPING) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMopping(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerAction.DRIVING) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isDriving(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerAction.DRILLING) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isDrilling(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isWalkingPuffle(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerAction.DANCING) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isDancing(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerAction.WAVING) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isWaving(player);
        }
        else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerAction.MOVING) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isMoving(player.player_id);
        }
        else if (__reg0 === com.clubpenguin.world.rooms.common.triggers.PlayerAction.SITTING) 
        {
            return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isSitting(player);
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

    static function isDriving(player)
    {
        return player.body == 4421 || player.body == 4414 || player.body == 4415 || player.body == 4715 || player.body == 14437;
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

    static function isSitting(player)
    {
        return player.frame >= 17 && player.frame <= 24;
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
        return player.attachedPuffle != null && player.attachedPuffle != undefined;
    }

}
