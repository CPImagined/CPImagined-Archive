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
            var _local_3 = new Array();
            if (statTypes != null) {
                var _local_2 = 0;
                while (_local_2 < statTypes.length) {
                    if (((statTypes[_local_2] == FOOD) && (foodStat != undefined)) && (foodStat <= lowStatThreshold)) {
                        _local_3.push(FOOD);
                    } else if (((statTypes[_local_2] == PLAY) && (playStat != undefined)) && (playStat <= lowStatThreshold)) {
                        _local_3.push(PLAY);
                    } else if (((statTypes[_local_2] == REST) && (restStat != undefined)) && (restStat <= lowStatThreshold)) {
                        _local_3.push(REST);
                    } else if (((statTypes[_local_2] == CLEAN) && (cleanStat != undefined)) && (cleanStat <= lowStatThreshold)) {
                        _local_3.push(CLEAN);
                    }
                    _local_2++;
                }
            }
            if (_local_3.length > 1) {
                var _local_6;
                _local_6 = Math.floor(Math.random() * _local_3.length);
                return(_local_3[_local_6]);
            }
            if (_local_3.length == 1) {
                return(_local_3[0]);
            }
            if (_local_3.length == 0) {
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
