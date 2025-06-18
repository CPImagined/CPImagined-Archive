//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.RoomPin
    {
        var _shell, _engine, _interface, _roomObject, _pinClip;
        function RoomPin (shell, engine, interfacer) {
            _shell = shell;
            _engine = engine;
            _interface = interfacer;
            init();
        }
        function destroy() {
            _shell.removeListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onRoomDestroyed));
            destroyPinClip();
        }
        function setupPin() {
            _roomObject = _shell.getRoomObject();
            if ((_roomObject != undefined) && (_roomObject != null)) {
                if ((((((_roomObject.pin_id != undefined) && (_roomObject.pin_id != null)) && (_roomObject.pin_x != undefined)) && (_roomObject.pin_x != null)) && (_roomObject.pin_y != undefined)) && (_roomObject.pin_y != null)) {
                    var _local_3 = _engine.getRoomMovieClip();
                    var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                    var _local_4 = (_shell.getPath("room_pin") + _roomObject.pin_id) + ".swf";
                    _pinClip = _local_3.createEmptyMovieClip("pinClip", _local_3.getNextHighestDepth());
                    _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onRoomPinLoadError));
                    _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onRoomPinLoadInit));
                    _local_2.loadClip(_local_4, _pinClip, "RoomPin setupPinForCurrentRoom");
                }
            }
        }
        function init() {
            _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onRoomDestroyed));
        }
        function onRoomDestroyed() {
            destroyPinClip();
        }
        function destroyPinClip() {
            if (_pinClip != undefined) {
                _pinClip.removeMovieClip();
            }
        }
        function onRoomPinLoadError(event) {
        }
        function onRoomPinLoadInit(event) {
            _pinClip._x = _roomObject.pin_x;
            _pinClip._y = _roomObject.pin_y;
            _pinClip.onPress = com.clubpenguin.util.Delegate.create(this, onPinClicked);
        }
        function onPinClicked() {
            _interface.buyInventory(_roomObject.pin_id);
        }
    }
