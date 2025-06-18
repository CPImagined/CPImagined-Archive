//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.triggers.ClothingRequirement
    {
        var _bodyPart, _clothingID;
        function ClothingRequirement (bodyPart, clothingID) {
            _bodyPart = bodyPart;
            _clothingID = clothingID;
        }
        function isWornBy(player) {
            var _local_4 = false;
            var _local_2 = 0;
            while (_local_2 < _clothingID.length) {
                if (player[_bodyPart] == _clothingID[_local_2]) {
                    return(true);
                } else if ((player[_bodyPart] > 10000) && ((player[_bodyPart] - 1000) == _clothingID[_local_2])) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
    }
