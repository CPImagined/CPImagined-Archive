dynamic class com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum extends com.clubpenguin.util.Enumeration
{
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
    var _careEffects;
    var _key;

    function PuffleRoomCareEffectEnum(key, careEffects)
    {
        super();
        this._key = key;
        this._careEffects = careEffects;
        com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST.push(this);
    }

    function get careEffects()
    {
        return this._careEffects;
    }

    function get key()
    {
        return this._key;
    }

    static function getCareEffectsByRoomKey(key)
    {
        var __reg1 = 0;
        while (__reg1 < com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST.length) 
        {
            if (com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST[__reg1].key == key) 
            {
                return com.clubpenguin.shell.puffle.PuffleRoomCareEffectEnum.ROOM_CARE_EFFECTS_LIST[__reg1].careEffects;
            }
            ++__reg1;
        }
        return null;
    }

}
