//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.scavengerhunt.ScavengerHunt
    {
        var _SHELL, scavengerHuntCompletedSignal, scavengerHuntClosedSignal, _firstUnfoundItem;
        function ScavengerHunt () {
            _SHELL = _global.getCurrentShell();
            scavengerHuntCompletedSignal = new org.osflash.signals.Signal();
            scavengerHuntClosedSignal = new org.osflash.signals.Signal();
        }
        function resetItemFlag() {
            _latestItemHasChanged = false;
            latestItemID = -1;
        }
        function hasLatestItemChanged() {
            return(_latestItemHasChanged);
        }
        function itemFound(itemID) {
            _itemsFoundArray[itemID] = true;
            latestItemID = itemID;
            _latestItemHasChanged = true;
        }
        function isItemFound(itemID) {
            if (_itemsFoundArray[itemID] == true) {
                return(true);
            }
            return(false);
        }
        function setupHuntWindow(window) {
            _firstUnfoundItem = undefined;
            progressCheck(window);
            window.content.close_btn.onRelease = com.clubpenguin.util.Delegate.create(this, closeWindow);
            var _local_2 = 0;
            while (_local_2 < ITEMS_TOTAL) {
                window.content["item" + _local_2].onRelease = com.clubpenguin.util.Delegate.create(this, showHint, _local_2, window);
                _local_2++;
            }
            if (_itemsFoundCount == ITEMS_TOTAL) {
                window.content.claim_mc.gotoAndStop("show");
                window.content.continue_mc.gotoAndStop("hide");
                window.content.claim_mc.claim_btn.onRelease = com.clubpenguin.util.Delegate.create(this, claimPrize);
            } else {
                window.content.claim_mc.gotoAndStop("hide");
                window.content.continue_mc.gotoAndStop("show");
                window.content.continue_mc.continue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, closeWindow);
            }
            window.content.title_txt.text = _SHELL.getLocalizedString("scavenger_title");
            makeMessage(window.content.message_txt);
            window.content.claim_mc.claimTextHolder.claim_txt.text = _SHELL.getLocalizedString("scavenger_claim_prize");
            window.content.continue_mc.continueTextHolder.continue_txt.text = _SHELL.getLocalizedString("scavenger_continue");
        }
        function progressCheck(window) {
            _firstUnfoundItem = undefined;
            _itemsFoundCount = 0;
            var _local_2 = 0;
            while (_local_2 < ITEMS_TOTAL) {
                if (_itemsFoundArray[_local_2]) {
                    window.content["item" + _local_2].gotoAndStop("show");
                    _itemsFoundCount++;
                } else {
                    window.content["item" + _local_2].gotoAndStop("hide");
                    if (_firstUnfoundItem == undefined) {
                        _firstUnfoundItem = _local_2;
                        showHint(_firstUnfoundItem, window);
                    }
                }
                _local_2++;
            }
            if (!_firstUnfoundItem) {
                _firstUnfoundItem = 0;
                showHint(_firstUnfoundItem, window);
            }
        }
        function makeMessage(txt) {
            if ((_itemsFoundCount == 0) && (_SHELL.getLanguageAbbreviation() == _SHELL.FR_ABBR)) {
                txt.text = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_itemsFoundCount), _SHELL.getLocalizedString("scavenger_items_found"));
            } else if (_itemsFoundCount != 1) {
                txt.text = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_itemsFoundCount), _SHELL.getLocalizedString("scavenger_items_found_plural"));
            } else {
                txt.text = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_itemsFoundCount), _SHELL.getLocalizedString("scavenger_items_found"));
            }
        }
        function showHint(itemID, window) {
            var _local_2 = "scavenger_clue" + itemID;
            window.content.clue_mc.clue_txt.text = _SHELL.getLocalizedString(_local_2);
        }
        function claimPrize() {
            scavengerHuntCompletedSignal.dispatch();
        }
        function closeWindow() {
            scavengerHuntClosedSignal.dispatch();
        }
        static var CLASS_NAME = "ScavengerHunt";
        static var ITEMS_TOTAL = 8;
        var _itemsFoundArray = [];
        var _itemsFoundCount = 0;
        var latestItemID = -1;
        var _latestItemHasChanged = false;
    }
