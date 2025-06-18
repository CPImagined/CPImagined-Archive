dynamic class com.clubpenguin.world.rooms.aliens.AlienAbduction
{
    var _abductionComplete;
    var _engine;
    var _engineOverrides;
    var _penguin_mc;
    var _player_id;
    var _previousRoomId;
    var _roomMC;
    var _this;

    function AlienAbduction()
    {
        trace("AlienAbduction()");
        this._engine = _global.getCurrentEngine();
    }

    function activate_EngineOverrides()
    {
        trace("AlienAbduction.activateEngineOverrides()");
        this._engine.movePlayer = com.clubpenguin.util.Delegate.create(this._engine, this._engineOverrides.movePlayer);
        this._engine.sendPlayerMove = com.clubpenguin.util.Delegate.create(this._engine, this._engineOverrides.sendPlayerMove);
        this._engine.updatePlayerPosition = com.clubpenguin.util.Delegate.create(this._engine, this._engineOverrides.updatePlayerPosition);
        trace("AlienAbduction.activateEngineOverrides() - X : " + this._penguin_mc._x);
        trace("AlienAbduction.activateEngineOverrides() - Y : " + this._penguin_mc._y);
        if (_global.getCurrentShell().isMyPlayer(this._player_id)) 
        {
            this._engine.sendPlayerMove(this._penguin_mc._x, this._penguin_mc._y);
            this._engine.movePlayer(this._player_id, this._penguin_mc._x, this._penguin_mc._y);
        }
    }

    function deactivateEngineOverrides()
    {
        trace("AlienAbduction.deactivateEngineOverrides()");
        trace("AlienAbduction.deactivateEngineOverrides()***");
        this._engine.movePlayer = com.clubpenguin.util.Delegate.create(this._engine, this._engineOverrides.defaultMovePlayer);
        this._engine.sendPlayerMove = com.clubpenguin.util.Delegate.create(this._engine, this._engineOverrides.defaultSendPlayerMove);
        this._engine.updatePlayerPosition = com.clubpenguin.util.Delegate.create(this._engine, this._engineOverrides.defaultUpdatePlayerPosition);
    }

    function abductPlayer(player_id, roomMC, _this)
    {
        this._player_id = player_id;
        this._roomMC = roomMC;
        this._previousRoomId = _global.getCurrentShell().getCurrentRoomId();
        this._penguin_mc = this._engine.getPlayerMovieClip(this._player_id);
        this._this = _this;
        trace("AlienAbduction.abductPlayer() : " + player_id);
        this._engineOverrides = new com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides();
        this._engineOverrides.init(player_id);
        this.activate_EngineOverrides();
        this.startBeam();
    }

    function startBeam()
    {
        var __reg2 = this._penguin_mc._y / 2;
        this._roomMC.tractorBeam_mc.gotoAndPlay(2);
        com.greensock.TweenMax.to(this._penguin_mc, 3.46, {_y: __reg2, _rotation: -30, delay: 0.7, ease: com.greensock.easing.Sine.easeIn, onComplete: this.tween1Complete, onCompleteParams: [this._penguin_mc], onCompleteScope: this});
        setTimeout(com.clubpenguin.util.Delegate.create(this, this.changeColor), 300);
        this._abductionComplete = setTimeout(com.clubpenguin.util.Delegate.create(this, this.abductionViewingComplete), 4000);
    }

    function tween1Complete(player)
    {
        trace("AlienAbduction - TWEEN 1 COMPLETE - player : " + player);
        com.greensock.TweenMax.to(player, 0.5, {_y: -50, _rotation: -30, delay: 0, ease: com.greensock.easing.Back.easeIn, onComplete: this.tween2Complete, onCompleteScope: this});
    }

    function tween2Complete()
    {
        trace("AlienAbduction - TWEEN 2 COMPLETE- SEND JOIN ROOM");
        trace("_roomMC : " + this._roomMC);
        trace("_this : " + this._this);
        this.deactivateEngineOverrides();
        this._this.abductedPlayerGoToUFO(this._player_id);
    }

    function changeColor()
    {
        var __reg3 = new flash.geom.ColorTransform(1, 1, 1, 1, 0, 55, 0, 0);
        var __reg2 = new flash.geom.Transform(this._penguin_mc);
        __reg2.colorTransform = __reg3;
    }

    function abductionViewingComplete()
    {
        trace("AlienAbduction - abductionViewingComplete()");
        this.deactivateEngineOverrides();
    }

    function clean()
    {
        trace("AlienAbduction - clean()");
        clearTimeout(this._abductionComplete);
    }

}
