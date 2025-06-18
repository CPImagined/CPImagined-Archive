//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2011.musicJam2011.Lounge extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, setupHint, _SHELL, _ENGINE, _destroyDelegate, _INTERFACE;
        function Lounge (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 590;
            _stage.start_y = 310;
            localize([_stage.thinIceMachine, _stage.astroMachine, _stage.bitsBoltsMachine, _stage.vendingMachine, _stage.foreground_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.thinIceMachine, 550, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.snowtrekker_mc, 220, 185), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.astroMachine, 595, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bitsBoltsMachine, 160, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair1.chairButton, 80, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair2.chairButton, 100, 440), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair3.chairButton, 165, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair4.chairButton, 200, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair5.chairButton, 560, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair6.chairButton, 595, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair7.chairButton, 660, 440), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair8.chairButton, 675, 380)]);
            _stage.chair1.chairButton.useHandCursor = false;
            _stage.chair2.chairButton.useHandCursor = false;
            _stage.chair3.chairButton.useHandCursor = false;
            _stage.chair4.chairButton.useHandCursor = false;
            _stage.chair5.chairButton.useHandCursor = false;
            _stage.chair6.chairButton.useHandCursor = false;
            _stage.chair7.chairButton.useHandCursor = false;
            _stage.chair8.chairButton.useHandCursor = false;
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.thinIceMachine, _stage.thinIceMachine, "thinice_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.snowtrekker_mc, _stage.snowtrekker_mc, "snowtrekker_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.astroMachine, _stage.astroMachine, "astro_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.bitsBoltsMachine, _stage.bitsBoltsMachine, "bitsandbolts")]);
            _stage.triggers_mc.danceTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitBack);
            _stage.triggers_mc.rooftopTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitRoof);
            _stage.triggers_mc.thinIceTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, thinIceGameLaunch);
            _stage.triggers_mc.astroTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, astroGameLaunch);
            _stage.triggers_mc.bitsTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, bitsGameLaunch);
			_stage.triggers_mc.trekkerTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, trekkerGameLaunch);
        }
        function exitBack() {
            _SHELL.sendJoinRoom("dance", 670, 276);
        }
        function exitRoof() {
            _SHELL.sendJoinRoom("party17", 570, 240);
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
		function trekkerGameLaunch() {
			if (!_global.getCurrentParty().BaseParty.CURRENT_PARTY.getMessageViewed(1)) {
				_INTERFACE.showContent("w.app.p2025.waddleon.game.launch");
			} else {
            	_ENGINE.sendJoinGame("snowtrekker", true);
			};
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        var ALL_ACCESS_PASS = 3079;
    }
