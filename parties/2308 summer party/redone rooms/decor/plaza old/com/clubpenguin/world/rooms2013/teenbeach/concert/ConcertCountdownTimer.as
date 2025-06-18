//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.concert.ConcertCountdownTimer
    {
        var _timeBetweenConcertsInMilliseconds, _timeTillConcertInMilliseconds, _onesDigit, _tensDigit;
        function ConcertCountdownTimer (timeBetweenConcertsInMilliseconds) {
            _timeBetweenConcertsInMilliseconds = timeBetweenConcertsInMilliseconds;
        }
        function setTimeTillConcertInMilliseconds(timeTillConcertInMilliseconds) {
            _timeTillConcertInMilliseconds = timeTillConcertInMilliseconds;
        }
        function increment(durationInMilliSeconds) {
            _timeTillConcertInMilliseconds = _timeTillConcertInMilliseconds - durationInMilliSeconds;
            if (_timeTillConcertInMilliseconds <= 0) {
                _timeTillConcertInMilliseconds = _timeTillConcertInMilliseconds + _timeBetweenConcertsInMilliseconds;
            }
            return(_timeTillConcertInMilliseconds);
        }
        function set onesDigit(onesDigit) {
            _onesDigit = onesDigit;
            //return(this.onesDigit);
        }
        function get onesDigit() {
            return(_onesDigit);
        }
        function set tensDigit(tensDigit) {
            _tensDigit = tensDigit;
            //return(this.tensDigit);
        }
        function get tensDigit() {
            return(_tensDigit);
        }
        function reset() {
            _tensDigit = 0;
            _onesDigit = 0;
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "ConcertCountdownTimer -> ";
            _local_2 = _local_2 + (" _tensDigit: " + _tensDigit);
            _local_2 = _local_2 + (" _onesDigit: " + _onesDigit);
            _local_2 = _local_2 + (" _timeTillConcertInMilliseconds: " + _timeTillConcertInMilliseconds);
            _local_2 = _local_2 + (" _timeBetweenConcertsInMilliseconds: " + _timeBetweenConcertsInMilliseconds);
            return(_local_2);
        }
        static var CLASS_NAME = "ConcertCountdownTimer";
    }
