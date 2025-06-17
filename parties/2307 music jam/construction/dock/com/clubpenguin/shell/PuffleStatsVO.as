//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleStatsVO
    {
        var _lowStats;
        function PuffleStatsVO (food, play, rest, clean) {
            foodStat = food;
            playStat = play;
            restStat = rest;
            cleanStat = clean;
            populateLowStatsArray();
        }
        function populateLowStatsArray() {
            _lowStats = new Array();
            if (foodStat <= LOW_STAT_NUM) {
                if (foodStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.FOOD_EMOTICON);
            }
            if (playStat <= LOW_STAT_NUM) {
                if (playStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.PLAY_EMOTICON);
            }
            if (restStat <= LOW_STAT_NUM) {
                if (restStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.REST_EMOTICON);
            }
            if (cleanStat <= LOW_STAT_NUM) {
                if (cleanStat == undefined) {
                    return(undefined);
                }
                _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.CLEAN_EMOTICON);
            }
        }
        function getLowestStat() {
            populateLowStatsArray();
            if (_lowStats.length > 1) {
                var _local_2;
                _local_2 = Math.floor(Math.random() * _lowStats.length);
                return(_lowStats[_local_2]);
            } else if (_lowStats.length == 1) {
                return(_lowStats[0]);
            } else if (_lowStats.length == 0) {
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
