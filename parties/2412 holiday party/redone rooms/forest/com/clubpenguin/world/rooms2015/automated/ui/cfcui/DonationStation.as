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
            _INTERFACE.showContent(_global.getCurrentParty().BaseParty.CURRENT_PARTY.CONSTANTS.CFC_UI_PATH);
        }
        function navigationButtonHandler() {
            var x = Math.round(_x + CFC_TRIGGER_X_OFFSET);
            var y = Math.round(_y);
            var pos = (new flash.geom.Point(x, y));
            _parent.localToGlobal(pos);
            _ENGINE.sendPlayerMove(pos.x, pos.y);
        }
        function cleanup() {
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _handlePlayerMoveCompleteDelegate, this);
            _handlePlayerMoveCompleteDelegate = null;
        }
        static var CFC_TRIGGER_X_OFFSET = 50;
    }
