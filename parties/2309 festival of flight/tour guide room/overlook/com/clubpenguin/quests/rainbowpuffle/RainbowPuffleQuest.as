//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest
    {
        var _shell, _airtower, _interface, _serverCookieService, _serverCookie, _taskCoinCollectedReceivedDelegate, _taskItemCollectedReceivedDelegate, _taskBonusCollectedReceivedDelegate, _opCodeJournal, _rewardThrottler, __get__isCannonAvailable;
        function RainbowPuffleQuest () {
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _serverCookieService = _shell.getServerCookieService();
            _serverCookie = new com.clubpenguin.quests.rainbowpuffle.vo.RainbowQuestCookieVO(SERVER_COOKIE_ID);
            _serverCookieService.registerCookieVO(_serverCookie.getID(), _serverCookie);
            _taskCoinCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, onTaskCoinCollectedReceived);
            _taskItemCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, onTaskItemCollectedReceived);
            _taskBonusCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, onTaskBonusCollectedReceived);
            _opCodeJournal = new com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal();
            _shell.addListener(_shell.JOIN_ROOM, handleJoinRoom, this);
            _rewardThrottler = new com.clubpenguin.util.EventThrottler();
            _rewardThrottler.delayBetweenEvents = 2000;
        }
        function handleJoinRoom() {
            var _local_2 = _shell.getCurrentRoomId();
            if ((_local_2 == HOTEL_LOBBY_ROOM_ID) && (!_isHotelVisited)) {
                _opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_ENTERS_HOTEL);
                _isHotelVisited = true;
            } else if ((_local_2 == CLOUD_FOREST_ROOM_ID) && (!_isCloudForestVisited)) {
                _opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_ENTERS_CLOUD_FOREST);
                _isCloudForestVisited = true;
            }
        }
        function cannonActivated() {
            _opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_USES_CANNON);
        }
        function get getRainbowQuestCookieVO() {
            return(_serverCookie);
        }
        function get currentPuffleQuestTaskIndex() {
            if (_serverCookie == null) {
                return(0);
            }
            return(_serverCookie.currentTaskIndex);
        }
        function set currentPuffleQuestTaskIndex(taskIndex) {
            if (_serverCookie == null) {
                return;
            }
            _serverCookie.currentTaskIndex = taskIndex;
            //return(currentPuffleQuestTaskIndex);
        }
        function completePuffleQuestTask(taskNumber) {
            if ((!isTaskComplete(taskNumber)) && (currentPuffleQuestTaskIndex == (taskNumber - 1))) {
                var _local_7 = com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal["PLAYER_COMPLETES_TASK" + taskNumber];
                _opCodeJournal.sendOpcode(_local_7);
                if (taskNumber == 4) {
                    _opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_COMPLETES_ALL_TASKS);
                }
            }
            taskJustCompleted = (true);
            sendTaskComplete(taskNumber - 1);
            var _local_8 = Math.round((_shell.getPenguinStandardTime().getTime() + TIME_TO_ADD_UNTIL_NEXT_TASK) / 1000);
            var _local_5 = 0;
            var _local_4 = 0;
            var _local_6 = 0;
            var _local_3 = 0;
            switch (taskNumber) {
                case 1 : 
                    _local_4 = 5;
                    break;
                case 2 : 
                    _local_3 = 5;
                    break;
                case 3 : 
                    _local_5 = 5;
                    break;
                case 4 : 
                    _local_6 = 5;
                    break;
            }
            _shell.sendAddPuffleCarePoints(_shell.puffleManager.getCurrentWalkingId(), _local_5, _local_4, _local_6, _local_3);
        }
        function isTaskComplete(taskNumber) {
            var _local_2 = _serverCookie.taskCollectables;
            return(_local_2[taskNumber - 1].completed);
        }
        function sendTaskComplete(taskIndex) {
            _airtower.send(_airtower.PLAY_EXT, "rpq#rpqtc", [taskIndex], "str", _shell.getCurrentServerRoomId());
        }
        function updateTime() {
            _airtower.send(_airtower.PLAY_EXT, "rpq#rpqtc", [0], "str", _shell.getCurrentServerRoomId());
        }
        function getIsCannonAvailable() {
            if (_serverCookie == null) {
                return(false);
            }
            return(_serverCookie.isCannonAvailable);
        }
        function set isCannonAvailable(cannonAvailable) {
            if (_serverCookie == null) {
                return;
            }
            _serverCookie.isCannonAvailable = cannonAvailable;
            //return(__get__isCannonAvailable());
        }
        function sendTaskCoinCollected(taskIndex) {
            _rewardThrottler.queueFunction(com.clubpenguin.util.Delegate.create(this, function () {
                this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqcc", [taskIndex], "str", this._shell.getCurrentServerRoomId());
                this._airtower.addListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.COIN_COLLECTED_RESPONSE_NAME, this._taskCoinCollectedReceivedDelegate, this);
            }));
        }
        function onTaskCoinCollectedReceived(data) {
            var _local_6 = _serverCookie.taskCollectables;
            var _local_4 = data[1];
            var _local_5 = data[2];
            var _local_2 = data[3];
            _local_6[_local_4].coin = _local_5;
            showCoinsCollectedPrompt(_local_2 - _shell.getMyPlayerTotalCoins(), _local_2);
            if ((_local_2 - _shell.getMyPlayerTotalCoins()) <= 0) {
                showCoinsCollectedPrompt(150, _local_2);
            } else {
                showCoinsCollectedPrompt(_local_2 - _shell.getMyPlayerTotalCoins(), _local_2);
            }
            _shell.setMyPlayerTotalCoins(_local_2);
            _airtower.removeListener(COIN_COLLECTED_RESPONSE_NAME, _taskCoinCollectedReceivedDelegate);
        }
        function sendTaskItemCollected(taskIndex) {
            _rewardThrottler.queueFunction(com.clubpenguin.util.Delegate.create(this, function () {
                this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqic", [taskIndex], "str", this._shell.getCurrentServerRoomId());
                this._airtower.addListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.ITEM_COLLECTED_RESPONSE_NAME, this._taskItemCollectedReceivedDelegate, this);
            }));
        }
        function onTaskItemCollectedReceived(data) {
            var _local_4 = _serverCookie.taskCollectables;
            var _local_3 = data[1];
            var _local_5 = data[2];
            var _local_2;
            switch (Number(_local_3)) {
                case 0 : 
                    _local_2 = PUFFLE_TASK_1_ITEM_ID;
                    break;
                case 1 : 
                    _local_2 = PUFFLE_TASK_2_ITEM_ID;
                    break;
                case 2 : 
                    _local_2 = PUFFLE_TASK_3_ITEM_ID;
                    break;
                case 3 : 
                    _local_2 = PUFFLE_TASK_4_ITEM_ID;
                    break;
                default : 
                    _local_2 = 0;
                    break;
            }
            _airtower.removeListener(ITEM_COLLECTED_RESPONSE_NAME, _taskItemCollectedReceivedDelegate);
            var _local_7 = _shell.getInventoryObjectById(_local_2);
            var _local_6 = _shell.getMyInventoryArray();
            if (((_local_2 > 0) && (!_shell.isItemInMyInventory(_local_2))) && (_local_4[_local_3].item != COLLECTED)) {
                _local_6.push(_local_7);
                showItemCollectedPrompt(_local_2);
            }
            _local_4[_local_3].item = _local_5;
        }
        function taskCoinsCollected(taskIndex) {
            sendTaskCoinCollected(taskIndex);
        }
        function taskItemCollected(taskIndex) {
            sendTaskItemCollected(taskIndex);
        }
        function getStateForPuffleQuestCollectable(taskID, collectableType) {
            if (_serverCookie == null) {
                return(0);
            }
            var _local_2 = _serverCookie.taskCollectables;
            var _local_5 = _local_2[taskID];
            if (collectableType == "coins") {
                return(_local_2[taskID].coin);
            } else if (collectableType == "item") {
                return(_local_2[taskID].item);
            } else {
                return(0);
            }
        }
        function setStateForPuffleQuestCollectable(taskID, collectableType, state) {
            if (_serverCookie == null) {
                return(0);
            }
            var _local_3 = _serverCookie.taskCollectables;
            var _local_2 = _local_3[taskID];
            if (collectableType == "coins") {
                _local_2.coin = state;
            } else if (collectableType == "item") {
                _local_2.item = state;
            }
            _local_3[taskID] = _local_2;
            _serverCookie.taskCollectables = _local_3;
        }
        function isNextPuffleQuestTaskAvailable() {
            if (((_serverCookie == null) || (_serverCookie.hoursRemaining < 0)) || (_serverCookie.hoursRemaining < 0)) {
                return(false);
            }
            var _local_2 = (((_serverCookie.hoursRemaining == 0) && (_serverCookie.minutesRemaining == 0)) ? true : false);
            return(_local_2);
        }
        function get puffleQuestTaskAvailableDateTime() {
            if (_serverCookie == null) {
                return(Math.floor(_shell.getPenguinStandardTime().getTime() / 1000));
            }
            var _local_2;
            _local_2 = (((_serverCookie.taskAvailableDateTime == null) || (_serverCookie.taskAvailableDateTime <= 0)) ? (Math.round((_shell.getPenguinStandardTime().getTime() + TIME_TO_ADD_UNTIL_NEXT_TASK) / 1000)) : (_serverCookie.taskAvailableDateTime));
            return(_local_2);
        }
        function hoursLeftUntilPuffleQuestTaskAvailable() {
            if (isNextPuffleQuestTaskAvailable()) {
                return(0);
            }
            if (_serverCookie == null) {
                return(0);
            }
            return(_serverCookie.hoursRemaining);
        }
        function minutesLeftUntilPuffleQuestTaskAvailable() {
            if (isNextPuffleQuestTaskAvailable()) {
                return(0);
            }
            if (_serverCookie == null) {
                return(0);
            }
            var _local_2 = _serverCookie.minutesRemaining;
            _local_2 = ((_local_2 < 10) ? ("0" + _local_2) : (_local_2));
            return(_local_2);
        }
        function getNumOfPuffleQuestsCompleted() {
            if (_serverCookie == null) {
                return(0);
            }
            return(_serverCookie.numOfQuestsCompleted);
        }
        function get puffleQuestBonusState() {
            if (_serverCookie == null) {
                return(0);
            }
            return(_serverCookie.questBonus);
        }
        function set puffleQuestBonusState(state) {
            if (_serverCookie == null) {
                return;
            }
            _serverCookie.questBonus = state;
            //return(puffleQuestBonusState);
        }
        function resetPuffleQuest() {
        }
        function sendTaskBonusCollected() {
            _rewardThrottler.queueFunction(com.clubpenguin.util.Delegate.create(this, function () {
                this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqbc", [], "str", this._shell.getCurrentServerRoomId());
                this._airtower.addListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.BONUS_COLLECTED_RESPONSE_NAME, this._taskBonusCollectedReceivedDelegate, this);
            }));
        }
        function onTaskBonusCollectedReceived(data) {
            var _local_7 = data[2];
            var _local_3 = PUFFLE_BONUS_ITEM_ID;
            _airtower.removeListener(BONUS_COLLECTED_RESPONSE_NAME, _taskBonusCollectedReceivedDelegate);
            var _local_5 = _shell.getInventoryObjectById(_local_3);
            var _local_4 = _shell.getMyInventoryArray();
            if (((_local_3 > 0) && (!_shell.isItemInMyInventory(_local_3))) && (puffleQuestBonusState != COLLECTED)) {
                _local_4.push(_local_5);
                showItemCollectedPrompt(_local_3);
            }
            var _local_2 = data[3];
            if ((_local_2 - _shell.getMyPlayerTotalCoins()) <= 0) {
                showCoinsCollectedPrompt(500, _local_2);
            } else {
                showCoinsCollectedPrompt(_local_2 - _shell.getMyPlayerTotalCoins(), _local_2);
            }
            showCoinsCollectedPrompt(_local_2 - _shell.getMyPlayerTotalCoins(), _local_2);
            _shell.setMyPlayerTotalCoins(_local_2);
            puffleQuestBonusState = (COLLECTED);
        }
        function collectPuffleQuestItem() {
            sendTaskBonusCollected();
        }
        function isPuffleEquipped(player_id) {
            var _local_2 = _shell.getPlayerObjectById(player_id);
            return(com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE));
        }
        function get taskJustCompleted() {
            return(_taskJustCompleted);
        }
        function set taskJustCompleted(isCompleted) {
            _taskJustCompleted = isCompleted;
            //return(taskJustCompleted);
        }
        function showItemCollectedPrompt(itemID) {
            var _local_4 = _shell.getInventoryObjectById(itemID);
            var _local_3 = _shell.getLocalizedString("buy_inventory_done");
            _local_3 = com.clubpenguin.util.StringUtils.replaceString("%name%", _local_4.name, _local_3);
            _global.getCurrentInterface().showPrompt("ok", _local_3);
        }
        function showCoinsCollectedPrompt(numCoins, totalCoins) {
            var _local_3 = _shell.getLocalizedString("game_over2");
            _local_3 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(numCoins), _local_3);
            _local_3 = com.clubpenguin.util.StringUtils.replaceString("%total%", String(totalCoins), _local_3);
            _global.getCurrentInterface().showPrompt("coin", _local_3);
        }
        static var SERVER_COOKIE_ID = "rainbowPuffleQuest";
        var _taskJustCompleted = false;
        var _isHotelVisited = false;
        var _isCloudForestVisited = false;
        static var NONMEMBER_OOPS_CANNON = "oops_puffle_rainbow";
        static var NONMEMBER_OOPS_PUFFLE_TASKITEM = "oops_puffle_rainbow";
        static var CANNON_LOCKED_MESSAGE = "w.hotel.roof.cannonLocked";
        static var PUFFLE_TASK_1_ITEM_ID = 6158;
        static var PUFFLE_TASK_2_ITEM_ID = 4809;
        static var PUFFLE_TASK_3_ITEM_ID = 1560;
        static var PUFFLE_TASK_4_ITEM_ID = 3159;
        static var PUFFLE_BONUS_ITEM_ID = 5220;
        static var UNAVAILABLE = 0;
        static var AVAILABLE = 1;
        static var COLLECTED = 2;
        static var HOTEL_ELEVATOR_UI = "w.hotel.elevatorui";
        static var PUFFLE_QUEST_UI = "w.hotel.questui";
        static var FIRST_INDEX_PUFFLE_RANGE_1 = 750;
        static var FIRST_INDEX_PUFFLE_RANGE_2 = 5230;
        static var NUM_PUFFLES_IN_RANGE_1 = 10;
        static var NUM_PUFFLES_IN_RANGE_2 = 10;
        static var COIN_COLLECTED_RESPONSE_NAME = "rpqcc";
        static var ITEM_COLLECTED_RESPONSE_NAME = "rpqic";
        static var BONUS_COLLECTED_RESPONSE_NAME = "rpqbc";
        static var TIME_TO_ADD_UNTIL_NEXT_TASK = 1200000;
        static var HOTEL_LOBBY_ROOM_ID = 430;
        static var CLOUD_FOREST_ROOM_ID = 433;
    }
