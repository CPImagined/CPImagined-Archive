//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.BigMommas extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _triggerWatcher, localize, _triggerWatcherInterval, _destroyDelegate, _onBuyInventoryDelegate, _playersOnStage, _stageBlockTrigger, _INTERFACE, setupNavigationButtons, _concert, _concertCountdownTimer, _ENGINE;
        function BigMommas (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 350;
            _stage.start_y = 275;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, catalogOpen);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _playersOnStage = new Array();
        }
		function catalogOpen() {
			_INTERFACE.showContent("party_catalogue");
		}
        function configureTriggers() {
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 410, 230);
            _stage.triggers_mc.backStage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, goBackStage);
        }
        function goBackStage() {
            trace(CLASS_NAME + "::goBackStage()");
            if (!_SHELL.isMyPlayerMember()) {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.OOPS_BACKSTAGE);
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal.BACK_STAGE_OOPS);
            } else {
                _SHELL.sendJoinRoom("party2", 300, 330);
            }
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.beach_btn, 370, 425), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.backStage_btn, 385, 140), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatA_btn, 207, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatB_btn, 194, 270), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatC_btn, 175, 310), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatD_btn, 190, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatE_btn, 290, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatF_btn, 270, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatG_btn, 370, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatH_btn, 700, 217), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatI_btn, 720, 306)]);
        }
        function startRoomMusic() {
            _SHELL.startRoomMusic();
        }
        function stopRoomMusic() {
            _SHELL.stopMusic();
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
		}
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _concert.destroy();
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "BigMommas";
    }
