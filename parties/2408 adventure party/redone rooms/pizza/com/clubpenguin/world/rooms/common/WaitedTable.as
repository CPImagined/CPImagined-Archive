//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.WaitedTable
    {
        var _table, _waiterTrigger, _seatTriggers, _seatsLength, _pizzaHats, _pizzaHatsLength, _pizzaAprons, _pizzaApronsLength, _coffeeAprons, _coffeeApronsLength, _icecreamAprons, _icecreamApronsLength, _cakeAprons, _cakeApronsLength, _popcornAprons, _popcornApronsLength, _triggerInteractionItemList, _seatsTaken, _seatsTakenAmount, _triggerCheck, _updateCheckIntervalID, _foodServed, _ignoreCount;
        function WaitedTable (isPizzaServed, isCoffeeServed, isIceCreamServed, isCakeServed, isPopcornServed, table, waiterTrigger, seatTriggers) {
            _table = table;
            _waiterTrigger = waiterTrigger;
            _seatTriggers = seatTriggers;
            _seatsLength = _seatTriggers.length;
            _pizzaHats = com.clubpenguin.world.rooms.common.WaiterConstants.PIZZA_HATS;
            _pizzaHatsLength = _pizzaHats.length;
            _pizzaAprons = com.clubpenguin.world.rooms.common.WaiterConstants.PIZZA_APRONS;
            _pizzaApronsLength = _pizzaAprons.length;
            _coffeeAprons = com.clubpenguin.world.rooms.common.WaiterConstants.COFFEE_APRONS;
            _coffeeApronsLength = _coffeeAprons.length;
            _icecreamAprons = com.clubpenguin.world.rooms.common.WaiterConstants.ICECREAM_APRONS;
            _icecreamApronsLength = _icecreamAprons.length;
            _cakeAprons = com.clubpenguin.world.rooms.common.WaiterConstants.CAKE_APRONS;
            _cakeApronsLength = _cakeAprons.length;
            _popcornAprons = com.clubpenguin.world.rooms.common.WaiterConstants.POPCORN_APRONS;
            _popcornApronsLength = _popcornAprons.length;
            _triggerInteractionItemList = [];
            _seatsTaken = [];
            _seatsTakenAmount = 0;
            init(isPizzaServed, isCoffeeServed, isIceCreamServed, isCakeServed, isPopcornServed);
        }
        function destroy() {
            _triggerCheck.destroy();
            clearInterval(_updateCheckIntervalID);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function init(isPizzaServed, isCoffeeServed, isIceCreamServed, isCakeServed, isPopcornServed) {
            var _local_4 = [];
            var _local_6 = [];
            var _local_7 = [];
            var _local_5 = [];
            pushValues(isPizzaServed, _local_6, _pizzaHats);
            pushValues(isPizzaServed, _local_5, _pizzaAprons);
            pushValues(isCoffeeServed, _local_5, _coffeeAprons);
            pushValues(isIceCreamServed, _local_5, _icecreamAprons);
            pushValues(isCakeServed, _local_5, _cakeAprons);
            pushValues(isPopcornServed, _local_7, _popcornAprons);
            var _local_8 = com.clubpenguin.util.Delegate.create(this, waiterWaiting);
            _local_4.push(new com.clubpenguin.world.rooms.common.TriggerManager(_waiterTrigger, _local_8, new com.clubpenguin.world.rooms.common.TriggerInteractionVO(false, true, false, [], _local_6, [], _local_7, _local_5, [], [], [], [])));
            var _local_2 = 0;
            while (_local_2 < _seatTriggers.length) {
                _seatsTaken[_local_2] = false;
                var _local_3 = com.clubpenguin.util.Delegate.create(this, customerEating, _local_2);
                _local_4.push(new com.clubpenguin.world.rooms.common.TriggerManager(_seatTriggers[_local_2], _local_3));
                _local_2++;
            }
            _triggerCheck = new com.clubpenguin.world.rooms.common.TriggerCheck(_local_4);
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
                default : 
                    break;
            }
            _foodServed.states.gotoAndStop(1);
            _foodServed.gotoAndPlay(APPEAR);
            _table.decoration.gotoAndPlay(DISAPPEAR);
        }
        function clean() {
            _foodServed.gotoAndPlay(DISAPPEAR);
            _foodServed = null;
            _table.decoration.gotoAndPlay(APPEAR);
            _triggerCheck.clearInteractingLists();
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
                    clean();
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
        static var PARK = "park";
        static var APPEAR = "appear";
        static var DISAPPEAR = "disappear";
        static var CONSUME = "consume";
        static var DANCE_FRAME = 26;
        static var IGNORE_COUNTER_MAX = 5;
        static var INTERVAL_DELAY = 2000;
    }
