//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.FindPlayerCommand implements com.clubpenguin.controller.ICommand
    {
        var _name, _airtower, _bridgeSendMessage, _swfBridge;
        function FindPlayerCommand (name, airtower, bridgeSendMessage, swfBridge) {
            _name = name;
            _airtower = airtower;
            _bridgeSendMessage = bridgeSendMessage;
            _swfBridge = swfBridge;
        }
        function execute() {
            _airtower.addListener(_airtower.GET_PLAYER_INFO_BY_NAME, onPlayerDataReceived, this);
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.GET_PLAYER_INFO_BY_NAME, [_name], "str", -1);
        }
        function onPlayerDataReceived(data) {
            _airtower.removeListener(_airtower.GET_PLAYER_INFO_BY_NAME, onPlayerDataReceived);
            var _local_3 = new com.clubpenguin.friendsas2.CredentialsVO(data[2], data[3], data[1]);
            (new com.clubpenguin.friendsas2.commands.PlayerFoundCommand(_local_3, _swfBridge, _bridgeSendMessage)).execute();
        }
    }
