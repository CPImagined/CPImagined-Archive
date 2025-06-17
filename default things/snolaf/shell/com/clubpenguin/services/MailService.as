//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.MailService extends com.clubpenguin.services.AbstractService
    {
        var _inboxReceived, _postCardReceived, connection, extension, messageFormat;
        function MailService (connection) {
            super(connection);
            _inboxReceived = new org.osflash.signals.Signal(com.clubpenguin.mail.Inbox);
            _postCardReceived = new org.osflash.signals.Signal(com.clubpenguin.mail.Postcard);
            connection.getResponded().add(onResponded, this);
        }
        function get inboxReceived() {
            return(_inboxReceived);
        }
        function get postCardReceived() {
            return(_postCardReceived);
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case GET_MAIL : 
                    onInboxReceived(responseData);
                    break;
                case RECEIVE_MAIL : 
                    onPostCardReceived(responseData);
                    break;
            }
        }
        function getInbox() {
            connection.sendXtMessage(extension, MAIL_HANDLER + GET_MAIL, [], messageFormat, -1);
            return(_inboxReceived);
        }
        function onInboxReceived(responseData) {
            var _local_3 = responseData.splice(1);
            var _local_2 = com.clubpenguin.mail.Inbox.getInboxFromRawArray(_local_3);
            _inboxReceived.dispatch(_local_2);
        }
        function onPostCardReceived(responseData) {
            var _local_3 = responseData.splice(1);
            var _local_2 = com.clubpenguin.mail.Postcard.getPostCardFromRawArray(_local_3);
            _postCardReceived.dispatch(_local_2);
        }
        var MAIL_HANDLER = "l#";
        var GET_MAIL = "mg";
        var RECEIVE_MAIL = "mr";
    }
