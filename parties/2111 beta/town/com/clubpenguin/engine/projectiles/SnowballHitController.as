class com.clubpenguin.engine.projectiles.SnowballHitController
{
    var _SHELL, _INTERFACE, _hitSnowballs, _activeRoomId, _joinRoomDelegate, _playerMoveDelegate, _playerTransformDelegate, _playerRemovedDelegate, __get__hitSnowballCount;
    function SnowballHitController(shell, _interface)
    {
        _SHELL = shell;
        _INTERFACE = _interface;
        _hitSnowballs = {};
        _activeRoomId = -1;
        _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom);
        _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMove);
        _playerTransformDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerTransform);
        _playerRemovedDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerRemoved);
        _SHELL.addListener(_SHELL.JOIN_ROOM, _joinRoomDelegate);
        _SHELL.addListener(_SHELL.PLAYER_MOVE, _playerMoveDelegate);
        _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _playerTransformDelegate);
        _SHELL.addListener(_SHELL.REMOVE_PLAYER, _playerRemovedDelegate);
    } // End of the function
    function playerSnowballHitCheck(snowballEvent, snowballHitCheck)
    {
        var _loc3 = snowballHitCheck.hitCheck(snowballEvent);
        if (_loc3 > 0)
        {
            snowballEvent.hit_player_id = _loc3;
            _hitSnowballs[snowballEvent.id] = snowballEvent;
            if (_SHELL.isMyPlayer(snowballEvent.hit_player_id))
            {
                _INTERFACE.stopQuickKeys();
            } // end if
            _SHELL.updateListeners(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, snowballEvent);
        } // end if
    } // End of the function
    function handleJoinRoom()
    {
        if (_activeRoomId != _SHELL.getCurrentRoomId())
        {
            _activeRoomId = _SHELL.getCurrentRoomId();
            _hitSnowballs = {};
        } // end if
    } // End of the function
    function handlePlayerRemoved(player_id)
    {
        this.handlePlayerMove(_SHELL.getPlayerObjectById(player_id));
    } // End of the function
    function handlePlayerTransform(eventData)
    {
        if (eventData.avatarId != 0)
        {
            this.handlePlayerMove(eventData.player);
        } // end if
    } // End of the function
    function handlePlayerMove(playerObj)
    {
        if (_SHELL.isMyPlayer(playerObj.player_id))
        {
            _INTERFACE.startQuickKeys();
        } // end if
        var _loc3 = [];
        for (var _loc5 in _hitSnowballs)
        {
            if (playerObj.player_id == _hitSnowballs[_loc5].hit_player_id)
            {
                _loc3.push(_loc5);
            } // end if
        } // end of for...in
        for (var _loc2 = _loc3.length - 1; _loc2 > -1; --_loc2)
        {
            _hitSnowballs[_loc3[_loc2]].snowballMC._visible = false;
            delete _hitSnowballs[_loc3[_loc2]];
        } // end of for
        _loc3 = null;
    } // End of the function
    function removeSnowball(snowballMC)
    {
        for (var _loc3 in _hitSnowballs)
        {
            var _loc2 = _hitSnowballs[_loc3];
            if (_loc2.snowballMC == snowballMC && _loc2.hit_player_id != undefined)
            {
                if (_SHELL.isMyPlayer(_loc2.hit_player_id))
                {
                    _INTERFACE.startQuickKeys();
                } // end if
                delete _hitSnowballs[_loc3];
                break;
            } // end if
        } // end of for...in
    } // End of the function
    function get hitSnowballCount()
    {
        return (_hitSnowballs.length);
    } // End of the function
} // End of Class
