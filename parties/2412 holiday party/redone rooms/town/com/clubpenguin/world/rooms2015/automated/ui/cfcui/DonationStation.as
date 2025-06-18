//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.ui.cfcui.DonationStation extends MovieClip
    {
        var _INTERFACE, _ENGINE, _SHELL, triggerMC, _navigationDelegate, cfc_button, _handlePlayerMoveCompleteDelegate, _x, _y, _parent;
        function DonationStation () {
            super();
            _INTERFACE = _global.getCurrentInterface();
            _ENGINE = _global.getCurrentEngine();
            _SHELL = _global.getCurrentShell();
            triggerMC._visible = false;
            _navigationDelegate = com.clubpenguin.util.Delegate.create(this, navigationButtonHandler);
            cfc_button.onRelease = _navigationDelegate;
            _handlePlayerMoveCompleteDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveComplete);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _handlePlayerMoveCompleteDelegate, this);
        }
        function handlePlayerMoveComplete(event) {
            if ((_SHELL.getMyPlayerId() != event.player_id) || (!triggerMC.hitTest(event.x, event.y))) {
                return(undefined);
            }
            _INTERFACE.showContent("w.p2015.holiday.cfcui");
        }
        function navigationButtonHandler() {
            var _local_6 = Math.round(_x + CFC_TRIGGER_X_OFFSET);
            var _local_5 = Math.round(_y);
            var _local_2 = new flash.geom.Point(_local_6, _local_5);
            _parent.localToGlobal(_local_2);
            var _local_4 = _SHELL.getMyPlayerId();
            var _local_3 = _ENGINE.getPlayerMovieClip(_local_4);
            if (triggerMC.hitTest(_local_3._x, _local_3._y, true)) {
                _INTERFACE.showContent("w.p2015.holiday.cfcui");
            } else {
                _ENGINE.sendPlayerMove(_local_2.x, _local_2.y);
            }
        }
        function cleanup() {
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _handlePlayerMoveCompleteDelegate, this);
            _handlePlayerMoveCompleteDelegate = null;
        }
        static var CFC_TRIGGER_X_OFFSET = 50;
    }
