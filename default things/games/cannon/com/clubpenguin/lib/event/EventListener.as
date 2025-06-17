//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.event.EventListener
    {
        var handler, scope;
        function EventListener (_arg_3, _arg_2) {
            handler = _arg_3;
            scope = _arg_2;
        }
        function toString() {
            return(("EventListener with scope (" + scope) + ")");
        }
    }
