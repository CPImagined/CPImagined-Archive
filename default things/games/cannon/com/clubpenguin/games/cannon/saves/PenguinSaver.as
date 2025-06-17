//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.saves.PenguinSaver
    {
        function PenguinSaver () {
        }
        function savePlayer(_arg_3) {
            trace("[PenguinSaver] savePlayer function is running");
            var _local_9 = _arg_3.dataSet;
            var _local_10 = _arg_3.saveData;
            var _local_1;
            var _local_2;
            var _local_6 = 1;
            while (_local_6 < 37) {
                _local_1 = Number(_arg_3[("level" + _local_6) + "playerPuffleOs"]);
                if ((((!isNaN(_local_1)) && (_local_1 != undefined)) && (_local_1 != null)) && (_local_1 >= 0)) {
                    _local_1 = Math.round(_local_1);
                    _local_9.setInt16(_local_1, _local_6 - 1);
                    trace((((("DataSet: index:" + (_local_6 - 1)) + " level") + _local_6) + "playerPuffleOs:") + _arg_3[("level" + _local_6) + "playerPuffleOs"]);
                } else {
                    trace((("[ERROR] @ PenguinSaver#savePlayer playerPuffleOs for level:" + _local_6) + " was num:") + _local_1);
                }
                _local_6++;
            }
            var _local_5 = 1;
            while (_local_5 < 37) {
                _local_1 = Number(_arg_3[("level" + _local_5) + "bestTime"]);
                if ((((!isNaN(_local_1)) && (_local_1 != undefined)) && (_local_1 != null)) && (_local_1 >= 0)) {
                    _local_1 = Math.round(_local_1);
                    _local_9.setInt16(_local_1, _local_5 + 35);
                    trace((((("DataSet: index:" + (_local_5 + 35)) + " level") + _local_5) + "bestTime:") + _arg_3[("level" + _local_5) + "bestTime"]);
                } else {
                    trace((("[ERROR] @ PenguinSaver#savePlayer bestTime for level:" + _local_5) + " was num:") + _local_1);
                }
                _local_5++;
            }
            var _local_8 = 0;
            while (_local_8 < 16) {
                _local_2 = Boolean(_arg_3[("level" + (_local_8 + 1)) + "turboDone"]);
                if ((_local_2 == true) || (_local_2 == false)) {
                    _local_9.setBool(_local_2, _local_8, 72);
                    trace((("DataSet: index:72 boolIndex:" + _local_8) + " turboDone:") + _arg_3[("level" + (_local_8 + 1)) + "turboDone"]);
                } else {
                    trace((("[ERROR] @ PenguinSaver#savePlayer turboDone for level:" + (_local_8 + 1)) + " was bool:") + _local_2);
                }
                _local_8++;
            }
            var _local_7 = 0;
            while (_local_7 < 16) {
                _local_2 = Boolean(_arg_3[("level" + (_local_7 + 17)) + "turboDone"]);
                if ((_local_2 == true) || (_local_2 == false)) {
                    _local_9.setBool(_local_2, _local_7, 73);
                    trace((("DataSet: index:73 boolIndex:" + _local_7) + " turboDone:") + _arg_3[("level" + (_local_7 + 17)) + "turboDone"]);
                } else {
                    trace((("[ERROR] @ PenguinSaver#savePlayer turboDone for level:" + (_local_7 + 17)) + " was bool:") + _local_2);
                }
                _local_7++;
            }
            var _local_4 = 0;
            while (_local_4 < 4) {
                _local_2 = Boolean(_arg_3[("level" + (_local_4 + 33)) + "turboDone"]);
                if ((_local_2 == true) || (_local_2 == false)) {
                    _local_9.setBool(_local_2, _local_4, 74);
                    trace((("DataSet: index:74 boolIndex:" + _local_4) + " turboDone:") + _arg_3[("level" + (_local_4 + 33)) + "turboDone"]);
                } else {
                    trace((("[ERROR] @ PenguinSaver#savePlayer turboDone for level:" + (_local_4 + 33)) + " was bool:") + _local_2);
                }
                _local_9.setBool(Boolean(_arg_3[("level" + (_local_4 + 33)) + "turboDone"]), _local_4, 74);
                _local_4++;
            }
            trace("[PenguinSaver] saveData.setGameData(dataSet)");
            _local_10.setGameData(_local_9);
        }
    }
