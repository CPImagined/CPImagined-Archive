//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.RoomBattlesService
    {
        var _activeBattlesPlayerMap, _numActiveBattles, _msgThrottler, _sendOpenBattleDelegate, _sendJoinBattleDelegate, _sendAttackSelectionDelegate, battleOpened, battleStarted, battleEnded, battleAborted, _shell, _engine, _airtower, _airtowerActionDelegate, _airtowerOpenDelegate, _airtowerCancelDelegate, _airtowerJoinDelegate, _airtowerResultDelegate, _airtowerCloseDelegate, _airtowerListDelegate, _airtowerInGameListDelegate;
        function RoomBattlesService () {
            com.clubpenguin.util.Log.debug("RoomBattlesService init");
            _activeBattlesPlayerMap = {};
            _numActiveBattles = 0;
            _msgThrottler = new com.clubpenguin.util.EventThrottler();
            _msgThrottler.delayBetweenEvents = 500;
            _msgThrottler.maxQueueSize = 4;
            _sendOpenBattleDelegate = com.clubpenguin.util.Delegate.create(this, delayedSendOpenBattle);
            _sendJoinBattleDelegate = com.clubpenguin.util.Delegate.create(this, delayedSendJoinBattle, [-1]);
            _sendAttackSelectionDelegate = com.clubpenguin.util.Delegate.create(this, delayedSendAttackSelection, [-1]);
            battleOpened = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO);
            battleStarted = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO, Number);
            battleEnded = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO, com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO);
            battleAborted = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO);
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _airtower = _global.getCurrentAirtower();
            _airtowerActionDelegate = com.clubpenguin.util.Delegate.create(this, onActionReceived);
            addAirtowerListeners();
        }
        function addAirtowerListeners() {
            com.clubpenguin.util.Log.debug("Add listeners");
            _airtowerOpenDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveOpenCommand);
            _airtowerCancelDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveCloseCommand);
            _airtowerJoinDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveJoinCommand);
            _airtowerResultDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveResultCommand);
            _airtowerCloseDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveCloseCommand);
            _airtowerListDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveListCommand);
            _airtowerInGameListDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveInGameListCommand);
            _airtower.addListener(SERVER_COMMAND_OPEN, _airtowerOpenDelegate);
            _airtower.addListener(SERVER_COMMAND_JOIN, _airtowerJoinDelegate);
            _airtower.addListener(SERVER_COMMAND_CANCEL, _airtowerCancelDelegate);
            _airtower.addListener(SERVER_COMMAND_RESULT, _airtowerResultDelegate);
            _airtower.addListener(SERVER_COMMAND_CLOSE, _airtowerCloseDelegate);
            _airtower.addListener(SERVER_COMMAND_LIST, _airtowerListDelegate);
            _airtower.addListener(SERVER_COMMAND_INGAME_LIST, _airtowerInGameListDelegate);
        }
        function removeAirtowerListeners() {
            _airtower.removeListener(SERVER_COMMAND_OPEN, _airtowerOpenDelegate);
            _airtower.removeListener(SERVER_COMMAND_JOIN, _airtowerJoinDelegate);
            _airtower.removeListener(SERVER_COMMAND_CANCEL, _airtowerCancelDelegate);
            _airtower.removeListener(SERVER_COMMAND_RESULT, _airtowerResultDelegate);
            _airtower.removeListener(SERVER_COMMAND_CLOSE, _airtowerCloseDelegate);
            _airtower.removeListener(SERVER_COMMAND_LIST, _airtowerListDelegate);
            _airtower.removeListener(SERVER_COMMAND_INGAME_LIST, _airtowerInGameListDelegate);
        }
        function destroy() {
            battleOpened.removeAll();
            battleStarted.removeAll();
            battleEnded.removeAll();
            battleAborted.removeAll();
            removeAirtowerListeners();
        }
        function isPlayerInBattle(playerId) {
            if (playerId == null) {
                return(false);
            }
            return((_activeBattlesPlayerMap[playerId] != null) && (_activeBattlesPlayerMap[playerId].state != com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.REMOVED));
        }
        function isPlayerInOpenBattle(playerId) {
            if (playerId == null) {
                return(false);
            }
            return((_activeBattlesPlayerMap[playerId] != null) && (_activeBattlesPlayerMap[playerId].state == com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.OPEN));
        }
        function get numActiveBattles() {
            return(_numActiveBattles);
        }
        function getOpenBattles() {
            var _local_3 = [];
            for (var _local_4 in _activeBattlesPlayerMap) {
                var _local_2 = _activeBattlesPlayerMap[_local_4];
                if (_local_2.state == com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.OPEN) {
                    _local_3.push(_local_2);
                }
            }
            return(_local_3);
        }
        function getBattleForPlayer(playerId) {
            return(_activeBattlesPlayerMap[playerId]);
        }
        function getStateForString(stateString) {
            switch (stateString) {
                case BATTLE_STATE_OPEN_STRING : 
                    return(BATTLE_STATE_OPEN);
                case BATTLE_STATE_START_STRING : 
                    return(BATTLE_STATE_START);
                case BATTLE_STATE_RESULT_STRING : 
                    return(BATTLE_STATE_RESULT);
                case BATTLE_STATE_ABORT_STRING : 
                    return(BATTLE_STATE_ABORT);
            }
            return(BATTLE_STATE_ABORT);
        }
        function sendOpenBattle() {
            _msgThrottler.queueFunction(_sendOpenBattleDelegate);
        }
        function delayedSendOpenBattle() {
            var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
            if (_local_2.isLoading) {
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (ACTION_SERVER_HANDLER + "#") + SERVER_COMMAND_OPEN, [0], "str", _shell.getCurrentServerRoomId());
        }
        function onReceiveOpenCommand(data) {
            logCommand("onReceiveOpenCommand ", data);
            var _local_3 = getStateForString(BATTLE_STATE_OPEN_STRING);
            var _local_2 = data.slice(1);
            processBattleAction(_local_3, _local_2);
        }
        function processBattleOpen(creatorId) {
            logCommand(("RoomBattlesService.processBattleOpen(" + creatorId) + ")");
            addOpenedBattle(creatorId);
        }
        function addOpenedBattle(creatorId) {
            logCommand(("RoomBattlesService.addOpenedBattle(" + creatorId) + ")");
            var _local_2 = new com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO(creatorId, null, com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.OPEN);
            var _local_3 = addBattle(_local_2);
            if (_local_3) {
                battleOpened.dispatch(_local_2);
            }
            return(_local_3);
        }
        function sendJoinBattle(creatorId) {
            logCommand("sendJoinBattle " + creatorId);
            _sendJoinBattleDelegate.initArgs[0] = creatorId;
            _msgThrottler.queueFunction(_sendJoinBattleDelegate);
        }
        function delayedSendJoinBattle(creatorId) {
            logCommand("delayedSendJoinBattle " + creatorId);
            _airtower.send(_airtower.PLAY_EXT, (ACTION_SERVER_HANDLER + "#") + SERVER_COMMAND_JOIN, [creatorId], "str", _shell.getCurrentServerRoomId());
        }
        function onReceiveJoinCommand(data) {
            logCommand("onReceiveJoinCommand " + data);
            var _local_3 = getStateForString(BATTLE_STATE_START_STRING);
            var _local_2 = data.slice(1);
            processBattleAction(_local_3, _local_2);
        }
        function sendAttackSelection(attackId, duelId) {
            _sendAttackSelectionDelegate.initArgs[0] = attackId;
            _sendAttackSelectionDelegate.initArgs[1] = duelId;
            _msgThrottler.queueFunction(_sendAttackSelectionDelegate);
        }
        function delayedSendAttackSelection(attackId, duelId) {
            _airtower.send(_airtower.PLAY_EXT, (ACTION_SERVER_HANDLER + "#") + SERVER_COMMAND_SELECT, [attackId, duelId], "str", _shell.getCurrentServerRoomId());
        }
        function onReceiveResultCommand(data) {
            logCommand("onReceiveResultCommand " + data);
            var _local_3 = getStateForString(BATTLE_STATE_RESULT_STRING);
            var _local_2 = data.slice(1);
            processBattleAction(_local_3, _local_2);
        }
        function abortMyBattle() {
            var _local_2 = getBattleForPlayer(_shell.getMyPlayerId());
            if (_local_2 != null) {
                processBattleAbort(_local_2.creatorId, _local_2.challengerId);
            }
            _msgThrottler.clearQueue();
        }
        function onReceiveCloseCommand(data) {
            logCommand("onReceiveResultCommand " + data);
            var _local_3 = getStateForString(BATTLE_STATE_ABORT_STRING);
            var _local_2 = data.slice(1);
            processBattleAction(_local_3, _local_2);
        }
        function onReceiveListCommand(data) {
            logCommand("MiniGameInvitation List", data);
            var _local_6 = data[1];
            var _local_4 = _local_6.split("|");
            var _local_7 = new Array();
            logCommand("MiniGameInvitation List invitations ", _local_4);
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                if (_local_4[_local_2] == "") {
                } else {
                    var _local_5 = getStateForString(BATTLE_STATE_OPEN_STRING);
                    var _local_3 = new Array(_local_4[_local_2]);
                    logCommand("args ", _local_3);
                    processBattleAction(_local_5, _local_3);
                }
                _local_2++;
            }
        }
        function onReceiveInGameListCommand(data) {
            logCommand("MiniGameInvitation In-game List", data);
            var _local_6 = data[1];
            var _local_3 = _local_6.split("|");
            var _local_7 = new Array();
            logCommand("MiniGameInvitation List invitations ", _local_3);
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                if (_local_3[_local_2] == "") {
                } else {
                    var _local_5 = getStateForString(BATTLE_STATE_START_STRING);
                    var _local_4 = _local_3[_local_2].split(",");
                    processBattleAction(_local_5, _local_4);
                }
                _local_2++;
            }
        }
        function processBattleAction(state, args) {
            com.clubpenguin.util.Log.debug(((("RoomBattlesService.processBattleAction(" + state) + ", [") + args) + "])");
            var _local_3;
            var _local_4;
            var _local_11;
            var _local_17;
            var _local_10;
            var _local_8;
            var _local_15;
            var _local_16;
            var _local_12;
            var _local_13;
            switch (state) {
                case BATTLE_STATE_OPEN : 
                    _local_3 = Number(args[0]);
                    com.clubpenguin.util.Log.debug("creatorId " + _local_3);
                    processBattleOpen(_local_3);
                    break;
                case BATTLE_STATE_START : 
                    _local_3 = Number(args[0]);
                    _local_4 = Number(args[1]);
                    _local_15 = Number(args[2]);
                    _local_16 = Number(args[3]);
                    processBattleStart(_local_3, _local_4, _local_15, _local_16);
                    break;
                case BATTLE_STATE_RESULT : 
                    var _local_14 = args[0];
                    var _local_9 = args[1];
                    var _local_6 = _local_14.split(",");
                    var _local_5 = _local_9.split(",");
                    _local_3 = Number(_local_6[0]);
                    _local_10 = Number(_local_6[1]);
                    _local_11 = Number(_local_6[2]);
                    _local_12 = Number(_local_6[3]);
                    _local_4 = Number(_local_5[0]);
                    _local_8 = Number(_local_5[1]);
                    _local_17 = Number(_local_5[2]);
                    _local_13 = Number(_local_5[3]);
                    processBattleResult(_local_3, _local_4, _local_11, _local_10, _local_8, _local_12, _local_13);
                    break;
                case BATTLE_STATE_ABORT : 
                    _local_3 = Number(args[0]);
                    _local_4 = Number(args[1]);
                    processBattleAbort(_local_3, _local_4);
                    break;
                default : 
                    trace(((((("RoomBattlesService.processDuelAction(" + state) + ", ") + args) + ") -> '") + state) + "' is not a valid duel state");
                    break;
            }
        }
        function processBattleStart(creatorId, challengerId, timeoutSeconds, duelId) {
            com.clubpenguin.util.Log.debug(((("RoomBattlesService.processBattleStart(" + creatorId) + ", ") + challengerId) + ")");
            if (isPlayerInBattle(creatorId)) {
                var _local_2 = getBattleForPlayer(creatorId);
                if ((_local_2.challengerId == null) && (!isPlayerInBattle(challengerId))) {
                    _local_2.state = com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.STARTED;
                    _local_2.challengerId = challengerId;
                    _local_2.duelId = duelId;
                    _activeBattlesPlayerMap[_local_2.challengerId] = _local_2;
                    battleStarted.dispatch(_local_2, timeoutSeconds);
                }
            } else {
                addInProgressBattle(creatorId, challengerId, duelId);
            }
        }
        function processBattleResult(creatorId, challengerId, resultForCreator, creatorAttack, challengerAttack, creatorPoints, challengerPoints) {
            if (isPlayerInBattle(creatorId)) {
                var _local_2 = getBattleForPlayer(creatorId);
                if (Number(_local_2.challengerId) == challengerId) {
                    _local_2.state = com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.ENDING;
                    battleEnded.dispatch(_local_2, new com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO(resultForCreator, creatorAttack, challengerAttack, creatorPoints, challengerPoints));
                }
            }
        }
        function processBattleAbort(creatorId, challengerId) {
            if (isPlayerInBattle(creatorId)) {
                var _local_2 = getBattleForPlayer(creatorId);
                if (_local_2 == null) {
                    return(undefined);
                }
                if (_local_2.state != com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.REMOVED) {
                    battleAborted.dispatch(_local_2);
                    removeBattle(_local_2);
                }
            }
        }
        function addInProgressBattle(creatorId, challengerId, duelId) {
            var _local_2 = new com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO(creatorId, challengerId, com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.STARTED, duelId);
            var _local_3 = addBattle(_local_2);
            if (_local_3) {
                battleStarted.dispatch(_local_2);
            }
            return(_local_3);
        }
        function addBattle(battle) {
            if (isPlayerInBattle(battle.creatorId) || (isPlayerInBattle(battle.challengerId))) {
                trace("RoomBattleService.addBattle WARNING: Trying to add player to battle when player is already in a battle.");
                return(false);
            }
            _activeBattlesPlayerMap[battle.creatorId] = battle;
            if (battle.challengerId != null) {
                _activeBattlesPlayerMap[battle.challengerId] = battle;
            }
            _numActiveBattles++;
            return(true);
        }
        function removeBattle(battle) {
            if (battle.state != com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.REMOVED) {
                _activeBattlesPlayerMap[battle.creatorId] = null;
                _activeBattlesPlayerMap[battle.challengerId] = null;
                delete _activeBattlesPlayerMap[battle.creatorId];
                delete _activeBattlesPlayerMap[battle.challengerId];
                battle.state = com.clubpenguin.world.rooms2014.pirate.swordfight.states.BattleStateEnum.REMOVED;
                _numActiveBattles--;
            }
        }
        function onActionReceived(data) {
            trace("RoomBattlesService.onActionReceived " + data);
            var _local_4 = String(data[1]);
            var _local_3 = data.slice(2);
            processBattleAction(getStateForString(_local_4), _local_3);
        }
        function logCommand(msg, data) {
            var _local_1 = com.clubpenguin.util.JSONParser.stringify(data);
            com.clubpenguin.util.Log.debug((((("[RoomBattleService] " + msg) + " : DATA=") + _local_1) + ", ") + com.clubpenguin.util.Log.PARTY);
        }
        static var ACTION_SERVER_HANDLER = "pirate";
        static var ACTION_SERVER_COMMAND = "swordfight";
        static var BATTLE_STATE_OPEN = 0;
        static var BATTLE_STATE_START = 1;
        static var BATTLE_STATE_RESULT = 2;
        static var BATTLE_STATE_ABORT = 3;
        static var BATTLE_STATE_OPEN_STRING = "open";
        static var BATTLE_STATE_START_STRING = "join";
        static var BATTLE_STATE_RESULT_STRING = "select";
        static var BATTLE_STATE_ABORT_STRING = "abort";
        static var SERVER_COMMAND_LIST = "pirateopenlist";
        static var SERVER_COMMAND_INGAME_LIST = "pirateongoingduels";
        static var SERVER_COMMAND_JOIN = "piratejoin";
        static var SERVER_COMMAND_OPEN = "pirateopen";
        static var SERVER_COMMAND_START = "piratestart";
        static var SERVER_COMMAND_SELECT = "pirateselect";
        static var SERVER_COMMAND_RESULT = "pirateresult";
        static var SERVER_COMMAND_CANCEL = "piratecancel";
        static var SERVER_COMMAND_CLOSE = "pirateclose";
        static var ATTACK_HIGH = 0;
        static var ATTACK_MIDDLE = 1;
        static var ATTACK_LOW = 2;
    }
