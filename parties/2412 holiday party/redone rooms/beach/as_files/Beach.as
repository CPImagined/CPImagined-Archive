//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Beach extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _INTERFACE, _destroyDelegate, _abductionDelegate, aliendAbduction, _checkTargetDelegate;
        function Beach (stageReference) {
            super(stageReference);
            trace((CLASS_NAME + "() : 2015 - ") + this);
            _stage.start_x = 400;
            _stage.start_y = 200;
            if (!_SHELL) {
                init();
            }
            localize([_stage.cfcRoof, _stage.foodBox, _stage.driveBox, _stage.background_mc.bgBitmap.candycanebanner_mc, _stage.coinsForChange_mc.text_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.light_btn, 205, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coinsForChange_mc.coinsForChange_btn, 200, 370)]);
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 270, 260);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 124, 184);
            _stage.triggers_mc.ship_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "ship", 449, 318);
            var _local_4 = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
        }
        function showContent(contentID) {
            trace("show content");
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace(CLASS_NAME + ": 2015 init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureSnowballTracking();
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
        }
        function abductPenguin(data) {
            trace((CLASS_NAME + "abductPenguin() - data : ") + data);
            var _local_4 = data[1];
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
            _stage.tractorBeam_mc.swapDepths(_local_3);
            _stage.tractorBeam_mc._x = _local_3._x;
            _stage.tractorBeam_mc._y = _local_3._y - 1;
            aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
            aliendAbduction.abductPlayer(_local_4, _stage, this);
        }
        function abductedPlayerGoToUFO(player_id) {
            trace((CLASS_NAME + "abductedPlayerGoToUFO() - player_id !!!!!! : ") + player_id);
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                trace("IS MY PLAYER - SEND JOIN ROOM");
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function configureSnowballTracking() {
            _checkTargetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _checkTargetDelegate);
            _stage.hitAreaDrive._visible = false;
            _stage.hitAreaFood._visible = false;
            trace("Beach.configureSnowballTracking()");
        }
        function onSnowballLand(snowballInfo) {
            trace("BEACH - onSnowballLand() - snowballInfo.x : " + snowballInfo.x);
            if (_stage.hitAreaFood.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                trace("BEACH - HIT TEST  hitAreaFood -- EARN COINS ");
                _stage.foodBox.art.animation.gotoAndPlay(7);
                _stage.foodBoxBack.gotoAndPlay(7);
                if (snowballInfo.player_id == _SHELL.getMyPlayerId()) {
                    earnCoins();
                }
                snowballInfo.snowballMC._visible = false;
            } else if (_stage.hitAreaDrive.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                trace("BEACH - HIT TEST  hitAreaDrive ");
                _stage.driveBox.art.animation.gotoAndPlay(7);
                _stage.driveBoxBack.gotoAndPlay(7);
                if (snowballInfo.player_id == _SHELL.getMyPlayerId()) {
                    earnCoins();
                }
                snowballInfo.snowballMC._visible = false;
            }
        }
        function earnCoins() {
            if (coinsCooldown) {
                return(undefined);
            }
            trace("earnCoins() - coinsEarnedNum : " + coinsEarnedNum);
            coinsEarnedNum++;
            if (coinsEarnedNum == 3) {
                coinsEarnedNum = 0;
                _global.getCurrentParty().BaseParty.CURRENT_PARTY.sendCoinsEarned(15);
                trace("BEACH - SUBMIT 15 COINS EARNED");
            }
            trace("_stage.coinanimation_mc : " + _stage.coinanimation_mc);
            if (_stage.coinanimation_mc) {
                _stage.coinanimation_mc.removeMovieClip();
            }
            var _local_4 = _SHELL.getMyPlayerId();
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("CoinAnimation", "coinanimation_mc", _stage.getNextHighestDepth());
            _stage.coinanimation_mc._x = _local_3._x;
            _stage.coinanimation_mc._y = _local_3._y;
            _stage.coinanimation_mc._xscale = 70;
            _stage.coinanimation_mc._yscale = 70;
            coinsCooldown = true;
            setTimeout(com.clubpenguin.util.Delegate.create(this, finishCooldown), 1500);
        }
        function finishCooldown() {
            coinsCooldown = false;
        }
        function removeCoin() {
            if (_stage.coinanimation_mc) {
                _stage.coinanimation_mc.removeMovieClip();
                _stage.coinanimation_mc = null;
            }
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkTargetDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Beach";
        var _snowballTotal = 0;
        var coinsEarnedNum = 0;
        var coinsCooldown = false;
    }
