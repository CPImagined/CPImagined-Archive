//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.BoxDimension extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _opcodeJournal, _currentPlayerID, _SHELL, _INTERFACE, _destroyDelegate;
        function BoxDimension (stageReference) {
            super(stageReference);
            _stage.start_x = 575;
            _stage.start_y = 145;
            localize([_stage.background_mc.floatc_mc.floatc01_mc, _stage.background_mc.platform01_mc.platform01words_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.world.portal_btn, 600, 125), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.desert.portal, 300, 110), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.escher.portal, 235, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.space.portal, 155, 180), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.icecream.portal, 85, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.soda.portal, 550, 390), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.silly.portal, 620, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.doodle.portal, 700, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.lost.portal, 480, 423), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.orange.portal, 125, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.platform01_mc.floorWalk.centerBox.middleBoxButton, 367, 315)]);
            _stage.triggers_mc.portal_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showMap);
            _stage.triggers_mc.desert.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 115, 290);
            _stage.triggers_mc.escher.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 375, 250);
            _stage.triggers_mc.space.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 480, 360);
            _stage.triggers_mc.candy.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 615, 355);
            _stage.triggers_mc.soda.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 240, 420);
            _stage.triggers_mc.silly.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 217, 370);
            _stage.triggers_mc.doodle.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 265, 300);
            _stage.triggers_mc.lost.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 720, 230);
            _stage.triggers_mc.orange.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 425, 360);
            _stage.triggers_mc.funhouse.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party9", 720, 230);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.aprilfools.OpcodeJournal();
            _currentPlayerID = _SHELL.getMyPlayerId();
        }
        function showMap() {
            _INTERFACE.showContent("map", null, null, null, true);
        }
        function exit(roomName, x, y) {
            if (roomName == "party9") {
                if (_SHELL.isMyPlayerMember()) {
                    _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.aprilfools.OpcodeJournal.MEMBER_ZANY_ENTER);
                } else {
                    _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.aprilfools.OpcodeJournal.NON_MEMBER_ZANY_OOPS);
                    _INTERFACE.showContent("oops_party9_room");
                    return(undefined);
                }
            }
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function init() {
            _opcodeJournal.init(_currentPlayerID);
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.aprilfools.OpcodeJournal.ENTER_BOX_DIMENSION);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function handleUpdatePlayer(event) {
        }
        function playElevator() {
            isElevatorShowing = true;
            _stage.sortingBoxBack.play();
            _stage.sortingBoxSide.play();
            _stage.background_mc.platform01_mc.floorWalk.centerBox.play();
        }
        static var CLASS_NAME = "BoxDimension";
        var isElevatorShowing = false;
        var isArmUp = false;
    }
