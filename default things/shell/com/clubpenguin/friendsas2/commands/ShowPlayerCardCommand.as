//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.ShowPlayerCardCommand implements com.clubpenguin.controller.ICommand
    {
        var _swid, _roster, _interface, _shell, _airtower, _buddyVO;
        function ShowPlayerCardCommand (swid, roster, interfaceClip, airtower, shell) {
            _swid = swid;
            _roster = roster;
            _interface = interfaceClip;
            _shell = shell;
            _airtower = airtower;
        }
        function execute() {
            if (_swid == _shell.getMyPlayerObject().friendsLoginVO.swid) {
                _interface.showPlayerWidget(_shell.getMyPlayerId(), _shell.getMyPlayerNickname());
                return(undefined);
            }
            var _local_3 = 0;
            while (_local_3 < _roster.buddies.length) {
                var _local_2 = com.clubpenguin.friendsas2.buddiesintegration.BuddyVO(_roster.buddies[_local_3]);
                if (_local_2.swid == _swid) {
                    if ((_local_2.player_id == -1) || (_local_2.player_id == null)) {
                        _buddyVO = _local_2;
                        _airtower.addListener(_airtower.GET_PLAYER_ID_AND_NAME_BY_SWID, onBuddyDataReceived, this);
                        _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.GET_PLAYER_ID_AND_NAME_BY_SWID, [_swid], "str", -1);
                    } else {
                        _interface.showPlayerWidget(_local_2.player_id, _local_2.nickname);
                    }
                    break;
                }
                _local_3++;
            }
            if (_buddyVO == null) {
                _airtower.addListener(_airtower.GET_PLAYER_ID_AND_NAME_BY_SWID, onPlayerDataReceived, this);
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.GET_PLAYER_ID_AND_NAME_BY_SWID, [_swid], "str", -1);
            }
        }
        function onBuddyDataReceived(data) {
            _airtower.removeListener(_airtower.GET_PLAYER_ID_AND_NAME_BY_SWID, onPlayerDataReceived);
            _interface.showPlayerWidget(data[2], _buddyVO.nickname);
        }
        function onPlayerDataReceived(data) {
            _airtower.removeListener(_airtower.GET_PLAYER_ID_AND_NAME_BY_SWID, onPlayerDataReceived);
            _interface.showPlayerWidget(data[2], data[3]);
        }
    }
