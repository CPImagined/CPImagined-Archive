    class com.clubpenguin.shell.puffle.PuffleHatEnum extends com.clubpenguin.util.Enumeration
    {
        var _name;
        function PuffleHatEnum (name) {
            super();
            _name = name;
        }
        function get name() {
            return(_name);
        }
        function toString() {
            return(("[PuffleHatEnum name=\"" + _name) + "\"]");
        }
        static var EMPTY_HAT = new com.clubpenguin.shell.puffle.PuffleHatEnum("empty hat");
        static var ACTUAL_HAT = new com.clubpenguin.shell.puffle.PuffleHatEnum("actual hat");
    }
