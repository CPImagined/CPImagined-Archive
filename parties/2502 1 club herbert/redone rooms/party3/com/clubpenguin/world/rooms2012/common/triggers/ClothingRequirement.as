//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.triggers.ClothingRequirement
    {
        var _bodyPart, _clothingID;
        function ClothingRequirement (bodyPart, clothingID) {
            _bodyPart = bodyPart;
            _clothingID = clothingID;
        }
        function isWornBy(player) {
            if (player[_bodyPart] == _clothingID) {
                return(true);
            } else if ((player[_bodyPart] > 10000) && ((player[_bodyPart] - 1000) == _clothingID)) {
                return(true);
            }
            return(false);
        }
    }
