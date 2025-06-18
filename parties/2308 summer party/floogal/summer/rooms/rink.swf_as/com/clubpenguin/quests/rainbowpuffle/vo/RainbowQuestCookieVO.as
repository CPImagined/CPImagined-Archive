dynamic class com.clubpenguin.quests.rainbowpuffle.vo.RainbowQuestCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
    static var TIME_TO_ADD_UNTIL_NEXT_TASK: Number = 64800000;
    var _jsonObject;
    var currentTaskIndexChanged;
    var hoursRemainingChanged;
    var isCannonAvailableChanged;
    var minutesRemainingChanged;
    var numOfQuestsCompletedChanged;
    var questBonusChanged;
    var taskAvailableDateTimeChanged;
    var taskCollectablesChanged;

    function RainbowQuestCookieVO(cookieId)
    {
        super(cookieId);
        this.currentTaskIndexChanged = new org.osflash.signals.Signal(Number);
        this.taskAvailableDateTimeChanged = new org.osflash.signals.Signal(Number);
        this.questBonusChanged = new org.osflash.signals.Signal(Number);
        this.isCannonAvailableChanged = new org.osflash.signals.Signal(Boolean);
        this.numOfQuestsCompletedChanged = new org.osflash.signals.Signal(Number);
        this.taskCollectablesChanged = new org.osflash.signals.Signal(Array);
        this.hoursRemainingChanged = new org.osflash.signals.Signal(Number);
        this.minutesRemainingChanged = new org.osflash.signals.Signal(Number);
    }

    function getCookieHandlerName()
    {
        return "rpq";
    }

    function getSendCommandName()
    {
        return "NO_SEND_CMD_AVAILABLE";
    }

    function getReceiveCommandName()
    {
        return "rpqd";
    }

    function get currentTaskIndex()
    {
        if (this._jsonObject.currTask == null || this._jsonObject.currTask < 0 || this._jsonObject.currTask > 3) 
        {
            return 0;
        }
        return this._jsonObject.currTask;
    }

    function set currentTaskIndex(value)
    {
        if (value == null || value < 0 || value > 3) 
        {
            this.traceSetError("currentTaskIndex", String(value));
            return;
        }
        this._jsonObject.currTask = value;
        this.currentTaskIndexChanged.dispatch(value);
    }

    function get taskAvailableDateTime()
    {
        return this._jsonObject.taskAvail == null || this._jsonObject.taskAvail <= 0 ? _global.getCurrentShell().server_time.getTime() + com.clubpenguin.quests.rainbowpuffle.vo.RainbowQuestCookieVO.TIME_TO_ADD_UNTIL_NEXT_TASK : this._jsonObject.taskAvail;
    }

    function set taskAvailableDateTime(value)
    {
        if (value == null) 
        {
            this.traceSetError("taskAvailableDateTime", String(value));
        }
        this._jsonObject.taskAvail = value;
        this.taskAvailableDateTimeChanged.dispatch(value);
    }

    function get questBonus()
    {
        if (this._jsonObject.bonus == null || this._jsonObject.bonus < 0 || this._jsonObject.bonus > 3) 
        {
            return 0;
        }
        return this._jsonObject.bonus;
    }

    function set questBonus(value)
    {
        if (value == null || value < 0 || value > 3) 
        {
            this.traceSetError("questBonus", String(value));
            return;
        }
        this._jsonObject.bonus = value;
        this.questBonusChanged.dispatch(value);
    }

    function get isCannonAvailable()
    {
        return this._jsonObject.cannon == null ? false : this._jsonObject.cannon;
    }

    function set isCannonAvailable(value)
    {
        if (value == null) 
        {
            this.traceSetError("isCannonAvailable", String(value));
            return;
        }
        this._jsonObject.cannon = value;
        this.isCannonAvailableChanged.dispatch(value);
    }

    function get numOfQuestsCompleted()
    {
        if (this._jsonObject.questsDone == null || this._jsonObject.questsDone < 0) 
        {
            return 0;
        }
        return this._jsonObject.questsDone;
    }

    function set numOfQuestsCompleted(value)
    {
        if (value == null || value < 0) 
        {
            this.traceSetError("numOfQuestsCompleted", String(value));
            return;
        }
        this._jsonObject.questsDone = value;
        this.numOfQuestsCompletedChanged.dispatch(value);
    }

    function get hoursRemaining()
    {
        if (this._jsonObject.hoursRemaining == null || this._jsonObject.hoursRemaining < 0) 
        {
            return 0;
        }
        return this._jsonObject.hoursRemaining;
    }

    function set hoursRemaining(value)
    {
        if (value == null || value < 0) 
        {
            this.traceSetError("hoursRemaining", String(value));
            return;
        }
        this._jsonObject.hoursRemaining = value;
        this.numOfQuestsCompletedChanged.dispatch(value);
    }

    function get minutesRemaining()
    {
        if (this._jsonObject.minutesRemaining == null || this._jsonObject.minutesRemaining < 0) 
        {
            return 0;
        }
        return this._jsonObject.minutesRemaining;
    }

    function set minutesRemaining(value)
    {
        if (value == null || value < 0) 
        {
            this.traceSetError("minutesRemaining", String(value));
            return;
        }
        this._jsonObject.minutesRemaining = value;
        this.minutesRemainingChanged.dispatch(value);
    }

    function get taskCollectables()
    {
        var __reg2 = undefined;
        if (this._jsonObject.tasks == null) 
        {
            __reg2 = [{completed: false, coin: 0, item: 0}, {completed: false, coin: 0, item: 0}, {completed: false, coin: 0, item: 0}, {completed: false, coin: 0, item: 0}, {completed: false, coin: 0, item: 0}];
        }
        else 
        {
            __reg2 = this._jsonObject.tasks;
        }
        return __reg2;
    }

    function set taskCollectables(value)
    {
        if (value == null) 
        {
            this.traceSetError("taskCollectables", String(value));
            return;
        }
        var __reg3 = 0;
        while (__reg3 < value.length) 
        {
            var __reg2 = value[__reg3];
            if (__reg2 == null || __reg2.coins == null || __reg2.coins < 0 || __reg2.coins > 2 || __reg2.item == null || __reg2.item < 0 || __reg2.item > 2) 
            {
                this.traceSetError("taskCollectables.obj", String(value) + ":" + __reg2.coins + ":" + __reg2.item);
                return;
            }
            ++__reg3;
        }
        this._jsonObject.tasks = value;
        this.taskCollectablesChanged.dispatch(value);
    }

    function traceSetError(propertyName, value)
    {
    }

}
