class com.clubpenguin.shell.PuffleStatsVO
{
    function PuffleStatsVO(food, play, rest, clean)
    {
        foodStat = food;
        playStat = play;
        restStat = rest;
        cleanStat = clean;
    } // End of the function
    function getLowestStatType(statTypes, lowStatThreshold)
    {
        var _loc3 = new Array();
        if (statTypes != null)
        {
            for (var _loc2 = 0; _loc2 < statTypes.length; ++_loc2)
            {
                if (statTypes[_loc2] == com.clubpenguin.shell.PuffleStatsVO.FOOD && foodStat != undefined && foodStat <= lowStatThreshold)
                {
                    _loc3.push(com.clubpenguin.shell.PuffleStatsVO.FOOD);
                    continue;
                } // end if
                if (statTypes[_loc2] == com.clubpenguin.shell.PuffleStatsVO.PLAY && playStat != undefined && playStat <= lowStatThreshold)
                {
                    _loc3.push(com.clubpenguin.shell.PuffleStatsVO.PLAY);
                    continue;
                } // end if
                if (statTypes[_loc2] == com.clubpenguin.shell.PuffleStatsVO.REST && restStat != undefined && restStat <= lowStatThreshold)
                {
                    _loc3.push(com.clubpenguin.shell.PuffleStatsVO.REST);
                    continue;
                } // end if
                if (statTypes[_loc2] == com.clubpenguin.shell.PuffleStatsVO.CLEAN && cleanStat != undefined && cleanStat <= lowStatThreshold)
                {
                    _loc3.push(com.clubpenguin.shell.PuffleStatsVO.CLEAN);
                } // end if
            } // end of for
        } // end if
        if (_loc3.length > 1)
        {
            var _loc6;
            _loc6 = Math.floor(Math.random() * _loc3.length);
            return (_loc3[_loc6]);
        }
        else if (_loc3.length == 1)
        {
            return (_loc3[0]);
        }
        else if (_loc3.length == 0)
        {
            return (null);
        } // end else if
    } // End of the function
    static var FOOD = "food";
    static var PLAY = "play";
    static var REST = "rest";
    static var CLEAN = "clean";
    var foodStat = -1;
    var playStat = -1;
    var restStat = -1;
    var cleanStat = -1;
} // End of Class
