class com.clubpenguin.world.rooms.common.skateboard.SkateboardConstants
{
    function SkateboardConstants()
    {
    } // End of the function
    static function isSkateboard(itemID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms.common.skateboard.SkateboardConstants.SKATEBOARD_IDS.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms.common.skateboard.SkateboardConstants.SKATEBOARD_IDS[_loc1] == itemID)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function getSkateboardFrame(frameNum)
    {
        var _loc1 = frameNum;
        switch (frameNum)
        {
            case 1:
            case 16:
            {
                _loc1 = 2;
                break;
            } 
            case 2:
            case 9:
            {
                _loc1 = 3;
                break;
            } 
            case 3:
            case 10:
            {
                _loc1 = 4;
                break;
            } 
            case 4:
            case 11:
            {
                _loc1 = 5;
                break;
            } 
            case 5:
            case 12:
            {
                _loc1 = 6;
                break;
            } 
            case 6:
            case 13:
            {
                _loc1 = 7;
                break;
            } 
            case 7:
            case 14:
            {
                _loc1 = 8;
                break;
            } 
            case 8:
            case 15:
            {
                _loc1 = 1;
                break;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
    static var SKATEBOARD_IDS = [5472, 5473, 5474, 5471, 5479];
} // End of Class
