//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.ShowCharacterCardCommand implements com.clubpenguin.controller.ICommand
    {
        var _characterId, _roster, _interface, _airtower, _shell;
        function ShowCharacterCardCommand (characterId, roster, interfaceClip, airtower, shell) {
            _characterId = characterId;
            _roster = roster;
            _interface = interfaceClip;
            _airtower = airtower;
            _shell = shell;
        }
        function execute() {
            _shell.addListener(_shell.LOAD_MASCOT_OBJECT, onMascotDataReceived, this);
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.GET_MASCOT_OBJECT, [_characterId], "str", -1);
        }
        function onMascotDataReceived(data) {
            _shell.removeListener(_shell.LOAD_MASCOT_OBJECT, onMascotDataReceived);
            _interface.showPlayerWidget(_characterId, _shell.getMascotNicknameByID(_characterId));
        }
    }
