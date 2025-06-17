//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.RoomBattlesService
    {
        var _activeBattlesPlayerMap, _numActiveBattles, _msgThrottler, _sendOpenBattleDelegate, _sendJoinBattleDelegate, _sendAttackSelectionDelegate, battleOpened, battleStarted, battleEnded, battleAborted, _shell, _engine, _airtower, _airtowerActionDelegate;
        function RoomBattlesService () {
            _activeBattlesPlayerMap = {};
            _numActiveBattles = 0;
            _msgThrottler = new com.clubpenguin.util.EventThrottler();
            _msgThrottler.delayBetweenEvents = 500;
            _msgThrottler.maxQueueSize = 4;
            _sendOpenBattleDelegate = com.clubpenguin.util.Delegate.create(this, delayedSendOpenBattle);
            _sendJoinBattleDelegate = com.clubpenguin.util.Delegate.create(this, delayedSendJoinBattle, [-1]);
            _sendAttackSelectionDelegate = com.clubpenguin.util.Delegate.create(this, delayedSendAttackSelection, [-1]);
            battleOpened = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2013.starwars.battle.BattleVO);
            battleStarted = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2013.starwars.battle.BattleVO, Number);
            battleEnded = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2013.starwars.battle.BattleVO, com.clubpenguin.world.rooms2013.starwars.battle.BattleResultVO);
            battleAborted = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2013.starwars.battle.BattleVO);
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _airtower = _global.getCurrentAirtower();
            _airtowerActionDelegate = com.clubpenguin.util.Delegate.create(this, onActionReceived);
            addAirtowerListeners();
        }
        function addAirtowerListeners() {
            _airtower.addListener(ACTION_SERVER_COMMAND, _airtowerActionDelegate);
        }
        function removeAirtowerListeners() {
            _airtower.removeListener(ACTION_SERVER_COMMAND, _airtowerActionDelegate);
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
            return((_activeBattlesPlayerMap[playerId] != null) && (_activeBattlesPlayerMap[playerId].state != com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_REMOVED));
        }
        function isPlayerInOpenBattle(playerId) {
            if (playerId == null) {
                return(false);
            }
            return((_activeBattlesPlayerMap[playerId] != null) && (_activeBattlesPlayerMap[playerId].state == com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_OPENED));
        }
        function get numActiveBattles() {
            return(_numActiveBattles);
        }
        function getOpenBattles() {
            var _local_3 = [];
            for (var _local_4 in _activeBattlesPlayerMap) {
                var _local_2 = _activeBattlesPlayerMap[_local_4];
                if (_local_2.state == com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_OPENED) {
                    _local_3.push(_local_2);
                }
            }
            return(_local_3);
        }
        function sendOpenBattle() {
            _msgThrottler.queueFunction(_sendOpenBattleDelegate);
        }
        function delayedSendOpenBattle() {
            var _local_2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
            if (_local_2.isLoading) {
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (ACTION_SERVER_HANDLER + "#") + ACTION_SERVER_COMMAND, [BATTLE_STATE_OPEN_STRING], "str", _shell.getCurrentServerRoomId());
        }
        function sendJoinBattle(creatorId) {
            _sendJoinBattleDelegate.initArgs[0] = creatorId;
            _msgThrottler.queueFunction(_sendJoinBattleDelegate);
        }
        function delayedSendJoinBattle(creatorId) {
            _airtower.send(_airtower.PLAY_EXT, (ACTION_SERVER_HANDLER + "#") + ACTION_SERVER_COMMAND, [BATTLE_STATE_START_STRING, creatorId], "str", _shell.getCurrentServerRoomId());
        }
        function sendAttackSelection(attackId) {
            _sendAttackSelectionDelegate.initArgs[0] = attackId;
            _msgThrottler.queueFunction(_sendAttackSelectionDelegate);
        }
        function delayedSendAttackSelection(attackId) {
            _airtower.send(_airtower.PLAY_EXT, (ACTION_SERVER_HANDLER + "#") + ACTION_SERVER_COMMAND, [BATTLE_STATE_RESULT_STRING, attackId], "str", _shell.getCurrentServerRoomId());
        }
        function abortMyBattle() {
            var _local_2 = getBattleForPlayer(_shell.getMyPlayerId());
            if (_local_2 != null) {
                processBattleAbort(_local_2.creatorId, _local_2.challengerId);
            }
            _msgThrottler.clearQueue();
        }
        function addOpenedBattle(creatorId) {
            var _local_2 = new com.clubpenguin.world.rooms2013.starwars.battle.BattleVO(creatorId, null, com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_OPENED);
            var _local_3 = addBattle(_local_2);
            if (_local_3) {
                battleOpened.dispatch(_local_2);
            }
            return(_local_3);
        }
        function addInProgressBattle(creatorId, challengerId) {
            var _local_2 = new com.clubpenguin.world.rooms2013.starwars.battle.BattleVO(creatorId, challengerId, com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_BATTLING);
            var _local_3 = addBattle(_local_2);
            if (_local_3) {
                battleStarted.dispatch(_local_2);
            }
            return(_local_3);
        }
        function addBattle(battle) {
            if (isPlayerInBattle(battle.creatorId) || (isPlayerInBattle(battle.challengerId))) {
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
            if (battle.state != com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_REMOVED) {
                _activeBattlesPlayerMap[battle.creatorId] = null;
                _activeBattlesPlayerMap[battle.challengerId] = null;
                delete _activeBattlesPlayerMap[battle.creatorId];
                delete _activeBattlesPlayerMap[battle.challengerId];
                battle.state = com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_REMOVED;
                _numActiveBattles--;
            }
        }
        function getBattleForPlayer(playerId) {
            return(_activeBattlesPlayerMap[playerId]);
        }
        function onActionReceived(data) {
            var _local_4 = String(data[1]);
            var _local_3 = data.slice(2);
            processBattleAction(getStateForString(_local_4), _local_3);
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
        function processBattleAction(state, args) {
            var _local_3;
            var _local_4;
            var _local_8;
            var _local_12;
            var _local_7;
            var _local_6;
            var _local_11;
            var _local_9;
            var _local_10;
            switch (state) {
                case BATTLE_STATE_OPEN : 
                    _local_3 = Number(args[0]);
                    processBattleOpen(_local_3);
                    break;
                case BATTLE_STATE_START : 
                    _local_3 = Number(args[0]);
                    _local_4 = Number(args[1]);
                    _local_11 = Number(args[2]);
                    processBattleStart(_local_3, _local_4, _local_11);
                    break;
                case BATTLE_STATE_RESULT : 
                    _local_3 = Number(args[0]);
                    _local_7 = Number(args[1]);
                    _local_8 = Number(args[2]);
                    _local_9 = Number(args[3]);
                    _local_4 = Number(args[4]);
                    _local_6 = Number(args[5]);
                    _local_12 = Number(args[6]);
                    _local_10 = Number(args[7]);
                    processBattleResult(_local_3, _local_4, _local_8, _local_7, _local_6, _local_9, _local_10);
                    break;
                case BATTLE_STATE_ABORT : 
                    _local_3 = Number(args[0]);
                    _local_4 = Number(args[1]);
                    processBattleAbort(_local_3, _local_4);
                    break;
                default : 
                    break;
            }
        }
        function processBattleOpen(creatorId) {
            addOpenedBattle(creatorId);
        }
        function processBattleStart(creatorId, challengerId, timeoutSeconds) {
            if (isPlayerInBattle(creatorId)) {
                var _local_2 = getBattleForPlayer(creatorId);
                if ((_local_2.challengerId == null) && (!isPlayerInBattle(challengerId))) {
                    _local_2.state = com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_BATTLING;
                    _local_2.challengerId = challengerId;
                    _activeBattlesPlayerMap[_local_2.challengerId] = _local_2;
                    battleStarted.dispatch(_local_2, timeoutSeconds);
                }
            } else {
                addInProgressBattle(creatorId, challengerId);
            }
        }
        function processBattleResult(creatorId, challengerId, resultForCreator, creatorAttack, challengerAttack, creatorPoints, challengerPoints) {
            if (isPlayerInBattle(creatorId)) {
                var _local_2 = getBattleForPlayer(creatorId);
                if (_local_2.challengerId == challengerId) {
                    _local_2.state = com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_ENDING;
                    battleEnded.dispatch(_local_2, new com.clubpenguin.world.rooms2013.starwars.battle.BattleResultVO(resultForCreator, creatorAttack, challengerAttack, creatorPoints, challengerPoints));
                }
            }
        }
        function processBattleAbort(creatorId, challengerId) {
            if (isPlayerInBattle(creatorId)) {
                var _local_2 = getBattleForPlayer(creatorId);
                if (_local_2 == null) {
                    return(undefined);
                }
                if (_local_2.state != com.clubpenguin.world.rooms2013.starwars.battle.BattleVO.STATE_REMOVED) {
                    battleAborted.dispatch(_local_2);
                    removeBattle(_local_2);
                }
            }
        }
        static var ACTION_SERVER_HANDLER = "stwr";
        static var ACTION_SERVER_COMMAND = "swlb";
        static var BATTLE_STATE_OPEN = 0;
        static var BATTLE_STATE_START = 1;
        static var BATTLE_STATE_RESULT = 2;
        static var BATTLE_STATE_ABORT = 3;
        static var BATTLE_STATE_OPEN_STRING = "open";
        static var BATTLE_STATE_START_STRING = "join";
        static var BATTLE_STATE_RESULT_STRING = "select";
        static var BATTLE_STATE_ABORT_STRING = "abort";
        static var ATTACK_HIGH = 0;
        static var ATTACK_MIDDLE = 1;
        static var ATTACK_LOW = 2;
    }
