//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Lounge extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _SHELL, _opcodeJournal, _INTERFACE, _ENGINE, _destroyDelegate;
        function Lounge (stageReference) {
            super(stageReference);
            _stage.start_x = 410;
            _stage.start_y = 290;
            localize([_stage.background_mc.bitmapBg.astroPoster, _stage.background_mc.bitmapBg.bitsPoster, _stage.background_mc.bitmapBg.thinPoster, _stage.background_mc.toybagstates_mc, _stage.toyMachine.stations_mc, _stage.santaGate]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.thinconsole_mc.thinice_btn, 208, 252), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.astroconsole_mc.astro_btn, 228, 231), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bitsconsole_mc.bitsBolts_btn, 200, 272), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.toroof_btn, 370, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.staffDoor.staffDoor_btn, 665, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.bakeryDoor, 725, 285), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool1, 123, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool2, 305, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool3, 500, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool4, 92, 405), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool5, 305, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool6, 510, 405)]);
            _stage.stool1.useHandCursor = false;
            _stage.stool2.useHandCursor = false;
            _stage.stool3.useHandCursor = false;
            _stage.stool4.useHandCursor = false;
            _stage.stool5.useHandCursor = false;
            _stage.stool6.useHandCursor = false;
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, danceExit);
            _stage.triggers_mc.roof_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, roofExit);
            _stage.triggers_mc.memberBakery.triggerFunction = com.clubpenguin.util.Delegate.create(this, memberBakeryExit);
            _stage.triggers_mc.freeBakery.triggerFunction = com.clubpenguin.util.Delegate.create(this, freeBakeryExit);
            _stage.triggers_mc.thinIce_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, thinIceGameLaunch);
            _stage.triggers_mc.astro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, astroGameLaunch);
            _stage.triggers_mc.bits_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, bitsGameLaunch);
            if (_SHELL == undefined) {
                init();
            }
        }
        function danceExit() {
            _SHELL.sendJoinRoom("dance", 615, 385);
        }
        function roofExit() {
            _SHELL.sendJoinRoom("party13", 370, 240);
        }
        function memberBakeryExit() {
            if (_SHELL.isMyPlayerMember()) {
                _SHELL.sendJoinRoom("party5", 160, 240);
            } else {
                _opcodeJournal.sendOpcodeHolidayWorkshopBakeryOops();
                _INTERFACE.showContent("oops_party2_room");
            }
        }
        function freeBakeryExit() {
            _SHELL.sendJoinRoom("party5", 160, 390);
        }
        function thinIceGameLaunch() {
            _ENGINE.sendJoinGame("thinice", true);
        }
        function astroGameLaunch() {
            _ENGINE.sendJoinGame("astro", true);
        }
        function bitsGameLaunch() {
            _ENGINE.sendJoinGame("bitsandbolts", true);
        }
        function init() {
            _opcodeJournal = new com.clubpenguin.world.rooms.common.OpcodeJournal();
            var _local_3 = _SHELL.getMyPlayerId();
            _opcodeJournal.init(_local_3);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.astroconsole_mc.astro_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, astroOver);
            _stage.astroconsole_mc.astro_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, astroOut);
            _stage.astroconsole_mc.astro_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, astroOut);
            _stage.bitsconsole_mc.bitsBolts_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, bitsOver);
            _stage.bitsconsole_mc.bitsBolts_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, bitsOut);
            _stage.bitsconsole_mc.bitsBolts_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, bitsOut);
            _stage.thinconsole_mc.thinice_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, thinOver);
            _stage.thinconsole_mc.thinice_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, thinOut);
            _stage.thinconsole_mc.thinice_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, thinOut);
            var _local_2 = _stage.background_mc.staffDoor;
            _local_2.staffDoor_btn.onRollOver = com.clubpenguin.util.Delegate.create(_local_2, gotoAndStop, "open");
            _local_2.staffDoor_btn.onRollOut = com.clubpenguin.util.Delegate.create(_local_2, gotoAndStop, "close");
            _local_2.staffDoor_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(_local_2, gotoAndStop, "close");
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function astroOver() {
            _stage.bigTV.gotoAndPlay("astroOn");
            _INTERFACE.showHint(_stage.bigTV, "astro_hint");
        }
        function astroOut() {
            _stage.bigTV.gotoAndPlay("astroOff");
            _INTERFACE.closeHint();
        }
        function bitsOver() {
            _stage.bigTV.gotoAndPlay("bitsBoltsOn");
            _INTERFACE.showHint(_stage.bigTV, "bitsandbolts");
        }
        function bitsOut() {
            _stage.bigTV.gotoAndPlay("bitsBoltsOff");
            _INTERFACE.closeHint();
        }
        function thinOver() {
            _stage.bigTV.gotoAndPlay("thinIceOn");
            _INTERFACE.showHint(_stage.bigTV, "thinice_hint");
        }
        function thinOut() {
            _stage.bigTV.gotoAndPlay("thinIceOff");
            _INTERFACE.closeHint();
        }
        var CLASS_NAME = "Lounge";
    }
