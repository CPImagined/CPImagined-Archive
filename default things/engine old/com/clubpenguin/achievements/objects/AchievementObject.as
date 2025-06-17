
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.objects.AchievementObject
    {
        var _objects, _operation, _debug, __get__debug, _shell, __get__shell;
        function AchievementObject (descriptor) {
            _objects = [];
            _operation = OPERATION_NONE;
        }
        function addElement(descriptor) {
            _objects.push(descriptor.shift());
        }
        function getCurrentObjects() {
            return(_objects);
        }
        function set debug(value) {
            _debug = value;
            //return(__get__debug());
        }
        function set shell(value) {
            _shell = value;
            //return(__get__shell());
        }
        function set operation(value) {
            _operation = value;
            //return(operation);
        }
        function get operation() {
            return(_operation);
        }
        static var LOCALIZE_START_TAG = "localize(\"";
        static var LOCALIZE_END_TAG = "\")";
        static var OPERATION_OR = "or";
        static var OPERATION_AND = "and";
        static var OPERATION_NONE = "none";
    }
