//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.MuppetStageTimer
    {
        var _view, _bottomPart, _onesDigitMC, _tensDigitMC, _timeTill, _tensDigit, _onesDigit;
        function MuppetStageTimer (view) {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("MuppetStageTimer()", CLASS_NAME);
            _view = view;
            _bottomPart = _view.bottomPart;
            _onesDigitMC = _bottomPart.digit1;
            _tensDigitMC = _bottomPart.digit0;
            _view.gotoAndStop(HIDE_LABEL);
        }
        function init(timeSinceStarted, timeBetweenShows) {
            TIME_BETWEEN_SHOWS = ((timeBetweenShows != undefined) ? (timeBetweenShows) : (TIME_BETWEEN_SHOWS));
            _timeTill = TIME_BETWEEN_SHOWS - timeSinceStarted;
            if (timeSinceStarted >= SHOW_DURATION) {
                showTimer(true);
            }
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("init():_timeTill=" + _timeTill, CLASS_NAME);
        }
        function hideTimer(force) {
            if (force) {
                _view.gotoAndStop(COME_BACK_LABEL);
            }
            _view.gotoAndPlay(GO_AWAY_LABEL);
        }
        function showTimer(force) {
            if (force) {
                _view.gotoAndStop(GO_AWAY_LABEL);
                return(undefined);
            }
            _view.gotoAndPlay(COME_BACK_LABEL);
        }
        function update(timeDelta) {
            increment(timeDelta);
            updateTimer();
        }
        function updateTimer() {
            var _local_4 = _timeTill / 1000;
            var _local_3;
            var _local_2;
            if (showOn) {
                isDisplayed = false;
                _local_2 = 0;
                _local_3 = 0;
            } else {
                isDisplayed = true;
                _local_3 = Math.floor((_local_4 / 60) / 10);
                _local_2 = Math.floor((_local_4 / 60) % 10) + 1;
                if (10 == _local_2) {
                    _local_2 = 0;
                    _local_3++;
                }
            }
            renderTimer(_local_3, _local_2);
        }
        function renderTimer(tensDigit, onesDigit) {
            if ((_tensDigit != tensDigit) || (_tensDigit == undefined)) {
                _tensDigitMC.gotoAndPlay("n_" + tensDigit);
                _tensDigit = tensDigit;
            }
            if ((_onesDigit != onesDigit) || (_onesDigit == undefined)) {
                _onesDigitMC.gotoAndPlay("n_" + onesDigit);
                _onesDigit = onesDigit;
            }
        }
        function increment(duration) {
            _timeTill = _timeTill - duration;
            if (_timeTill <= 0) {
                _timeTill = _timeTill + TIME_BETWEEN_SHOWS;
            }
            return(_timeTill);
        }
        function getPercentageIntoShow(totalFrames) {
            return((timeSinceStarted / SHOW_DURATION) * totalFrames);
        }
        function reset() {
            renderTimer(0, 0);
            _tensDigit = 0;
            _onesDigit = 0;
            _timeTill = TIME_BETWEEN_SHOWS;
        }
        function get timeSinceStarted() {
            return(TIME_BETWEEN_SHOWS - _timeTill);
        }
        function get showOn() {
            return((TIME_BETWEEN_SHOWS - _timeTill) <= SHOW_DURATION);
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "MuppetStageTimer -> ";
            _local_2 = _local_2 + (" _tensDigit: " + _tensDigit);
            _local_2 = _local_2 + (" _onesDigit: " + _onesDigit);
            _local_2 = _local_2 + (" _timeTill: " + _timeTill);
            _local_2 = _local_2 + (" TIME_BETWEEN_SHOWS: " + TIME_BETWEEN_SHOWS);
            return(_local_2);
        }
        static var CLASS_NAME = "MuppetStageTimer";
        static var GO_AWAY_LABEL = "goAway";
        static var COME_BACK_LABEL = "comeBack";
        static var HIDE_LABEL = "hide";
        static var TIME_BETWEEN_SHOWS = 60000;
        static var SHOW_DURATION = 51000;
        var isDisplayed = false;
    }
