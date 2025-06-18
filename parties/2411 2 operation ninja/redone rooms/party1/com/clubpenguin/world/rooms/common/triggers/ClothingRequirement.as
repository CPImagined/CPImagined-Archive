    class com.clubpenguin.world.rooms.common.triggers.ClothingRequirement
    {
        var _bodyPart, _clothingID;
        function ClothingRequirement (bodyPart, clothingID) {
            _bodyPart = bodyPart;
            _clothingID = clothingID;
        }
        function isWornBy(player) {
            if (player[_bodyPart] == _clothingID) {
                return(true);
            }
            if ((player[_bodyPart] > 10000) && ((player[_bodyPart] - 1000) == _clothingID)) {
                return(true);
            }
            return(false);
        }
    }
