//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.quests.rainbowpuffle.vo.RainbowQuestCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var currentTaskIndexChanged, taskAvailableDateTimeChanged, questBonusChanged, isCannonAvailableChanged, numOfQuestsCompletedChanged, taskCollectablesChanged, hoursRemainingChanged, minutesRemainingChanged, _jsonObject;
        function RainbowQuestCookieVO (cookieId) {
            super(cookieId);
            currentTaskIndexChanged = new org.osflash.signals.Signal(Number);
            taskAvailableDateTimeChanged = new org.osflash.signals.Signal(Number);
            questBonusChanged = new org.osflash.signals.Signal(Number);
            isCannonAvailableChanged = new org.osflash.signals.Signal(Boolean);
            numOfQuestsCompletedChanged = new org.osflash.signals.Signal(Number);
            taskCollectablesChanged = new org.osflash.signals.Signal(Array);
            hoursRemainingChanged = new org.osflash.signals.Signal(Number);
            minutesRemainingChanged = new org.osflash.signals.Signal(Number);
        }
        function getCookieHandlerName() {
            return("rpq");
        }
        function getSendCommandName() {
            return("NO_SEND_CMD_AVAILABLE");
        }
        function getReceiveCommandName() {
            return("rpqd");
        }
        function get currentTaskIndex() {
            if (((_jsonObject.currTask == null) || (_jsonObject.currTask < 0)) || (_jsonObject.currTask > 3)) {
                return(0);
            } else {
                return(_jsonObject.currTask);
            }
        }
        function set currentTaskIndex(value) {
            if (((value == null) || (value < 0)) || (value > 3)) {
                traceSetError("currentTaskIndex", String(value));
                return;
            }
            _jsonObject.currTask = value;
            currentTaskIndexChanged.dispatch(value);
            //return(currentTaskIndex);
        }
        function get taskAvailableDateTime() {
            return((((_jsonObject.taskAvail == null) || (_jsonObject.taskAvail <= 0)) ? (_global.getCurrentShell().server_time.getTime() + TIME_TO_ADD_UNTIL_NEXT_TASK) : (_jsonObject.taskAvail)));
        }
        function set taskAvailableDateTime(value) {
            if (value == null) {
                traceSetError("taskAvailableDateTime", String(value));
            }
            _jsonObject.taskAvail = value;
            taskAvailableDateTimeChanged.dispatch(value);
            //return(taskAvailableDateTime);
        }
        function get questBonus() {
            if (((_jsonObject.bonus == null) || (_jsonObject.bonus < 0)) || (_jsonObject.bonus > 3)) {
                return(0);
            } else {
                return(_jsonObject.bonus);
            }
        }
        function set questBonus(value) {
            if (((value == null) || (value < 0)) || (value > 3)) {
                traceSetError("questBonus", String(value));
                return;
            }
            _jsonObject.bonus = value;
            questBonusChanged.dispatch(value);
            //return(questBonus);
        }
        function get isCannonAvailable() {
            return(((_jsonObject.cannon == null) ? false : (_jsonObject.cannon)));
        }
        function set isCannonAvailable(value) {
            if (value == null) {
                traceSetError("isCannonAvailable", String(value));
                return;
            }
            _jsonObject.cannon = value;
            isCannonAvailableChanged.dispatch(value);
            //return(isCannonAvailable);
        }
        function get numOfQuestsCompleted() {
            if ((_jsonObject.questsDone == null) || (_jsonObject.questsDone < 0)) {
                return(0);
            } else {
                return(_jsonObject.questsDone);
            }
        }
        function set numOfQuestsCompleted(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("numOfQuestsCompleted", String(value));
                return;
            }
            _jsonObject.questsDone = value;
            numOfQuestsCompletedChanged.dispatch(value);
            //return(numOfQuestsCompleted);
        }
        function get hoursRemaining() {
            if ((_jsonObject.hoursRemaining == null) || (_jsonObject.hoursRemaining < 0)) {
                return(0);
            } else {
                return(_jsonObject.hoursRemaining);
            }
        }
        function set hoursRemaining(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("hoursRemaining", String(value));
                return;
            }
            _jsonObject.hoursRemaining = value;
            numOfQuestsCompletedChanged.dispatch(value);
            //return(hoursRemaining);
        }
        function get minutesRemaining() {
            if ((_jsonObject.minutesRemaining == null) || (_jsonObject.minutesRemaining < 0)) {
                return(0);
            } else {
                return(_jsonObject.minutesRemaining);
            }
        }
        function set minutesRemaining(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("minutesRemaining", String(value));
                return;
            }
            _jsonObject.minutesRemaining = value;
            minutesRemainingChanged.dispatch(value);
            //return(minutesRemaining);
        }
        function get taskCollectables() {
            var _local_2;
            if (_jsonObject.tasks == null) {
                _local_2 = [{completed:false, coin:0, item:0}, {completed:false, coin:0, item:0}, {completed:false, coin:0, item:0}, {completed:false, coin:0, item:0}, {completed:false, coin:0, item:0}];
            } else {
                _local_2 = _jsonObject.tasks;
            }
            return(_local_2);
        }
        function set taskCollectables(value) {
            if (value == null) {
                traceSetError("taskCollectables", String(value));
                return;
            }
            var _local_3 = 0;
            while (_local_3 < value.length) {
                var _local_2 = value[_local_3];
                if (((((((_local_2 == null) || (_local_2.coins == null)) || (_local_2.coins < 0)) || (_local_2.coins > 2)) || (_local_2.item == null)) || (_local_2.item < 0)) || (_local_2.item > 2)) {
                    traceSetError("taskCollectables.obj", (((String(value) + ":") + _local_2.coins) + ":") + _local_2.item);
                    return;
                }
                _local_3++;
            }
            _jsonObject.tasks = value;
            taskCollectablesChanged.dispatch(value);
            //return(taskCollectables);
        }
        function traceSetError(propertyName, value) {
        }
        static var TIME_TO_ADD_UNTIL_NEXT_TASK = 64800000;
    }
