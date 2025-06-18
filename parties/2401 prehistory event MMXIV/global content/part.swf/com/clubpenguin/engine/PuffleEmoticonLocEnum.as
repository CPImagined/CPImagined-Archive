
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.PuffleEmoticonLocEnum extends com.clubpenguin.util.Enumeration
    {
        var _name;
        function PuffleEmoticonLocEnum (_arg_3) {
            super();
            _name = _arg_3;
        }
        function get name() {
            return(_name);
        }
        function toString() {
            return(("[PuffleEmoticonLocEnum name=\"" + _name) + "\"]");
        }
        static var PLAY_EMOTICON = new com.clubpenguin.engine.PuffleEmoticonLocEnum("play_emoticon");
        static var FOOD_EMOTICON = new com.clubpenguin.engine.PuffleEmoticonLocEnum("food_emoticon");
        static var REST_EMOTICON = new com.clubpenguin.engine.PuffleEmoticonLocEnum("rest_emoticon");
        static var CLEAN_EMOTICON = new com.clubpenguin.engine.PuffleEmoticonLocEnum("clean_emoticon");
        static var NO_EMOTE = new com.clubpenguin.engine.PuffleEmoticonLocEnum("none");
    }
