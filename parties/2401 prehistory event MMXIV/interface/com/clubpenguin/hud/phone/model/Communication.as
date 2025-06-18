//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.model.Communication
    {
        var _messages;
        function Communication () {
            _messages = [];
        }
        function get messages() {
            return(_messages);
        }
        function pushNewMessage(message) {
            _messages.unshift(message);
            if (_messages.length > MAX_MESSAGES) {
                _messages.pop();
            }
        }
        static var MAX_MESSAGES = 10;
    }
