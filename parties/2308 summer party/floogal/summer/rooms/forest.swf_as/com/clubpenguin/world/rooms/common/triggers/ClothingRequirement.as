dynamic class com.clubpenguin.world.rooms.common.triggers.ClothingRequirement
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
        var __reg4 = false;
        var __reg2 = 0;
        while (__reg2 < this._clothingID.length) 
        {
            if (player[this._bodyPart] == this._clothingID[__reg2]) 
            {
                return true;
            }
            else if (player[this._bodyPart] > 10000 && player[this._bodyPart] - 1000 == this._clothingID[__reg2]) 
            {
                return true;
            }
            ++__reg2;
        }
        return false;
    }

}
