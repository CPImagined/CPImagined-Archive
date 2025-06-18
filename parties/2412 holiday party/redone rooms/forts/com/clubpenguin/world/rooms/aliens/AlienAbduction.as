//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.aliens.AlienAbduction
    {
        var _engine, _engineOverrides, _penguin_mc, _player_id, _roomMC, _previousRoomId, _this, _abductionComplete;
        function AlienAbduction () {
            trace("AlienAbduction()");
            _engine = _global.getCurrentEngine();
        }
        function activate_EngineOverrides() {
            trace("AlienAbduction.activateEngineOverrides()");
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.movePlayer);
            _engine.sendPlayerMove = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.sendPlayerMove);
            _engine.updatePlayerPosition = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.updatePlayerPosition);
            trace("AlienAbduction.activateEngineOverrides() - X : " + _penguin_mc._x);
            trace("AlienAbduction.activateEngineOverrides() - Y : " + _penguin_mc._y);
            if (_global.getCurrentShell().isMyPlayer(_player_id)) {
                _engine.sendPlayerMove(_penguin_mc._x, _penguin_mc._y);
                _engine.movePlayer(_player_id, _penguin_mc._x, _penguin_mc._y);
            }
        }
        function deactivateEngineOverrides() {
            trace("AlienAbduction.deactivateEngineOverrides()");
            trace("AlienAbduction.deactivateEngineOverrides()***");
            _engine.movePlayer = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.defaultMovePlayer);
            _engine.sendPlayerMove = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.defaultSendPlayerMove);
            _engine.updatePlayerPosition = com.clubpenguin.util.Delegate.create(_engine, _engineOverrides.defaultUpdatePlayerPosition);
        }
        function abductPlayer(player_id, roomMC, _this) {
            _player_id = player_id;
            _roomMC = roomMC;
            _previousRoomId = _global.getCurrentShell().getCurrentRoomId();
            _penguin_mc = _engine.getPlayerMovieClip(_player_id);
            this._this = _this;
            trace("AlienAbduction.abductPlayer() : " + player_id);
            _engineOverrides = new com.clubpenguin.world.rooms.aliens.AlienAbduction_EngineOverrides();
            _engineOverrides.init(player_id);
            activate_EngineOverrides();
            startBeam();
        }
        function startBeam() {
            var _local_2 = _penguin_mc._y / 2;
            _roomMC.tractorBeam_mc.gotoAndPlay(2);
            com.greensock.TweenMax.to(_penguin_mc, 3.46, {_y:_local_2, _rotation:-30, delay:0.7, ease:com.greensock.easing.Sine.easeIn, onComplete:tween1Complete, onCompleteParams:[_penguin_mc], onCompleteScope:this});
            setTimeout(com.clubpenguin.util.Delegate.create(this, changeColor), 300);
            _abductionComplete = setTimeout(com.clubpenguin.util.Delegate.create(this, abductionViewingComplete), 4000);
        }
        function tween1Complete(player) {
            trace("AlienAbduction - TWEEN 1 COMPLETE - player : " + player);
            com.greensock.TweenMax.to(player, 0.5, {_y:-50, _rotation:-30, delay:0, ease:com.greensock.easing.Back.easeIn, onComplete:tween2Complete, onCompleteScope:this});
        }
        function tween2Complete() {
            trace("AlienAbduction - TWEEN 2 COMPLETE- SEND JOIN ROOM");
            trace("_roomMC : " + _roomMC);
            trace("_this : " + _this);
            deactivateEngineOverrides();
            _this.abductedPlayerGoToUFO(_player_id);
        }
        function changeColor() {
            var _local_3 = new flash.geom.ColorTransform(1, 1, 1, 1, 0, 55, 0, 0);
            var _local_2 = new flash.geom.Transform(_penguin_mc);
            _local_2.colorTransform = _local_3;
        }
        function abductionViewingComplete() {
            trace("AlienAbduction - abductionViewingComplete()");
            deactivateEngineOverrides();
        }
        function clean() {
            trace("AlienAbduction - clean()");
            clearTimeout(_abductionComplete);
        }
    }
