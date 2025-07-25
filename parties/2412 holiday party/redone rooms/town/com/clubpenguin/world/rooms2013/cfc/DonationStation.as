﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.DonationStation extends MovieClip
    {
        var _INTERFACE, _ENGINE, _SHELL, triggerMC, enabled, useHandCursor, _navigationDelegate, cfc_button, handlePlayerMoveCompleteDelegate, _x, _y, _parent;
        function DonationStation () {
            super();
            _INTERFACE = _global.getCurrentInterface();
            _ENGINE = _global.getCurrentEngine();
            _SHELL = _global.getCurrentShell();
            triggerMC._visible = false;
            if (!com.clubpenguin.world.rooms2013.cfc.CFCParty.isActive) {
                enabled = false;
                useHandCursor = false;
                _INTERFACE.showContent("coins_for_change");
                return;
            }
            _navigationDelegate = com.clubpenguin.util.Delegate.create(this, navigationButtonHandler);
            cfc_button.onRelease = _navigationDelegate;
            handlePlayerMoveCompleteDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveComplete);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, handlePlayerMoveCompleteDelegate, this);
        }
        function handlePlayerMoveComplete(event) {
            if ((_SHELL.getMyPlayerId() != event.player_id) || (!triggerMC.hitTest(event.x, event.y))) {
                return(undefined);
            }
            _INTERFACE.showContent(com.clubpenguin.world.rooms2013.cfc.CFCPartyConstants.DONATION_UI_PATH);
        }
        function navigationButtonHandler() {
            var _local_4 = Math.round(_x + CFC_TRIGGER_X_OFFSET);
            var _local_3 = Math.round(_y);
            var _local_2 = new flash.geom.Point(_local_4, _local_3);
            _parent.localToGlobal(_local_2);
            _ENGINE.sendPlayerMove(_local_2.x, _local_2.y);
        }
        static var CFC_TRIGGER_X_OFFSET = 50;
    }
