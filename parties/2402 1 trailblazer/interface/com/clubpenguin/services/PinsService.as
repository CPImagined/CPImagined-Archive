//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.PinsService extends com.clubpenguin.services.AbstractService
    {
        var _pinsListReceived, connection, extension, messageFormat;
        function PinsService (connection) {
            super(connection);
            _pinsListReceived = new org.osflash.signals.Signal(Array);
            connection.getResponded().add(onResponded, this);
        }
        function get pinsListReceived() {
            return(_pinsListReceived);
        }
        function onResponded(responseType, responseData) {
            if (!(responseType === QUERY_PLAYERS_PINS)) {
            } else {
                _pinsListReceived.dispatch(responseData);
            }
            return(undefined);
        }
        function queryPlayersPins(playerID) {
            connection.sendXtMessage(extension, ITEM_HANDLER + QUERY_PLAYERS_PINS, [playerID], messageFormat, -1);
            return(_pinsListReceived);
        }
        static var ITEM_HANDLER = "i#";
        static var QUERY_PLAYERS_PINS = "qpp";
    }
