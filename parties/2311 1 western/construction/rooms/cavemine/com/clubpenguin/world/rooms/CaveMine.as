//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.CaveMine extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _AIRTOWER, _trackerAS2, _stage, localize, setupNavigationButtons, _onCancelCloseUpClickDelegate, _INTERFACE, _SHELL, _destroyDelegate, _caveMineDigging, _ENGINE;
        function CaveMine (stageReference) {
            super(stageReference);
            _AIRTOWER = _global.getCurrentAirtower();
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            _stage.start_x = 300;
            _stage.start_y = 280;
            localize([_stage.background_mc.digSign_mc.digSignLang_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool01_btn, 135, 369), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool02_btn, 196, 394), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.itemBox_mc.itemBox_btn, 330, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.enterMine_mc.enterMine_btn, 60, 305), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.enterLake_mc.enterLake_btn, 485, 205), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.goldRevealBg_mc.goldRevealBg_btn, 185, 182)]);
            _stage.stool01_btn.useHandCursor = false;
            _stage.stool02_btn.useHandCursor = false;
            _stage.background_mc.digSign_mc.digSign_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "splunkposter2");
            _stage.triggers_mc.mine_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mine", 560, 355);
            _stage.triggers_mc.lake_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lake", 100, 275);
            _stage.triggers_mc.goldPuffle_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, onRevealGoldPuffleTrigger);
            _stage.triggers_mc.freeItem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpMiningHat);
            _stage.dig_area_mc._visible = false;
            _onCancelCloseUpClickDelegate = com.clubpenguin.util.Delegate.create(this, onCancelCloseUpClick);
        }
        function pickUpMiningHat() {
            _INTERFACE.buyInventory(429);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _caveMineDigging = new com.clubpenguin.world.rooms.cavemine.CaveMineDigging(_stage, _SHELL, _ENGINE);
        }
        function onRevealGoldPuffleTrigger() {
            _trackerAS2.trackGameAction("view", "gold_puffle_jackhammer_start");
            if (!_SHELL.getMyPlayerObject().is_member) {
                _INTERFACE.showContent(NONMEMBER_OOPS_JACKHAMMER);
            } else if (isMaxPuffles()) {
                var _local_3 = _SHELL.getMyPlayerObject();
                var _local_2 = new Object();
                _local_2.numGoldNuggetsCollected = _local_3.currencies[_SHELL.CURRENCY_TYPE_GOLD_NUGGETS];
                _SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_GOLD_JACKHAMMER_PROMPT, _local_2, {modalBackgroundEnabled:true, hideLoadingDialog:true, blockPuffleNotifications:true});
            } else {
                var _local_4 = _AIRTOWER.getServer();
                _local_4.sendXtMessage(_AIRTOWER.PLAY_EXT, _AIRTOWER.PET_HANDLER + "#revealgoldpuffle", [], "str", -1);
            }
        }
        function onCancelCloseUpClick(playerObject) {
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_TREASURE_HUNTING, _SHELL.getMyPlayerObject().player_id);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _onCancelCloseUpClickDelegate);
        }
        function isMaxPuffles() {
            return(_SHELL.puffleManager.myPuffleCount >= com.clubpenguin.shell.PuffleManager.MAX_PUFFLES);
        }
        function destroy() {
            if (!_ENGINE.isMovementEnabled()) {
                _ENGINE.enableMouseMovement();
            }
            _caveMineDigging.handleRoomDestroyed();
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var TOTAL_GOLD_NUGGETS_TO_COLLECT = 15;
        static var NONMEMBER_OOPS_JACKHAMMER = "oops_gold_berry_machine";
        static var CLASS_NAME = "CaveMine";
    }
