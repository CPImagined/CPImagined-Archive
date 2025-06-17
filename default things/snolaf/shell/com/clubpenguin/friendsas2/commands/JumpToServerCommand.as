//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.JumpToServerCommand implements com.clubpenguin.controller.ICommand
    {
        var _worldId, _loginKey, _airtower, _shell, _targetPlayerId, _playerId;
        function JumpToServerCommand (worldId, loginKey, airtower, shell, targetPlayerId) {
            _worldId = worldId;
            _loginKey = loginKey;
            _airtower = airtower;
            _shell = shell;
            _targetPlayerId = targetPlayerId;
            _playerId = _shell.getMyPlayerId();
        }
        function execute() {
            _shell.addListener(_shell.JUMP_TO_PLAYER_ANIMATION_COMPLETE, onJumpAnimationComplete, this);
            _shell.playJumpToPlayerInAnimation(_playerId);
        }
        function onJumpAnimationComplete(player_id) {
            if (_shell.getMyPlayerId() != player_id) {
                return(undefined);
            }
            _shell.removeListener(_shell.JUMP_TO_PLAYER_ANIMATION_COMPLETE, onJumpAnimationComplete);
            _shell.jumpToWorld(_worldId, _loginKey, _playerId);
            _shell.sendInteraction(_shell.getBuddySwidById(_targetPlayerId), _shell.JUMP_INTERACTION);
        }
    }
