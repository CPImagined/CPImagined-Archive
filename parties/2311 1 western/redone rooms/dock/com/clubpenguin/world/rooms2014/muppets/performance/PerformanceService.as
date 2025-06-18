//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService
    {
        var _msgThrottler, performanceUpdated, performanceRemoved, _shell, _engine, _airtower, _airtowerOpenDelegate, _airtowerCancelDelegate, _airtowerJoinDelegate, _airtowerCloseDelegate, _airtowerListDelegate;
        function PerformanceService () {
            _msgThrottler = new com.clubpenguin.util.EventThrottler();
            _msgThrottler.delayBetweenEvents = 500;
            _msgThrottler.maxQueueSize = 4;
            performanceUpdated = new org.osflash.signals.Signal(Array);
            performanceRemoved = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO);
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _airtower = _global.getCurrentAirtower();
            addAirtowerListeners();
        }
        function addAirtowerListeners() {
            logCommand("Add listeners");
            _airtowerOpenDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveOpenCommand);
            _airtowerCancelDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveCancelCommand);
            _airtowerJoinDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveJoinCommand);
            _airtowerCloseDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveCloseCommand);
            _airtowerListDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveListCommand);
            _airtower.addListener(SERVER_COMMAND_OPEN, _airtowerOpenDelegate);
            _airtower.addListener(SERVER_COMMAND_JOIN, _airtowerJoinDelegate);
            _airtower.addListener(SERVER_COMMAND_CANCEL, _airtowerCancelDelegate);
            _airtower.addListener(SERVER_COMMAND_CLOSE, _airtowerCloseDelegate);
            _airtower.addListener(SERVER_COMMAND_LIST, _airtowerListDelegate);
        }
        function removeAirtowerListeners() {
            _airtower.removeListener(SERVER_COMMAND_OPEN, _airtowerOpenDelegate);
            _airtower.removeListener(SERVER_COMMAND_JOIN, _airtowerJoinDelegate);
            _airtower.removeListener(SERVER_COMMAND_CANCEL, _airtowerCancelDelegate);
            _airtower.removeListener(SERVER_COMMAND_CLOSE, _airtowerCloseDelegate);
            _airtower.removeListener(SERVER_COMMAND_LIST, _airtowerListDelegate);
        }
        function destroy() {
            performanceUpdated.removeAll();
            performanceRemoved.removeAll();
            removeAirtowerListeners();
        }
        function sendOpenPerformance() {
            logCommand("Send: open");
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND_OPEN, [0], "str", _shell.getCurrentServerRoomId());
        }
        function sendCancelPerformance() {
            logCommand("Send: cancel");
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND_CANCEL, [0], "str", _shell.getCurrentServerRoomId());
        }
        function sendClosePerformance() {
            logCommand("Send: close");
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND_CLOSE, [0], "str", _shell.getCurrentServerRoomId());
        }
        function sendJoinPerformance(hostId) {
            logCommand("Send: join", hostId);
            _airtower.send(_airtower.PLAY_EXT, (SERVER_HANDLER + "#") + SERVER_COMMAND_JOIN, [hostId], "str", _shell.getCurrentServerRoomId());
        }
        function onReceiveOpenCommand(data) {
            logCommand("Updating a performance", data);
            var _local_2 = Number(data[1]);
            var _local_3 = {hostId:_local_2, participant:null, open:true};
            performanceUpdated.dispatch([com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_local_3)]);
        }
        function onReceiveCancelCommand(data) {
            logCommand("Canceling a performance", data);
            var _local_2 = Number(data[1]);
            var _local_3 = {hostId:_local_2, participant:null, open:false};
            performanceRemoved.dispatch(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_local_3));
        }
        function onReceiveJoinCommand(data) {
            logCommand("Updating a performance", data);
            var _local_2 = Number(data[1]);
            var _local_5 = Number(data[2]);
            var _local_3 = {hostId:_local_2, participant:_local_5, open:false};
            performanceUpdated.dispatch([com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_local_3)]);
        }
        function onReceiveCloseCommand(data) {
            logCommand("Closing a performance", data);
            var _local_2 = Number(data[1]);
            var _local_5 = Number(data[2]);
            var _local_3 = {hostId:_local_2, participant:_local_5, open:false};
            performanceRemoved.dispatch(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_local_3));
        }
        function onReceiveListCommand(data) {
            logCommand("Performance List", data);
            var _local_9 = data[1];
            var _local_4 = _local_9.split("|");
            var _local_8 = new Array();
            logCommand("Performance List performances ", _local_4);
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                if (_local_4[_local_2] == "") {
                } else {
                    var _local_3 = {hostId:Number(_local_4[_local_2]), participant:null, open:true};
                    logCommand("Performance List jsonObject ", _local_3);
                    _local_8.push(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_local_3));
                }
                _local_2++;
            }
            performanceUpdated.dispatch(_local_8);
        }
        function logCommand(msg, data) {
            var _local_1 = com.clubpenguin.util.JSONParser.stringify(data);
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.logPerformanceMessage((("[PerformanceService] " + msg) + " : DATA=") + _local_1);
            com.clubpenguin.util.Log.info((("[PerformanceService] " + msg) + " : DATA=") + _local_1, com.clubpenguin.util.Log.PARTY);
        }
        static var SERVER_HANDLER = "muppets";
        static var SERVER_COMMAND_ERROR = "error";
        static var SERVER_COMMAND_LIST = "mperformancelist";
        static var SERVER_COMMAND_JOIN = "mperformancejoin";
        static var SERVER_COMMAND_OPEN = "mperformanceopen";
        static var SERVER_COMMAND_CANCEL = "mperformancecancel";
        static var SERVER_COMMAND_CLOSE = "mperformanceclose";
    }
