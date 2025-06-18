//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.HalloweenParty_TrickOrTreating
    {
        static var _instance;
        var _shell, _airtower, _interface, _engine, _party, _pumpkinGameCompleteSignal, _currentTrickOrTreatPumpkin, _trickOrTreatPumpkins;
        function HalloweenParty_TrickOrTreating () {
            init();
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            _pumpkinGameCompleteSignal = new org.osflash.signals.Signal();
        }
        function callCurrentRoomFunction(functionName) {
            _engine.getRoomMovieClip().room[functionName]();
            _engine.getRoomMovieClip().roomFunctionality[functionName]();
        }
        static function get instance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.world.rooms2013.halloween.HalloweenParty_TrickOrTreating();
            }
            return(_instance);
        }
        function get currentTrickOrTreatPumpkin() {
            return(_currentTrickOrTreatPumpkin);
        }
        function set currentTrickOrTreatPumpkin(value) {
            _currentTrickOrTreatPumpkin = value;
            //return(currentTrickOrTreatPumpkin);
        }
        function get pumpkinGameCompleteSignal() {
            return(_pumpkinGameCompleteSignal);
        }
        function get trickOrTreatPumpkins() {
            if (_trickOrTreatPumpkins == undefined) {
                _trickOrTreatPumpkins = new Object();
            }
            return(_trickOrTreatPumpkins);
        }
        function trickOrTreatPumpkinVisited(id) {
            var _local_2 = _shell.getPenguinStandardTime().getTime();
            trickOrTreatPumpkins[id] = _local_2;
            pumpkinGameCompleteSignal.dispatch();
        }
        function resetTrickOrTreatPumpkin(id) {
            trickOrTreatPumpkins[id] = undefined;
        }
        function isTrickOrTreatPumpkinActive(id) {
            var _local_3 = _shell.getPenguinStandardTime().getTime();
            var _local_2 = trickOrTreatPumpkins[id];
            if (_local_2 == undefined) {
                return(true);
            }
            return((((_local_3 - _local_2) >= com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.TIME_BETWEEN_PUMPKIN_VISITS) ? true : false));
        }
        function updatePumpkinState(pumpkinsArray) {
            var _local_2 = 0;
            while (_local_2 < pumpkinsArray.length) {
                var _local_4 = pumpkinsArray[_local_2].id;
                if (isTrickOrTreatPumpkinActive(_local_4) && (!pumpkinsArray[_local_2].mc.isActive)) {
                    trace("set pumpkin as active");
                    pumpkinsArray[_local_2].mc.gotoAndStop("active");
                    pumpkinsArray[_local_2].mc.isActive = true;
                    pumpkinsArray[_local_2].trigger.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.halloween.HalloweenParty.instance, com.clubpenguin.world.rooms2013.halloween.HalloweenParty.instance.launchPumpkinMiniGame, _local_4);
                } else if ((!isTrickOrTreatPumpkinActive(_local_4)) && (pumpkinsArray[_local_2].mc.isActive)) {
                    pumpkinsArray[_local_2].mc.gotoAndStop("deactive");
                    pumpkinsArray[_local_2].mc.isActive = false;
                    pumpkinsArray[_local_2].trigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, showDeactivePumpkinPrompt);
                    callCurrentRoomFunction("refreshPumpkinNavigationButtons");
                }
                _local_2++;
            }
        }
        function showDeactivePumpkinPrompt() {
            _interface.showContent(com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.PUMPKIN_DEACTIVE_PROMPT);
        }
    }
