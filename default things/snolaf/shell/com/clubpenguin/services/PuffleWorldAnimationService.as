//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.PuffleWorldAnimationService extends com.clubpenguin.services.AbstractService
    {
        function PuffleWorldAnimationService (connection, localPlayerID) {
            super(connection);
            connection.getResponded().add(onResponded, this);
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case PUFFLE_EAT_ANIMATION : 
                    onPuffleEatAnimation(responseData);
                    break;
                case PUFFLE_GOLD_BERRY_ANIMATION : 
                    onPuffleGoldBerryAnimation(responseData);
                    break;
                case PUFFLE_GOLD_REVEAL_ANIMATION : 
                    onGoldRevealAnimation(responseData);
                    break;
                case PUFFLE_CARE_ITEM_DELIVERED : 
                    onPuffleFullStatsAnimation(responseData);
                    break;
            }
        }
        function onPuffleEatAnimation(responseData) {
            var _local_2 = Number(responseData[1]);
            var _local_3 = Number(responseData[2]);
            _global.getCurrentEngine().puffleCareStationController.onPuffleCareStationFeed(_local_2, _local_3);
        }
        function onPuffleGoldBerryAnimation(responseData) {
            var _local_2 = Number(responseData[1]);
            var _local_3 = Number(responseData[2]);
            _global.getCurrentEngine().puffleGoldBerryStationController.onPuffleGoldBerryStationFeed(_local_2, _local_3);
        }
        function onGoldRevealAnimation(responseData) {
            var _local_2 = Number(responseData[1]);
            _global.getCurrentEngine().puffleGoldRevealController.onGoldPuffleReveal(_local_2);
        }
        function onPuffleFullStatsAnimation(responseData) {
            var _local_4 = responseData[2].split("|");
            var _local_3 = Number(responseData[1]);
            var _local_2 = _local_4[5];
            if (_local_2 == 1) {
                _global.getCurrentEngine().puffleCareStationController.onPuffleFullStatsAnimation(_local_3);
            }
        }
        static var PUFFLE_EAT_ANIMATION = "carestationmenuchoice";
        static var PUFFLE_GOLD_BERRY_ANIMATION = "oberry";
        static var PUFFLE_GOLD_REVEAL_ANIMATION = "revealgoldpuffle";
        static var PUFFLE_CARE_ITEM_DELIVERED = "pcid";
    }
