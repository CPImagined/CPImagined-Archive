class com.clubpenguin.engine.RoomPin
{
    var _shell, _engine, _interface, _roomObject, _pinClip;
    function RoomPin(shell, engine, interfacer)
    {
        _shell = shell;
        _engine = engine;
        _interface = interfacer;
        this.init();
    } // End of the function
    function destroy()
    {
        _shell.removeListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onRoomDestroyed));
        this.destroyPinClip();
    } // End of the function
    function setupPin()
    {
        _roomObject = _shell.getRoomObject();
        if (_roomObject != undefined && _roomObject != null)
        {
            if (_roomObject.pin_id != undefined && _roomObject.pin_id != null && _roomObject.pin_x != undefined && _roomObject.pin_x != null && _roomObject.pin_y != undefined && _roomObject.pin_y != null)
            {
                var _loc3 = _engine.getRoomMovieClip();
                var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                var _loc4 = _shell.getPath("room_pin") + _roomObject.pin_id + ".swf";
                _pinClip = _loc3.createEmptyMovieClip("pinClip", _loc3.getNextHighestDepth());
                _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onRoomPinLoadError));
                _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onRoomPinLoadInit));
                _loc2.loadClip(_loc4, _pinClip, "RoomPin setupPinForCurrentRoom");
            } // end if
        } // end if
    } // End of the function
    function init()
    {
        _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onRoomDestroyed));
    } // End of the function
    function onRoomDestroyed()
    {
        this.destroyPinClip();
    } // End of the function
    function destroyPinClip()
    {
        if (_pinClip != undefined)
        {
            _pinClip.removeMovieClip();
        } // end if
    } // End of the function
    function onRoomPinLoadError(event)
    {
    } // End of the function
    function onRoomPinLoadInit(event)
    {
        _pinClip._x = _roomObject.pin_x;
        _pinClip._y = _roomObject.pin_y;
        _pinClip.onPress = com.clubpenguin.util.Delegate.create(this, onPinClicked);
    } // End of the function
    function onPinClicked()
    {
        _interface.buyInventory(_roomObject.pin_id);
    } // End of the function
} // End of Class
