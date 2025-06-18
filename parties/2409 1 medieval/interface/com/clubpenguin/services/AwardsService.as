//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.AwardsService extends com.clubpenguin.services.AbstractService
    {
        var _awardsListReceived, connection, extension, messageFormat;
        function AwardsService (connection) {
            super(connection);
            _awardsListReceived = new org.osflash.signals.Signal(Array);
            connection.getResponded().add(onResponded, this);
        }
        function get awardsListReceived() {
            return(_awardsListReceived);
        }
        function onResponded(responseType, responseData) {
            if (!(responseType === QUERY_PLAYERS_AWARDS)) {
            } else {
                _awardsListReceived.dispatch(responseData);
            }
            return(undefined);
        }
        function queryPlayersAwards(playerID) {
            connection.sendXtMessage(extension, ITEM_HANDLER + QUERY_PLAYERS_AWARDS, [playerID], messageFormat, -1);
            return(_awardsListReceived);
        }
        static var ITEM_HANDLER = "i#";
        static var QUERY_PLAYERS_AWARDS = "qpa";
    }
