//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.mail.Inbox
    {
        var postCards;
        function Inbox () {
            postCards = [];
        }
        function addPostCard(postCard) {
            postCards.push(postCard);
        }
        function getPostCardsByTypeID(typeID) {
            var _local_3;
            var _local_4 = [];
            var _local_2 = 0;
            while (_local_2 < postCards.length) {
                _local_3 = postCards[_local_2];
                if (_local_3.typeID == typeID) {
                    _local_4.push(_local_3);
                }
                _local_2++;
            }
            return(_local_4);
        }
        static function getInboxFromRawArray(rawInbox) {
            var _local_3 = new com.clubpenguin.mail.Inbox();
            var _local_1 = 0;
            while (_local_1 < rawInbox.length) {
                _local_3.addPostCard(com.clubpenguin.mail.Postcard.getPostcardFromRawString(rawInbox[_local_1]));
                _local_1++;
            }
            return(_local_3);
        }
    }
