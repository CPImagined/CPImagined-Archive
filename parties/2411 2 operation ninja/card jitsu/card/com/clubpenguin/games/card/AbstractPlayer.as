//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.AbstractPlayer extends com.clubpenguin.games.card.BaseObject
    {
        var _seat, _nickname, _color, _rank, log;
        function AbstractPlayer (seat, nickname, color, rank) {
            super();
            _seat = seat;
            _nickname = nickname;
            _color = color;
            _rank = rank;
            this.log(((((((("Player - seat->" + seat) + " | nickname->") + nickname) + " | color->") + _color) + " | rank->") + _rank) + " created...", "INFO");
        }
        function get seat() {
            return(_seat);
        }
        function set seat(seat) {
            _seat = seat;
            //return(this.seat);
        }
        function get nickname() {
            return(_nickname);
        }
        function set nickname(nickname) {
            _nickname = nickname;
            //return(this.nickname);
        }
        function get color() {
            return(_color);
        }
        function set color(color) {
            _color = color;
            //return(this.color);
        }
        function get rank() {
            return(_rank);
        }
        function set rank(rank) {
            _rank = rank;
            //return(this.rank);
        }
        function toString() {
            return((((((("Player - seat->" + seat) + " | nickname->") + nickname) + " | color->") + _color) + " | rank->") + _rank);
        }
        static var CLASS_PACKAGE = "com.clubpenguin.games.card";
        static var CLASS_NAME = "AbstractPlayer";
        var __classPackage = CLASS_PACKAGE;
        var __className = CLASS_NAME;
    }
