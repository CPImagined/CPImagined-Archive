    class com.clubpenguin.services.vo.ServerCookieVO implements com.clubpenguin.util.IVO, com.clubpenguin.util.ISerializable
    {
        var _cookieId;
        function ServerCookieVO (cookieId) {
            _cookieId = cookieId;
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
        function equals(vo) {
            return(_cookieId == vo.getID());
        }
        function serialize() {
            return(null);
        }
        function deserialize(data) {
        }
    }
