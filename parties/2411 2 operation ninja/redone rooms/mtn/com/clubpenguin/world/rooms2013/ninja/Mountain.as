//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.Mountain extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, setupNavigationButtons, _destroyDelegate, wem, _INTERFACE, _ENGINE;
        function Mountain (stageReference) {
            super(stageReference);
            _stage.start_x = 460;
            _stage.start_y = 300;
            if (!_SHELL) {
                init();
            }
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle100_mc.game_btn, 200, 395), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle101_mc.game_btn, 390, 427), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle102_mc.game_btn, 538, 407), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waddle103_mc.game_btn, 640, 367), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat_mc.seat_btn, 95, 185), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.ninja_btn, 400, 220)]);
            _stage.waddle_list = [100, 101, 102, 103];
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(40);
            wem.setupRainAnimationHeight(65);
            wem.setupSnowAnimationHeight(65);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            hideStuff();
            var _local_2 = [100, 101, 102, 103];
            _stage.waddle100_mc.seat_frames = [18, 18, 18, 18];
            _stage.waddle101_mc.seat_frames = [18, 18, 18];
            _stage.waddle102_mc.seat_frames = [17, 17];
            _stage.waddle103_mc.seat_frames = [24, 24];
            _stage.interface_mc.mtn_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "mtn_catalogue");
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 145, 270);
            _stage.triggers_mc.ninja_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 200, 135);
            _stage.triggers_mc.waddle100_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 100);
            _stage.triggers_mc.waddle101_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 101);
            _stage.triggers_mc.waddle102_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 102);
            _stage.triggers_mc.waddle103_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinSledGame, 103);
            _stage.waddle100_mc.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSledHint, _stage.waddle100_mc);
            _stage.waddle101_mc.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSledHint, _stage.waddle101_mc);
            _stage.waddle102_mc.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSledHint, _stage.waddle102_mc);
            _stage.waddle103_mc.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showSledHint, _stage.waddle103_mc);
            _stage.waddle100_mc.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSledHint);
            _stage.waddle101_mc.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSledHint);
            _stage.waddle102_mc.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSledHint);
            _stage.waddle103_mc.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideSledHint);
            _stage.seat_mc.seat_btn.useHandCursor = false;
        }
        function showSledHint(waddleHint) {
            _INTERFACE.showHint(waddleHint, "sled_hint");
        }
        function hideSledHint() {
            _INTERFACE.closeHint();
        }
        function joinSledGame(gameNumber) {
            _ENGINE.sendJoinWaddle("sled", gameNumber, true);
        }
        function hideStuff() {
            _stage.waddle100_mc.seat0_mc._visible = false;
            _stage.waddle100_mc.seat1_mc._visible = false;
            _stage.waddle100_mc.seat2_mc._visible = false;
            _stage.waddle100_mc.seat3_mc._visible = false;
            _stage.waddle101_mc.seat0_mc._visible = false;
            _stage.waddle101_mc.seat1_mc._visible = false;
            _stage.waddle101_mc.seat2_mc._visible = false;
            _stage.waddle102_mc.seat0_mc._visible = false;
            _stage.waddle102_mc.seat1_mc._visible = false;
            _stage.waddle103_mc.seat0_mc._visible = false;
            _stage.waddle103_mc.seat1_mc._visible = false;
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Mountain";
    }
