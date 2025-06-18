//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.goldnuggets.controller.GoldNuggetsHUDController
    {
        var _SHELL, _hudContainer, _myPlayerObject, _previousNuggetTotal, _isFirstTime, _isQuestProgressModuleOpened, _view, _joinRoomDelegate, _playerCurrenciesUpdatedDelegate, _moduleClosedDelegate, _showRevealAnimationTimer;
        function GoldNuggetsHUDController (shellMC, hudContainer) {
            _SHELL = shellMC;
            _hudContainer = hudContainer;
            _myPlayerObject = _SHELL.getMyPlayerObject();
            _previousNuggetTotal = -1;
            _isFirstTime = false;
            _isQuestProgressModuleOpened = false;
            _view = new com.clubpenguin.hud.goldnuggets.view.GoldNuggetsHUDView(_hudContainer, TOTAL_GOLD_NUGGETS_TO_COLLECT);
            _view.HUDClicked.add(onHUDClicked, this);
            _view.HUDAnimationCompleted.add(onHUDAnimationCompleted, this);
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom);
            _playerCurrenciesUpdatedDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerCurrenciesUpdated);
            _moduleClosedDelegate = com.clubpenguin.util.Delegate.create(this, handleModuleClosed);
            _SHELL.addListener(_SHELL.JOIN_ROOM, _joinRoomDelegate);
            _SHELL.addListener(_SHELL.PLAYER_CURRENCIES_UPDATED, _playerCurrenciesUpdatedDelegate);
            _SHELL.addListener(_SHELL.MODULE_CLOSED, _moduleClosedDelegate);
            loadGoldNuggetsHUD();
        }
        function destroy() {
            _view.destroy();
            _view.HUDClicked.remove(onHUDClicked, this);
            _view.HUDAnimationCompleted.remove(onHUDAnimationCompleted, this);
            _SHELL.removeListener(_SHELL.JOIN_ROOM, _joinRoomDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_CURRENCIES_UPDATED, _playerCurrenciesUpdatedDelegate);
            _SHELL.removeListener(_SHELL.MODULE_CLOSED, _moduleClosedDelegate);
        }
        function showHUD(animate, isFirstTime) {
            _isFirstTime = isFirstTime;
            _view.show(animate);
        }
        function isHUDVisible() {
            return(_view.isVisible());
        }
        function loadGoldNuggetsHUD() {
            _view.loadGoldNuggetsHUD(_SHELL.getPath("w.interface.hud.goldnuggets"));
        }
        function onHUDClicked() {
            var _local_2 = false;
            openAS3QuestProgress(_local_2);
        }
        function onHUDAnimationCompleted() {
            if (_isFirstTime) {
                var _local_2 = false;
                openAS3QuestProgress(_local_2);
                _isFirstTime = false;
            }
        }
        function handlePlayerCurrenciesUpdated(playerID) {
            if (playerID == _myPlayerObject.player_id) {
                if (_previousNuggetTotal == -1) {
                    _previousNuggetTotal = _myPlayerObject.currencies[_SHELL.CURRENCY_TYPE_GOLD_NUGGETS];
                }
                var _local_2 = _myPlayerObject.currencies[_SHELL.CURRENCY_TYPE_GOLD_NUGGETS];
                _view.setNumGoldNuggetsCollected(_local_2);
                if ((_previousNuggetTotal < TOTAL_GOLD_NUGGETS_TO_COLLECT) && (_local_2 >= TOTAL_GOLD_NUGGETS_TO_COLLECT)) {
                    _showRevealAnimationTimer = setInterval(this, "openQuestProgressWithReveal", REVEAL_TIMER);
                }
                _previousNuggetTotal = _local_2;
            }
        }
        function handleJoinRoom() {
            if (_SHELL.getCurrentRoomId() == CAVEMINE_ROOM_ID) {
                _SHELL.sendGetCurrencies();
                var _local_2 = false;
                _view.show(_local_2);
            } else if (_myPlayerObject.attachedPuffle && (_myPlayerObject.attachedPuffle.getPuffleState() == GOLD_STATE)) {
                var _local_2 = false;
                _view.show(_local_2);
            } else {
                _view.hide();
            }
        }
        function openAS3QuestProgress(showRevealAnimation) {
            if (!_isQuestProgressModuleOpened) {
                var _local_2 = new Object();
                _local_2.numGoldNuggetsCollected = _myPlayerObject.currencies[_SHELL.CURRENCY_TYPE_GOLD_NUGGETS];
                _local_2.isFirstTime = _isFirstTime;
                _local_2.showRevealAnimation = showRevealAnimation;
                _SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_GOLD_QUEST_PROGRESS, _local_2, {modalBackgroundEnabled:true, hideLoadingDialog:true, blockPuffleNotifications:false});
                _isQuestProgressModuleOpened = true;
            }
        }
        function handleModuleClosed() {
            _isQuestProgressModuleOpened = false;
        }
        function openQuestProgressWithReveal() {
            clearInterval(_showRevealAnimationTimer);
            var _local_2 = true;
            openAS3QuestProgress(_local_2);
        }
        static var TOTAL_GOLD_NUGGETS_TO_COLLECT = 15;
        static var CAVEMINE_ROOM_ID = 813;
        static var REVEAL_TIMER = 8000;
        static var GOLD_STATE = 1;
    }
