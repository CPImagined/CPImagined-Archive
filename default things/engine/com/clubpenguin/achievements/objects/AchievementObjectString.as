//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.objects.AchievementObjectString extends com.clubpenguin.achievements.objects.AchievementObject
    {
        var __set__shell, _shell, _objects, _debug;
        function AchievementObjectString (descriptor, shell) {
            super(descriptor);
            __set__shell(shell);
            addElement(descriptor);
        }
        function addElement(descriptor) {
            var _local_3 = "";
            var _local_7 = descriptor[0].indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG);
            if (_local_7 != -1) {
                var _local_4 = String(descriptor.shift());
                var _local_5 = _local_4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_END_TAG);
                var _local_8;
                _local_7 = _local_4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG);
                while (_local_5 == -1) {
                    _local_4 = (_local_4 + " ") + String(descriptor.shift());
                    _local_5 = _local_4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_END_TAG);
                }
                _local_8 = _local_4.substring(_local_7 + com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG.length, _local_5);
                if (_local_8 != undefined) {
                    _local_3 = _shell.getLocalizedString(_local_8);
                }
            } else {
                var _local_2;
                do {
                    if (_local_3.length > 0) {
                        _local_3 = _local_3 + " ";
                    }
                    _local_2 = String(descriptor.shift());
                    if (_local_2 == "undefined") {
                        throw new com.clubpenguin.achievements.AchievementException("Unterminated string in AchievementObjectFactory:createObject!");
                    }
                    _local_3 = _local_3 + _local_2;
                } while  (_local_2.charAt(_local_2.length - 1) != "\"");
                _local_3 = _local_3.substr(1);
                _local_3 = _local_3.substr(0, _local_3.length - 1);
                _local_3 = _local_3.toLowerCase();
            }
            _objects.push(_local_3);
            debugTrace(("addElement - '" + _local_3) + "'");
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
