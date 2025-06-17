//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.trickortreating.TrickOrTreatPumpkin extends MovieClip
    {
        var _SHELL, _ENGINE, pumpkin_mc, _pumpkinNavigationDelegate, handlePlayerMoveCompleteDelegate, handleRoomDestroyedDelegate, _cleanPumpkinDelegate, pumpkinTrigger_mc, _updateThisPumpkinStateDelegate, _name, _pumpkinID, _currentframe, _pumpkinUpdateInterval, removeMovieClip, tongue_mc, _x, _y, _parent;
        function TrickOrTreatPumpkin () {
            super();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            if (!com.clubpenguin.world.rooms2013.halloween.HalloweenParty.instance.isActive) {
                pumpkin_mc.enabled = false;
                pumpkin_mc.pumpkin_btn.enabled = false;
                pumpkin_mc.useHandCursor = false;
                return;
            }
            setPumpkinName();
            _pumpkinNavigationDelegate = com.clubpenguin.util.Delegate.create(this, navigationButtonHandler);
            handlePlayerMoveCompleteDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveComplete);
            handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
            _cleanPumpkinDelegate = com.clubpenguin.util.Delegate.create(this, cleanPumpkin);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, handlePlayerMoveCompleteDelegate, this);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate, this);
            pumpkinTrigger_mc._visible = 0;
            _updateThisPumpkinStateDelegate = com.clubpenguin.util.Delegate.create(this, updatePumpkin);
            com.clubpenguin.world.rooms2013.halloween.HalloweenParty_TrickOrTreating.instance.pumpkinGameCompleteSignal.add(_updateThisPumpkinStateDelegate);
            init();
        }
        function init() {
            updatePumpkin();
            setupNavigationButton();
            startUpdatePumpkinLoop();
        }
        function setPumpkinName() {
            var _local_2 = _name;
            var _local_3 = _SHELL.getRoomObject().room_id;
            _pumpkinID = ((_local_2 == undefined) ? (_SHELL.getRoomObject().room_id) : (_local_2.substr(_local_2.lastIndexOf("_") + 1)));
        }
        function handlePlayerMoveComplete(event) {
            if ((_SHELL.getMyPlayerId() != event.player_id) || (!pumpkinTrigger_mc.hitTest(event.x, event.y))) {
                return(undefined);
            }
            if (_currentframe == ACTIVE_FRAME) {
                com.clubpenguin.world.rooms2013.halloween.HalloweenParty.instance.launchPumpkinMiniGame(_pumpkinID);
            } else {
                com.clubpenguin.world.rooms2013.halloween.HalloweenParty_TrickOrTreating.instance.showDeactivePumpkinPrompt();
            }
        }
        function updatePumpkin() {
            if ((_pumpkinID == undefined) || (_pumpkinUpdateInterval == undefined)) {
                this.removeMovieClip();
                return(undefined);
            }
            com.clubpenguin.world.rooms2013.halloween.HalloweenParty_TrickOrTreating.instance.updatePumpkinState([{mc:this, id:_pumpkinID, trigger:pumpkinTrigger_mc}]);
            setupNavigationButton();
        }
        function setupNavigationButton() {
            if ((_currentframe == 1) && (pumpkin_mc.pumpkin_btn.onRelease == undefined)) {
                pumpkin_mc.pumpkin_btn.onRelease = _pumpkinNavigationDelegate;
            } else if ((_currentframe == 2) && (pumpkin_mc.onRelease == undefined)) {
                pumpkin_mc.onRelease = _pumpkinNavigationDelegate;
                tongue_mc.onRelease = _pumpkinNavigationDelegate;
            }
        }
        function navigationButtonHandler() {
            var _local_4 = Math.round(_x);
            var _local_3 = Math.round(_y + PUMPKIN_TRIGGER_Y_OFFSET);
            var _local_2 = new flash.geom.Point(_local_4, _local_3);
            _parent.localToGlobal(_local_2);
            _ENGINE.sendPlayerMove(_local_2.x, _local_2.y);
        }
        function startUpdatePumpkinLoop() {
            if (_pumpkinUpdateInterval != undefined) {
                return(undefined);
            }
            var _local_2 = com.clubpenguin.util.Delegate.create(this, updatePumpkin);
            _pumpkinUpdateInterval = setInterval(_local_2, com.clubpenguin.world.rooms2013.halloween.HalloweenPartyConstants.PUMPKIN_UPDATE_INTERVAL);
        }
        function stopUpdatePumpkinLoop() {
            clearInterval(_pumpkinUpdateInterval);
            _pumpkinUpdateInterval = undefined;
        }
        function handleRoomDestroyed() {
            _cleanPumpkinDelegate();
        }
        function cleanPumpkin() {
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, handlePlayerMoveCompleteDelegate, this);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate, this);
            com.clubpenguin.world.rooms2013.halloween.HalloweenParty_TrickOrTreating.instance.resetTrickOrTreatPumpkin(_pumpkinID);
            stopUpdatePumpkinLoop();
            this.removeMovieClip();
        }
        static var ACTIVE_FRAME = 1;
        static var DEACTIVE_FRAME = 2;
        static var PUMPKIN_TRIGGER_Y_OFFSET = 45;
    }
