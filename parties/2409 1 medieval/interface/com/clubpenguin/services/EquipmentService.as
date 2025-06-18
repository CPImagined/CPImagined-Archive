//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.EquipmentService extends com.clubpenguin.services.AbstractService
    {
        var _handItemEquipped, connection, extension, messageFormat;
        function EquipmentService (connection) {
            super(connection);
            _handItemEquipped = new org.osflash.signals.Signal(Number, Number);
            connection.getResponded().add(onResponded, this);
        }
        function get handItemEquipped() {
            return(_handItemEquipped);
        }
        function onResponded(responseType, responseData) {
            if (!(responseType === UPDATE_PLAYER_HAND)) {
            } else {
                onHandItemEquipped(responseData);
            }
        }
        function equipHandItem(handItemID) {
            connection.sendXtMessage(extension, SETTING_HANDLER + UPDATE_PLAYER_HAND, [handItemID], messageFormat, -1);
            return(_handItemEquipped);
        }
        function onHandItemEquipped(responseData) {
            var _local_3 = Number(responseData[1]);
            var _local_2 = Number(responseData[2]);
            _handItemEquipped.dispatch(_local_3, _local_2);
        }
        static var SETTING_HANDLER = "s#";
        static var UPDATE_PLAYER_HAND = "upa";
    }
