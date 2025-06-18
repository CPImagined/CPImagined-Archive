//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.scavengerhunts.GhostHauntScavengerHunt implements com.clubpenguin.world.rooms2012.halloween.scavengerhunts.IScavengerHunt
    {
        var _SHELL, _INTERFACE, _scavengerHuntCompleted, _handlePlayerFrameDelegate, _handleAvatarChangedDelegate, _foundItems, _numFoundItems;
        function GhostHauntScavengerHunt (isActive) {
            _SHELL = _global.getCurrentShell();
            _INTERFACE = _global.getCurrentInterface();
            _isActive = isActive;
            _scavengerHuntCompleted = new org.osflash.signals.Signal();
            _handlePlayerFrameDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerFrame);
            _handleAvatarChangedDelegate = com.clubpenguin.util.Delegate.create(this, handleAvatarChanged);
            reset();
        }
        function getScavengerHuntCompleted() {
            return(_scavengerHuntCompleted);
        }
        function setupHuntWindow(window) {
            var _local_6 = _SHELL.getLocalizedFrameLabel();
            window.continue_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onContinueClicked);
            window.continue_label.gotoAndStop(_local_6);
            window.instructions.gotoAndStop(_local_6);
            var _local_10 = window.Task1_text;
            var _local_2 = 0;
            while (_local_2 < TOTAL_ITEMS) {
                var _local_4 = _local_2 + 1;
                var _local_5 = window.instructions["checkMark" + _local_4];
                if (!_foundItems[_local_2]) {
                    _local_5.checkmark._visible = false;
                }
                _local_2++;
            }
            var _local_8 = _SHELL.getPenguinStandardTime().valueOf();
            var _local_9 = _local_8 >= com.clubpenguin.world.rooms2012.halloween.Halloween.HAUNTING_PRIZE_2_AVAILABILITY_DATE;
            var _local_7 = _local_8 >= com.clubpenguin.world.rooms2012.halloween.Halloween.HAUNTING_PRIZE_3_AVAILABILITY_DATE;
            if (_local_9) {
                window.prizes.prize2.gotoAndStop("show");
            } else {
                window.prizes.prize2.gotoAndStop("hide");
            }
            window.prizes.prize2.label.gotoAndStop(_local_6);
            if (_local_7) {
                window.prizes.prize3.gotoAndStop("show");
            } else {
                window.prizes.prize3.gotoAndStop("hide");
            }
            window.prizes.prize3.label.gotoAndStop(_local_6);
            if (_numFoundItems == TOTAL_ITEMS) {
                window.prizes.prize1.gotoAndStop("collect");
                window.prizes.prize1.label.gotoAndStop(_local_6);
                window.prizes.prize1.btn.onRelease = com.clubpenguin.util.Delegate.create(this, claimPrize, com.clubpenguin.world.rooms2012.halloween.Halloween.GHOST_HAUNT_ITEM_1, window);
                if (_local_9) {
                    window.prizes.prize2.gotoAndStop("collect");
                    window.prizes.prize2.label.gotoAndStop(_local_6);
                    window.prizes.prize2.btn.onRelease = com.clubpenguin.util.Delegate.create(this, claimPrize, com.clubpenguin.world.rooms2012.halloween.Halloween.GHOST_HAUNT_ITEM_2, window);
                }
                if (_local_7) {
                    window.prizes.prize3.gotoAndStop("collect");
                    window.prizes.prize3.label.gotoAndStop(_local_6);
                    window.prizes.prize3.btn.onRelease = com.clubpenguin.util.Delegate.create(this, claimPrize, com.clubpenguin.world.rooms2012.halloween.Halloween.GHOST_HAUNT_ITEM_3, window);
                }
            } else {
                window.prizes.prize1.gotoAndStop("show");
                window.prizes.prize1.label.gotoAndStop(_local_6);
            }
        }
        function claimPrize(itemID, window) {
            _SHELL.removeListener(_SHELL.BUY_FURNITURE, com.clubpenguin.util.Delegate.create(this, handleBuyFurniture));
            _SHELL.addListener(_SHELL.BUY_FURNITURE, com.clubpenguin.util.Delegate.create(this, handleBuyFurniture));
            _INTERFACE.buyFurniture(itemID);
        }
        function handleBuyFurniture(event) {
            _SHELL.removeListener(_SHELL.BUY_FURNITURE, com.clubpenguin.util.Delegate.create(this, handleBuyFurniture));
            if (event.success) {
                _INTERFACE.closeContent();
                _scavengerHuntCompleted.dispatch();
            }
        }
        function isItemFound(itemID) {
            return(_foundItems[itemID]);
        }
        function itemFound(itemID) {
            if (!_isActive) {
                return(undefined);
            }
            if (!_foundItems[itemID]) {
                setShowUiInterval();
            }
            _foundItems[itemID] = true;
            checkIfComplete();
        }
        function reset() {
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
            _SHELL.addListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _handleAvatarChangedDelegate);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, _handleAvatarChangedDelegate);
            _foundItems = {};
            _numFoundItems = 0;
            _INTERFACE.ICONS.scavenger_hunt_icon._visible = com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost();
        }
        function handlePlayerFrame(event) {
            if (!_isActive) {
                return(undefined);
            }
            var _local_5 = event.player_id;
            var _local_6 = event.frame;
            var _local_4 = _global.getCurrentShell();
            var _local_8 = _local_4.getPlayerObjectById(_local_4.getMyPlayerId());
            if ((_local_4.isMyPlayer(_local_5) && (com.clubpenguin.world.rooms2012.halloween.Halloween.isGhost(_local_8))) && (_local_6 == DANCE_FRAME)) {
                var _local_7 = _local_4.getRoomObject().room_key;
                var _local_3;
                switch (_local_7) {
                    case "party1" : 
                    case "party2" : 
                    case "party3" : 
                    case "party4" : 
                    case "party5" : 
                    case "party6" : 
                    case "party7" : 
                    case "party8" : 
                    case "party9" : 
                        _local_3 = com.clubpenguin.world.rooms2012.halloween.Halloween.HAUNTED_ANY_PARTY_ROOM;
                        break;
                    case "beach" : 
                        _local_3 = com.clubpenguin.world.rooms2012.halloween.Halloween.HAUNTED_BEACH;
                        break;
                    case "forts" : 
                        _local_3 = com.clubpenguin.world.rooms2012.halloween.Halloween.HAUNTED_FORTS;
                        break;
                    case "forest" : 
                        _local_3 = com.clubpenguin.world.rooms2012.halloween.Halloween.HAUNTED_FOREST;
                        break;
                    case "cove" : 
                        _local_3 = com.clubpenguin.world.rooms2012.halloween.Halloween.HAUNTED_COVE;
                        break;
                    default : 
                        _local_3 = null;
                        break;
                }
                if (_local_3 != undefined) {
                    itemFound(_local_3);
                }
            }
        }
        function handleAvatarChanged(event) {
            if (event.player_id == _SHELL.getMyPlayerId()) {
                if (event.avatar_id == com.clubpenguin.world.rooms2012.halloween.Halloween.GHOST_AVATAR_ID) {
                    _INTERFACE.ICONS[_INTERFACE.PARTY_ICON_INSTANCE_NAME].scavengerBtn._visible = true;
                } else {
                    _INTERFACE.ICONS[_INTERFACE.PARTY_ICON_INSTANCE_NAME].scavengerBtn._visible = false;
                }
            }
        }
        function onContinueClicked() {
            _INTERFACE.closeContent();
        }
        function checkIfComplete() {
            var _local_2 = 0;
            for (var _local_3 in _foundItems) {
                if (_foundItems[_local_3] == true) {
                    _local_2 = _local_2 + 1;
                }
            }
            _numFoundItems = _local_2;
        }
        function setShowUiInterval() {
            _completedTimeout = setInterval(this, "onCompletedTimeout", 2200);
        }
        function onCompletedTimeout() {
            _INTERFACE.showContent("scavenger_hunt2");
            clearInterval(_completedTimeout);
        }
        function isActive() {
            return(_isActive);
        }
        function setActive(isActive) {
            _isActive = isActive;
        }
        function getName() {
            return("ghostHaunt");
        }
        static var TOTAL_ITEMS = 5;
        static var HINT_SPACING = -5;
        static var DANCE_FRAME = 26;
        var _isActive = false;
        var _completedTimeout = -1;
    }
