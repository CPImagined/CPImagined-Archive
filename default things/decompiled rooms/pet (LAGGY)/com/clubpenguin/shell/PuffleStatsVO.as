//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleStatsVO
    {
        function PuffleStatsVO (_arg_4, _arg_3, _arg_5, _arg_2) {
            foodStat = _arg_4;
            playStat = _arg_3;
            restStat = _arg_5;
            cleanStat = _arg_2;
        }
        function getLowestStatType(_arg_4, _arg_5) {
            var _local_3 = new Array();
            if (_arg_4 != null) {
                var _local_2 = 0;
                while (_local_2 < _arg_4.length) {
                    if (((_arg_4[_local_2] == FOOD) && (foodStat != undefined)) && (foodStat <= _arg_5)) {
                        _local_3.push(FOOD);
                    } else if (((_arg_4[_local_2] == PLAY) && (playStat != undefined)) && (playStat <= _arg_5)) {
                        _local_3.push(PLAY);
                    } else if (((_arg_4[_local_2] == REST) && (restStat != undefined)) && (restStat <= _arg_5)) {
                        _local_3.push(REST);
                    } else if (((_arg_4[_local_2] == CLEAN) && (cleanStat != undefined)) && (cleanStat <= _arg_5)) {
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
