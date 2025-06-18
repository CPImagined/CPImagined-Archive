//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleStatsVO
    {
        var _lowStats;
        function PuffleStatsVO (food, play, rest, clean) {
            trace((((((("com.clubpenguin.shell.PuffleStatsVO ---> Creating new PuffleStatsVO : " + food) + " ") + play) + " ") + rest) + " ") + clean);
            foodStat = food;
            playStat = play;
            restStat = rest;
            cleanStat = clean;
            populateLowStatsArray();
        }
        function populateLowStatsArray() {
            _lowStats = new Array();
            trace("populateLowStatsArray() Food is  " + foodStat);
            if (foodStat <= LOW_STAT_NUM) {
                trace("food is less");
                if (foodStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.FOOD_EMOTICON);
            }
            trace("populateLowStatsArray() Play is  " + playStat);
            if (playStat <= LOW_STAT_NUM) {
                trace("play is less");
                if (playStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.PLAY_EMOTICON);
            }
            trace("populateLowStatsArray() Rest is  " + restStat);
            if (restStat <= LOW_STAT_NUM) {
                trace("rest is less");
                if (restStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.REST_EMOTICON);
            }
            trace("populateLowStatsArray() Clean is  " + cleanStat);
            if (cleanStat <= LOW_STAT_NUM) {
                trace("clean is less");
                if (cleanStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.CLEAN_EMOTICON);
            }
        }
        function getLowestStat() {
            populateLowStatsArray();
            if (_lowStats.length > 1) {
                trace("getLowestStat() LENGTH IS GREATER THAN 1");
                var _local_2;
                _local_2 = Math.floor(Math.random() * _lowStats.length);
                return(_lowStats[_local_2]);
            } else if (_lowStats.length == 1) {
                trace("getLowestStat() LENGTH IS GREATER THAN 1");
                return(_lowStats[0]);
            } else if (_lowStats.length == 0) {
                trace("LOW STATS LENGTH IS 0");
                return(com.clubpenguin.engine.PuffleEmoticonLocEnum.NO_EMOTE);
            }
        }
        static var LOW_STAT_NUM = 20;
        static var NO_STATS_LOW = "none";
        var foodStat = -1;
        var playStat = -1;
        var restStat = -1;
        var cleanStat = -1;
    }
