//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum extends com.clubpenguin.util.Enumeration
    {
        var _key, _careEffects;
        function PuffleRoomCareEffectEnum (_arg_3, _arg_4) {
            super();
            _key = _arg_3;
            _careEffects = _arg_4;
            ROOM_CARE_EFFECTS_LIST.push(this);
        }
        function get careEffects() {
            return(_careEffects);
        }
        function get key() {
            return(_key);
        }
        static function getCareEffectsByRoomKey(_arg_2) {
            var _local_1 = 0;
            while (_local_1 < ROOM_CARE_EFFECTS_LIST.length) {
                if (ROOM_CARE_EFFECTS_LIST[_local_1]["key"] == _arg_2) {
                    return(ROOM_CARE_EFFECTS_LIST[_local_1].careEffects);
                }
                _local_1++;
            }
            return(null);
        }
        static var ROOM_CARE_EFFECTS_LIST = new Array();
        static var HOTELLOBBY = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("hotellobby", [com.clubpenguin.shell.PuffleStatsVO.FOOD, com.clubpenguin.shell.PuffleStatsVO.REST]);
        static var HOTELSPA = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("hotelspa", [com.clubpenguin.shell.PuffleStatsVO.PLAY, com.clubpenguin.shell.PuffleStatsVO.CLEAN]);
        static var HOTELROOF = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("hotelroof", [com.clubpenguin.shell.PuffleStatsVO.FOOD, com.clubpenguin.shell.PuffleStatsVO.REST, com.clubpenguin.shell.PuffleStatsVO.PLAY, com.clubpenguin.shell.PuffleStatsVO.CLEAN]);
        static var PIZZA = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("pizza", [com.clubpenguin.shell.PuffleStatsVO.FOOD]);
        static var PARK = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("park", [com.clubpenguin.shell.PuffleStatsVO.FOOD, com.clubpenguin.shell.PuffleStatsVO.REST, com.clubpenguin.shell.PuffleStatsVO.PLAY, com.clubpenguin.shell.PuffleStatsVO.CLEAN]);
        static var DOJOWATER = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("dojowater", [com.clubpenguin.shell.PuffleStatsVO.CLEAN]);
        static var COVE = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("cove", [com.clubpenguin.shell.PuffleStatsVO.CLEAN]);
        static var CAVE = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("cave", [com.clubpenguin.shell.PuffleStatsVO.CLEAN]);
        static var LAKE = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("lake", [com.clubpenguin.shell.PuffleStatsVO.CLEAN]);
    }
