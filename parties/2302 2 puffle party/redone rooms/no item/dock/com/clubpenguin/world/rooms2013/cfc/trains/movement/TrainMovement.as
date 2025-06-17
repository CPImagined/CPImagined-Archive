//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.movement.TrainMovement
    {
        var requestMovePlayer, requestChangePlayerFrame, _driverId, _driverClip, _passengers, _targetPoint, _lastDriverPos, _currentDriverPos;
        function TrainMovement (driverId, driverClip) {
            requestMovePlayer = new org.osflash.signals.Signal(Number, Number, Number);
            requestChangePlayerFrame = new org.osflash.signals.Signal(Number, Number);
            _driverId = driverId;
            _driverClip = driverClip;
            _passengers = new Array();
            _targetPoint = new flash.geom.Point(driverClip._x, driverClip._y);
            _lastDriverPos = new flash.geom.Point(driverClip._x, driverClip._y);
            _currentDriverPos = new flash.geom.Point(_driverClip._x, driverClip._y);
        }
        function addPassenger(slotIndex, passengerId, passengerClip) {
            trace(((("HSF TrainMovement.addPassenger(" + slotIndex) + ", ") + passengerClip) + ")");
            slotIndex = _passengers.length;
            if (_passengers[slotIndex] == undefined) {
                trace(("HSF _passengers[" + slotIndex) + "] did not exist yet");
                _passengers[slotIndex] = new Object();
            }
            _passengers[slotIndex].clip = passengerClip;
            _passengers[slotIndex].id = passengerId;
            onPassengerAdded(slotIndex, passengerId, passengerClip);
            trace("HSF _passengers = " + _passengers);
        }
        function removePassenger(slotIndex) {
            trace(("HSF TrainMovement.removePassenger(" + slotIndex) + ")");
            if (_passengers[slotIndex] != undefined) {
                trace(("HSF _passengers[" + slotIndex) + "] does exists");
                onPassengerRemoved(slotIndex, _passengers[slotIndex].id, _passengers[slotIndex].clip);
                _passengers.splice(slotIndex, 1);
                trace("HSF _passengers = " + _passengers);
            }
        }
        function changeTargetPosition(x, y) {
            _targetPoint.x = x;
            _targetPoint.y = y;
            onTargetPositionChanged();
        }
        function update() {
            _currentDriverPos.x = _driverClip._x;
            _currentDriverPos.y = _driverClip._y;
            this.onUpdate();
            _lastDriverPos.x = _driverClip._x;
            _lastDriverPos.y = _driverClip._y;
        }
        function onTargetPositionChanged() {
        }
        function onPassengerAdded(slotIndex, passengerId, passengerClip) {
        }
        function onPassengerRemoved(slotIndex, passengerId, passengerClip) {
        }
        function onUpdate() {
        }
        static var DISTANCE_BETWEEN_CARTS = 46;
        static var PASSENGER_OFFSET = 15;
    }
