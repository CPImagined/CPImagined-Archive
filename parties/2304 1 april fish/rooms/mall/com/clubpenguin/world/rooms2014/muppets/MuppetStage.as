//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.MuppetStage extends com.clubpenguin.world.rooms.BaseRoom
    {
        static var _airtower;
        var _stage, _SHELL, _destroyDelegate, _INTERFACE, _timer, _checkSnowballDelegate, setupNavigationButtons, localize, handleShowStartDelegate, _countdownIntervalId;
        function MuppetStage (stageReference) {
            super(stageReference);
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("MuppetStage()", CLASS_NAME);
            _stage.start_x = 90;
            _stage.start_y = 265;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("init()", CLASS_NAME);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _airtower = _global.getCurrentAirtower();
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PARTY_DAY <= 8) {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.KERMIT_FINALE_PATH);
                return(undefined);
            }
            _stage.foreground_mc.roomMask._visible = false;
            activateShowStatusBroadcastReceiver();
            _timer = new com.clubpenguin.world.rooms2014.muppets.MuppetStageTimer(_stage.foreground_mc.counterThing);
            if ((com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PARTY_DAY > 8) && (!_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.STAGE_BACKGROUND_ITEM_ID))) {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.KERMIT_FINALE_PATH);
            }
            _checkSnowballDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _checkSnowballDelegate);
            _quality  = "MEDIUM";
        }
        function configureTriggers() {
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 512, 310);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton01, 84, 123), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton02, 100, 112), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton03, 664, 112), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton04, 680, 123), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton05, 100, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton06, 119, 347), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton07, 144, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton08, 172, 384), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton09, 204, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton10, 242, 411), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton11, 276, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton12, 314, 419), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton13, 352, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton14, 394, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton15, 434, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton16, 473, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton17, 507, 411), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton18, 545, 400), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton19, 577, 384), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton20, 605, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton21, 629, 347), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton22, 649, 325), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton23, 73, 365), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton24, 92, 387), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton25, 117, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton26, 145, 424), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton27, 177, 440), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton28, 578, 441), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton29, 610, 425), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton30, 638, 411), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton31, 662, 388), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navButton32, 682, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 140, 235)]);
        }
        function configureRoomElements() {
            localize([_stage.foreground_mc.counterThing.topPart, _stage.foreground_mc.counterThing.bottomPart, _stage.background_mc.insideStage.stageSignApplause.langText, _stage.background_mc.insideStage.stageSignLaugh.langText]);
            _stage.customPenguinSize = 85;
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.navButton01.useHandCursor = false;
            _stage.navButton02.useHandCursor = false;
            _stage.navButton03.useHandCursor = false;
            _stage.navButton04.useHandCursor = false;
            _stage.navButton05.useHandCursor = false;
            _stage.navButton06.useHandCursor = false;
            _stage.navButton07.useHandCursor = false;
            _stage.navButton08.useHandCursor = false;
            _stage.navButton09.useHandCursor = false;
            _stage.navButton10.useHandCursor = false;
            _stage.navButton11.useHandCursor = false;
            _stage.navButton12.useHandCursor = false;
            _stage.navButton13.useHandCursor = false;
            _stage.navButton14.useHandCursor = false;
            _stage.navButton15.useHandCursor = false;
            _stage.navButton16.useHandCursor = false;
            _stage.navButton17.useHandCursor = false;
            _stage.navButton18.useHandCursor = false;
            _stage.navButton19.useHandCursor = false;
            _stage.navButton20.useHandCursor = false;
            _stage.navButton21.useHandCursor = false;
            _stage.navButton22.useHandCursor = false;
            _stage.navButton23.useHandCursor = false;
            _stage.navButton24.useHandCursor = false;
            _stage.navButton25.useHandCursor = false;
            _stage.navButton26.useHandCursor = false;
            _stage.navButton27.useHandCursor = false;
            _stage.navButton28.useHandCursor = false;
            _stage.navButton29.useHandCursor = false;
            _stage.navButton30.useHandCursor = false;
            _stage.navButton31.useHandCursor = false;
            _stage.navButton32.useHandCursor = false;
        }
        function activateShowStatusBroadcastReceiver() {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("activateShowStatusBroadcastReceiver()", CLASS_NAME);
            handleShowStartDelegate = com.clubpenguin.util.Delegate.create(this, handleShowDetails);
            _airtower.addListener(_global.getCurrentParty().MuppetsParty.CONSTANTS.MUPPETS_SHOW_COMMAND, handleShowStartDelegate);
        }
        function deactivateShowStatusBroadcastReceiver() {
            _airtower.removeListener(_global.getCurrentParty().MuppetsParty.CONSTANTS.MUPPETS_SHOW_COMMAND, handleShowStartDelegate);
        }
        function handleShowDetails(data) {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("handleShowDetails()", CLASS_NAME);
            var _local_3 = Number(data[1]);
            var _local_2 = Number(data[2]);
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug((("handleShowDetails():timeSinceStarted=" + _local_3) + " :timeBetweenShows=") + _local_2, CLASS_NAME);
            _timer.init(_local_3, _local_2);
            updateState(true);
            clearInterval(_countdownIntervalId);
            _countdownIntervalId = setInterval(this, "processUpdate", COUNTDOWN_INTERVAL);
        }
        function processUpdate() {
            _timer.update(COUNTDOWN_INTERVAL);
            updateState(false);
        }
        function updateState(force) {
            var _local_2 = _isShowActive;
            if (_timer.showOn) {
                return(startShow(_local_2, force));
            } else {
                return(stopShow(_local_2, force));
            }
        }
        function startShow(previouslyActive, force) {
            if (!previouslyActive) {
                _isShowActive = true;
                if (force) {
                    var _local_2 = calculateStartFrame(_stage.background_mc.insideStage._totalframes);
                    _stage.background_mc.insideStage.gotoAndPlay(_local_2);
                } else {
                    _stage.background_mc.insideStage.gotoAndPlay(SHOW_START_LABEL);
                }
                return(true);
            }
            return(false);
        }
        function stopShow(previouslyActive, force) {
            if (previouslyActive) {
                _isShowActive = false;
                return(true);
            }
            return(false);
        }
        function calculateStartFrame(totalFrames) {
            return(Math.floor(_timer.getPercentageIntoShow(totalFrames)) + 1);
        }
        function onSnowballLand(snowballInfo) {
            if (_stage.background_mc.insideStage.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                snowballInfo.snowballMC._visible = false;
            }
        }
        function exit(roomName, x, y) {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("exit()", CLASS_NAME);
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("destroy()", CLASS_NAME);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_countdownIntervalId);
            deactivateShowStatusBroadcastReceiver();
            _quality  = "HIGH";
        }
        static var CLASS_NAME = "MuppetStage";
        static var SHOW_START_LABEL = "performanceStart";
        static var SHOW_END_LABEL = "performanceEnd";
        var _isShowActive = false;
        static var COUNTDOWN_INTERVAL = 500;
    }
