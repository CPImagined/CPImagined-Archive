//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.SaveData implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.lib.IDisposable
    {
        var uid, roomId, AIRTOWER;
        function SaveData () {
            uid = ++uids;
            roomId = _global.getCurrentShell().getCurrentServerRoomId();
            AIRTOWER = _global.getCurrentAirtower();
            AIRTOWER.removeListener(MESSAGE_GET_GAME_DATA, handleGetGameData, this);
            AIRTOWER.removeListener(MESSAGE_SET_GAME_DATA, handleSetGameData, this);
            AIRTOWER.addListener(MESSAGE_GET_GAME_DATA, handleGetGameData, this);
            AIRTOWER.addListener(MESSAGE_SET_GAME_DATA, handleSetGameData, this);
        }
        function getGameData(_arg_3) {
            trace("GET GAME DATA in SaveData.as index of: " + _arg_3);
            var _local_2 = new Array();
            if (_arg_3 != undefined) {
                _local_2.push(_arg_3.toString());
            }
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_GET_GAME_DATA, _local_2, SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function setGameData(_arg_5, _arg_3) {
            trace("SET GAME DATA in SaveData.as index of: " + _arg_3);
            var _local_2 = new Array();
            if (_arg_3 != undefined) {
                _local_2.push(_arg_3.toString());
            }
            var _local_4 = com.clubpenguin.lib.data.compression.Compressor.compress(_arg_5);
            _local_2.push(_local_4);
            AIRTOWER.send(SERVER_SIDE_EXTENSION_NAME, MESSAGE_SET_GAME_DATA, _local_2, SERVER_SIDE_MESSAGE_TYPE, roomId);
        }
        function handleGetGameData(_arg_4) {
            var _local_3 = String(_arg_4[1]);
            var _local_2 = com.clubpenguin.lib.data.compression.Compressor.decompress(_local_3);
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.data.event.SaveDataEvent(this, com.clubpenguin.lib.data.event.SaveDataEvent.EVENT_GET_GAME_DATA, _local_2, _local_2, _local_3));
        }
        function handleSetGameData(resonseArray) {
        }
        function getUniqueName() {
            return(("[SaveGameData" + uid) + "]");
        }
        function dispose() {
            AIRTOWER.removeListener(MESSAGE_GET_GAME_DATA, handleGetGameData, this);
            AIRTOWER.removeListener(MESSAGE_SET_GAME_DATA, handleSetGameData, this);
            AIRTOWER = null;
        }
        static var SERVER_SIDE_EXTENSION_NAME = "z";
        static var SERVER_SIDE_MESSAGE_TYPE = "str";
        static var MESSAGE_GET_GAME_DATA = "ggd";
        static var MESSAGE_SET_GAME_DATA = "sgd";
        static var uids = -1;
    }
