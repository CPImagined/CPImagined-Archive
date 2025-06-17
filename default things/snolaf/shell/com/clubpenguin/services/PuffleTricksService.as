//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.PuffleTricksService extends com.clubpenguin.services.AbstractService
    {
        function PuffleTricksService (connection) {
            super(connection);
            connection.getResponded().add(onResponded, this);
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case PUFFLE_TRICK : 
                    onPuffleTrick(responseData);
                    break;
                default : 
            }
        }
        function onPuffleTrick(responseData) {
            var _local_3 = Number(responseData[1]);
            var _local_2 = Number(responseData[2]);
            _global.getCurrentEngine().puffleTricks.onPuffleTrickReceivedFromServer(_local_3, _local_2);
        }
        static var PUFFLE_TRICK = "puffletrick";
    }
