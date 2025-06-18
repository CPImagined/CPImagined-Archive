//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainNormalMovement extends com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainMovement
    {
        var _trailPoints, _driverClip, _engine, _passengers, _lastDriverPos, _currentDriverPos, requestMovePlayer, requestChangePlayerFrame;
        function TrainNormalMovement (driverId, driverClip) {
            super(driverId, driverClip);
            _trailPoints = new Array();
            _trailPoints.push(new flash.geom.Point(((_driverClip._x < (Stage.width / 2)) ? 1000 : -1000), _driverClip._y));
            _trailPoints.push(new flash.geom.Point(_driverClip._x, _driverClip._y));
            _engine = _global.getCurrentEngine();
        }
        function onPassengerAdded(slotIndex, passengerId, passengerClip) {
            var _local_4 = _driverClip._x;
            var _local_3 = _driverClip._y;
            movePassenger(_passengers[slotIndex], slotIndex);
        }
        function onPassengerRemoved(slotIndex, passengerId, passengerClip) {
        }
        function onTargetPositionChanged(x, y) {
            if ((_trailPoints[-1].x != _driverClip._x) || (_trailPoints[-1].y != _driverClip._y)) {
                _trailPoints.push(new flash.geom.Point(_driverClip._x, _driverClip._y));
            }
        }
        function onUpdate() {
            if ((_lastDriverPos.x == _driverClip._x) && (_lastDriverPos.y == _driverClip._y)) {
                return(undefined);
            }
            var _local_2 = 0;
            while (_local_2 < _passengers.length) {
                var _local_3 = _passengers[_local_2];
                movePassenger(_local_3, _local_2);
                _local_2++;
            }
        }
        function movePassenger(passenger, slotIndex) {
            var _local_2 = _trailPoints.length - 1;
            var _local_4 = _currentDriverPos;
            var _local_3 = _trailPoints[_local_2];
            var _local_6 = ((slotIndex + 1) * com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainMovement.DISTANCE_BETWEEN_CARTS) + com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainMovement.PASSENGER_OFFSET;
            while (_local_6 > 0) {
                var _local_5 = flash.geom.Point.distance(_local_4, _local_3);
                if (_local_5 > _local_6) {
                    var _local_10 = _local_6 / _local_5;
                    var _local_7 = flash.geom.Point.interpolate(_local_3, _local_4, _local_10);
                    requestMovePlayer.dispatch(passenger.id, _local_7.x, _local_7.y);
                    var _local_11 = _engine.findAngle(_local_3.x, _local_3.y, _local_4.x, _local_4.y);
                    var _local_8 = _engine.findDirection(_local_11);
                    if (passenger.clip._currentFrame != _local_8) {
                        requestChangePlayerFrame.dispatch(passenger.id, _local_8);
                    }
                    if (((slotIndex == (_passengers.length - 1)) && (_local_2 != 0)) && (_local_2 < (_trailPoints.length - 1))) {
                        _trailPoints.splice(0, _local_2);
                    }
                    break;
                }
                _local_2 = _local_2 - 1;
                if (_local_2 < 0) {
                    var _local_9 = _trailPoints[0].subtract(_trailPoints[1]);
                    _local_9.normalize(1000);
                    _trailPoints.unshift(_trailPoints[0].add(_local_9));
                    _local_2 = 0;
                }
                _local_4 = _local_3;
                _local_3 = _trailPoints[_local_2];
                _local_6 = _local_6 - _local_5;
            }
        }
    }
