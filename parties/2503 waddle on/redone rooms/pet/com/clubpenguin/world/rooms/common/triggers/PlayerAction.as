//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.triggers.PlayerAction
    {
        function PlayerAction () {
        }
        static function isPlayer(_arg_1, _arg_2) {
            switch (_arg_2) {
                case MOPPING : 
                    return(isMopping(_arg_1));
                case DRIVING : 
                    return(isDriving(_arg_1));
                case DRILLING : 
                    return(isDrilling(_arg_1));
                case WALKING_PUFFLE : 
                    return(isWalkingPuffle(_arg_1));
                case DANCING : 
                    return(isDancing(_arg_1));
                case WAVING : 
                    return(isWaving(_arg_1));
                case MOVING : 
                    return(isMoving(_arg_1.player_id));
                case SITTING : 
                    return(isSitting(_arg_1));
            }
            return(false);
        }
        static function isMoving(_arg_4) {
            var _local_3 = _global.getCurrentEngine();
            var _local_2 = _local_3.getPlayerMovieClip(_arg_4);
            if (_local_2) {
                return(_local_2.is_moving);
            }
            return(false);
        }
        static function isDriving(_arg_1) {
            return(((((_arg_1.body == 4421) || (_arg_1.body == 4414)) || (_arg_1.body == 4415)) || (_arg_1.body == 4715)) || (_arg_1.body == 14437));
        }
        static function isLocalPlayer(_arg_3) {
            var _local_2 = _global.getCurrentShell();
            return(_arg_3.player_id == _local_2.getMyPlayerId());
        }
        static function isDancing(_arg_1) {
            return(_arg_1.frame == 26);
        }
        static function isWaving(_arg_1) {
            return(_arg_1.frame == _arg_1.wave_frame);
        }
        static function isMopping(_arg_2) {
            var _local_3 = _global.getCurrentShell();
            if (_arg_2.hand == 5084) {
                if ((_arg_2.frame == 26) && (_local_3.getSecretFrame(_arg_2.player_id, _arg_2.frame) != 26)) {
                    return(true);
                }
            }
            return(false);
        }
        static function isSitting(_arg_1) {
            return((_arg_1.frame >= 17) && (_arg_1.frame <= 24));
        }
        static function isDrilling(_arg_2) {
            var _local_3 = _global.getCurrentShell();
            if ((((((_arg_2.head == 403) || (_arg_2.head == 10403)) || (_arg_2.head == 429)) || (_arg_2.head == 10429)) || (_arg_2.head == 674)) || (_arg_2.head == 1133)) {
                if ((_arg_2.frame == 26) && (_local_3.getSecretFrame(_arg_2.player_id, _arg_2.frame) != 26)) {
                    return(true);
                }
            }
            return(false);
        }
        static function isWalkingPuffle(_arg_1) {
            return((_arg_1.attachedPuffle != null) && (_arg_1.attachedPuffle != undefined));
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
