//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.TrainVO
    {
        var _id, driverId, passengers, score, state;
        function TrainVO () {
            _id = NEXT_ID++;
        }
        static function fromObject(obj) {
            var _local_1 = new com.clubpenguin.world.rooms2013.cfc.trains.TrainVO();
            _local_1.driverId = obj.driverId;
            _local_1.passengers = obj.passengers.slice();
            _local_1.score = obj.score;
            _local_1.state = (obj.open ? (com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum.BOARDING) : (com.clubpenguin.world.rooms2013.cfc.trains.states.TrainStateEnum.DRIVING));
            return(_local_1);
        }
        function get id() {
            return(_id);
        }
        function clone() {
            var _local_2 = new com.clubpenguin.world.rooms2013.cfc.trains.TrainVO();
            _local_2.driverId = driverId;
            _local_2.passengers = passengers.slice();
            _local_2.score = score;
            _local_2.state = state;
            return(_local_2);
        }
        function containsPassenger(playerId) {
            var _local_2 = 0;
            while (_local_2 < passengers.length) {
                if (passengers[_local_2] == playerId) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function containsPlayer(playerId) {
            return((driverId == playerId) || (containsPassenger(playerId)));
        }
        function getPassengerSlotIndex(passengerId) {
            var _local_2 = 0;
            while (_local_2 < passengers.length) {
                if (passengers[_local_2] == passengerId) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(-1);
        }
        function getPassengerDifferences(other, notContainedByThis) {
            notContainedByThis.length = 0;
            var _local_3 = 0;
            while (_local_3 < other.passengers.length) {
                var _local_4 = false;
                var _local_2 = 0;
                while (_local_2 < passengers.length) {
                    if (passengers[_local_2] == other.passengers[_local_3]) {
                        _local_4 = true;
                        break;
                    }
                    _local_2++;
                }
                if (!_local_4) {
                    notContainedByThis.push(other.passengers[_local_3]);
                }
                _local_3++;
            }
        }
        function passengersEqual(other) {
            if (passengers.length != other.passengers.length) {
                return(false);
            }
            var _local_2 = 0;
            while (_local_2 < other.passengers.length) {
                if (!containsPassenger(other.passengers[_local_2])) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function equals(other) {
            return((((driverId == other.driverId) && (score == other.score)) && (state == other.state)) && (passengersEqual(other)));
        }
        function toString() {
            return(((((((("TrainVO{ driverId=" + driverId) + ", passengers=") + passengers) + ", score=") + score) + ", state=") + state) + " }");
        }
        static var NEXT_ID = 0;
    }
