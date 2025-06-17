
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.objects.AchievementObjectString extends com.clubpenguin.achievements.objects.AchievementObject
    {
        var __set__shell, _shell, _objects, _debug;
        function AchievementObjectString (descriptor, shell) {
            super(descriptor);
            __set__shell(shell);
            addElement(descriptor);
        }
        function addElement(descriptor) {
            var _local3 = "";
            var _local7 = descriptor[0].indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG);
            if (_local7 != -1) {
                var _local4 = String(descriptor.shift());
                var _local5 = _local4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_END_TAG);
                var _local8;
                _local7 = _local4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG);
                while (_local5 == -1) {
                    _local4 = (_local4 + " ") + String(descriptor.shift());
                    _local5 = _local4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_END_TAG);
                }
                _local8 = _local4.substring(_local7 + com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG.length, _local5);
                if (_local8 != undefined) {
                    _local3 = _shell.getLocalizedString(_local8);
                }
            } else {
                var _local2;
                do {
                    if (_local3.length > 0) {
                        _local3 = _local3 + " ";
                    }
                    _local2 = String(descriptor.shift());
                    if (_local2 == "undefined") {
                        throw new com.clubpenguin.achievements.AchievementException("Unterminated string in AchievementObjectFactory:createObject!");
                    }
                    _local3 = _local3 + _local2;
                } while  (_local2.charAt(_local2.length - 1) != "\"");
                _local3 = _local3.substr(1);
                _local3 = _local3.substr(0, _local3.length - 1);
                _local3 = _local3.toLowerCase();
            }
            _objects.push(_local3);
            debugTrace(("addElement - '" + _local3) + "'");
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
