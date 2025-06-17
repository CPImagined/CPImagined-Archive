//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Cloudforest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _INTERFACE, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function Cloudforest (stageReference) {
            super(stageReference);
            _stage.start_x = 295;
            _stage.start_y = 300;
            if (!_SHELL) {
                _INTERFACE = _global.getCurrentInterface();
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            randomizePuffleBouncing();
            _stage.background_mc.exit_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, exitMouseOver);
            _stage.background_mc.exit_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, exitMouseOff);
            _stage.background_mc.exit_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, exitMouseOff);
            _stage.triggers_mc.exit_trigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, promptMap);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stump_mc.stump_btn, 428, 203), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.cave_btn, 428, 203), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_btn, 408, 327)]);
            _stage.background_mc.stump_mc.stump_btn.onPress = (_stage.background_mc.cave_btn.onPress = com.clubpenguin.util.Delegate.create(this, showTheChosenPuffle));
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function showTheChosenPuffle() {
            var _local_2 = _SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.isCannonAvailable;
            if (_local_2) {
                _stage.background_mc.puffleAnim_mc.gotoAndStop("animate");
            }
        }
        function showRainbowAdoptionPrompt() {
            checkForRainbowAdoption();
        }
        function randomizePuffleBouncing() {
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle1_mc.gotoAndPlay(1);
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle2_mc.gotoAndPlay(5);
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle3_mc.gotoAndPlay(10);
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle4_mc.gotoAndPlay(6);
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle5_mc.gotoAndPlay(7);
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle6_mc.gotoAndPlay(14);
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle7_mc.gotoAndPlay(4);
            _stage.background_mc.puffleAnim_mc.pufflesBounce_mc.puffle9_mc.gotoAndPlay(11);
        }
        function promptMap() {
            _INTERFACE.showContent("map");
        }
        function checkForRainbowAdoption() {
            var _local_2 = _SHELL.getRainbowPuffleQuest().getRainbowQuestCookieVO.isCannonAvailable;
            if (_local_2) {
                _INTERFACE.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, undefined, {puffleAdoptionType:"rainbow"}, true);
                _stage.background_mc.puffleAnim_mc.gotoAndStop("bounce");
                randomizePuffleBouncing();
            }
        }
        function exitMouseOver() {
            _stage.background_mc.backgroundchunk1.cloudplatform_mc.waterfallHighlight_mc.gotoAndStop(2);
            _stage.background_mc.backgroundchunk1.rainbowArrow_mc.gotoAndStop(2);
        }
        function exitMouseOff() {
            _stage.background_mc.backgroundchunk1.cloudplatform_mc.waterfallHighlight_mc.gotoAndStop(1);
            _stage.background_mc.backgroundchunk1.rainbowArrow_mc.gotoAndStop(1);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Cloudforest";
        var _canAdoptPuffle = true;
    }
