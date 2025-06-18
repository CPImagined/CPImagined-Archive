//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.triggers.PlayerAction
    {
        function PlayerAction () {
        }
        static function isPlayer(player, action) {
            switch (action) {
                case MOPPING : 
                    return(isMopping(player));
                    return(false);
                case DRIVING : 
                    return(isDriving(player));
                    return(false);
                case DRILLING : 
                    return(isDrilling(player));
                    return(false);
                case WALKING_PUFFLE : 
                    return(isWalkingPuffle(player));
                    return(false);
                case DANCING : 
                    return(isDancing(player));
                    return(false);
                case WAVING : 
                    return(isWaving(player));
                    return(false);
                case MOVING : 
                    return(isMoving(player.player_id));
                    return(false);
                case SITTING : 
                    return(isSitting(player));
                    return(false);
            }
            return(false);
        }
        static function isMoving(playerID) {
            var _local_3 = _global.getCurrentEngine();
            var _local_2 = _local_3.getPlayerMovieClip(playerID);
            if (_local_2) {
                return(_local_2.is_moving);
            }
            return(false);
        }
        static function isDriving(player) {
            return(((((player.body == 4421) || (player.body == 4414)) || (player.body == 4415)) || (player.body == 4715)) || (player.body == 14437));
        }
        static function isLocalPlayer(player) {
            var _local_2 = _global.getCurrentShell();
            return(player.player_id == _local_2.getMyPlayerId());
        }
        static function isDancing(player) {
            return(player.frame == 26);
        }
        static function isWaving(player) {
            return(player.frame == player.wave_frame);
        }
        static function isMopping(player) {
            var _local_3 = _global.getCurrentShell();
            if (player.hand == 5084) {
                if ((player.frame == 26) && (_local_3.getSecretFrame(player.player_id, player.frame) != 26)) {
                    return(true);
                }
            }
            return(false);
        }
        static function isSitting(player) {
            return((player.frame >= 17) && (player.frame <= 24));
        }
        static function isDrilling(player) {
            var _local_3 = _global.getCurrentShell();
            if ((((((player.head == 403) || (player.head == 10403)) || (player.head == 429)) || (player.head == 10429)) || (player.head == 674)) || (player.head == 1133)) {
                if ((player.frame == 26) && (_local_3.getSecretFrame(player.player_id, player.frame) != 26)) {
                    return(true);
                }
            }
            return(false);
        }
        static function isWalkingPuffle(player) {
            return(((player.hand >= 750) && (player.hand <= 759)) || ((player.hand >= 5230) && (player.hand <= 5239)));
        }
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
    }
