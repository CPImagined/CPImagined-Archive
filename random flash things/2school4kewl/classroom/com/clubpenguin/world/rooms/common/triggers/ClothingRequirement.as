class com.clubpenguin.world.rooms.common.triggers.ClothingRequirement
{
    var _bodyPart, _clothingID;
    function ClothingRequirement(bodyPart, clothingID)
    {
        _bodyPart = bodyPart;
        _clothingID = clothingID;
    } // End of the function
    function isWornBy(player)
    {
        var _loc4 = false;
        for (var _loc2 = 0; _loc2 < _clothingID.length; ++_loc2)
        {
            if (player[_bodyPart] == _clothingID[_loc2])
            {
                return (true);
                continue;
            } // end if
            if (player[_bodyPart] > 10000 && player[_bodyPart] - 1000 == _clothingID[_loc2])
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
} // End of Class
