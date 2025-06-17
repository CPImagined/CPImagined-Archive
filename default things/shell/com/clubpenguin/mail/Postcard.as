//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.mail.Postcard
    {
        var senderName, senderID, _typeID, __detailArray, _otherDate, ID, __bread, __date, __uid, __read;
        function Postcard (_senderName, _senderID, _typeID, _details, _date, _ID) {
            senderName = _senderName;
            senderID = _senderID;
            this._typeID = _typeID;
            __detailArray = _details.split(DETAIL_DELIMITER);
            _otherDate = _date;
            ID = _ID;
            __bread = false;
        }
        function get typeID() {
            return(_typeID);
        }
        static function getPostcardFromRawString(rawPostcardString) {
            var _local_1 = rawPostcardString.split(RAW_POSTCARD_SEPARATOR);
            return(getPostCardFromRawArray(_local_1));
        }
        static function getPostCardFromRawArray(rawPostCardArray) {
            var _local_2 = new com.clubpenguin.mail.Postcard(String(rawPostCardArray[0]), Number(rawPostCardArray[1]), Number(rawPostCardArray[2]), String(rawPostCardArray[3]), Number(rawPostCardArray[4]), Number(rawPostCardArray[5]));
            return(_local_2);
        }
        function set details(_details) {
            __detailArray = _details.split(DETAIL_DELIMITER);
            //return(details);
        }
        function get details() {
            return(__detailArray[0]);
        }
        function detailItem(_index) {
            return(__detailArray[_index]);
        }
        function set from(_sender) {
            senderName = _sender;
            //return(from);
        }
        function get from() {
            return(senderName);
        }
        function set user_id(_id) {
            ID = _id;
            //return(user_id);
        }
        function get user_id() {
            return(ID);
        }
        function set pc_id(_postcardID) {
            _typeID = _postcardID;
            //return(pc_id);
        }
        function get pc_id() {
            return(_typeID);
        }
        function set date(_date) {
            __date = _date;
            //return(date);
        }
        function get date() {
            return(__date);
        }
        function set unq_id(_uid) {
            __uid = _uid;
            //return(unq_id);
        }
        function get unq_id() {
            return(__uid);
        }
        function set read(_read) {
            __read = _read;
            //return(read);
        }
        function get read() {
            return(__read);
        }
        function toString() {
            var _local_2;
            _local_2 = "[Postcard]\n";
            _local_2 = _local_2 + (("\trecip:   " + from) + newline);
            _local_2 = _local_2 + (("\tuser id: " + user_id) + newline);
            _local_2 = _local_2 + (("\tpc id:   " + pc_id) + newline);
            _local_2 = _local_2 + (("\tcontent: " + details) + newline);
            _local_2 = _local_2 + (("\tdate:    " + date) + newline);
            _local_2 = _local_2 + (("\tuid:     " + unq_id) + newline);
            _local_2 = _local_2 + (("\tread:    " + read) + newline);
            return(_local_2);
        }
        static var RAW_POSTCARD_SEPARATOR = "|";
        static var DETAIL_DELIMITER = "$";
    }
