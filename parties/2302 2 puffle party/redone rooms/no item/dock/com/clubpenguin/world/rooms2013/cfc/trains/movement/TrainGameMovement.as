//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainGameMovement extends com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainMovement
    {
        var _engine, _keyFrames, _currentKeyFrame, _driverClip, _currentTime, _passengers, _currentDriverPos, requestMovePlayer;
        function TrainGameMovement (driverId, driverClip) {
            super(driverId, driverClip);
            trace("HSF TrainGameMovement CTOR");
            _engine = _global.getCurrentEngine();
            _keyFrames = new Array();
            var _local_4 = getTimer();
            _currentKeyFrame = {t:_local_4, y:_driverClip._y};
            _keyFrames.push({t:_local_4 - 5000, y:_currentKeyFrame.y});
        }
        function onPassengerAdded(slotIndex, passengerId, passengerClip) {
            if (slotIndex == 0) {
                _currentTime = getTimer();
            }
            var _local_4 = _driverClip._x;
            var _local_3 = _driverClip._y;
            _passengers[slotIndex].delay = (slotIndex + 1) * 250;
            movePassenger(_passengers[slotIndex], slotIndex, _currentTime);
        }
        function onPassengerRemoved(slotIndex, passengerId, passengerClip) {
        }
        function onTargetPositionChanged(x, y) {
            _keyFrames.push({t:getTimer(), y:_driverClip._y});
        }
        function getDistanceFromDriver(slotIndex) {
            return(((slotIndex + 1) * com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainMovement.DISTANCE_BETWEEN_CARTS) + com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainMovement.PASSENGER_OFFSET);
        }
        function onUpdate() {
            var _local_4 = getTimer();
            _currentKeyFrame.t = _local_4;
            _currentKeyFrame.y = _currentDriverPos.y;
            _keyFrames.push({t:_local_4, y:_currentDriverPos.y});
            var _local_2 = 0;
            while (_local_2 < _passengers.length) {
                var _local_3 = _passengers[_local_2];
                movePassenger(_local_3, _local_2, _local_4);
                _local_2++;
            }
            pruneOldKeyFrames();
        }
        function movePassenger(passenger, slotIndex, t) {
            t = t - passenger.delay;
            var _local_4;
            var _local_6;
            if (_keyFrames[_keyFrames.length - 1].t < t) {
                _local_4 = _keyFrames[_keyFrames.length - 1];
                _local_6 = _currentKeyFrame;
            } else {
                var _local_2 = _keyFrames.length - 1;
                while (_local_2 >= 0) {
                    var _local_3 = _keyFrames[_local_2];
                    if (_local_3.t < t) {
                        _local_4 = _local_3;
                        _local_6 = _keyFrames[_local_2 + 1];
                        break;
                    }
                    _local_2--;
                }
            }
            var _local_8 = _local_6.t - _local_4.t;
            var _local_10 = t - _local_4.t;
            var _local_7 = _local_10 / _local_8;
            var _local_9 = _local_4.y + ((_local_6.y - _local_4.y) * _local_7);
            requestMovePlayer.dispatch(passenger.id, _driverClip._x - getDistanceFromDriver(slotIndex), _local_9);
        }
        function pruneOldKeyFrames() {
            var _local_4 = 0;
            var _local_5 = getTimer();
            var _local_2 = _keyFrames.length - 1;
            while (_local_2 >= 0) {
                var _local_3 = _keyFrames[_local_2];
                if (_local_3.t < (_local_5 - 1500)) {
                    _local_4 = _local_2;
                    break;
                }
                _local_2--;
            }
            _keyFrames.splice(0, _local_4);
        }
    }
