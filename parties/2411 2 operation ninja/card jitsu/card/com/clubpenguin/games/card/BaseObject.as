//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.BaseObject extends Object
    {
        function BaseObject () {
            super();
        }
        function get classPackage() {
            return(__classPackage);
        }
        function get className() {
            return(__className);
        }
        function toString() {
            return((__classPackage + ".") + __className);
        }
        function log(pMessage, pLevel) {
            com.clubpenguin.util.Debug.log((((__classPackage + ".") + __className) + "::") + pMessage, pLevel);
        }
        function destroy() {
        }
        static var CLASS_PACKAGE = "com.clubpenguin.game.card";
        static var CLASS_NAME = "BaseObject";
        var __classPackage = CLASS_PACKAGE;
        var __className = CLASS_NAME;
    }
