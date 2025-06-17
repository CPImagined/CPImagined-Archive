//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.CFCParty_ShellOverrides
    {
        var SHELL, AIRTOWER, INTERFACE, ENGINE, PARTY, defaultSendJoinRoom, defaultSendJoinRoomFromMap;
        function CFCParty_ShellOverrides () {
        }
        function init() {
            SHELL = _global.getCurrentShell();
            AIRTOWER = _global.getCurrentAirtower();
            INTERFACE = _global.getCurrentInterface();
            ENGINE = _global.getCurrentEngine();
            PARTY = _global.getCurrentParty();
            defaultSendJoinRoom = SHELL.sendJoinRoom;
            defaultSendJoinRoomFromMap = SHELL.sendJoinRoomFromMap;
        }
        function sendJoinRoomFromMap(room_name, xpos, ypos, categoryId, mapId, triggerId) {
            trace("CFCParty_ShellOverrides SHELL.room.as sendJoinRoomFromMap()");
            var _local_3 = getTimer();
            trace("SHELL.getIsGameQueWidgetOpen " + SHELL.getIsGameQueWidgetOpen);
            trace("ENGINE.__cardJitsuWidget " + ENGINE.getCardJitsuGameQueWidget());
            if (SHELL.getIsGameQueWidgetOpen() == true) {
                SHELL.setJoinGameFromIgloo(false, "");
                ENGINE.getCardJitsuGameQueWidget().cleanUp();
            }
            var _local_2 = SHELL.getRoomCrumbsByName(room_name);
            if (SHELL.getCurrentRoomId() == _local_2.room_id) {
                SHELL.resetTriggerHideCount();
                SHELL.sendMapAction(categoryId, mapId, triggerId, true);
                SHELL.currentRoomService.unpauseRoomView(false);
            } else {
                SHELL.sendJoinRoom(room_name, xpos, ypos, _local_3, true);
            }
            SHELL._categoryId = categoryId;
            SHELL._mapId = mapId;
            SHELL._triggerId = triggerId;
        }
        function sendJoinRoom(room_name, xpos, ypos, startTime, disbandTrain) {
            trace("CFCParty_ShellOverrides SHELL.room.as sendJoinRoom()");
            var _local_3 = SHELL.getRoomCrumbsByName(room_name);
            if (SHELL.getCurrentRoomId() == _local_3.room_id) {
                trace("\t\tPlayer is already in the desired room");
                SHELL.currentRoomService.unpauseRoomView(false);
            } else {
                SHELL.currentRoomService.unpauseRoomView(true);
            }
            if (disbandTrain == null) {
                disbandTrain = false;
            }
            var _local_9 = _global.getCurrentRoom().trainManager;
            var _local_10 = SHELL.getMyPlayerId();
            var _local_12 = _local_9.isPlayerADriver(_local_10) && (_local_9.getPlayerTrain(_local_10) != null);
            SHELL.loadRoomStartTime = (startTime ? (startTime) : (getTimer()));
            trace((((("joing the room:  room_name: " + room_name) + " x: ") + xpos) + "  y: ") + ypos);
            if (SHELL.getIsGameQueWidgetOpen() == true) {
                ENGINE.__cardJitsuWidget.cleanUp();
            }
            if (SHELL.getCurrentGameRoomId() == undefined) {
                if (room_name.indexOf("dojo") != -1) {
                    trace("\t\t-entering dojo");
                    if (((((!SHELL.isItemInMyInventory(SHELL.AMULET_ITEM_ID)) || (!SHELL.isItemInMyInventory(SHELL.STARTER_DECK_ITEM_ID))) || (!SHELL.isItemInMyInventory(SHELL.FIRE_DECK_ITEM_ID))) || (!SHELL.isItemInMyInventory(SHELL.WATER_DECK_ITEM_ID))) || (!SHELL.isItemInMyInventory(SHELL.SNOW_DECK_ITEM_ID))) {
                        trace("\t\t\t-Missing card deck or amulet: Setting room to Dojo Exterior Solo");
                        room_name = SHELL.DOJO_EXT_SOLO_ROOM_NAME;
                        xpos = SHELL.DOJO_EXT_SOLO_START_X;
                        ypos = SHELL.DOJO_EXT_SOLO_START_Y;
                        disbandTrain = true;
                    }
                    SHELL.isDojo = true;
                }
                var _local_15 = room_name.indexOf("party") == 0;
                _local_3 = SHELL.getRoomCrumbsByName(room_name);
                if (_local_3.is_member && (!SHELL.isMyPlayerMember())) {
                    trace("ROOM KEY " + _local_3.room_key);
                    var _local_11 = _global.getCurrentInterface();
                    _local_11.showContent(("oops_" + _local_3.room_key) + "_room", null, null, {oopsTag:_local_3.room_key + "_room"});
                    return(undefined);
                } else if (_local_3.is_member && (SHELL.isMyPlayerMember())) {
                    SHELL.updateListeners(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, new com.clubpenguin.shell.events.MembershipEvent(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, "joinedMemberOnlyRoom", room_name));
                }
                if (SHELL.getCurrentRoomId() != _local_3.room_id) {
                    if (_local_3 != undefined) {
                        if (SHELL.getCurrentRoomId() > SHELL.PLAYER_ROOM_SMART_ID_CUTOFF) {
                            SHELL.getGlobalIgloo().destroy();
                        }
                        var _local_7 = SHELL.getMyPlayerObject();
                        SHELL.last_known_xpos = _local_7.x;
                        SHELL.last_known_ypos = _local_7.y;
                        if (isNaN(xpos)) {
                            xpos = 0;
                        }
                        if (isNaN(ypos)) {
                            ypos = 0;
                        }
                        _local_7.x = xpos;
                        _local_7.y = ypos;
                        SHELL.showLoading();
                        SHELL._categoryId = null;
                        SHELL._mapId = null;
                        SHELL._triggerId = null;
                        SHELL.clearTriggers();
                        SHELL.sendMapTracking(room_name);
                        SHELL.sendAS3LeavingRoom();
                        ENGINE.avatarManager.delayTransformations();
                        if (_local_12) {
                            com.clubpenguin.world.rooms2013.cfc.CFCParty.sendTrainJoinRoom(room_name, xpos, ypos, disbandTrain);
                        } else {
                            AIRTOWER.send(AIRTOWER.PLAY_EXT, (AIRTOWER.NAVIGATION + "#") + AIRTOWER.JOIN_ROOM, [_local_3.room_id, xpos, ypos], "str", SHELL.getCurrentServerRoomId());
                        }
                    } else {
                        SHELL.$e("[shell] sendJoinRoom() -> Tried to join a room which did not exist in crumbs. room_name: " + room_name);
                    }
                } else {
                    SHELL.$e("[shell] sendJoinRoom() -> Tried to join a room which your already in!: room_id: " + _local_3.room_id);
                }
            } else {
                SHELL.$e("[shell] sendJoinRoom() -> Tried to join a room while in a game room!", {error_code:SHELL.PLAYER_IN_ROOM});
            }
        }
        static var CLASS_NAME = "CFCParty_ShellOverrides";
    }
