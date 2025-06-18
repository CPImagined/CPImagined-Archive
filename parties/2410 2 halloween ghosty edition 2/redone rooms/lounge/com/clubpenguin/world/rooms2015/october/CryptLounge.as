//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.october.CryptLounge extends com.clubpenguin.world.rooms2015.october.Lounge
    {
        static var _currentParty;
        var localize, _stage, setupNavigationButtons, _destroyDelegate, destroy, _SHELL;
        function CryptLounge (stageReference) {
            super(stageReference);
            localize([_stage.background_mc.picture_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.crypt.dance_btn, 700, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair0.chairButton, 150, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair1.chairButton, 240, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair2.chairButton, 325, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair3.chairButton, 420, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair4.chairButton, 500, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair5.chairButton, 595, 370)]);
            _stage.chair0.chairButton.useHandCursor = false;
            _stage.chair1.chairButton.useHandCursor = false;
            _stage.chair2.chairButton.useHandCursor = false;
            _stage.chair3.chairButton.useHandCursor = false;
            _stage.chair4.chairButton.useHandCursor = false;
            _stage.chair5.chairButton.useHandCursor = false;
            init();
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            var _local_3 = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            var _local_4 = _local_3.getQuestVOByIndex(QUEST_TASK_ID);
            if ((_local_3.CONSTANTS.PARTY_DAY >= _local_4.unlockDay) && (!_local_3.partyCookie.hasPlayerCompletedTask(QUEST_TASK_ID))) {
                _stage.itemCollect_mc.itemCollect_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, itemCollectRollOver);
                _stage.itemCollect_mc.itemCollect_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, itemCollectRollOut);
                _stage.itemCollect_mc.itemCollect_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, itemCollectRollOut);
                _stage.itemCollect_mc.itemCollect_btn.onRelease = com.clubpenguin.util.Delegate.create(this, itemCollectRelease);
            } else {
                _stage.itemCollect_mc._visible = false;
            }
        }
        function itemCollectRollOver() {
            _stage.itemCollect_mc.gotoAndStop("over");
        }
        function itemCollectRollOut() {
            _stage.itemCollect_mc.gotoAndStop("idle");
        }
        function itemCollectRelease() {
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _currentParty.pickupItem(_currentParty.CONSTANTS.CLOWN, QUEST_TASK_ID);
            _stage.itemCollect_mc.gotoAndStop("click");
            setTimeout(com.clubpenguin.util.Delegate.create(this, showInstructionsPopup), 1000);
        }
        function showInstructionsPopup() {
            _currentParty.displayItemPickupInstructions();
        }
        var CLASS_NAME = "CryptLounge";
        static var QUEST_TASK_ID = 7;
    }
