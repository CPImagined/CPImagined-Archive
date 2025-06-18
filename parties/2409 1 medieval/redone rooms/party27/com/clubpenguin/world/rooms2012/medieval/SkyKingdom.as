//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.SkyKingdom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _PARTY, _SHELL, localize, setupNavigationButtons, _triggerWatcher, _vipAreaTrigger, _forgeTrigger, _thunderThroneTrigger, _wingThroneTrigger, _roomUpdateInterval, _opcodeJournal, _INTERFACE, _ENGINE;
        function SkyKingdom (stageReference) {
            super(stageReference);
            _stage.start_x = 510;
            _stage.start_y = 325;
        }
        function init() {
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            if (_PARTY.getTaskComplete(7)) {
                setToDragonDefeatedState();
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.plaque_mc]);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 220, 330);
            _stage.triggers_mc.battlesite_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party26", 136, 278);
            _stage.triggers_mc.teleportup_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, checkVIPRequirements);
            _stage.triggers_mc.teleportdown_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, leaveVIPArea);
            _stage.triggers_mc.openGateTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, checkGateRequirements);
            _stage.door_mc.door2_mc.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, checkDragonBattleRoomRequirements);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.freestaff_btn, 525, 317)]);
            _stage.triggers_mc.freeitem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeMemberItem);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _vipAreaTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.vipMemberTrigger);
            _vipAreaTrigger.addClothingRequirement("hand", com.clubpenguin.world.rooms2012.medieval.MedievalParty.SKYWARD_STAFF_ID);
            _vipAreaTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerAddedToVIPArea));
            _vipAreaTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerRemovedFromVIPArea));
            _forgeTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.forge_mc);
            _forgeTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerAddedToForgeTrigger));
            _forgeTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerRemovedFromForgeTrigger));
            _thunderThroneTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.thunderThroneTrigger);
            _thunderThroneTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerAddedToThunderThroneTrigger));
            _wingThroneTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.wingtrigger_mc);
            _wingThroneTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerAddedToWingThroneTrigger));
            _wingThroneTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerRemovedFromWingThroneTrigger));
            _triggerWatcher.addTrigger(_vipAreaTrigger);
            _triggerWatcher.addTrigger(_forgeTrigger);
            _triggerWatcher.addTrigger(_thunderThroneTrigger);
            _triggerWatcher.addTrigger(_wingThroneTrigger);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 40);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.medieval.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function checkGateRequirements() {
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            if (_PARTY.getTaskComplete(7) || _PARTY.getTaskComplete(3)) {
                _stage.block_mc.gotoAndStop(2);
                _stage.door_mc.gotoAndStop(2);
                _SHELL.stampEarned(com.clubpenguin.world.rooms2012.medieval.MedievalParty.STAMP_ID_SOLVE_SCAVENGER_HUNT);
            } else {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2012.medieval.MedievalParty.CONTENT_SKY_KINGDOM_SCORN_BATTLE_GATE);
            }
        }
        function onPlayerAddedToThunderThroneTrigger() {
            if (_currentState < STATE_GREEN) {
                return(undefined);
            }
            _stage.thunderchair_mc.lightninganim_mc.lightning1_mc.gotoAndPlay(2);
            _stage.thunderchair_mc.lightninganim_mc.lightning2_mc.gotoAndPlay(2);
        }
        function leaveVIPArea() {
            _ENGINE.sendPlayerTeleportAndMove(374, 237, 406, 244);
        }
        function checkVIPRequirements() {
            if (_SHELL.getPlayerObjectById(_SHELL.getMyPlayerId()).hand == com.clubpenguin.world.rooms2012.medieval.MedievalParty.SKYWARD_STAFF_ID) {
                var _local_3 = 350 + Math.round((Math.random() * 100) - 50);
                var _local_2 = 125 + Math.round((Math.random() * 20) - 10);
                _ENGINE.sendPlayerTeleportAndMove(350, 125, _local_3, _local_2);
            } else {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2012.medieval.MedievalParty.CONTENT_NEED_STAFF);
            }
        }
        function onPlayerAddedToWingThroneTrigger() {
            if (_currentState < STATE_PURPLE) {
                return(undefined);
            }
            if (_wingThroneState == ACTIVATED) {
                _stage.thronewings_mc.gotoAndPlay("open");
                _wingThroneState = OPEN;
            }
        }
        function onPlayerRemovedFromWingThroneTrigger() {
            var _local_2 = _wingThroneTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STANDING).length == 0;
            if ((_wingThroneState == OPEN) && (_local_2)) {
                _stage.thronewings_mc.gotoAndPlay("close");
            }
            if (_currentState < STATE_PURPLE) {
                _wingThroneState = DEACTIVATED;
            } else {
                _wingThroneState = ACTIVATED;
            }
        }
        function onPlayerAddedToForgeTrigger(playerList) {
            if ((_stage.anvil_mc._currentframe == 1) && (_currentState >= STATE_YELLOW)) {
                _stage.anvil_mc.gotoAndPlay(2);
            }
        }
        function onPlayerRemovedFromForgeTrigger(playerList) {
            _stage.anvil_mc.gotoAndStop(1);
        }
        function onPlayerAddedToVIPArea(playerList) {
            changeState(_vipAreaTrigger.getPlayerCount());
        }
        function onPlayerRemovedFromVIPArea(playerList) {
            changeState(_vipAreaTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger.STANDING).length);
        }
        function changeState(newState) {
            if (newState > STATE_PURPLE) {
                newState = STATE_PURPLE;
            }
            _currentState = newState;
            switch (newState) {
                case STATE_NONE : 
                    if (_gazeboState != DEACTIVATED) {
                        _stage.gazebo_mc.gotoAndPlay("deactivate");
                    }
                    if (_forgeState != DEACTIVATED) {
                        _stage.forgetower_mc.gotoAndPlay("deactivate");
                    }
                    if (_thunderChairState != DEACTIVATED) {
                        _stage.thunderchair_mc.gotoAndPlay("deactivate");
                    }
                    if (_waterfallState != DEACTIVATED) {
                        _stage.watergate_mc.gotoAndStop("deactivate");
                    }
                    if ((_wingThroneState == ACTIVATED) || (_wingThroneState == OPEN)) {
                        _stage.thronewings_mc.gotoAndPlay("deactivate");
                    }
                    _stage.redmeter_mc.redgem_mc.gotoAndStop(1);
                    _stage.yellowmeter_mc.yellowgem_mc.gotoAndStop(1);
                    _stage.greenmeter_mc.greengem_mc.gotoAndStop(1);
                    _stage.bluemeter_mc.bluegem_mc.gotoAndStop(1);
                    _stage.purplemeter_mc.purplegem_mc.gotoAndStop(1);
                    _gazeboState = DEACTIVATED;
                    _forgeState = DEACTIVATED;
                    _thunderChairState = DEACTIVATED;
                    _waterfallState = DEACTIVATED;
                    _wingThroneState = DEACTIVATED;
                    break;
                case STATE_RED : 
                    if (_gazeboState != ACTIVATED) {
                        _stage.gazebo_mc.gotoAndPlay("activate");
                    }
                    _stage.redmeter_mc.redgem_mc.gotoAndStop(2);
                    if (_forgeState == ACTIVATED) {
                        _stage.forgetower_mc.gotoAndPlay("deactivate");
                    }
                    if (_thunderChairState == ACTIVATED) {
                        _stage.thunderchair_mc.gotoAndPlay("deactivate");
                    }
                    if (_waterfallState == ACTIVATED) {
                        _stage.watergate_mc.gotoAndStop("deactivate");
                    }
                    if ((_wingThroneState == ACTIVATED) || (_wingThroneState == OPEN)) {
                        _stage.thronewings_mc.gotoAndPlay("deactivate");
                    }
                    _gazeboState = ACTIVATED;
                    _forgeState = DEACTIVATED;
                    _thunderChairState = DEACTIVATED;
                    _waterfallState = DEACTIVATED;
                    _wingThroneState = DEACTIVATED;
                    break;
                case STATE_YELLOW : 
                    if (_gazeboState != ACTIVATED) {
                        _stage.gazebo_mc.gotoAndPlay("activate");
                    }
                    if (_forgeState != ACTIVATED) {
                        _stage.forgetower_mc.gotoAndPlay("activate");
                    }
                    if (_thunderChairState == ACTIVATED) {
                        _stage.thunderchair_mc.gotoAndPlay("deactivate");
                    }
                    if (_waterfallState == ACTIVATED) {
                        _stage.watergate_mc.gotoAndStop("deactivate");
                    }
                    if ((_wingThroneState == ACTIVATED) || (_wingThroneState == OPEN)) {
                        _stage.thronewings_mc.gotoAndPlay("deactivate");
                    }
                    _stage.redmeter_mc.redgem_mc.gotoAndStop(2);
                    _stage.yellowmeter_mc.yellowgem_mc.gotoAndStop(2);
                    _gazeboState = ACTIVATED;
                    _forgeState = ACTIVATED;
                    _thunderChairState = DEACTIVATED;
                    _waterfallState = DEACTIVATED;
                    _wingThroneState = DEACTIVATED;
                    break;
                case STATE_GREEN : 
                    if (_gazeboState != ACTIVATED) {
                        _stage.gazebo_mc.gotoAndPlay("activate");
                    }
                    if (_forgeState != ACTIVATED) {
                        _stage.forgetower_mc.gotoAndPlay("activate");
                    }
                    if (_thunderChairState != ACTIVATED) {
                        _stage.thunderchair_mc.gotoAndPlay("activate");
                    }
                    if (_waterfallState == ACTIVATED) {
                        _stage.watergate_mc.gotoAndStop("deactivate");
                    }
                    if ((_wingThroneState == ACTIVATED) || (_wingThroneState == OPEN)) {
                        _stage.thronewings_mc.gotoAndPlay("deactivate");
                    }
                    _stage.redmeter_mc.redgem_mc.gotoAndStop(2);
                    _stage.yellowmeter_mc.yellowgem_mc.gotoAndStop(2);
                    _stage.greenmeter_mc.greengem_mc.gotoAndStop(2);
                    _gazeboState = ACTIVATED;
                    _forgeState = ACTIVATED;
                    _thunderChairState = ACTIVATED;
                    _waterfallState = DEACTIVATED;
                    _wingThroneState = DEACTIVATED;
                    break;
                case STATE_BLUE : 
                    if (_gazeboState != ACTIVATED) {
                        _stage.gazebo_mc.gotoAndPlay("activate");
                    }
                    if (_forgeState != ACTIVATED) {
                        _stage.forgetower_mc.gotoAndPlay("activate");
                    }
                    if (_thunderChairState != ACTIVATED) {
                        _stage.thunderchair_mc.gotoAndPlay("activate");
                    }
                    if (_waterfallState != ACTIVATED) {
                        _stage.watergate_mc.gotoAndPlay("activate");
                    }
                    if ((_wingThroneState == ACTIVATED) || (_wingThroneState == OPEN)) {
                        _stage.thronewings_mc.gotoAndPlay("deactivate");
                    }
                    _stage.redmeter_mc.redgem_mc.gotoAndStop(2);
                    _stage.yellowmeter_mc.yellowgem_mc.gotoAndStop(2);
                    _stage.greenmeter_mc.greengem_mc.gotoAndStop(2);
                    _stage.bluemeter_mc.bluegem_mc.gotoAndStop(2);
                    _gazeboState = ACTIVATED;
                    _forgeState = ACTIVATED;
                    _thunderChairState = ACTIVATED;
                    _waterfallState = ACTIVATED;
                    _wingThroneState = DEACTIVATED;
                    break;
                case STATE_PURPLE : 
                    if (_gazeboState != ACTIVATED) {
                        _stage.gazebo_mc.gotoAndPlay("activate");
                    }
                    if (_forgeState != ACTIVATED) {
                        _stage.forgetower_mc.gotoAndPlay("activate");
                    }
                    if (_thunderChairState != ACTIVATED) {
                        _stage.thunderchair_mc.gotoAndPlay("activate");
                    }
                    if (_waterfallState != ACTIVATED) {
                        _stage.watergate_mc.gotoAndPlay("activate");
                    }
                    if ((_wingThroneState != ACTIVATED) && (_wingThroneState != OPEN)) {
                        _stage.thronewings_mc.gotoAndPlay("activate");
                    }
                    _stage.redmeter_mc.redgem_mc.gotoAndStop(2);
                    _stage.yellowmeter_mc.yellowgem_mc.gotoAndStop(2);
                    _stage.greenmeter_mc.greengem_mc.gotoAndStop(2);
                    _stage.bluemeter_mc.bluegem_mc.gotoAndStop(2);
                    _stage.purplemeter_mc.purplegem_mc.gotoAndStop(2);
                    _gazeboState = ACTIVATED;
                    _forgeState = ACTIVATED;
                    _thunderChairState = ACTIVATED;
                    _waterfallState = ACTIVATED;
                    _wingThroneState = ACTIVATED;
                    break;
            }
        }
        function checkDragonBattleRoomRequirements() {
            if (com.clubpenguin.world.rooms2012.medieval.MedievalParty.canAccessMemberExperience() && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.medieval.MedievalParty.SCORN_CROWN_PIN_ID) || ((_INTERFACE.scavengerHunt.isItemFound(0) && (_INTERFACE.scavengerHunt.isItemFound(1))) && (_INTERFACE.scavengerHunt.isItemFound(2))))) {
                _ENGINE.sendPlayerMove(646, 365);
            } else {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2012.medieval.MedievalParty.CONTENT_SKY_KINGDOM_SCORN_BATTLE_GATE);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function getFreeMemberItem() {
            if (!_SHELL.isMyPlayerMember()) {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2012.medieval.MedievalParty.OOPS_SKY_KINGDOM_STAFF);
                return(undefined);
            }
            _INTERFACE.buyInventory(com.clubpenguin.world.rooms2012.medieval.MedievalParty.SKYWARD_STAFF_ID);
        }
        function setToDragonDefeatedState() {
            _stage.banner01.gotoAndStop(2);
            _stage.banner02.gotoAndStop(2);
            _stage.banner03.gotoAndStop(2);
            _stage.banner04.gotoAndStop(2);
            _stage.banner05.gotoAndStop(2);
            _stage.foreground_mc.banner06.gotoAndStop(2);
            _stage.foreground_mc.dragon01.gotoAndStop(2);
            _stage.dragon02.gotoAndStop(2);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "SkyKingdom";
        static var STATE_NONE = 0;
        static var STATE_RED = 1;
        static var STATE_YELLOW = 2;
        static var STATE_GREEN = 3;
        static var STATE_BLUE = 4;
        static var STATE_PURPLE = 5;
        static var ACTIVATED = "activated";
        static var DEACTIVATED = "deactivated";
        static var OPEN = "open";
        var _gazeboState = "deactivated";
        var _forgeState = "deactivated";
        var _thunderChairState = "deactivated";
        var _waterfallState = "deactivated";
        var _wingThroneState = "deactivated";
        var _currentState = 0;
    }
