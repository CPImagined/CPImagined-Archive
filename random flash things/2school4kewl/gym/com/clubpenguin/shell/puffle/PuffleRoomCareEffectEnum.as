class com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum extends com.clubpenguin.util.Enumeration
{
    var _key, _careEffects, __get__careEffects, __get__key;
    function PuffleRoomCareEffectEnum(key, careEffects)
    {
        super();
        _key = key;
        _careEffects = careEffects;
        com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST.push(this);
    } // End of the function
    function get careEffects()
    {
        return (_careEffects);
    } // End of the function
    function get key()
    {
        return (_key);
    } // End of the function
    static function getCareEffectsByRoomKey(key)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST.length; ++_loc1)
        {
            if (com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST[_loc1].key == key)
            {
                return (com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST[_loc1].careEffects);
            } // end if
        } // end of for
        return (null);
    } // End of the function
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
    static var PARTY3 = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("party3", [com.clubpenguin.shell.PuffleStatsVO.FOOD]);
    static var PARTY5 = new com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum("party5", [com.clubpenguin.shell.PuffleStatsVO.PLAY]);
} // End of Class
