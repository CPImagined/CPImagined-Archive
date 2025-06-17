//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Heartbeat
    {
        var _shell, _airtower, _timeout, _heart_interval;
        function Heartbeat (shell, airtower) {
            _shell = shell;
            _airtower = airtower;
            _timeout = new com.clubpenguin.util.Timeout(TIMEOUT_FREQUENCY, handleTimeout, [], this);
            _shell.addListener(_shell.WORLD_CONNECT_SUCCESS, startHeartbeat, this);
            _airtower.addListener(_airtower.HEARTBEAT, handleSendHeartbeat, this);
        }
        function startHeartbeat() {
            _heart_interval = setInterval(com.clubpenguin.util.Delegate.create(this, sendHeartbeat), com.clubpenguin.util.Time.ONE_MINUTE_IN_MILLISECONDS);
        }
        function stopHeartbeat() {
            clearInterval(_heart_interval);
            _timeout.stop();
        }
        function sendHeartbeat() {
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.HEARTBEAT, [], "str", _shell.getCurrentServerRoomId());
            _timeout.start();
        }
        function handleSendHeartbeat() {
            _timeout.stop();
        }
        function handleTimeout() {
            _shell.$e("[shell] handleTimeout() -> Client has timed out! Heartbeat request was not responded to fast enough.", {error_code:_shell.CONNECTION_LOST});
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PLAYER_HANDLER + "#") + _airtower.TIMEOUT, [], "str", _shell.getCurrentServerRoomId());
            clearInterval(_heart_interval);
            _timeout.stop();
        }
        static var TIMEOUT_FREQUENCY = 15;
    }
