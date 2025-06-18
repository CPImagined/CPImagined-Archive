//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.concert.Concert
    {
        var _room, _concertIntervalId, _showMacBradyIntervalId, _hideMacBradyIntervalId, _startAnimatingMacBradyIntervalId;
        function Concert (room) {
            trace(CLASS_NAME + "()");
            _room = room;
            updateConcert(true);
        }
        function updateConcert(firstRun) {
            if ((com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart <= 0) || (com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart == com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds)) {
                preConcert();
            } else if ((com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds - com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart) < com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.CONCERT_DURATION_IN_MILLISECONDS) {
                playConcert();
            } else if ((com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds - com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart) == com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.CONCERT_DURATION_IN_MILLISECONDS) {
                postConcert();
            } else if ((com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds - com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart) > com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.CONCERT_DURATION_IN_MILLISECONDS) {
                idleStage();
            }
            if (!firstRun) {
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart = com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart - _concertIntervalInMilliseconds;
            }
            _room.updateCountdown();
            if ((_concertIntervalId == undefined) || (_concertIntervalId == null)) {
                _concertIntervalId = setInterval(this, "updateConcert", _concertIntervalInMilliseconds, false);
            }
        }
        function isIdle() {
            return((_state == STATE_IDLE) || (_state == undefined));
        }
        function preConcert() {
            if (_state != STATE_PRE_CONCERT) {
                _state = STATE_PRE_CONCERT;
                _room.resetCountdown();
                _room.addBlockLayerToStage();
                _room.removeStageNavigation();
                _room.removePenguinsFromStage();
                _room.playStageShift();
                addMacAndBradyDelay();
            }
        }
        function playConcert() {
            if (_state == STATE_PRE_CONCERT) {
                _state = STATE_PLAY;
                startMacAndBradyDelay(1);
                return(undefined);
            }
            if (_state == "") {
                _state = STATE_PLAY;
                _room.addBlockLayerToStage();
                _room.stopRoomMusic();
                var _local_2 = com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds - com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart;
                var _local_3 = calculateAnimationFrame(_local_2);
                var _local_4 = (((_local_3 > 1) || (_local_2 == 0)) ? true : false);
                _room.removeItemsFromStage(_local_4);
                addMacAndBrady();
                startMacAndBrady(_local_3);
                return(undefined);
            }
        }
        function postConcert() {
            if (_state != STATE_POST_CONCERT) {
                _state = STATE_POST_CONCERT;
                _room.postConcertStageItems();
                _room.startRoomMusic();
                removeMacAndBradyDelay();
            }
        }
        function idleStage() {
            if (_state == "") {
                _state = STATE_IDLE;
                _room.forceAddInstrumentsToStage();
                _room.stopMacAndBrady();
                _room.hideMacAndBrady();
            } else if (_state == STATE_POST_CONCERT) {
                _state = STATE_IDLE;
            }
        }
        function addMacAndBradyDelay() {
            if (_showMacBradyIntervalId != null) {
                trace("clearInterval");
                clearInterval(_showMacBradyIntervalId);
            }
            _showMacBradyIntervalId = setInterval(this, "addMacAndBrady", _showMacBradyIntervalInMilliseconds);
        }
        function addMacAndBrady() {
            _room.showMacAndBrady();
            clearInterval(_showMacBradyIntervalId);
        }
        function removeMacAndBradyDelay() {
            trace(CLASS_NAME + "::removeMacAndBradyDelay()");
            if (_hideMacBradyIntervalId != null) {
                trace("clearInterval");
                clearInterval(_hideMacBradyIntervalId);
            }
            _hideMacBradyIntervalId = setInterval(this, "removeMacAndBrady", _hideMacBradyIntervalInMilliseconds);
        }
        function removeMacAndBrady() {
            _room.removeBlockLayerFromStage();
            _room.addBackStageNavigation();
            _room.stopMacAndBrady();
            _room.hideMacAndBrady();
            clearInterval(_hideMacBradyIntervalId);
        }
        function startMacAndBradyDelay(frameNumber) {
            if (_startAnimatingMacBradyIntervalId != null) {
                trace("clearInterval");
                clearInterval(_startAnimatingMacBradyIntervalId);
            }
            _startAnimatingMacBradyIntervalId = setInterval(this, "startMacAndBrady", _startAnimatingMacBradyIntervalInMilliseconds, frameNumber);
        }
        function startMacAndBrady(frameNumber) {
            _room.startMacAndBrady(frameNumber);
            _room.stopRoomMusic();
            clearInterval(_startAnimatingMacBradyIntervalId);
        }
        function calculateAnimationFrame(milliSecondsPassed) {
            trace(((CLASS_NAME + "::calculateAnimationFrame(") + milliSecondsPassed) + ")");
            if (milliSecondsPassed > _concertIntervalInMilliseconds) {
                var _local_4 = milliSecondsPassed / com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.CONCERT_DURATION_IN_MILLISECONDS;
                var _local_2 = Math.ceil(_room.totalMacAndBradyFrames() * _local_4);
                trace((CLASS_NAME + "::calculateAnimationFrame:frameNumber=") + _local_2);
                return(_local_2);
            }
            return(1);
        }
        function getState() {
            return(_state);
        }
        function destroy() {
            clearInterval(_concertIntervalId);
            clearInterval(_showMacBradyIntervalId);
            clearInterval(_startAnimatingMacBradyIntervalId);
            clearInterval(_hideMacBradyIntervalId);
            _state = "";
        }
        function toString() {
            var _local_1 = "";
            _local_1 = _local_1 + "Concert -> ";
            _local_1 = _local_1 + (" _state: " + _state);
            _local_1 = _local_1 + (" TeenBeachParty.instance.millisecondsTillStart: " + com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.millisecondsTillStart);
            _local_1 = _local_1 + (" TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds: " + com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.timeBetweenConcertsInMilliSeconds);
            return(_local_1);
        }
        static var CLASS_NAME = "Concert";
        var _concertIntervalInMilliseconds = 1000;
        var _showMacBradyIntervalInMilliseconds = 2000;
        var _startAnimatingMacBradyIntervalInMilliseconds = 1000;
        var _hideMacBradyIntervalInMilliseconds = 3000;
        static var _state = "";
        static var STATE_IDLE = "idle";
        static var STATE_PRE_CONCERT = "preConcert";
        static var STATE_PLAY = "play";
        static var STATE_POST_CONCERT = "postConcert";
    }
