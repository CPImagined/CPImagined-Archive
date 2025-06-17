//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.FriendsDisconnectedCommand implements com.clubpenguin.controller.ICommand
    {
        var _shell, _status;
        function FriendsDisconnectedCommand (status, shell) {
            _shell = shell;
            _status = status;
        }
        function execute() {
            _shell.setIsFriendsConnected(_status, "");
        }
    }
