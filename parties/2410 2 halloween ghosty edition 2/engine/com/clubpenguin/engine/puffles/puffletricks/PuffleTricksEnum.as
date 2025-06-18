//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum extends com.clubpenguin.util.Enumeration
    {
        var _name, _id, _playerEmoteFrame;
        function PuffleTricksEnum (name, id, playerEmoteFrame) {
            super();
            _name = name;
            _id = id;
            _playerEmoteFrame = playerEmoteFrame;
            PUFFLE_TRICKS_LIST.push(this);
        }
        function get id() {
            return(_id);
        }
        function get name() {
            return(_name);
        }
        function get playerEmoteFrame() {
            return(_playerEmoteFrame);
        }
        static function getPuffleTricksById(id) {
            var _local_1 = 0;
            while (_local_1 < PUFFLE_TRICKS_LIST.length) {
                if (PUFFLE_TRICKS_LIST[_local_1].id == id) {
                    return(PUFFLE_TRICKS_LIST[_local_1]);
                }
                _local_1++;
            }
            return(null);
        }
        static var PUFFLE_TRICKS_LIST = new Array();
        static var PLAYER_EMOTE_FRAME_NUZZLE = 34;
        static var PLAYER_EMOTE_FRAME_SPEAK = 35;
        static var PLAYER_EMOTE_FRAME_JUMP_FORWARD = 36;
        static var PLAYER_EMOTE_FRAME_STAND_ON_HEAD = 37;
        static var PLAYER_EMOTE_FRAME_ROLL = 38;
        static var PLAYER_EMOTE_FRAME_JUMP_SPIN = 39;
        static var NUZZLE = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("nuzzle", 1, PLAYER_EMOTE_FRAME_NUZZLE);
        static var SPEAK = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("speak", 2, PLAYER_EMOTE_FRAME_SPEAK);
        static var JUMP_FORWARD = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("jumpForward", 3, PLAYER_EMOTE_FRAME_JUMP_FORWARD);
        static var STAND_ON_HEAD = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("standOnHead", 4, PLAYER_EMOTE_FRAME_STAND_ON_HEAD);
        static var ROLL = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("roll", 5, PLAYER_EMOTE_FRAME_ROLL);
        static var JUMP_SPIN = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("jumpSpin", 6, PLAYER_EMOTE_FRAME_JUMP_SPIN);
    }
