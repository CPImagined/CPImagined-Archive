//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Forest extends com.clubpenguin.world.rooms2014.holiday.HolidayRoom
    {
        var _stage, _currentParty, setupNavigationButtons, _destroyDelegate, _SHELL, _checkTargetDelegate, _ENGINE, localize, _abductionDelegate, aliendAbduction, _targetArray, _INTERFACE, dialogueTimeout;
        function Forest (stageReference) {
            super(stageReference);
            _stage.start_x = 175;
            _stage.start_y = 245;
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 689, 336);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 139, 376);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cove", 171, 170);
            _stage.triggers_mc.what_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lake", 237, 143);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.plaza_btn, 56, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shack_btn, 655, 152), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cove_btn, 646, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coinsForChange_mc.coinsForChange_btn, 417, 316)]);
            _stage.plaza_btn.useHandCursor = false;
            _stage.shack_btn.useHandCursor = false;
            _stage.cove_btn.useHandCursor = false;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _checkTargetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _checkTargetDelegate);
            var currentRoomID = Number(_global.getCurrentShell().getCurrentRoomId());
            _ENGINE.snowballManager.setMaxSnowballs(20);
            configureArrays();
            super.configureHolidayRoomElements();
            localize([_stage.cfcSign, _stage.coinsForChange_mc.text_mc]);
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
        }
        function abductPenguin(data) {
            var player_id = data[1];
            var player_mc = _global.getCurrentEngine().getPlayerMovieClip(player_id);
            _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
            _stage.tractorBeam_mc.swapDepths(player_mc);
            _stage.tractorBeam_mc._x = player_mc._x;
            _stage.tractorBeam_mc._y = player_mc._y - 1;
            aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
            aliendAbduction.abductPlayer(player_id, _stage, this);
        }
        function abductedPlayerGoToUFO(player_id) {
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function configureArrays() {
            _targetArray = [];
            var i = 1;
            while (i < MAX_NUM_ORNAMENTS) {
                var num = ("0" + i).substr(-2);
                var ornament = {mc:_stage["ornament" + num], hitTarget:_stage["ornamentHitArea" + num], showing:false};
                ornament.mc._visible = false;
                _targetArray.push(ornament);
                i++;
            }
        }
        function onSnowballLand(snowballInfo) {
            var isOrnamentHit = false;
            var i = 0;
            while (i < _targetArray.length) {
                if (_targetArray[i].hitTarget.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                    snowballInfo.snowballMC._visible = false;
                    if (!_targetArray[i].showing) {
                        if (snowballInfo.player_id == _SHELL.getMyPlayerId()) {
                            _targetArray[i].mc._visible = true;
                            _targetArray[i].showing = true;
                            isOrnamentHit = true;
                            _currentParty.playSound(_stage, "sfx_ornament_hit_" + (random(2) + 1));
                            checkCompletion();
                            earnCoins();
                        }
                    }
                    break;
                } else if (_stage.snowBlock_mc.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                    snowballInfo.snowballMC._visible = false;
                }
                i++;
            }
            if (!isOrnamentHit) {
            }
        }
        function earnCoins() {
            if (coinsCooldown) {
                return(undefined);
            }
            coinsEarnedNum++;
            if (coinsEarnedNum == 3) {
                coinsEarnedNum = 0;
                _global.getCurrentParty().BaseParty.CURRENT_PARTY.sendCoinsEarned(15);
            }
            if (_stage.coinanimation_mc) {
                _stage.coinanimation_mc.removeMovieClip();
            }
            var player_id = _SHELL.getMyPlayerId();
            var player_mc = _global.getCurrentEngine().getPlayerMovieClip(player_id);
            _stage.attachMovie("CoinAnimation", "coinanimation_mc", _stage.getNextHighestDepth());
            _stage.coinanimation_mc._x = player_mc._x;
            _stage.coinanimation_mc._y = player_mc._y;
            _stage.coinanimation_mc._xscale = 70;
            _stage.coinanimation_mc._yscale = 70;
            coinsCooldown = true;
            setTimeout(com.clubpenguin.util.Delegate.create(this, finishCooldown), 1500);
        }
        function finishCooldown() {
            coinsCooldown = false;
        }
        function checkCompletion() {
            _amountShowing = 0;
            var i = 0;
            while (i <= (_targetArray.length - 1)) {
                if (_targetArray[i].showing) {
                    _amountShowing++;
                }
                i++;
            }
            if (_amountShowing == NUM_ORNAMENTS_GOAL) {
            }
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearTimeout(dialogueTimeout);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkTargetDelegate);
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Forest";
        static var NUM_ORNAMENTS_GOAL = 8;
        var MAX_NUM_ORNAMENTS = 18;
        var ornaments = [];
        var _aniStep = 0;
        var _amountShowing = 0;
        var coinsEarnedNum = 0;
        var coinsCooldown = false;
    }
