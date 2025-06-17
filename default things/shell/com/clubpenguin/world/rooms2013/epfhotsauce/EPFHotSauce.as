//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce
    {
        static var instance, _opcodeJournal;
        var inventory, trackerAS2, timesCompleted, _questStateUpdated, _facetimeCallReceived, _evidenceReadyUpdated, _evidenceReadyComplete, _footPrintVisibilityChanged, _rewardGranted, _inventoryItemSelected, _inventoryItemDropped, _SHELL, _INTERFACE, questState;
        function EPFHotSauce () {
            initInventoryItems();
            inventory = new com.clubpenguin.util.collection.Collection(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
            trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            timesCompleted = 0;
            _questStateUpdated = new org.osflash.signals.Signal();
            _facetimeCallReceived = new org.osflash.signals.Signal();
            _evidenceReadyUpdated = new org.osflash.signals.Signal();
            _evidenceReadyComplete = new org.osflash.signals.Signal();
            _footPrintVisibilityChanged = new org.osflash.signals.Signal();
            _rewardGranted = new org.osflash.signals.Signal();
            _inventoryItemSelected = new org.osflash.signals.Signal(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
            _inventoryItemDropped = new org.osflash.signals.Signal(com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO);
            _isLockedDoorToHerbertLairShown = false;
            _SHELL = _global.getCurrentShell();
            _INTERFACE = _global.getCurrentInterface();
            setupGlobalMissionDialogs();
            setupEvidenceCompleteSignal();
            _SHELL.addListener(_SHELL.PARTY_COOKIE_UPDATED, onPartyCookieUpdated, this);
            _SHELL.addListener(_SHELL.PLAYER_AVATAR_TRANSFORMED, onPlayerAvatarUpdated, this);
            _SHELL.sendRequestForPartyCookie();
            INVENTORY_NONMEMBER_TRACE_TRACKER.itemActivated.add(activateTraceTracker, this);
            INVENTORY_NONMEMBER_TRACE_TRACKER.itemDeactivated.add(deactivateTraceTracker, this);
        }
        static function init() {
            instance = new com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce();
            var _local_2 = _global.getCurrentShell();
            _opcodeJournal = new com.clubpenguin.world.rooms2013.epfhotsauce.OpcodeJournal();
            _opcodeJournal.init(_local_2.getMyPlayerId());
        }
        function setupGlobalMissionDialogs() {
            var _local_2 = com.clubpenguin.util.Delegate.create(this, function () {
                if (com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.hasEvidenceToSubmit()) {
                    this._facetimeCallReceived.dispatch(com.clubpenguin.util.Delegate.create(this, com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.showGaryFacetimeCall), true);
                }
            });
            var _local_3 = com.clubpenguin.util.Delegate.create(this, function () {
                this._facetimeCallReceived.dispatch(com.clubpenguin.util.Delegate.create(this, com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.showTraceTrackerReadyFacetimeCall), false);
            });
            _evidenceReadyComplete.add(_local_3);
            inventory.getItemsAdded().add(_local_2);
        }
        static function isFacetimeCallWaiting() {
            return(hasEvidenceToSubmit() || (instance.isWaitingForTraceTracker() && (getEvidenceReadyInSeconds() <= 0)));
        }
        static function getWaitingFacetimeArgs() {
            var _local_1 = new Array();
            if (hasEvidenceToSubmit()) {
                _local_1.push(showGaryFacetimeCall);
                _local_1.push(true);
            } else if (instance.isWaitingForTraceTracker()) {
                _local_1.push(showTraceTrackerReadyFacetimeCall);
                _local_1.push(false);
            }
            return(_local_1);
        }
        static function showGaryFacetimeCall() {
            var _SHELL = _global.getCurrentShell();
            var _INTERFACE = _global.getCurrentInterface();
            if (_SHELL.isMyPlayerMember()) {
                _INTERFACE.showContent(QUEST_DIALOG_GARY_FACETIME);
            } else {
                _INTERFACE.showContent(QUEST_DIALOG_GARY_FACETIME_NONMEMBER, function (mc) {
                    mc.target.goThere.onRelease = function () {
                        _SHELL.sendJoinRoom("agentcom");
                        _INTERFACE.closeContent();
                    };
                });
            }
        }
        static function showTraceTrackerReadyFacetimeCall() {
            var _SHELL = _global.getCurrentShell();
            var _INTERFACE = _global.getCurrentInterface();
            _INTERFACE.showContent(QUEST_DIALOG_GARY_FACETIME_NONMEMBER_TRACETRACKER_READY, function (mc) {
                mc.target.goThere.onRelease = function () {
                    _SHELL.sendJoinRoom("agentcom");
                    _INTERFACE.closeContent();
                };
            });
        }
        function setupEvidenceCompleteSignal() {
            _evidenceReadyUpdated.add(com.clubpenguin.util.Delegate.create(this, function () {
                if (this.isWaitingForTraceTracker()) {
                    setTimeout(com.clubpenguin.util.Delegate.create(this, function () {
                        this._evidenceReadyComplete.dispatch();
                    }), com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getEvidenceReadyInSeconds() * 1000);
                }
            }));
        }
        function isWaitingForTraceTracker() {
            return(((!_SHELL.isMyPlayerMember()) && (questState == QUEST_STATE_EVIDENCE_SUBMITTED)) && (!inventory.contains(INVENTORY_NONMEMBER_TRACE_TRACKER)));
        }
        function initInventoryItems() {
            INVENTORY_FUR.itemSelected.add(onInventoryItemSelected, this);
            INVENTORY_HOT_SAUCE.itemSelected.add(onInventoryItemSelected, this);
            INVENTORY_PIZZA_SLICE.itemSelected.add(onInventoryItemSelected, this);
        }
        static function getNextHerbertAmbientDialog() {
            var _local_1 = herbertDialogFrame;
            herbertDialogFrame = herbertDialogFrame + 1;
            return(_local_1);
        }
        static function allHerbertAmbientDialogDone() {
            return(herbertDialogFrame >= HERBERT_DIALOG_MAX_FRAME);
        }
        function onPlayerAvatarUpdated(updatedPlayer) {
            if (updatedPlayer.player.player_id != _SHELL.getMyPlayerId()) {
                return(undefined);
            }
            if (updatedPlayer.player.avatar_id == TRACE_TRACKER_AVATAR_ID) {
                trackerAS2.trackStepTimingEvent("epf_mission", "activate_tracker_member", "mission_1");
                _traceTrackerEnabled = true;
            } else if (updatedPlayer.player.avatar_id == NONMEMBER_TRACE_TRACKER_AVATAR_ID) {
                trackerAS2.trackStepTimingEvent("epf_mission", "activate_tracker_nonmember", "mission_1");
                _traceTrackerEnabled = true;
            } else {
                _traceTrackerEnabled = false;
            }
            _footPrintVisibilityChanged.dispatch();
        }
        static function activateTraceTracker() {
            if (_global.getCurrentShell().isMyPlayerMember()) {
                _global.getCurrentEngine().avatarManager.transformationManager.sendTransformPlayer(TRACE_TRACKER_AVATAR_ID);
            } else {
                _global.getCurrentEngine().avatarManager.transformationManager.sendTransformPlayer(NONMEMBER_TRACE_TRACKER_AVATAR_ID);
            }
        }
        static function deactivateTraceTracker() {
            _global.getCurrentEngine().avatarManager.transformationManager.sendTransformPlayer(DEFAULT_PENGUIN_AVATAR);
        }
        static function getFootPrintVisibilityChangedSignal() {
            return(instance._footPrintVisibilityChanged);
        }
        function onInventoryItemSelected(inventoryItemVO) {
            instance._inventoryItemSelected.dispatch(inventoryItemVO);
        }
        static function getInventoryItemSelectedSignal() {
            return(instance._inventoryItemSelected);
        }
        static function getInventoryItemDroppedSignal() {
            return(instance._inventoryItemDropped);
        }
        static function getInventory() {
            return(instance.inventory);
        }
        static function getQuestState() {
            return(instance.questState);
        }
        static function getEvidenceReadyEpoch() {
            return(instance.evidenceReadyEpoch);
        }
        static function getEvidenceReadyInSeconds() {
            var _local_3 = _global.getCurrentShell();
            var _local_4 = _local_3.getCurrentServerEpochFromLocalTime();
            var _local_2 = (getEvidenceReadyEpoch() * 1000) - _local_4;
            if (_local_2 <= 0) {
                return(0);
            }
            return(_local_2 / 1000);
        }
        static function getRewardedMedalCount() {
            return(instance.rewardedMedals);
        }
        static function getRewardedItemId() {
            return(instance.rewardedItemId);
        }
        static function dropInventoryItem(inventoryItemDropped, dropPoint) {
            if ((((inventoryItemDropped != undefined) && (inventoryItemDropped != null)) && (dropPoint != undefined)) && (dropPoint != null)) {
                instance._inventoryItemDropped.dispatch(inventoryItemDropped, dropPoint);
            }
        }
        static function canSeeFootprints() {
            if ((!isOnMission()) || (!isTrackTrackerCalibrated())) {
                return(false);
            }
            return(isTraceTrackerActive());
        }
        static function isTraceTrackerActive() {
            var _local_2 = _global.getCurrentShell();
            var _local_3 = _local_2.getPlayerObjectById(_local_2.getMyPlayerId());
            return((_local_3.avatar_id == TRACE_TRACKER_AVATAR_ID) || (_local_3.avatar_id == NONMEMBER_TRACE_TRACKER_AVATAR_ID));
        }
        static function setLockedDoorToHerbertLairShown(shown) {
            instance._isLockedDoorToHerbertLairShown = shown;
        }
        static function isLockedDoorToHerbertLairShown() {
            return(isOnMission() && (instance._isLockedDoorToHerbertLairShown));
        }
        static function setQuestState(newState) {
            var _local_3 = false;
            var _local_1 = 0;
            while (_local_1 < validQuestStates.length) {
                if (validQuestStates[_local_1] == newState) {
                    _local_3 = true;
                    break;
                }
                _local_1++;
            }
            if (!_local_3) {
                throw new Error("Invalid quest state " + newState);
            }
            if (instance.questState != newState) {
                if (newState == QUEST_STATE_MISSION_AVAILABLE) {
                    resetMission();
                }
                instance.questState = newState;
                instance._questStateUpdated.dispatch();
                return(true);
            }
            return(false);
        }
        static function resetMission() {
            INVENTORY_FUR.isUsed = false;
            INVENTORY_HOT_SAUCE.isUsed = false;
            setLockedDoorToHerbertLairShown(false);
        }
        static function setEvidenceReadyEpoch(epoch) {
            if (instance.evidenceReadyEpoch != epoch) {
                instance.evidenceReadyEpoch = epoch;
                instance._evidenceReadyUpdated.dispatch();
                return(true);
            }
            return(false);
        }
        static function setInventory(newInventory) {
            var _local_7 = false;
            var _local_5 = 0;
            while (_local_5 < newInventory.length) {
                var _local_2 = com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO(newInventory[_local_5]);
                if (playerHasQuestItem(_local_2)) {
                    var _local_4 = com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO(instance.inventory.getItemByID(_local_2.getID()));
                    if (_local_2.isUsed != _local_4.isUsed) {
                        _local_4.isUsed = _local_2.isUsed;
                        _local_7 = true;
                    }
                } else {
                    instance.inventory.addItem(_local_2);
                    _local_7 = true;
                }
                _local_5++;
            }
            var _local_8 = instance.inventory.getItems();
            if (newInventory.length < _local_8.length) {
                _local_5 = 0;
                while (_local_5 < _local_8.length) {
                    var _local_4 = _local_8[_local_5];
                    var _local_6 = false;
                    var _local_1 = 0;
                    while (_local_1 < newInventory.length) {
                        if (newInventory[_local_1].itemID == _local_4.itemID) {
                            _local_6 = true;
                            break;
                        }
                        _local_1++;
                    }
                    if (!_local_6) {
                        instance.inventory.removeItem(_local_4);
                        _local_7 = true;
                    }
                    _local_5++;
                }
            }
            return(_local_7);
        }
        static function playerHasQuestItem(questItem) {
            return(instance.inventory.contains(questItem));
        }
        static function pickUpQuestItem(questItem) {
            if (!playerHasQuestItem(questItem)) {
                questItem.isUsed = false;
                instance.inventory.addItem(questItem);
                sendPartyCookieUpdate();
            }
        }
        static function useQuestItem(questItem) {
            if (playerHasQuestItem(questItem) && (questItem.isUsed == false)) {
                questItem.isUsed = true;
                sendPartyCookieUpdate();
            }
        }
        static function getQuestStateUpdatedSignal() {
            return(instance._questStateUpdated);
        }
        static function getFacetimeCallSignal() {
            return(instance._facetimeCallReceived);
        }
        static function getEvidenceReadyUpdatedSignal() {
            return(instance._evidenceReadyUpdated);
        }
        static function getEvidenceReadyCompleteSignal() {
            return(instance._evidenceReadyComplete);
        }
        static function getRewardGrantedSignal() {
            return(instance._rewardGranted);
        }
        function onPartyCookieUpdated(partyCookie) {
            if (!SYNC_WITH_SERVER) {
                return(undefined);
            }
            var _local_2 = [];
            for (var _local_3 in partyCookie.inventory) {
                switch (Number(_local_3)) {
                    case INVENTORY_FUR.itemID : 
                        INVENTORY_FUR.isUsed = partyCookie.inventory[_local_3];
                        _local_2.push(INVENTORY_FUR);
                        break;
                    case INVENTORY_HOT_SAUCE.itemID : 
                        INVENTORY_HOT_SAUCE.isUsed = partyCookie.inventory[_local_3];
                        _local_2.push(INVENTORY_HOT_SAUCE);
                        break;
                    case INVENTORY_NONMEMBER_TRACE_TRACKER.itemID : 
                        INVENTORY_NONMEMBER_TRACE_TRACKER.isUsed = partyCookie.inventory[_local_3];
                        _local_2.push(INVENTORY_NONMEMBER_TRACE_TRACKER);
                        break;
                    case INVENTORY_PIZZA_SLICE.itemID : 
                        INVENTORY_PIZZA_SLICE.isUsed = partyCookie.inventory[_local_3];
                        _local_2.push(INVENTORY_PIZZA_SLICE);
                        break;
                }
            }
            setInventory(_local_2);
            setQuestState(partyCookie.state);
            setEvidenceReadyEpoch(partyCookie.evidenceready);
            if (partyCookie.done) {
                instance.timesCompleted = partyCookie.done;
            } else {
                instance.timesCompleted = 0;
            }
            if (partyCookie.reward) {
                instance.rewardedMedals = partyCookie.reward.medals;
                instance.rewardedItemId = partyCookie.reward.item;
                instance._rewardGranted.dispatch();
            } else {
                instance.rewardedMedals = null;
                instance.rewardedItemId = null;
            }
        }
        static function changeQuestState(newState) {
            if (setQuestState(newState)) {
                sendPartyCookieUpdate();
            }
        }
        static function sendPartyCookieUpdate() {
            if (!SYNC_WITH_SERVER) {
                return(undefined);
            }
            var _local_2 = _global.getCurrentParty();
            _local_2.sendSavePartyCookieJson(PARTY_COOKIE_ID, toJsonObject());
        }
        static function toJsonObject() {
            var _local_4 = new Object();
            _local_4.state = instance.questState;
            _local_4.inventory = new Object();
            var _local_3 = instance.inventory.getItems();
            var _local_1 = 0;
            while (_local_1 < _local_3.length) {
                var _local_2 = _local_3[_local_1];
                _local_4.inventory[_local_2.itemID] = _local_2.isUsed;
                _local_1++;
            }
            if (getEvidenceReadyEpoch()) {
                _local_4.evidenceready = getEvidenceReadyEpoch();
            }
            return(_local_4);
        }
        static function getOpcodeJournal() {
            return(_opcodeJournal);
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static function canSeePizzaParty() {
            return(getQuestState() == QUEST_STATE_DONE);
        }
        static function canCompleteMission() {
            return(getQuestState() == QUEST_STATE_DOOR_UNLOCKED);
        }
        static function markMissionComplete() {
            changeQuestState(QUEST_STATE_DONE);
        }
        static function isOnMission() {
            var _local_1 = getQuestState();
            if (((_local_1 == undefined) || (_local_1 == QUEST_STATE_DONE)) || (_local_1 == QUEST_STATE_MISSION_AVAILABLE)) {
                return(false);
            }
            return(true);
        }
        static function isTrackTrackerCalibrated() {
            var _local_1 = getQuestState();
            return((_local_1 == QUEST_STATE_DOOR_UNLOCKED) || ((_local_1 == QUEST_STATE_EVIDENCE_SUBMITTED) && (getEvidenceReadyInSeconds() == 0)));
        }
        static function hasEvidenceToSubmit() {
            if (getQuestState() == QUEST_STATE_MISSION_ACCEPTED) {
                if (playerHasQuestItem(INVENTORY_FUR) && (playerHasQuestItem(INVENTORY_HOT_SAUCE))) {
                    return(true);
                }
            }
            return(false);
        }
        static var SYNC_WITH_SERVER = true;
        static var PARTY_COOKIE_ID = "20130403";
        static var DELAYED_USE_TRACE_TRACKER_TIME = 500;
        static var MISSION_COMPLETE_BG = 9999;
        static var TRACE_TRACKER_AVATAR_ID = 29;
        static var NONMEMBER_TRACE_TRACKER_AVATAR_ID = 30;
        static var DEFAULT_PENGUIN_AVATAR = 0;
        static var PARTY_CATALOGUE_1 = "w.party.clothing.catalogue1";
        static var PARTY_CATALOGUE_2 = "w.party.clothing.catalogue2";
        static var CONTENT_SCAVENGER_HUNT = "scavenger_hunt";
        static var GO_THERE_POSTER = "party_poster";
        static var QUEST_DIALOG_DIRECTOR_VIDEO = "w.party.04.2013.epfhotsauce.director.video";
        static var QUEST_DIALOG_JETPACK_GUY_1 = "w.party.04.2013.epfhotsauce.jetpackguy.intro";
        static var QUEST_DIALOG_JETPACK_GUY_2 = "w.party.04.2013.epfhotsauce.jetpackguy.more";
        static var QUEST_DIALOG_JETPACK_GUY_3 = "w.party.04.2013.epfhotsauce.jetpackguy.revisit";
        static var QUEST_DIALOG_GARY_FACETIME = "w.party.04.2013.epfhotsauce.gary.facetime";
        static var QUEST_DIALOG_GARY_FACETIME_NONMEMBER = "w.party.04.2013.epfhotsauce.gary.facetime.nonmember";
        static var QUEST_DIALOG_GARY_FACETIME_NONMEMBER_TRACETRACKER_READY = "w.party.04.2013.epfhotsauce.gary.facetime.nonmember.tracetrackerready";
        static var QUEST_DIALOG_HERBERT_MONOLOG = "w.party.04.2013.epfhotsauce.herbert.monolog";
        static var QUEST_DIALOG_HERBERT_AMBIENT = "w.party.04.2013.epfhotsauce.herbert.ambient";
        static var QUEST_DIALOG_HERBERT_OHNO = "w.party.04.2013.epfhotsauce.herbert.ohno";
        static var QUEST_DIALOG_DIRECTOR_FACETIME = "w.party.04.2013.epfhotsauce.director.facetime";
        static var QUEST_DIALOG_ROOKIE = "w.party.04.2013.epfhotsauce.rookie.partysaved";
        static var QUEST_DIALOG_DIRECTOR_FACETIME_VICTORY = "w.party.04.2013.epfhotsauce.director.victory";
        static var QUEST_DIALOG_ROOKIE_NO_PIZZA = "w.party.04.2013.epfhotsauce.rookie.nopizza";
        static var QUEST_DIALOG_ROOKIE_VICTORY = "w.party.04.2013.epfhotsauce.rookie.victory";
        static var QUEST_DIALOG_REWARD = "w.party.04.2013.epfhotsauce.complete.award";
        static var BINOCULARS_HERBERT_KLUTZY_FLOAT_AWAY = "w.party.04.2013.epfhotsauce.binoculars";
        static var QUEST_STATE_MISSION_AVAILABLE = "missionavail";
        static var QUEST_STATE_MISSION_ACCEPTED = "accepted";
        static var QUEST_STATE_EVIDENCE_SUBMITTED = "evidencesubmitted";
        static var QUEST_STATE_DOOR_UNLOCKED = "unlocked";
        static var QUEST_STATE_DONE = "done";
        static var validQuestStates = new Array(QUEST_STATE_MISSION_AVAILABLE, QUEST_STATE_MISSION_ACCEPTED, QUEST_STATE_EVIDENCE_SUBMITTED, QUEST_STATE_DOOR_UNLOCKED, QUEST_STATE_DONE);
        static var FOOTPRINT_RESIDUAL_ALPHA = 20;
        static var FOOTPRINT_MAX_ALPHA = 100;
        static var FOOTPRINT_TRACKER_MAX_RANGE = 75;
        static var FOOTPRINT_TRACKER_MIN_RANGE = 40;
        static var INVENTORY_FUR = new com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO("Fur", 410, com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO.ITEM_TYPE_USEABLE, "w.party.04.2013.epfhotsauce.inventoryicons.fur");
        static var INVENTORY_HOT_SAUCE = new com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO("Hot Sauce", 411, com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO.ITEM_TYPE_USEABLE, "w.party.04.2013.epfhotsauce.inventoryicons.hotsauce");
        static var INVENTORY_NONMEMBER_TRACE_TRACKER = new com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO("Non-member Trace Tracker", 412, com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO.ITEM_TYPE_EFFECT, "w.party.04.2013.epfhotsauce.inventoryicons.nonmembertracetracker");
        static var INVENTORY_PIZZA_SLICE = new com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO("Pizza Slice", 413, com.clubpenguin.hud.epfmission.vo.EPFInventoryItemVO.ITEM_TYPE_TEMPORARY, "w.party.04.2013.epfhotsauce.inventoryicons.pizzaslice");
        static var OOPS_PHONE_GADGET = "oops_party1";
        static var PIZZATRON_NOTE = "w.party.04.2013.epfhotsauce.pizzatron.note";
        static var TRACE_TRACKER_RANGE = 50;
        static var HERBERT_DIALOG_MAX_FRAME = 14;
        static var herbertDialogFrame = 4;
        var _isLockedDoorToHerbertLairShown = false;
        var _traceTrackerEnabled = false;
    }
