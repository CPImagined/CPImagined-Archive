//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.AgentCommand extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _trackerAS2, _SHELL, _destroyDelegate, localize, setupNavigationButtons, _INTERFACE, _ENGINE;
        function AgentCommand (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 305;
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.background_mc.spyDrills_mc.spyDrillsScreen_mc, _stage.background_mc.sysDef_mc.sysDefScreen_mc, _stage.background_mc.tv_mc.tvScreen_mc, _stage.background_mc.epfBadge_mc, _stage.missions_mc.missionsScreen_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatMeeting01_btn, 307, 171), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatMeeting02_btn, 454, 171), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatMeeting03_btn, 296, 207), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatMeeting04_btn, 465, 207), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatMeeting05_btn, 285, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatMeeting06_btn, 476, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatPrison01_btn, 30, 316), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatPrison02_btn, 98, 286), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seatSecurity01_btn, 98, 423), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_mc.agentLobby_btn, 650, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.missions_btn, 675, 320)]);
            _stage.seatMeeting01_btn.useHandCursor = false;
            _stage.seatMeeting02_btn.useHandCursor = false;
            _stage.seatMeeting03_btn.useHandCursor = false;
            _stage.seatMeeting04_btn.useHandCursor = false;
            _stage.seatMeeting05_btn.useHandCursor = false;
            _stage.seatMeeting06_btn.useHandCursor = false;
            _stage.seatPrison01_btn.useHandCursor = false;
            _stage.seatPrison02_btn.useHandCursor = false;
            _stage.seatSecurity01_btn.useHandCursor = false;
            if (!_SHELL.isEPFAgent()) {
                _SHELL.getEPFService().setAgentStatus();
                _SHELL.sendEPFPhoneRequest();
                _INTERFACE.showContent("epfinitiated");
            }
            _stage.background_mc.exit_mc.agentLobby_btn.onRollOver = com.clubpenguin.util.Delegate.create(_stage.background_mc.exit_mc, _stage.background_mc.exit_mc.gotoAndPlay, "doorOpen");
            _stage.background_mc.exit_mc.agentLobby_btn.onRollOut = com.clubpenguin.util.Delegate.create(_stage.background_mc.exit_mc, _stage.background_mc.exit_mc.gotoAndPlay, "doorClose");
            _stage.background_mc.exit_mc.agentLobby_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(_stage.background_mc.exit_mc, _stage.background_mc.exit_mc.gotoAndPlay, "doorClose");
            _stage.background_mc.spyDrills_mc.spyDrillsRollOver_mc.spyDrills_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, spyDrillsRollOver);
            _stage.background_mc.spyDrills_mc.spyDrillsRollOver_mc.spyDrills_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, spyDrillsRollOut);
            _stage.background_mc.spyDrills_mc.spyDrillsRollOver_mc.spyDrills_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, spyDrillsRollOut);
            _stage.background_mc.spyDrills_mc.spyDrillsRollOver_mc.spyDrills_btn.onRelease = com.clubpenguin.util.Delegate.create(this, spyDrillsRelease);
            _stage.background_mc.sysDef_mc.sysDefRollOver_mc.sysDef_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, systemDefenderRollOver);
            _stage.background_mc.sysDef_mc.sysDefRollOver_mc.sysDef_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, systemDefenderRollOut);
            _stage.background_mc.sysDef_mc.sysDefRollOver_mc.sysDef_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, systemDefenderRollOut);
            _stage.background_mc.sysDef_mc.sysDefRollOver_mc.sysDef_btn.onRelease = com.clubpenguin.util.Delegate.create(this, systemDefenderRelease);
            _stage.missions_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, missionsRollOver);
            _stage.missions_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, missionsRollOut);
            _stage.missions_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, missionsRollOut);
            _stage.triggers_mc.agentLobby_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "agentlobbymulti", 490, 245);
            _stage.triggers_mc.systemDefender_mc.triggerFunction = com.clubpenguin.util.Delegate.create(_ENGINE, _ENGINE.sendJoinGame, "systemdefend", true);
            _stage.triggers_mc.spyDrills_mc.triggerFunction = com.clubpenguin.util.Delegate.create(_ENGINE, _ENGINE.sendJoinGame, "spydrills", true);
            _stage.triggers_mc.missionsTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, displayMissions);
            _stage.interface_mc.epf_catalogIcon.onRelease = com.clubpenguin.util.Delegate.create(this, openEPFCatalog);
            _stage.interface_mc.epf_handbookIcon.onRelease = com.clubpenguin.util.Delegate.create(this, openEPFHandbook);
        }
        function openEPFCatalog() {
            _INTERFACE.openPhoneCatalog();
        }
        function openEPFHandbook() {
            _INTERFACE.showContent("w.app.epfhandbook");
        }
        function spyDrillsRollOver() {
            _INTERFACE.showHint(_stage.spyDrillsHint_mc, "spydrills_hint");
            _stage.background_mc.spyDrills_mc.spyDrillsRollOver_mc.gotoAndPlay("screenRollOver");
        }
        function spyDrillsRollOut() {
            _INTERFACE.closeHint();
            _stage.background_mc.spyDrills_mc.spyDrillsRollOver_mc.gotoAndPlay("screenRollOut");
        }
        function spyDrillsRelease() {
            var _local_2 = _SHELL.getMyPlayerObject();
            if (_stage.triggers_mc.spyDrills_mc.hitTest(_local_2.x, _local_2.y, true)) {
                _ENGINE.sendJoinGame("spydrills", true);
            } else {
                _ENGINE.sendPlayerMove(SPY_DRILLS_TRIGGER_POSITION.x, SPY_DRILLS_TRIGGER_POSITION.y);
            }
        }
        function systemDefenderRollOver() {
            _INTERFACE.showHint(_stage.sysDefHint_mc, "systemdefend_hint");
            _stage.background_mc.sysDef_mc.sysDefRollOver_mc.gotoAndPlay("screenRollOver");
        }
        function systemDefenderRollOut() {
            _INTERFACE.closeHint();
            _stage.background_mc.sysDef_mc.sysDefRollOver_mc.gotoAndPlay("screenRollOut");
        }
        function systemDefenderRelease() {
            var _local_2 = _SHELL.getMyPlayerObject();
            if (_stage.triggers_mc.systemDefender_mc.hitTest(_local_2.x, _local_2.y, true)) {
                _ENGINE.sendJoinGame("systemdefend", true);
            } else {
                _ENGINE.sendPlayerMove(SYSTEM_DEFENDER_TRIGGER_POSITION.x, SYSTEM_DEFENDER_TRIGGER_POSITION.y);
            }
        }
        function missionsRollOver() {
            _INTERFACE.showHint(_stage.missionsHint_mc, "missions_hint");
            _stage.missions_mc.gotoAndStop("screenRollOver");
        }
        function missionsRollOut() {
            _INTERFACE.closeHint();
            _stage.missions_mc.gotoAndPlay("screenRollOut");
        }
        function displayMissions() {
            var _local_2 = _SHELL.getMyPlayerObject();
            if (_stage.triggers_mc.missionsTrigger_mc.hitTest(_local_2.x, _local_2.y, true)) {
                showContent(PSA_UI);
            } else {
                _ENGINE.sendPlayerMove(MISSIONS_TRIGGER_POSITION.x, MISSIONS_TRIGGER_POSITION.y);
            }
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "AgentCommand";
        static var SYSTEM_DEFENDER_TRIGGER_POSITION = new flash.geom.Point(180, 150);
        static var SPY_DRILLS_TRIGGER_POSITION = new flash.geom.Point(90, 180);
        static var MISSIONS_TRIGGER_POSITION = new flash.geom.Point(665, 335);
        static var PSA_UI = "w.p2015.june.missions.interface";
    }
