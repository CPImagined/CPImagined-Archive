//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.saves.PlayerInitializer implements com.clubpenguin.lib.IDisposable
    {
        var penguin, callback, saveData, dataSet;
        function PlayerInitializer () {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA, handleGetGameData, this);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA, handleGetGameData, this);
        }
        function loadPlayer(_arg_2, _arg_3) {
            penguin = _arg_2;
            callback = _arg_3;
            saveData = _arg_2.saveData;
            trace("[PlayerInitializer] loadPlayer()  about to getGameData()");
            saveData.getGameData();
        }
        function handleGetGameData(_arg_2) {
            trace("[PlayerInitializer] about to create the dataSet");
            dataSet = com.clubpenguin.lib.data.compression.DataSet(_arg_2.data);
            trace("[PlayerInitializer] dataSet was built");
            if (dataSet.numEntries == 0) {
                initializeDataSet();
            } else {
                loadDataSet();
            }
            trace("[PlayerInitializer] dataSet was created");
            penguin.dataSet = dataSet;
            callback();
        }
        function initializeDataSet() {
            trace("[PlayerInitializer] new dataSet");
            var _local_6 = 0;
            while (_local_6 < 36) {
                dataSet.setInt16(0);
                _local_6++;
            }
            var _local_5 = 36;
            while (_local_5 < 72) {
                dataSet.setInt16(600);
                _local_5++;
            }
            var _local_4 = 0;
            while (_local_4 < 16) {
                dataSet.setBool(false, _local_4, 72);
                _local_4++;
            }
            var _local_3 = 0;
            while (_local_3 < 16) {
                dataSet.setBool(false, _local_3, 73);
                _local_3++;
            }
            var _local_2 = 0;
            while (_local_2 < 3) {
                dataSet.setBool(false, _local_2, 74);
                _local_2++;
            }
        }
        function loadDataSet() {
            trace("[PlayerInitializer] loadDataSet");
            var _local_3;
            var _local_2;
            var _local_5 = 1;
            while (_local_5 < 37) {
                _local_3 = dataSet.getInt16(_local_5 - 1);
                if ((_local_3 == null) || (_local_3 < 0)) {
                    _local_3 = 0;
                    dataSet.setData(new com.clubpenguin.lib.data.compression.type.CInt16(_local_3), _local_5 - 1);
                }
                penguin[("level" + _local_5) + "playerPuffleOs"] = _local_3;
                _local_5++;
            }
            var _local_4 = 1;
            while (_local_4 < 37) {
                _local_3 = dataSet.getInt16(_local_4 + 35);
                if ((_local_3 == null) || (_local_3 < 0)) {
                    _local_3 = 600;
                    dataSet.setData(new com.clubpenguin.lib.data.compression.type.CInt16(_local_3), _local_4 + 35);
                }
                penguin[("level" + _local_4) + "bestTime"] = _local_3;
                _local_4++;
            }
            var _local_8 = 0;
            while (_local_8 < 16) {
                _local_2 = dataSet.getBool(72, _local_8);
                if (_local_2 == null) {
                    _local_2 = false;
                    dataSet.setData(new com.clubpenguin.lib.data.compression.type.CBool(0), 72);
                }
                penguin[("level" + (_local_8 + 1)) + "turboDone"] = _local_2;
                _local_8++;
            }
            var _local_6 = 0;
            while (_local_6 < 16) {
                _local_2 = dataSet.getBool(73, _local_6);
                if (_local_2 == null) {
                    _local_2 = false;
                    dataSet.setData(new com.clubpenguin.lib.data.compression.type.CBool(0), 73);
                }
                penguin[("level" + (_local_6 + 17)) + "turboDone"] = _local_2;
                _local_6++;
            }
            var _local_7 = 0;
            while (_local_7 < 4) {
                _local_2 = dataSet.getBool(74, _local_7);
                if (_local_2 == null) {
                    _local_2 = false;
                    dataSet.setData(new com.clubpenguin.lib.data.compression.type.CBool(0), 74);
                }
                penguin[("level" + (_local_7 + 33)) + "turboDone"] = _local_2;
                _local_7++;
            }
        }
        function dispose() {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA, handleGetGameData, this);
            saveData.dispose();
            saveData = null;
            penguin = null;
            dataSet = null;
            callback = null;
        }
    }
