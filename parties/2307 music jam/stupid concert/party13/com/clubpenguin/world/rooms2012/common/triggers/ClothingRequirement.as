dynamic class com.clubpenguin.world.rooms2012.common.triggers.ClothingRequirement
{
    var _bodyPart;
    var _clothingID;

    function ClothingRequirement(bodyPart, clothingID)
    {
        this._bodyPart = bodyPart;
        this._clothingID = clothingID;
    }

    function isWornBy(player)
    {
        if (player[this._bodyPart] == this._clothingID) 
        {
            return true;
        }
        else if (player[this._bodyPart] > 10000 && player[this._bodyPart] - 1000 == this._clothingID) 
        {
            return true;
        }
        return false;
    }

}
