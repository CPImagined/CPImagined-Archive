class com.clubpenguin.world.rooms2012.common.triggers.ClothingRequirement
{
    var _bodyPart, _clothingID;
    function ClothingRequirement(bodyPart, clothingID)
    {
        _bodyPart = bodyPart;
        _clothingID = clothingID;
    } // End of the function
    function isWornBy(player)
    {
        if (player[_bodyPart] == _clothingID)
        {
            return (true);
        }
        else if (player[_bodyPart] > 10000 && player[_bodyPart] - 1000 == _clothingID)
        {
            return (true);
        } // end else if
        return (false);
    } // End of the function
} // End of Class
