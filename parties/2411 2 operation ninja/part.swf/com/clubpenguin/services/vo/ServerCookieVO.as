
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.services.vo.ServerCookieVO implements com.clubpenguin.util.IVO, com.clubpenguin.util.ISerializable
    {
        var _cookieId;
        function ServerCookieVO (_arg_2) {
            _cookieId = _arg_2;
        }
        function destroy() {
        }
        function getID() {
            return(_cookieId);
        }
        function getCookieHandlerName() {
            return(null);
        }
        function getSendCommandName() {
            return(null);
        }
        function getReceiveCommandName() {
            return(null);
        }
        function update(vo) {
        }
        function requestFromServer() {
            _global.getCurrentShell().getServerCookieService().requestCookieFromServer(getID());
        }
        function sendToServer() {
            _global.getCurrentShell().getServerCookieService().sendCookieToServer(getID());
        }
        function toString() {
            return(("[ServerCookieVO:id=" + getID()) + "]");
        }
        function equals(_arg_2) {
            return(_cookieId == _arg_2.getID());
        }
        function serialize() {
            return(null);
        }
        function deserialize(data) {
        }
    }
