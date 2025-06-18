//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.ui.cfcui.DonationStation extends MovieClip
    {
        var _INTERFACE, _ENGINE, _SHELL, triggerMC, _navigationDelegate, cfc_button, _handlePlayerMoveCompleteDelegate, _x, _y, _parent;
        function DonationStation () {
            super();
            trace("DonationStation() : ENTERING");
            _INTERFACE = _global.getCurrentInterface();
            _ENGINE = _global.getCurrentEngine();
            _SHELL = _global.getCurrentShell();
            trace("this[triggerMC] : " + triggerMC);
            triggerMC._visible = false;
            _navigationDelegate = com.clubpenguin.util.Delegate.create(this, navigationButtonHandler);
            cfc_button.onRelease = _navigationDelegate;
            _handlePlayerMoveCompleteDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveComplete);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _handlePlayerMoveCompleteDelegate, this);
        }
        function handlePlayerMoveComplete(event) {
            trace("DonationStation.handlePlayerMoveComplete()");
            if ((_SHELL.getMyPlayerId() != event.player_id) || (!triggerMC.hitTest(event.x, event.y))) {
                return(undefined);
            }
            _INTERFACE.showContent(_global.getCurrentParty().BaseParty.CURRENT_PARTY.CONSTANTS.CFC_UI_PATH);
        }
        function navigationButtonHandler() {
            var _local_4 = Math.round(_x + CFC_TRIGGER_X_OFFSET);
            var _local_3 = Math.round(_y);
            var _local_2 = new flash.geom.Point(_local_4, _local_3);
            _parent.localToGlobal(_local_2);
            _ENGINE.sendPlayerMove(_local_2.x, _local_2.y);
        }
        function cleanup() {
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _handlePlayerMoveCompleteDelegate, this);
            _handlePlayerMoveCompleteDelegate = null;
        }
        static var CFC_TRIGGER_X_OFFSET = 50;
    }
