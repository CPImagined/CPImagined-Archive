dynamic class com.clubpenguin.engine.projectiles.SnowballHitController
{
    var _INTERFACE;
    var _SHELL;
    var _activeRoomId;
    var _hitSnowballs;
    var _joinRoomDelegate;
    var _playerMoveDelegate;
    var _playerRemovedDelegate;
    var _playerTransformDelegate;

    function SnowballHitController(shell, _interface)
    {
        this._SHELL = shell;
        this._INTERFACE = _interface;
        this._hitSnowballs = {};
        this._activeRoomId = -1;
        this._joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, this.handleJoinRoom);
        this._playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, this.handlePlayerMove);
        this._playerTransformDelegate = com.clubpenguin.util.Delegate.create(this, this.handlePlayerTransform);
        this._playerRemovedDelegate = com.clubpenguin.util.Delegate.create(this, this.handlePlayerRemoved);
        this._SHELL.addListener(this._SHELL.JOIN_ROOM, this._joinRoomDelegate);
        this._SHELL.addListener(this._SHELL.PLAYER_MOVE, this._playerMoveDelegate);
        this._SHELL.addListener(this._SHELL.PLAYER_AVATAR_TRANSFORMED, this._playerTransformDelegate);
        this._SHELL.addListener(this._SHELL.REMOVE_PLAYER, this._playerRemovedDelegate);
    }

    function playerSnowballHitCheck(snowballEvent, snowballHitCheck)
    {
        var __reg3 = snowballHitCheck.hitCheck(snowballEvent);
        if (__reg3 > 0) 
        {
            snowballEvent.hit_player_id = __reg3;
            this._hitSnowballs[snowballEvent.id] = snowballEvent;
            if (this._SHELL.isMyPlayer(snowballEvent.hit_player_id)) 
            {
                this._INTERFACE.stopQuickKeys();
            }
            this._SHELL.updateListeners(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, snowballEvent);
        }
    }

    function handleJoinRoom()
    {
        if (this._activeRoomId != this._SHELL.getCurrentRoomId()) 
        {
            this._activeRoomId = this._SHELL.getCurrentRoomId();
            this._hitSnowballs = {};
        }
    }

    function handlePlayerRemoved(player_id)
    {
        this.handlePlayerMove(this._SHELL.getPlayerObjectById(player_id));
    }

    function handlePlayerTransform(eventData)
    {
        if (eventData.avatarId != 0) 
        {
            this.handlePlayerMove(eventData.player);
        }
    }

    function handlePlayerMove(playerObj)
    {
        if (this._SHELL.isMyPlayer(playerObj.player_id)) 
        {
            this._INTERFACE.startQuickKeys();
        }
        var __reg3 = [];
        for (var __reg5 in this._hitSnowballs) 
        {
            if (playerObj.player_id == this._hitSnowballs[__reg5].hit_player_id) 
            {
                __reg3.push(__reg5);
            }
        }
        var __reg2 = __reg3.length - 1;
        while (__reg2 > -1) 
        {
            this._hitSnowballs[__reg3[__reg2]].snowballMC._visible = false;
            delete this._hitSnowballs[__reg3[__reg2]];
            --__reg2;
        }
        __reg3 = null;
    }

    function removeSnowball(snowballMC)
    {
        for (var __reg4 in this._hitSnowballs) 
        {
            var __reg2 = this._hitSnowballs[__reg4];
            if (__reg2.snowballMC == snowballMC && __reg2.hit_player_id != undefined) 
            {
                if (this._SHELL.isMyPlayer(__reg2.hit_player_id)) 
                {
                    this._INTERFACE.startQuickKeys();
                }
                delete this._hitSnowballs[__reg4];
                break;
            }
        }
        do 
        {
        }
        while (undefined != null);
        do 
        {
        }
        while (undefined != null);
    }

    function get hitSnowballCount()
    {
        return this._hitSnowballs.length;
    }

}
