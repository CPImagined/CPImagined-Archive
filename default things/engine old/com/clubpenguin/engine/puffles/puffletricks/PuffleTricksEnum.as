class com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum extends com.clubpenguin.util.Enumeration
{
    var _name, _id, _playerEmoteFrame, __get__id, __get__name, __get__playerEmoteFrame;
    function PuffleTricksEnum(name, id, playerEmoteFrame)
    {
        super();
        _name = name;
        _id = id;
        _playerEmoteFrame = playerEmoteFrame;
        com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PUFFLE_TRICKS_LIST.push(this);
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function get playerEmoteFrame()
    {
        return (_playerEmoteFrame);
    } // End of the function
    static function getPuffleTricksById(id)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PUFFLE_TRICKS_LIST.length; ++_loc1)
        {
            if (com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PUFFLE_TRICKS_LIST[_loc1].id == id)
            {
                return (com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PUFFLE_TRICKS_LIST[_loc1]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    static var PUFFLE_TRICKS_LIST = new Array();
    static var PLAYER_EMOTE_FRAME_NUZZLE = 34;
    static var PLAYER_EMOTE_FRAME_SPEAK = 35;
    static var PLAYER_EMOTE_FRAME_JUMP_FORWARD = 36;
    static var PLAYER_EMOTE_FRAME_STAND_ON_HEAD = 37;
    static var PLAYER_EMOTE_FRAME_ROLL = 38;
    static var PLAYER_EMOTE_FRAME_JUMP_SPIN = 39;
    static var NUZZLE = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("nuzzle", 1, com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PLAYER_EMOTE_FRAME_NUZZLE);
    static var SPEAK = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("speak", 2, com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PLAYER_EMOTE_FRAME_SPEAK);
    static var JUMP_FORWARD = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("jumpForward", 3, com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PLAYER_EMOTE_FRAME_JUMP_FORWARD);
    static var STAND_ON_HEAD = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("standOnHead", 4, com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PLAYER_EMOTE_FRAME_STAND_ON_HEAD);
    static var ROLL = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("roll", 5, com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PLAYER_EMOTE_FRAME_ROLL);
    static var JUMP_SPIN = new com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum("jumpSpin", 6, com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.PLAYER_EMOTE_FRAME_JUMP_SPIN);
} // End of Class
