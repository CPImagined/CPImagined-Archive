dynamic class com.clubpenguin.shell.PuffleStatsVO
{
    static var FOOD: String = "food";
    static var PLAY: String = "play";
    static var REST: String = "rest";
    static var CLEAN: String = "clean";
    var foodStat: Number = -1;
    var playStat: Number = -1;
    var restStat: Number = -1;
    var cleanStat: Number = -1;

    function PuffleStatsVO(food, play, rest, clean)
    {
        this.foodStat = food;
        this.playStat = play;
        this.restStat = rest;
        this.cleanStat = clean;
    }

    function getLowestStatType(statTypes, lowStatThreshold)
    {
        var __reg3 = new Array();
        if (statTypes != null) 
        {
            var __reg2 = 0;
            while (__reg2 < statTypes.length) 
            {
                if (statTypes[__reg2] == com.clubpenguin.shell.PuffleStatsVO.FOOD && this.foodStat != undefined && this.foodStat <= lowStatThreshold) 
                {
                    __reg3.push(com.clubpenguin.shell.PuffleStatsVO.FOOD);
                }
                else if (statTypes[__reg2] == com.clubpenguin.shell.PuffleStatsVO.PLAY && this.playStat != undefined && this.playStat <= lowStatThreshold) 
                {
                    __reg3.push(com.clubpenguin.shell.PuffleStatsVO.PLAY);
                }
                else if (statTypes[__reg2] == com.clubpenguin.shell.PuffleStatsVO.REST && this.restStat != undefined && this.restStat <= lowStatThreshold) 
                {
                    __reg3.push(com.clubpenguin.shell.PuffleStatsVO.REST);
                }
                else if (statTypes[__reg2] == com.clubpenguin.shell.PuffleStatsVO.CLEAN && this.cleanStat != undefined && this.cleanStat <= lowStatThreshold) 
                {
                    __reg3.push(com.clubpenguin.shell.PuffleStatsVO.CLEAN);
                }
                ++__reg2;
            }
        }
        if (__reg3.length > 1) 
        {
            var __reg6 = undefined;
            __reg6 = Math.floor(Math.random() * __reg3.length);
            return __reg3[__reg6];
        }
        if (__reg3.length == 1) 
        {
            return __reg3[0];
        }
        if (__reg3.length == 0) 
        {
            return null;
        }
    }

}
