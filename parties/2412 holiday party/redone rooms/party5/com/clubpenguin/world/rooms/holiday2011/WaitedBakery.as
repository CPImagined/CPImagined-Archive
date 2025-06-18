//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.holiday2011.WaitedBakery extends com.clubpenguin.world.rooms.common.WaitedTable
    {
        var _fetchCookies, _table, _waiterTrigger, _seatTriggers, _seatsLength, _cookiesAprons, _cookiesApronsLength, _triggerInteractionItemList, _seatsTaken, _seatsTakenAmount, pushValues, _triggerCheck, waiterWaiting, _waiterTriggerID, customerEating, _updateCheckIntervalID, updateCheck, _foodServed;
        function WaitedBakery (fetchCookies, table, waiterTrigger, seatTriggers) {
            super();
            _fetchCookies = fetchCookies;
            _table = table;
            _waiterTrigger = waiterTrigger;
            _seatTriggers = seatTriggers;
            _seatsLength = _seatTriggers.length;
            _cookiesAprons = com.clubpenguin.world.rooms.common.WaiterConstants.COOKIE_APRONS;
            _cookiesApronsLength = _cookiesAprons.length;
            _triggerInteractionItemList = [];
            _seatsTaken = [];
            _seatsTakenAmount = 0;
        }
        function init() {
            var _local_4 = [];
            pushValues(true, _local_4, _cookiesAprons);
            _triggerCheck = com.clubpenguin.world.rooms.common.TriggerCheck.fetchInstance();
            var _local_5 = com.clubpenguin.util.Delegate.create(this, waiterWaiting);
            _waiterTriggerID = _triggerCheck.addTrigger(_waiterTrigger, _local_5);
            _triggerCheck.defineAreAnyNeededRequirement(_waiterTriggerID, true);
            _triggerCheck.defineDancingRequiredRequirement(_waiterTriggerID, true);
            _triggerCheck.defineBodyRequirement(_waiterTriggerID, _local_4);
            var _local_2 = 0;
            while (_local_2 < _seatTriggers.length) {
                var _local_3 = com.clubpenguin.util.Delegate.create(this, customerEating, _local_2);
                _triggerCheck.addTrigger(_seatTriggers[_local_2], _local_3);
                _seatsTaken[_local_2] = false;
                _local_2++;
            }
            _triggerCheck.init();
            clearInterval(_updateCheckIntervalID);
            _updateCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateCheck), com.clubpenguin.world.rooms.common.WaitedTable.INTERVAL_DELAY);
        }
        function serve(selectedFood) {
            if (!_fetchCookies()) {
                return(undefined);
            }
            _foodServed = _table.food.cookie;
            _foodServed.states.gotoAndStop(1);
            _foodServed.gotoAndPlay(com.clubpenguin.world.rooms.common.WaitedTable.APPEAR);
        }
        static var CLASS_NAME = "WaitedBakery";
    }
