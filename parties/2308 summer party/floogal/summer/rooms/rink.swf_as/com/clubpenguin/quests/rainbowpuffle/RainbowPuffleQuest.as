dynamic class com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest
{
    static var SERVER_COOKIE_ID: String = "rainbowPuffleQuest";
    var _taskJustCompleted: Boolean = false;
    var _isHotelVisited: Boolean = false;
    var _isCloudForestVisited: Boolean = false;
    static var NONMEMBER_OOPS_CANNON: String = "oops_puffle_rainbow";
    static var NONMEMBER_OOPS_PUFFLE_TASKITEM: String = "oops_puffle_rainbow";
    static var CANNON_LOCKED_MESSAGE: String = "w.hotel.roof.cannonLocked";
    static var PUFFLE_TASK_1_ITEM_ID: Number = 6158;
    static var PUFFLE_TASK_2_ITEM_ID: Number = 4809;
    static var PUFFLE_TASK_3_ITEM_ID: Number = 1560;
    static var PUFFLE_TASK_4_ITEM_ID: Number = 3159;
    static var PUFFLE_BONUS_ITEM_ID: Number = 5220;
    static var UNAVAILABLE: Number = 0;
    static var AVAILABLE: Number = 1;
    static var COLLECTED: Number = 2;
    static var HOTEL_ELEVATOR_UI: String = "w.hotel.elevatorui";
    static var PUFFLE_QUEST_UI: String = "w.hotel.questui";
    static var FIRST_INDEX_PUFFLE_RANGE_1: Number = 750;
    static var FIRST_INDEX_PUFFLE_RANGE_2: Number = 5230;
    static var NUM_PUFFLES_IN_RANGE_1: Number = 10;
    static var NUM_PUFFLES_IN_RANGE_2: Number = 10;
    static var COIN_COLLECTED_RESPONSE_NAME: String = "rpqcc";
    static var ITEM_COLLECTED_RESPONSE_NAME: String = "rpqic";
    static var BONUS_COLLECTED_RESPONSE_NAME: String = "rpqbc";
    static var TIME_TO_ADD_UNTIL_NEXT_TASK: Number = 1200000;
    static var HOTEL_LOBBY_ROOM_ID: Number = 430;
    static var CLOUD_FOREST_ROOM_ID: Number = 433;
    var _airtower;
    var _interface;
    var _opCodeJournal;
    var _rewardThrottler;
    var _serverCookie;
    var _serverCookieService;
    var _shell;
    var _taskBonusCollectedReceivedDelegate;
    var _taskCoinCollectedReceivedDelegate;
    var _taskItemCollectedReceivedDelegate;

    function RainbowPuffleQuest()
    {
    }

    function init()
    {
        this._shell = _global.getCurrentShell();
        this._airtower = _global.getCurrentAirtower();
        this._interface = _global.getCurrentInterface();
        this._serverCookieService = this._shell.getServerCookieService();
        this._serverCookie = new com.clubpenguin.quests.rainbowpuffle.vo.RainbowQuestCookieVO(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.SERVER_COOKIE_ID);
        this._serverCookieService.registerCookieVO(this._serverCookie.getID(), this._serverCookie);
        this._taskCoinCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, this.onTaskCoinCollectedReceived);
        this._taskItemCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, this.onTaskItemCollectedReceived);
        this._taskBonusCollectedReceivedDelegate = com.clubpenguin.util.Delegate.create(this, this.onTaskBonusCollectedReceived);
        this._opCodeJournal = new com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal();
        this._shell.addListener(this._shell.JOIN_ROOM, this.handleJoinRoom, this);
        this._rewardThrottler = new com.clubpenguin.util.EventThrottler();
        this._rewardThrottler.__set__delayBetweenEvents(2000);
    }

    function handleJoinRoom()
    {
        var __reg2 = this._shell.getCurrentRoomId();
        if (__reg2 == com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.HOTEL_LOBBY_ROOM_ID && !this._isHotelVisited) 
        {
            this._opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_ENTERS_HOTEL);
            this._isHotelVisited = true;
            return;
        }
        if (__reg2 == com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.CLOUD_FOREST_ROOM_ID && !this._isCloudForestVisited) 
        {
            this._opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_ENTERS_CLOUD_FOREST);
            this._isCloudForestVisited = true;
        }
    }

    function cannonActivated()
    {
        this._opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_USES_CANNON);
    }

    function get getRainbowQuestCookieVO()
    {
        return this._serverCookie;
    }

    function get currentPuffleQuestTaskIndex()
    {
        if (this._serverCookie == null) 
        {
            return 0;
        }
        return this._serverCookie.__get__currentTaskIndex();
    }

    function set currentPuffleQuestTaskIndex(taskIndex)
    {
        if (this._serverCookie != null) 
        {
            this._serverCookie.__set__currentTaskIndex(taskIndex);
            return;
        }
    }

    function completePuffleQuestTask(taskNumber)
    {
        if (!this.isTaskComplete(taskNumber) && this.__get__currentPuffleQuestTaskIndex() == taskNumber - 1) 
        {
            var __reg7 = com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal["PLAYER_COMPLETES_TASK" + taskNumber];
            this._opCodeJournal.sendOpcode(__reg7);
            if (taskNumber == 4) 
            {
                this._opCodeJournal.sendOpcode(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleOpCodeJournal.PLAYER_COMPLETES_ALL_TASKS);
            }
        }
        this.__set__taskJustCompleted(true);
        this.sendTaskComplete(taskNumber - 1);
        var __reg8 = Math.round((this._shell.getPenguinStandardTime().getTime() + com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.TIME_TO_ADD_UNTIL_NEXT_TASK) / 1000);
        var __reg5 = 0;
        var __reg4 = 0;
        var __reg6 = 0;
        var __reg3 = 0;
        if ((__reg0 = taskNumber) === 1) 
        {
            __reg4 = 5;
        }
        else if (__reg0 === 2) 
        {
            __reg3 = 5;
        }
        else if (__reg0 === 3) 
        {
            __reg5 = 5;
        }
        else if (__reg0 === 4) 
        {
            __reg6 = 5;
        }
        this._shell.sendAddPuffleCarePoints(this._shell.puffleManager.getCurrentWalkingId(), __reg5, __reg4, __reg6, __reg3);
    }

    function isTaskComplete(taskNumber)
    {
        var __reg2 = this._serverCookie.__get__taskCollectables();
        return __reg2[taskNumber - 1].completed;
    }

    function sendTaskComplete(taskIndex)
    {
        this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqtc", [taskIndex], "str", this._shell.getCurrentServerRoomId());
    }

    function updateTime()
    {
        this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqtc", [0], "str", this._shell.getCurrentServerRoomId());
    }

    function getIsCannonAvailable()
    {
        if (this._serverCookie == null) 
        {
            return false;
        }
        return this._serverCookie.__get__isCannonAvailable();
    }

    function set isCannonAvailable(cannonAvailable)
    {
        if (this._serverCookie != null) 
        {
            this._serverCookie.__set__isCannonAvailable(cannonAvailable);
            return;
        }
    }

    function sendTaskCoinCollected(taskIndex)
    {
        this._rewardThrottler.queueFunction(com.clubpenguin.util.Delegate.create(this, function ()
        {
            this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqcc", [taskIndex], "str", this._shell.getCurrentServerRoomId());
            this._airtower.addListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.COIN_COLLECTED_RESPONSE_NAME, this._taskCoinCollectedReceivedDelegate, this);
        }
        ));
    }

    function onTaskCoinCollectedReceived(data)
    {
        var __reg6 = this._serverCookie.__get__taskCollectables();
        var __reg4 = data[1];
        var __reg5 = data[2];
        var __reg2 = data[3];
        __reg6[__reg4].coin = __reg5;
        this.showCoinsCollectedPrompt(__reg2 - this._shell.getMyPlayerTotalCoins(), __reg2);
        if (__reg2 - this._shell.getMyPlayerTotalCoins() <= 0) 
        {
            this.showCoinsCollectedPrompt(150, __reg2);
        }
        else 
        {
            this.showCoinsCollectedPrompt(__reg2 - this._shell.getMyPlayerTotalCoins(), __reg2);
        }
        this._shell.setMyPlayerTotalCoins(__reg2);
        this._airtower.removeListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.COIN_COLLECTED_RESPONSE_NAME, this._taskCoinCollectedReceivedDelegate);
    }

    function sendTaskItemCollected(taskIndex)
    {
        this._rewardThrottler.queueFunction(com.clubpenguin.util.Delegate.create(this, function ()
        {
            this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqic", [taskIndex], "str", this._shell.getCurrentServerRoomId());
            this._airtower.addListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.ITEM_COLLECTED_RESPONSE_NAME, this._taskItemCollectedReceivedDelegate, this);
        }
        ));
    }

    function onTaskItemCollectedReceived(data)
    {
        var __reg4 = this._serverCookie.__get__taskCollectables();
        var __reg3 = data[1];
        var __reg5 = data[2];
        var __reg2 = undefined;
        if ((__reg0 = Number(__reg3)) === 0) 
        {
            __reg2 = com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_TASK_1_ITEM_ID;
        }
        else if (__reg0 === 1) 
        {
            __reg2 = com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_TASK_2_ITEM_ID;
        }
        else if (__reg0 === 2) 
        {
            __reg2 = com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_TASK_3_ITEM_ID;
        }
        else if (__reg0 === 3) 
        {
            __reg2 = com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_TASK_4_ITEM_ID;
        }
        else 
        {
            __reg2 = 0;
        }
        this._airtower.removeListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.ITEM_COLLECTED_RESPONSE_NAME, this._taskItemCollectedReceivedDelegate);
        var __reg7 = this._shell.getInventoryObjectById(__reg2);
        var __reg6 = this._shell.getMyInventoryArray();
        if (__reg2 > 0 && !this._shell.isItemInMyInventory(__reg2) && __reg4[__reg3].item != com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.COLLECTED) 
        {
            __reg6.push(__reg7);
            this.showItemCollectedPrompt(__reg2);
        }
        __reg4[__reg3].item = __reg5;
    }

    function taskCoinsCollected(taskIndex)
    {
        this.sendTaskCoinCollected(taskIndex);
    }

    function taskItemCollected(taskIndex)
    {
        this.sendTaskItemCollected(taskIndex);
    }

    function getStateForPuffleQuestCollectable(taskID, collectableType)
    {
        if (this._serverCookie == null) 
        {
            return 0;
        }
        var __reg2 = this._serverCookie.__get__taskCollectables();
        var __reg5 = __reg2[taskID];
        if (collectableType == "coins") 
        {
            return __reg2[taskID].coin;
        }
        if (collectableType == "item") 
        {
            return __reg2[taskID].item;
        }
        return 0;
    }

    function setStateForPuffleQuestCollectable(taskID, collectableType, state)
    {
        if (this._serverCookie == null) 
        {
            return 0;
        }
        var __reg3 = this._serverCookie.__get__taskCollectables();
        var __reg2 = __reg3[taskID];
        if (collectableType == "coins") 
        {
            __reg2.coin = state;
        }
        else if (collectableType == "item") 
        {
            __reg2.item = state;
        }
        __reg3[taskID] = __reg2;
        this._serverCookie.__set__taskCollectables(__reg3);
    }

    function isNextPuffleQuestTaskAvailable()
    {
        if (this._serverCookie == null || this._serverCookie.__get__hoursRemaining() < 0 || this._serverCookie.__get__hoursRemaining() < 0) 
        {
            return false;
        }
        var __reg2 = this._serverCookie.__get__hoursRemaining() == 0 && this._serverCookie.__get__minutesRemaining() == 0 ? true : false;
        return __reg2;
    }

    function get puffleQuestTaskAvailableDateTime()
    {
        if (this._serverCookie == null) 
        {
            return Math.floor(this._shell.getPenguinStandardTime().getTime() / 1000);
        }
        var __reg2 = undefined;
        __reg2 = this._serverCookie.__get__taskAvailableDateTime() == null || this._serverCookie.__get__taskAvailableDateTime() <= 0 ? Math.round((this._shell.getPenguinStandardTime().getTime() + com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.TIME_TO_ADD_UNTIL_NEXT_TASK) / 1000) : this._serverCookie.__get__taskAvailableDateTime();
        return __reg2;
    }

    function hoursLeftUntilPuffleQuestTaskAvailable()
    {
        if (this.isNextPuffleQuestTaskAvailable()) 
        {
            return 0;
        }
        if (this._serverCookie == null) 
        {
            return 0;
        }
        return this._serverCookie.__get__hoursRemaining();
    }

    function minutesLeftUntilPuffleQuestTaskAvailable()
    {
        if (this.isNextPuffleQuestTaskAvailable()) 
        {
            return 0;
        }
        if (this._serverCookie == null) 
        {
            return 0;
        }
        var __reg2 = this._serverCookie.__get__minutesRemaining();
        __reg2 = __reg2 >= 10 ? __reg2 : "0" + __reg2;
        return __reg2;
    }

    function getNumOfPuffleQuestsCompleted()
    {
        if (this._serverCookie == null) 
        {
            return 0;
        }
        return this._serverCookie.__get__numOfQuestsCompleted();
    }

    function get puffleQuestBonusState()
    {
        if (this._serverCookie == null) 
        {
            return 0;
        }
        return this._serverCookie.__get__questBonus();
    }

    function set puffleQuestBonusState(state)
    {
        if (this._serverCookie != null) 
        {
            this._serverCookie.__set__questBonus(state);
            return;
        }
    }

    function resetPuffleQuest()
    {
    }

    function sendTaskBonusCollected()
    {
        this._rewardThrottler.queueFunction(com.clubpenguin.util.Delegate.create(this, function ()
        {
            this._airtower.send(this._airtower.PLAY_EXT, "rpq#rpqbc", [], "str", this._shell.getCurrentServerRoomId());
            this._airtower.addListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.BONUS_COLLECTED_RESPONSE_NAME, this._taskBonusCollectedReceivedDelegate, this);
        }
        ));
    }

    function onTaskBonusCollectedReceived(data)
    {
        var __reg7 = data[2];
        var __reg3 = com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_BONUS_ITEM_ID;
        this._airtower.removeListener(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.BONUS_COLLECTED_RESPONSE_NAME, this._taskBonusCollectedReceivedDelegate);
        var __reg5 = this._shell.getInventoryObjectById(__reg3);
        var __reg4 = this._shell.getMyInventoryArray();
        if (__reg3 > 0 && !this._shell.isItemInMyInventory(__reg3) && this.__get__puffleQuestBonusState() != com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.COLLECTED) 
        {
            __reg4.push(__reg5);
            this.showItemCollectedPrompt(__reg3);
        }
        var __reg2 = data[3];
        if (__reg2 - this._shell.getMyPlayerTotalCoins() <= 0) 
        {
            this.showCoinsCollectedPrompt(500, __reg2);
        }
        else 
        {
            this.showCoinsCollectedPrompt(__reg2 - this._shell.getMyPlayerTotalCoins(), __reg2);
        }
        this.showCoinsCollectedPrompt(__reg2 - this._shell.getMyPlayerTotalCoins(), __reg2);
        this._shell.setMyPlayerTotalCoins(__reg2);
        this.__set__puffleQuestBonusState(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.COLLECTED);
    }

    function collectPuffleQuestItem()
    {
        this.sendTaskBonusCollected();
    }

    function isPuffleEquipped(player_id)
    {
        var __reg2 = this._shell.getPlayerObjectById(player_id);
        return com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(__reg2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE);
    }

    function get taskJustCompleted()
    {
        return this._taskJustCompleted;
    }

    function set taskJustCompleted(isCompleted)
    {
        this._taskJustCompleted = isCompleted;
    }

    function showItemCollectedPrompt(itemID)
    {
        var __reg4 = this._shell.getInventoryObjectById(itemID);
        var __reg3 = this._shell.getLocalizedString("buy_inventory_done");
        __reg3 = com.clubpenguin.util.StringUtils.replaceString("%name%", __reg4.name, __reg3);
        _global.getCurrentInterface().showPrompt("ok", __reg3);
    }

    function showCoinsCollectedPrompt(numCoins, totalCoins)
    {
        var __reg3 = this._shell.getLocalizedString("game_over2");
        __reg3 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(numCoins), __reg3);
        __reg3 = com.clubpenguin.util.StringUtils.replaceString("%total%", String(totalCoins), __reg3);
        _global.getCurrentInterface().showPrompt("coin", __reg3);
    }

}
