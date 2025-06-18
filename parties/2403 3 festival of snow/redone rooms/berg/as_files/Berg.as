//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Berg extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _checkBergTippingIntervalID, _SHELL, _INTERFACE, _ENGINE, _musicTrack, _destroyDelegate, wem;
        function Berg (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 315;
            _stage.start_y = 300;
            localize([_stage.background_mc.berg_mc.itemBox_mc.itemBoxText_mc, _stage.nothing_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.berg_mc.itemBox_mc.itemBox_btn, 345, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.aliens_mc.aliens_btn, 199, 184)]);
            _stage.background_mc.aqua_mc.aqua_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, aquaRollOver);
            _stage.background_mc.aqua_mc.aqua_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, aquaRollOut);
            _stage.background_mc.aqua_mc.aqua_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, aquaRollOut);
            _stage.background_mc.aqua_mc.aqua_btn.onRelease = com.clubpenguin.util.Delegate.create(this, aquaRelease);
            _stage.triggers_mc.triggerItemBox_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpFreeItem);
            _stage.triggers_mc.aqua_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchAquaGame);
			_stage.triggers_mc.aliens_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showAliens);
            _stage.background_mc.berg_mc.tablet_mc.tablet_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tabletRollOver);
            _stage.background_mc.berg_mc.tablet_mc.tablet_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tabletRollOut);
            _stage.background_mc.berg_mc.tablet_mc.tablet_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tabletRollOut);
            _stage.background_mc.berg_mc.tablet_mc.tablet_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "w.app.p2017.dialogprompt.february.iceberg.plaque");
            _stage.background_mc.berg_mc.itemBox_mc.itemBox_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, itemBoxRollOver);
            _stage.background_mc.berg_mc.itemBox_mc.itemBox_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, itemBoxRollOut);
            _stage.background_mc.berg_mc.itemBox_mc.itemBox_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, itemBoxRollOut);
            _stage.foreground_mc.debug01_btn.onRelease = com.clubpenguin.util.Delegate.create(this, bergDefault);
            _stage.foreground_mc.debug02_btn.onRelease = com.clubpenguin.util.Delegate.create(this, bergShake);
            _stage.foreground_mc.debug03_btn.onRelease = com.clubpenguin.util.Delegate.create(this, bergTip);
            _stage.foreground_mc.debug04_btn.onRelease = com.clubpenguin.util.Delegate.create(this, bergUnder);
        }
		function showAliens() {
			showContent("alienpuffle");
		}
        function pickUpFreeItem() {
            _SHELL.sendBuyInventory(21118);
        }
        function aquaRollOver() {
            trace("show hint");
            _INTERFACE.showHint(_stage.background_mc.aqua_mc.hint_mc, "aqua_hint");
            _stage.background_mc.aqua_mc.float_mc.base_mc.lights_mc.gotoAndPlay("turnOn");
        }
        function aquaRollOut() {
            trace("hide hint");
            _INTERFACE.closeHint();
            _stage.background_mc.aqua_mc.float_mc.base_mc.lights_mc.gotoAndPlay("turnOff");
        }
        function aquaRelease() {
            _ENGINE.sendPlayerMove(635, 160);
            if ((_stage.background_mc.aqua_mc.float_mc.base_mc.body_mc._currentframe >= 1) && (_stage.background_mc.aqua_mc.float_mc.base_mc.body_mc._currentframe <= 10)) {
                _stage.background_mc.aqua_mc.float_mc.base_mc.body_mc.gotoAndPlay("opening");
            }
        }
        function launchAquaGame() {
            _ENGINE.sendJoinGame("aqua", true);
        }
        function tabletRollOver() {
            _stage.background_mc.berg_mc.tablet_mc.gotoAndStop("rollOver");
        }
        function tabletRollOut() {
            _stage.background_mc.berg_mc.tablet_mc.gotoAndStop("rollOut");
        }
        function itemBoxRollOver() {
            _stage.background_mc.berg_mc.itemBox_mc.gotoAndStop("rollOver");
        }
        function itemBoxRollOut() {
            _stage.background_mc.berg_mc.itemBox_mc.gotoAndStop("rollOut");
        }
        function bergDefault() {
            _stage.background_mc.berg_mc.gotoAndStop("default");
        }
        function bergShake() {
            _stage.background_mc.berg_mc.gotoAndStop("shake");
        }
        function bergTip() {
            _stage.background_mc.berg_mc.gotoAndStop("tip");
        }
        function bergUnder() {
            _stage.background_mc.berg_mc.gotoAndStop("under");
        }
        function checkBergTipping() {
            var _local_5 = 0;
            var _local_4 = _SHELL.getPlayerList();
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_2 = _local_4[_local_3];
                if ((((_local_2.colour_id == 1) && (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE))) && (_local_2.attachedPuffle["color"] == "blue")) && (isJackHammering(_local_2))) {
                    _local_5++;
                }
                _local_3++;
            }
            if (_local_5 >= 5) {
                clearInterval(_checkBergTippingIntervalID);
                bergTip();
            } else if (_local_5 >= 2) {
                bergShake();
            } else {
                bergDefault();
            }
        }
        function isJackHammering(playerObj) {
            var _local_3 = _SHELL.getSecretFrame(playerObj.player_id, playerObj.frame);
            if ((playerObj.frame == 26) && (_local_3 != playerObj.frame)) {
                return(((((((((playerObj.head == 403) or (playerObj.head == 429)) or (playerObj.head == 674)) or (playerObj.head == 1765)) or (playerObj.head == 1133)) or (playerObj.head == 10403)) or (playerObj.head == 11133)) or (playerObj.head == 10429)) or (playerObj.head == 21118));
            }
            return(false);
        }
        function raisePlayers() {
            var _local_6 = _SHELL.getPlayerList();
            var _local_3 = 0;
            while (_local_3 < _local_6.length) {
                var _local_5 = _local_6[_local_3];
                var _local_2 = _ENGINE.getPlayerMovieClip(_local_5.player_id);
                var _local_4 = _local_2._y;
                com.greensock.TweenMax.to(_local_2, 0.5, {_y:_local_4 - 100, ease:com.greensock.easing.Quad.easeOut, overwrite:true, onComplete:com.clubpenguin.util.Delegate.create(this, movePlayerToOriginalY, _local_2, _local_4)});
                _local_3++;
            }
        }
        function completeBergTippingTask() {
            _global.getCurrentParty().BaseParty.CURRENT_PARTY.taskComplete(22);
        }
        function movePlayerToOriginalY(playerMC, playerMCOriginalY) {
            com.greensock.TweenMax.to(playerMC, 0.5, {_y:playerMCOriginalY, ease:com.greensock.easing.Quad.easeOut, overwrite:true});
        }
        function playDanceFloorMusic() {
            loadExternalMusic(_SHELL.getPath("w.app.music.berg.tipped"));
        }
        function loadExternalMusic(url) {
            _musicTrack = new Sound();
            _musicTrack.onLoad = com.clubpenguin.util.Delegate.create(this, onMusicTrackLoaded);
            _musicTrack.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onMusicTrackComplete);
            _musicTrack.loadSound(url, true);
        }
        function onMusicTrackLoaded(success) {
            if (success) {
                _musicTrack.start();
            }
        }
        function onMusicTrackComplete() {
            _musicTrack.start();
        }
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID, popupCallback, null, null, null, 18);
        }
        static function popupCallback(event) {
            var _local_1 = event.params;
            event.target.init(_local_1);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(45);
            wem.setupRainAnimationHeight(70);
            wem.setupSnowAnimationHeight(70);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _musicTrack.stop();
            _musicTrack = new Sound();
            clearInterval(_checkBergTippingIntervalID);
            wem.destroy();
        }
        static var CLASS_NAME = "Test";
    }
