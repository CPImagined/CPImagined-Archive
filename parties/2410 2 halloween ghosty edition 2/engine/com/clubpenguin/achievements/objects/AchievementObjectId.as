//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.objects.AchievementObjectId extends com.clubpenguin.achievements.objects.AchievementObject
    {
        var _objects, _idTag, _shell;
        function AchievementObjectId (descriptor) {
            super(descriptor);
            _objects.push(descriptor.shift());
            if (typeof(_objects[0]) == "string") {
                _idTag = _objects[0];
            } else {
                _idTag = "";
            }
        }
        function getCurrentObjects() {
            if (_idTag == MY_PENGUIN_COLOUR_TAG) {
                var _local_2 = _shell.getMyPlayerObject();
                if (_local_2.colour_id != undefined) {
                    var _local_3 = Number(_local_2.colour_id);
                    _objects[0] = _local_3;
                }
            }
            return(_objects);
        }
        static var MY_PENGUIN_COLOUR_TAG = "myPenguinColourID";
    }
