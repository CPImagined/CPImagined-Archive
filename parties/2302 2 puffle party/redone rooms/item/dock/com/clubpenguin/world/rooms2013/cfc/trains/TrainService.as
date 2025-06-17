//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.TrainService
    {
        var _msgThrottler, trainsUpdated, trainRemoved, _shell, _engine, _airtower, _airtowerActionDelegate;
        function TrainService () {
            _msgThrottler = new com.clubpenguin.util.EventThrottler();
            _msgThrottler.delayBetweenEvents = 500;
            _msgThrottler.maxQueueSize = 4;
            trainsUpdated = new org.osflash.signals.Signal(Array);
            trainRemoved = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2013.cfc.trains.TrainVO);
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _airtower = _global.getCurrentAirtower();
            _airtowerActionDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveCommand);
            addAirtowerListeners();
        }
        function addAirtowerListeners() {
            _airtower.addListener(SERVER_COMMAND, _airtowerActionDelegate);
        }
        function removeAirtowerListeners() {
            _airtower.removeListener(SERVER_COMMAND, _airtowerActionDelegate);
        }
        function destroy() {
            trainsUpdated.removeAll();
            trainRemoved.removeAll();
            removeAirtowerListeners();
        }
        function sendOpenTrain() {
            logCommand("Send: open");
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND, [SERVER_COMMAND_OPEN], "str", _shell.getCurrentServerRoomId());
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("dance", "train_engine");
        }
        function sendCloseTrain() {
            logCommand("Send: close");
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND, [SERVER_COMMAND_CLOSE], "str", _shell.getCurrentServerRoomId());
        }
        function sendJoinTrain(driverId) {
            logCommand("Send: join", driverId);
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND, [SERVER_COMMAND_JOIN, driverId], "str", _shell.getCurrentServerRoomId());
        }
        function sendLeaveTrain(driverId) {
            logCommand("Send: leave", driverId);
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND, [SERVER_COMMAND_LEAVE, driverId], "str", _shell.getCurrentServerRoomId());
        }
        function sendDisbandTrain() {
            logCommand("Send: disband", "none");
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND, [SERVER_COMMAND_DISBAND], "str", _shell.getCurrentServerRoomId());
        }
        function sendTrainJoinRoom(room, x, y, disbandTrain) {
            logCommand("Send: joinroom", [room, x, y, disbandTrain]);
            var _local_5 = _shell.getRoomCrumbsByName(room).room_id;
            if (disbandTrain == undefined) {
                disbandTrain = false;
            }
            if (x == undefined) {
                x = 0;
            }
            if (y == undefined) {
                y = 0;
            }
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND, [SERVER_COMMAND_JOIN_ROOM, _local_5, x, y, (disbandTrain ? 1 : 0)], "str", _shell.getCurrentServerRoomId());
        }
        function onReceiveCommand(data) {
            var _local_3 = String(data[1]);
            var _local_6 = data.slice(2);
            trace("HSF onReceiveCommand: " + data);
            if (_local_3 == SERVER_COMMAND_ERROR) {
                logCommand("Server Error: " + _local_6[0], data);
            } else {
                logCommand(("Received Action Type '" + _local_3) + "'", data);
            }
            try {
                if (_local_3 == SERVER_COMMAND_UPDATE) {
                    var _local_8 = _local_6[0];
                    var _local_7 = com.clubpenguin.util.JSONParser.parse(_local_8);
                    trainsUpdated.dispatch([com.clubpenguin.world.rooms2013.cfc.trains.TrainVO.fromObject(_local_7)]);
                } else if (_local_3 == SERVER_COMMAND_LIST) {
                    var _local_8 = _local_6[0];
                    var _local_7 = com.clubpenguin.util.JSONParser.parse(_local_8);
                    var _local_2 = new Array();
                    for (var _local_5 in _local_7) {
                        _local_2.push(com.clubpenguin.world.rooms2013.cfc.trains.TrainVO.fromObject(_local_7[_local_5]));
                    }
                    trainsUpdated.dispatch(_local_2);
                } else if (_local_3 == SERVER_COMMAND_REMOVE) {
                    var _local_8 = _local_6[0];
                    var _local_7 = com.clubpenguin.util.JSONParser.parse(_local_8);
                    var _local_9 = com.clubpenguin.world.rooms2013.cfc.trains.TrainVO.fromObject(_local_7);
                    trainRemoved.dispatch(_local_9);
                } else {
                    logCommand(("Error: Invalid Action Type '" + _local_3) + "'", data);
                }
            } catch(e) {
                logCommand(("Error: Failed to process action '" + _local_3) + "' : ", data);
                var _local_10;
                _local_10 = ((((((((("Exception:\nname= " + e.name) + newline) + "message= ") + e.message) + newline) + "at= ") + e.at) + newline) + "text= ") + e.text;
                logCommand(_local_10, "none");
                throw e;
            }
        }
        function logCommand(msg, data) {
            var _local_1 = com.clubpenguin.util.JSONParser.stringify(data);
            com.clubpenguin.world.rooms2013.cfc.CFCParty.logTrainMessage((("[TrainService] " + msg) + " : DATA=") + _local_1);
            com.clubpenguin.util.Log.info((("[TrainService] " + msg) + " : DATA=") + _local_1, com.clubpenguin.util.Log.PARTY);
        }
        static var SERVER_HANDLER = "christmas";
        static var SERVER_COMMAND = "christmastrain";
        static var SERVER_COMMAND_ERROR = "error";
        static var SERVER_COMMAND_REMOVE = "remove";
        static var SERVER_COMMAND_UPDATE = "update";
        static var SERVER_COMMAND_LIST = "list";
        static var SERVER_COMMAND_JOIN = "join";
        static var SERVER_COMMAND_LEAVE = "leave";
        static var SERVER_COMMAND_DISBAND = "disband";
        static var SERVER_COMMAND_OPEN = "open";
        static var SERVER_COMMAND_CLOSE = "close";
        static var SERVER_COMMAND_JOIN_ROOM = "joinroom";
    }
