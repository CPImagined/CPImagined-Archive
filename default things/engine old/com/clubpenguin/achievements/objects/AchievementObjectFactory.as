
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.objects.AchievementObjectFactory
    {
        var _debug, _shell, __get__debug, __get__shell;
        function AchievementObjectFactory (debug) {
            _debug = debug;
        }
        function createObject(descriptor) {
            var _local2 = 0;
            while (_local2 < descriptor.length) {
                descriptor[_local2] = descriptor[_local2].split(XML_QUOTATION).join("\"");
                _local2++;
            }
            debugTrace("createObject - " + descriptor.join(" "));
            if (descriptor[0] == "myIgloo") {
                var _local4 = new com.clubpenguin.achievements.objects.AchievementObject(descriptor);
                _local4.addElement(descriptor);
                return(_local4);
            }
            if ((descriptor[0].charAt(0) == "\"") || (descriptor[0].indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG) != -1)) {
                return(new com.clubpenguin.achievements.objects.AchievementObjectString(descriptor, _shell));
            }
            return(new com.clubpenguin.achievements.objects.AchievementObjectId([String(descriptor.shift())]));
        }
        function set debug(state) {
            _debug = state;
            //return(__get__debug());
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        function set shell(s) {
            _shell = s;
            //return(__get__shell());
        }
        static var XML_QUOTATION = "&quot;";
    }
