//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.EmptyRoom2 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval, _INTERFACE;
        function EmptyRoom2 (stageReference) {
            super(stageReference);
            _stage.start_x = 140;
            _stage.start_y = 270;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.elevator_btn, 60, 235)]);
            _stage.background_mc.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevatorRollOver);
            _stage.background_mc.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.background_mc.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureSuitcases();
        }
        function configureSuitcases() {
            _stage.luggage_4.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "hotelLuggage4");
			_stage.luggage_5.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "hotelLuggage5");
			_stage.luggage_6.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "hotelLuggage6");
			_stage.luggage_7.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "hotelLuggage7");
        }
        function openQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.CONSTANTS.QUEST_UI_PATH);
        }
        function elevatorRollOver() {
            _stage.background_mc.elevator_mc.door_mc.gotoAndPlay("open");
            _stage.background_mc.elevator_mc.interior_mc.gotoAndPlay("open");
        }
        function elevatorRollOut() {
            _stage.background_mc.elevator_mc.door_mc.gotoAndPlay("close");
            _stage.background_mc.elevator_mc.interior_mc.gotoAndPlay("close");
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.CONSTANTS.ELEVATOR_UI_PATH);
        }
		function showContent(contentID, data) {
            _INTERFACE.showContent(contentID, null, null, data, null);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.clean();
        }
        static var CLASS_NAME = "EmptyRoom2";
    }
