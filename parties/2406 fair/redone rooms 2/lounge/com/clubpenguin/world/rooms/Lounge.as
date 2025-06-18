//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Lounge extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, setupHint, _SHELL, _ENGINE, _targetGame, _destroyDelegate;
        function Lounge (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage = stageReference;
            _stage.start_x = 590;
            _stage.start_y = 310;
            localize([_stage.thinIceMachine, _stage.astroMachine, _stage.bitsBoltsMachine, _stage.vendingMachine, _stage.foreground_mc, _stage.background_mc.targetGame.gameLogo]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.thinIceMachine, 550, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.astroMachine, 595, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bitsBoltsMachine, 160, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair1.chairButton, 80, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair2.chairButton, 100, 440), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair3.chairButton, 165, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair4.chairButton, 200, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair5.chairButton, 560, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair6.chairButton, 595, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair7.chairButton, 660, 440), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair8.chairButton, 675, 380)]);
            _stage.chair1.chairButton.useHandCursor = false;
            _stage.chair2.chairButton.useHandCursor = false;
            _stage.chair3.chairButton.useHandCursor = false;
            _stage.chair4.chairButton.useHandCursor = false;
            _stage.chair5.chairButton.useHandCursor = false;
            _stage.chair6.chairButton.useHandCursor = false;
            _stage.chair7.chairButton.useHandCursor = false;
            _stage.chair8.chairButton.useHandCursor = false;
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.thinIceMachine, _stage.thinIceMachine, "thinice_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.astroMachine, _stage.astroMachine, "astro_hint"), new com.clubpenguin.world.rooms.common.HintVO(_stage.bitsBoltsMachine, _stage.bitsBoltsMachine, "bitsandbolts")]);
            _stage.triggers_mc.danceTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit);
            _stage.triggers_mc.thinIceTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, thinIceGameLaunch);
            _stage.triggers_mc.astroTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, astroGameLaunch);
            _stage.triggers_mc.bitsTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, bitsGameLaunch);
            if (_SHELL == undefined) {
                init();
            }
        }
        function exit() {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom("dance", 685, 290);
        }
        function thinIceGameLaunch() {
            trace(CLASS_NAME + ": thinIceGameLaunch()");
            _ENGINE.sendJoinGame("thinice", true);
        }
        function astroGameLaunch() {
            trace(CLASS_NAME + ": astroGameLaunch()");
            _ENGINE.sendJoinGame("astro", true);
        }
        function bitsGameLaunch() {
            trace(CLASS_NAME + ": bitsGameLaunch()");
            _ENGINE.sendJoinGame("bitsandbolts", true);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _targetGame = new com.clubpenguin.world.rooms.common.TargetGame(_stage.foreground_mc.screen, null, _stage.background_mc.targetGame.redScore, _stage.background_mc.targetGame.blueScore, [_stage.background_mc.targetGame.targetRed1, _stage.background_mc.targetGame.targetRed2, _stage.background_mc.targetGame.targetRed3, _stage.background_mc.targetGame.targetRed4, _stage.background_mc.targetGame.targetRed5, _stage.background_mc.targetGame.targetRed6, _stage.background_mc.targetGame.targetRed7, _stage.background_mc.targetGame.targetRed8, _stage.background_mc.targetGame.targetRed9, _stage.background_mc.targetGame.targetRed10, _stage.background_mc.targetGame.monsterRed], [_stage.background_mc.targetGame.targetBlue1, _stage.background_mc.targetGame.targetBlue2, _stage.background_mc.targetGame.targetBlue3, _stage.background_mc.targetGame.targetBlue4, _stage.background_mc.targetGame.targetBlue5, _stage.background_mc.targetGame.targetBlue6, _stage.background_mc.targetGame.targetBlue7, _stage.background_mc.targetGame.targetBlue8, _stage.background_mc.targetGame.targetBlue9, _stage.background_mc.targetGame.targetBlue10, _stage.background_mc.targetGame.monsterBlue], _SHELL.getPenguinStandardTime());
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function handleThrow(snowball) {
            _targetGame.handleThrow(snowball);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _targetGame.destroy();
            delete _targetGame;
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        var CLASS_NAME = "";
    }
