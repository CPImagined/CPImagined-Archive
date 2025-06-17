//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.Keyboard
    {
        static var keyboard_listener, on_enter_func;
        function Keyboard () {
        }
        static function onKeyboardDown() {
            if (getOnEnterFunction == null) {
            }
            if (Key.getCode() == 13) {
                getOnEnterFunction()();
            }
        }
        static function setOnEnterFunction(func) {
            if (func == null) {
                Key.removeListener(keyboard_listener);
                delete keyboard_listener;
            } else if (keyboard_listener == null) {
                keyboard_listener = new Object();
                keyboard_listener.onKeyDown = onKeyboardDown;
                Key.addListener(keyboard_listener);
            }
            on_enter_func = func;
        }
        static function getOnEnterFunction() {
            return(on_enter_func);
        }
        static function clearOnEnterFunction() {
            setOnEnterFunction(null);
        }
    }
