//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.StampsService extends com.clubpenguin.services.AbstractService
    {
        var _playersStampsReceived, _recentlyEarnedStampsReceived, _playersStampBookCoverDetailsReceived, _playerEarnedStampReceived, connection, extension, messageFormat;
        function StampsService (connection) {
            super(connection);
            _playersStampsReceived = new org.osflash.signals.Signal(Array);
            _recentlyEarnedStampsReceived = new org.osflash.signals.Signal(Array);
            _playersStampBookCoverDetailsReceived = new org.osflash.signals.Signal(Array);
            _playerEarnedStampReceived = new org.osflash.signals.Signal(Array);
            connection.getResponded().add(onResponded, this);
        }
        function get playersStampsReceived() {
            return(_playersStampsReceived);
        }
        function get recentlyEarnedStampsReceived() {
            return(_recentlyEarnedStampsReceived);
        }
        function get playersStampBookCoverDetailsReceived() {
            return(_playersStampBookCoverDetailsReceived);
        }
        function get playerEarnedStampReceived() {
            return(_playerEarnedStampReceived);
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case GET_PLAYERS_STAMPS : 
                    _playersStampsReceived.dispatch(responseData);
                    break;
                case GET_MY_RECENTLY_EARNED_STAMPS : 
                    _recentlyEarnedStampsReceived.dispatch(responseData);
                    break;
                case GET_STAMP_BOOK_COVER_DETAILS : 
                    _playersStampBookCoverDetailsReceived.dispatch(responseData);
                    break;
                case RECEIVE_STAMP_EARNED : 
                    _playerEarnedStampReceived.dispatch(responseData);
                default : 
                    return(undefined);
            }
        }
        function sendStampEarned(stampID) {
            connection.sendXtMessage(extension, STAMPS_HANDLER + SEND_STAMP_EARNED, [stampID], messageFormat, -1);
            return(_recentlyEarnedStampsReceived);
        }
        function getPlayersStamps(playerID) {
            connection.sendXtMessage(extension, STAMPS_HANDLER + GET_PLAYERS_STAMPS, [playerID], messageFormat, -1);
            return(_playersStampsReceived);
        }
        function getMyRecentlyEarnedStamps() {
            connection.sendXtMessage(extension, STAMPS_HANDLER + GET_MY_RECENTLY_EARNED_STAMPS, [], messageFormat, -1);
            return(_recentlyEarnedStampsReceived);
        }
        function getStampBookCoverDetails(playerID) {
            connection.sendXtMessage(extension, STAMPS_HANDLER + GET_STAMP_BOOK_COVER_DETAILS, [playerID], messageFormat, -1);
            return(_playersStampBookCoverDetailsReceived);
        }
        function setStampBookCoverDetails(colourID, highlightID, patternID, claspID, coverItemDetails) {
            var _local_3 = [];
            var _local_4 = coverItemDetails.length;
            _local_3.push(colourID);
            _local_3.push(highlightID);
            _local_3.push(patternID);
            _local_3.push(claspID);
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                _local_3.push(coverItemDetails[_local_2]);
                _local_2++;
            }
            connection.sendXtMessage(extension, STAMPS_HANDLER + SET_STAMP_BOOK_COVER_DETAILS, _local_3, messageFormat, -1);
            return(_playersStampBookCoverDetailsReceived);
        }
        static var STAMPS_HANDLER = "st#";
        static var SEND_STAMP_EARNED = "sse";
        static var GET_PLAYERS_STAMPS = "gps";
        static var GET_MY_RECENTLY_EARNED_STAMPS = "gmres";
        static var GET_STAMP_BOOK_COVER_DETAILS = "gsbcd";
        static var SET_STAMP_BOOK_COVER_DETAILS = "ssbcd";
        static var RECEIVE_STAMP_EARNED = "aabs";
    }
