//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.Village extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, localize, _INTERFACE, setupNavigationButtons, _opcodeJournal, _ENGINE;
        function Village (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 320;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.tour_mc]);
            if (com.clubpenguin.world.rooms2012.medieval.MedievalParty.isGoodState()) {
                setToDragonDefeatedState();
            }
            if (com.clubpenguin.world.rooms2012.medieval.MedievalParty.canAccessMemberExperience()) {
                if (_INTERFACE.scavengerHunt.isItemFound(com.clubpenguin.world.rooms2012.medieval.MedievalParty.SCAVENGER_HUNT_ROCKS)) {
                    _stage.rubble_mc.gotoAndStop(2);
                    _stage.foreground_mc.sunbeam_mc.gotoAndStop(2);
                } else {
                    _stage.rubble_mc.rubble_btn.onRelease = com.clubpenguin.util.Delegate.create(this, pickUpScavengerHuntItem);
                }
            } else {
                _stage.rubble_mc.gotoAndStop(3);
                _stage.foreground_mc.sunbeam_mc.gotoAndStop(2);
            }
            _stage.tour_mc.tour_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onTourBoothClick);
            _stage.triggers_mc.mtn_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mtn", 564, 371);
            _stage.triggers_mc.lodge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lodge", 160, 320);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 460, 180);
            _stage.triggers_mc.sport_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, enterEPF);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lodge_btn, 480, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lobby_btn, 630, 295)]);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.medieval.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function enterEPF() {
            _INTERFACE.showContent("modernPopup_room");
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function onTourBoothClick() {
            if (_INTERFACE.isTourGuide()) {
                _INTERFACE.showContent("give_tour");
            } else {
                _INTERFACE.showContent("take_tour");
            }
        }
        function pickUpScavengerHuntItem() {
            if (!_INTERFACE.scavengerHunt.isItemFound(com.clubpenguin.world.rooms2012.medieval.MedievalParty.SCAVENGER_HUNT_ROCKS)) {
                if (com.clubpenguin.world.rooms2012.medieval.MedievalParty.playerHasNoScavengerHuntItems()) {
                    com.clubpenguin.world.rooms2012.medieval.MedievalParty.track("firstScavengerHuntItem");
                    _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.medieval.OpcodeJournal.MEMBER_START_QUEST);
                }
                _INTERFACE.scavengerHunt.itemFound(com.clubpenguin.world.rooms2012.medieval.MedievalParty.SCAVENGER_HUNT_ROCKS);
                _INTERFACE.showContent(com.clubpenguin.world.rooms2012.medieval.MedievalParty.CONTENT_SCAVENGER_HUNT);
                com.clubpenguin.world.rooms2012.medieval.MedievalParty.track("rocksScavengerHuntItem");
            }
            _stage.rubble_mc.gotoAndStop(2);
            _stage.foreground_mc.sunbeam_mc.gotoAndStop(2);
        }
        function setToDragonDefeatedState() {
            _stage.arch_mc.banner_mc.gotoAndStop(2);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Village";
    }
