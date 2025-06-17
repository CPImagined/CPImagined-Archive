//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.friendsas2.commands.FriendsConnectedCommand implements com.clubpenguin.controller.ICommand
    {
        var _sid, _shell, _status;
        function FriendsConnectedCommand (status, sid, shell) {
            _sid = sid;
            _shell = shell;
            _status = status;
        }
        function execute() {
            _shell.setIsFriendsConnected(_status, _sid);
        }
    }
