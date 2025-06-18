//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleStatsVO
    {
        function PuffleStatsVO (food, play, rest, clean) {
            foodStat = food;
            playStat = play;
            restStat = rest;
            cleanStat = clean;
        }
        function getLowestStatType(statTypes, lowStatThreshold) {
            var lowStats = new Array();
            if (statTypes != null) {
                var i = 0;
                while (i < statTypes.length) {
                    if (((statTypes[i] == FOOD) && (foodStat != undefined)) && (foodStat <= lowStatThreshold)) {
                        lowStats.push(FOOD);
                    } else if (((statTypes[i] == PLAY) && (playStat != undefined)) && (playStat <= lowStatThreshold)) {
                        lowStats.push(PLAY);
                    } else if (((statTypes[i] == REST) && (restStat != undefined)) && (restStat <= lowStatThreshold)) {
                        lowStats.push(REST);
                    } else if (((statTypes[i] == CLEAN) && (cleanStat != undefined)) && (cleanStat <= lowStatThreshold)) {
                        lowStats.push(CLEAN);
                    }
                    i++;
                }
            }
            if (lowStats.length > 1) {
                var randNum;
                randNum = Math.floor(Math.random() * lowStats.length);
                return(lowStats[randNum]);
            } else if (lowStats.length == 1) {
                return(lowStats[0]);
            } else if (lowStats.length == 0) {
                return(null);
            }
        }
        static var FOOD = "food";
        static var PLAY = "play";
        static var REST = "rest";
        static var CLEAN = "clean";
        var foodStat = -1;
        var playStat = -1;
        var restStat = -1;
        var cleanStat = -1;
    }
