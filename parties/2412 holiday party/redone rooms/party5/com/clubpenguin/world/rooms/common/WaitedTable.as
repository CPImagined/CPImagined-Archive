//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.WaitedTable
    {
        var _table, _waiterTrigger, _seatTriggers, _seatsLength, _triggerInteractionItemList, _seatsTaken, _seatsTakenAmount, _triggerCheck, _updateCheckIntervalID, _pizzaHats, _pizzaHatsLength, _pizzaAprons, _pizzaApronsLength, _coffeeAprons, _coffeeApronsLength, _icecreamAprons, _icecreamApronsLength, _cakeAprons, _cakeApronsLength, _popcornAprons, _popcornApronsLength, _cookiesAprons, _cookiesApronsLength, _waiterTriggerID, _foodServed, _ignoreCount;
        function WaitedTable (table, waiterTrigger, seatTriggers) {
            _table = table;
            _waiterTrigger = waiterTrigger;
            _seatTriggers = seatTriggers;
            _seatsLength = _seatTriggers.length;
            _triggerInteractionItemList = [];
            _seatsTaken = [];
            _seatsTakenAmount = 0;
        }
        function destroy() {
            _triggerCheck.destroy();
            clearInterval(_updateCheckIntervalID);
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        function pizzaServed() {
            _isPizzaServed = true;
            _pizzaHats = com.clubpenguin.world.rooms.common.WaiterConstants.PIZZA_HATS;
            _pizzaHatsLength = _pizzaHats.length;
            _pizzaAprons = com.clubpenguin.world.rooms.common.WaiterConstants.PIZZA_APRONS;
            _pizzaApronsLength = _pizzaAprons.length;
        }
        function coffeeServed() {
            _isCoffeeServed = true;
            _coffeeAprons = com.clubpenguin.world.rooms.common.WaiterConstants.COFFEE_APRONS;
            _coffeeApronsLength = _coffeeAprons.length;
        }
        function iceCreamServed() {
            _isIceCreamServed = true;
            _icecreamAprons = com.clubpenguin.world.rooms.common.WaiterConstants.ICECREAM_APRONS;
            _icecreamApronsLength = _icecreamAprons.length;
        }
        function cakeServed() {
            _isCakeServed = true;
            _cakeAprons = com.clubpenguin.world.rooms.common.WaiterConstants.CAKE_APRONS;
            _cakeApronsLength = _cakeAprons.length;
        }
        function popcornServed() {
            _isPopcornServed = true;
            _popcornAprons = com.clubpenguin.world.rooms.common.WaiterConstants.POPCORN_APRONS;
            _popcornApronsLength = _popcornAprons.length;
        }
        function cookiesServed() {
            _isCookiesServed = true;
            _cookiesAprons = com.clubpenguin.world.rooms.common.WaiterConstants.COOKIE_APRONS;
            _cookiesApronsLength = _cookiesAprons.length;
        }
        function init() {
            var _local_5 = [];
            var _local_6 = [];
            var _local_4 = [];
            pushValues(_isPizzaServed, _local_5, _pizzaHats);
            pushValues(_isPopcornServed, _local_6, _popcornAprons);
            pushValues(_isPizzaServed, _local_4, _pizzaAprons);
            pushValues(_isCoffeeServed, _local_4, _coffeeAprons);
            pushValues(_isIceCreamServed, _local_4, _icecreamAprons);
            pushValues(_isCakeServed, _local_4, _cakeAprons);
            pushValues(_isCookiesServed, _local_4, _cookiesAprons);
            _triggerCheck = com.clubpenguin.world.rooms.common.TriggerCheck.fetchInstance();
            var _local_7 = com.clubpenguin.util.Delegate.create(this, waiterWaiting);
            _waiterTriggerID = _triggerCheck.addTrigger(_waiterTrigger, _local_7);
            _triggerCheck.defineAreAnyNeededRequirement(_waiterTriggerID, true);
            _triggerCheck.defineDancingRequiredRequirement(_waiterTriggerID, true);
            _triggerCheck.defineHeadRequirement(_waiterTriggerID, _local_5);
            _triggerCheck.defineNeckRequirement(_waiterTriggerID, _local_6);
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
            _updateCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateCheck), INTERVAL_DELAY);
        }
        function pushValues(followThrough, oldList, newValues) {
            if (!followThrough) {
                return(undefined);
            }
            var _local_1 = 0;
            while (_local_1 < newValues.length) {
                oldList.push(newValues[_local_1]);
                _local_1++;
            }
        }
        function waiterWaiting(playerID, players) {
            var _local_4;
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2].player_id == playerID) {
                    _local_4 = players[_local_2];
                }
                _local_2++;
            }
            if (_local_4.frame != DANCE_FRAME) {
                return(undefined);
            }
            if (isServing(_coffeeAprons, _coffeeApronsLength, _local_4.body)) {
                serve(COFFEE);
            } else if (isServing(_icecreamAprons, _icecreamApronsLength, _local_4.body)) {
                serve(ICECREAM);
            } else if (isServing(_cakeAprons, _cakeApronsLength, _local_4.body)) {
                serve(CAKE);
            } else if (isServing(_popcornAprons, _popcornApronsLength, _local_4.body)) {
                serve(POPCORN);
            } else if (isServing(_pizzaAprons, _pizzaApronsLength, _local_4.body) || (isServing(_pizzaHats, _pizzaHatsLength, _local_4.head))) {
                serve(PIZZA);
            } else if (isServing(_cookiesAprons, _cookiesApronsLength, _local_4.body)) {
                serve(COOKIE);
            }
        }
        function isServing(list, listLength, item) {
            var _local_1 = 0;
            while (_local_1 < listLength) {
                if (list[_local_1] == item) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        function serve(selectedFood) {
            switch (selectedFood) {
                case PIZZA : 
                    _foodServed = _table.food.pizza;
                    break;
                case COFFEE : 
                    _foodServed = _table.food.coffee;
                    break;
                case ICECREAM : 
                    _foodServed = _table.food.icecream;
                    break;
                case CAKE : 
                    _foodServed = _table.food.cake;
                    break;
                case POPCORN : 
                    _foodServed = _table.food.popcorn;
                    break;
                case COOKIE : 
                    _foodServed = _table.food.cookie;
                    break;
                default : 
                    break;
            }
            _foodServed.states.gotoAndStop(1);
            _foodServed.gotoAndPlay(APPEAR);
            _table.decoration.gotoAndPlay(DISAPPEAR);
        }
        function clean(id) {
            _foodServed.gotoAndPlay(DISAPPEAR);
            _foodServed = null;
            _table.decoration.gotoAndPlay(APPEAR);
            _triggerCheck.clearInteractingPlayers(id);
        }
        function customerEating(playerID, players, seat) {
            if ((players.length > 0) && (_seatsTaken[seat] == false)) {
                _seatsTaken[seat] = true;
            } else if ((players.length == 0) && (_seatsTaken[seat] == true)) {
                _seatsTaken[seat] = false;
            } else {
                return(undefined);
            }
            updateSeatsTakenAmount();
        }
        function updateSeatsTakenAmount() {
            _seatsTakenAmount = 0;
            var _local_2 = 0;
            while (_local_2 < _seatsLength) {
                if (_seatsTaken[_local_2]) {
                    _seatsTakenAmount++;
                }
                _local_2++;
            }
        }
        function updateCheck() {
            if (!_foodServed) {
                return(undefined);
            }
            if (_seatsTakenAmount == 0) {
                if (_ignoreCount == 0) {
                    _ignoreCount = null;
                    clean(_waiterTriggerID);
                } else if (!_ignoreCount) {
                    _ignoreCount = IGNORE_COUNTER_MAX;
                } else {
                    _ignoreCount--;
                }
            } else {
                var _local_3 = _foodServed.states._totalframes;
                var _local_4 = _seatsTakenAmount;
                var _local_2 = _foodServed.states._currentframe + _local_4;
                if (_local_2 > _local_3) {
                    _local_2 = _local_3;
                }
                _foodServed.states.gotoAndStop(_local_2);
            }
        }
        static var CLASS_NAME = "WaitedTable";
        static var PIZZA = "pizza";
        static var COFFEE = "coffee";
        static var ICECREAM = "icecream";
        static var CAKE = "cake";
        static var POPCORN = "popcorn";
        static var COOKIE = "cookie";
        static var PARK = "park";
        static var APPEAR = "appear";
        static var DISAPPEAR = "disappear";
        static var CONSUME = "consume";
        static var DANCE_FRAME = 26;
        static var IGNORE_COUNTER_MAX = 5;
        static var INTERVAL_DELAY = 2000;
        var _isPizzaServed = false;
        var _isCoffeeServed = false;
        var _isIceCreamServed = false;
        var _isCakeServed = false;
        var _isPopcornServed = false;
        var _isCookiesServed = false;
    }
