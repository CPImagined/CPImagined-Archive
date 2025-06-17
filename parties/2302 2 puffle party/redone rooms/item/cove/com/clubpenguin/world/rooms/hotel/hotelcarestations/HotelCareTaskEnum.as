//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum
    {
        var _taskNumber, _effect, _careItemID;
        function HotelCareTaskEnum (taskNumber, effect, careItemID) {
            _taskNumber = taskNumber;
            _effect = effect;
            _careItemID = careItemID;
        }
        function get taskNumber() {
            return(_taskNumber);
        }
        function get effect() {
            return(_effect);
        }
        function get careItemID() {
            return(_careItemID);
        }
        function toString() {
            return((("HotelCareTaskEnum number : " + _taskNumber) + " | effect : ") + _effect);
        }
        static var PLAYING_TASK = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum(1, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PUFFLE_PLAY_POINT, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_ITEM_ID);
        static var GROOMING_TASK = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum(2, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PUFFLE_BATH_POINT, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
        static var EATING_TASK = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum(3, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PUFFLE_EAT_POINT, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_EAT_ITEM_ID);
        static var SLEEPING_TASK = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum(4, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PUFFLE_SLEEP_POINT, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_REST_ITEM_ID);
    }
