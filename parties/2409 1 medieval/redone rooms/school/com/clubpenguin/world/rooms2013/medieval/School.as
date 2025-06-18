//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.School extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval, _ENGINE, _INTERFACE;
        function School (stageReference) {
            super(stageReference);
            _stage.start_x = 564;
            _stage.start_y = 335;
            init();
        }
        function init() {
            checkRoomState();
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 444, 315);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 552, 253);
            _stage.triggers_mc.party2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 169, 419);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchPotionGame);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.doorR_mc.door1_btn, 732, 397), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.doorL_mc.door2_btn, 28, 397), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.tower_btn, 673, 185), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.steps_mc.game_btn, 566, 210)]);
            _stage.foreground_mc.locker1_btn.useHandCursor = false;
            _stage.foreground_mc.locker2_btn.useHandCursor = false;
            _stage.foreground_mc.locker3_btn.useHandCursor = false;
            _stage.foreground_mc.locker4_btn.useHandCursor = false;
            _stage.foreground_mc.locker5_btn.useHandCursor = false;
            _stage.foreground_mc.locker6_btn.useHandCursor = false;
            _stage.foreground_mc.locker7_btn.useHandCursor = false;
            _stage.foreground_mc.locker8_btn.useHandCursor = false;
            _stage.foreground_mc.locker9_btn.useHandCursor = false;
            _stage.foreground_mc.locker10_btn.useHandCursor = false;
            var _local_2 = 1;
            while (_local_2 <= 10) {
                var _local_4 = new com.clubpenguin.world.rooms.school.Locker(_stage.foreground_mc["lockermc_" + _local_2]);
                var _local_3 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc[("locker" + _local_2) + "_mc"]);
                _local_3.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _local_4));
                _local_3.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _local_3, _local_4));
                _triggerWatcher.addTrigger(_local_3);
                _local_2++;
            }
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.showPartyCatalogue);
        }
        function openLocker(players, locker) {
            if (players.length > 0) {
                locker.openLocker();
            }
        }
        function closeLocker(players, trigger, locker) {
            if (trigger.getPlayerCount() == 0) {
                locker.closeLocker();
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function checkRoomState() {
            if (_SHELL.getCurrentRoomId() == com.clubpenguin.world.rooms2013.medieval.MedievalParty.SOLO_ROOM_ID) {
                initiateSoloRoomFunctionality();
            } else {
                _stage.gary_MC._visible = false;
                _stage.triggers_mc.gary_mc._visible = false;
            }
        }
        function initiateSoloRoomFunctionality() {
            _stage.gary_MC.gotoAndStop("solo_active");
            _ENGINE.teleportPlayer(_SHELL.getMyPlayerId(), _stage.start_x, _stage.start_y);
            _stage.steps_mc.game_btn.enabled = false;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gary_MC.gary_btn, 560, 300)]);
            _stage.triggers_mc.gary_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSoloRoomCharacterDialogue);
        }
        function launchSoloRoomCharacterDialogue() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2013.medieval.MedievalParty.CHARACTER_DIALOGUE_PATH_SOLOROOM);
            _stage.gary_MC.gotoAndStop("solo");
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gary_MC, 560, 300)]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gary_MC.gary_btn, 560, 300)]);
        }
        function launchPotionGame() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2013.medieval.MedievalParty.SPELLBOOK_PATH);
        }
        static var CLASS_NAME = "School";
    }
