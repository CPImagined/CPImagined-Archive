//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.JumpToPlayerCommand implements com.clubpenguin.controller.ICommand
    {
        var _playerId, _airtower, _shell;
        function JumpToPlayerCommand (playerId, airtower, shell) {
            _playerId = playerId;
            _airtower = airtower;
            _shell = shell;
        }
        function execute() {
            if (_shell.getPlayerObjectFromRoomById(_playerId) != undefined) {
                return(undefined);
            }
            _shell.addListener(_shell.JUMP_TO_PLAYER_ANIMATION_COMPLETE, onJumpAnimationComplete, this);
            _shell.playJumpToPlayerInAnimation(_shell.getMyPlayerId());
        }
        function onJumpAnimationComplete(player_id) {
            if (_shell.getMyPlayerId() != player_id) {
                return(undefined);
            }
            _shell.removeListener(_shell.JUMP_TO_PLAYER_ANIMATION_COMPLETE, onJumpAnimationComplete);
            if (_shell.getPlayerObjectFromRoomById(_playerId) != undefined) {
                _shell.playJumpToPlayerOutAnimation(_shell.getMyPlayerId());
                return(undefined);
            }
            _shell.showJumpLoading("");
            _airtower.addListener(JUMP_COMMAND, onJumpResponse, this);
            _airtower.send(_airtower.PLAY_EXT, (HANDLER + "#") + JUMP_COMMAND, [_playerId, 0, 0], "str", -1);
            _shell.sendInteraction(_shell.getBuddySwidById(_playerId), _shell.JUMP_INTERACTION);
        }
        function onJumpResponse(data) {
            _airtower.removeListener(JUMP_COMMAND, onJumpResponse);
            if (data[1] == "failed") {
                _shell.hideJumpLoading();
                _shell.playJumpToPlayerOutAnimation(_shell.getMyPlayerId());
            }
        }
        static var HANDLER = "q";
        static var JUMP_COMMAND = "ssj";
    }
