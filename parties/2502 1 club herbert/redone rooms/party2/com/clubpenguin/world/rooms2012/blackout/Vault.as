//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.Vault extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _playerUpdateDelegate, setupNavigationButtons, _INTERFACE;
        function Vault (stageReference) {
            super(stageReference);
            _stage.start_x = 390;
            _stage.start_y = 395;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _playerUpdateDelegate = com.clubpenguin.util.Delegate.create(this, checkForLavaBoots);
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _stage.triggers_mc.trigSecuritydoor_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitToChallenge1);
            _stage.triggers_mc.trigChallengeroom1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 680, 270);
            _stage.triggers_mc.trigParadise_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 555, 290);
            _stage.triggers_mc.trigTunnel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 160, 180);
            _stage.triggers_mc.trigVent2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, party5Vent);
            _stage.triggers_mc.trigLair_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 395, 395);
            _stage.triggers_mc.trigVent1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 670, 385);
            setRoomState();
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exitChallengeroom1_btn, 115, 90), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exitLairvent_btn, 560, 50), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.securityDoor.exitSecuritydoor_btn, 108, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.escapeVent.exitChallengeroom2_btn, 695, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exitTunnel_btn, 608, 403), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exitParadise_btn, 90, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.vaultContainer.vaultOpening.vaultOpen_btn, 440, 285)]);
        }
        function exitToChallenge1() {
            if (((com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1) || (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.CRAB_COSTUME_ID))) || (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.HERBERT_COSTUME_ID))) && (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeUnlocked(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1))) {
                exit("party1", 569, 90);
            } else {
                _INTERFACE.showContent("w.app.generic.partyinterface");
            }
        }
        function checkForLavaBoots() {
            if (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.LAVA_SHOES_ITEM_ID) || (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_6))) {
                _stage.block_mc.gotoAndStop(2);
                _stage.triggers_mc.trig_boots_mc.triggerFunction = null;
            } else {
                _stage.block_mc.gotoAndStop(1);
                _stage.triggers_mc.trig_boots_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showLairQuest);
            }
        }
        function showLairQuest() {
            _INTERFACE.showContent("w.app.generic.partyinterface");
        }
        function setRoomState() {
            var _local_3 = com.clubpenguin.world.rooms2012.blackout.Blackout.getJustCompletedChallenges();
            var _local_4 = {};
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _local_4[_local_3[_local_2]] = true;
                _local_2++;
            }
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_6)) {
                _stage.block_mc.gotoAndStop(2);
                _stage.background_mc.floorGrate.gotoAndStop(2);
                _stage.background_mc.vaultContainer.gotoAndStop(2);
                _stage.background_mc.escapeVent.gotoAndStop(2);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5)) {
                _stage.background_mc.vaultContainer.gotoAndStop(2);
                _stage.background_mc.floorGrate.gotoAndStop(1);
                _stage.background_mc.escapeVent.gotoAndStop(2);
            } else {
                _stage.background_mc.floorGrate.gotoAndStop(1);
                _stage.background_mc.escapeVent.gotoAndStop(1);
                _stage.background_mc.escapeVent.exitChallengeroom2_btn.useHandCursor = false;
                _local_2 = 1;
                while (_local_2 <= 4) {
                    if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout["CHALLENGE_" + _local_2])) {
                        if (_local_4[com.clubpenguin.world.rooms2012.blackout.Blackout["CHALLENGE_" + _local_2]]) {
                            _stage.background_mc.vaultContainer.vaultclosed_mc.vault_door_mc.door_frame_mc["light" + _local_2].gotoAndStop(2);
                            _stage.background_mc.vaultContainer.vaultclosed_mc.vault_door_mc.door_mc["lock" + _local_2].gotoAndPlay(2);
                        } else {
                            _stage.background_mc.vaultContainer.vaultclosed_mc.vault_door_mc.door_frame_mc["light" + _local_2].gotoAndStop(3);
                            _stage.background_mc.vaultContainer.vaultclosed_mc.vault_door_mc.door_mc["lock" + _local_2].gotoAndStop("open");
                        }
                    }
                    _local_2++;
                }
            }
            com.clubpenguin.world.rooms2012.blackout.Blackout.clearJustCompletedChallenges();
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1)) {
                _stage.background_mc.cameras_mc.gotoAndStop(2);
            }
            checkForLavaBoots();
        }
        function party5Vent() {
            if (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.SMOKE_GOGGLES_ITEM_ID) || (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5))) {
                exit("party5", 150, 350);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, _playerUpdateDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Vault";
    }
