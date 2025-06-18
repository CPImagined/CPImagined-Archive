//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.ui.FuturePartyInterface
    {
        var _shell, _interface, _engine, _view, _purchaseItemThrottler, itemButtonHolder, _pointsDisplay, _protobotCountdown, _airtower, _handleUpdateProtobotCountdownDelegate, _countdownInterval, _handleUpdateProtobotCountdownUpdateDelegate, _buyJetpackDelegate;
        function FuturePartyInterface (view) {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("FuturePartyInterface()" + view);
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _view = view;
            _view._visible = false;
            isMember = _shell.isMyPlayerMember();
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
        }
        function get isProtobotBattleActive() {
            return(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.PARTY_DAY >= com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.PROTOBOT_BATTLE_PARTY_DAY);
        }
        function get isProtobotRewardActive() {
            trace("FutureParty.partyCookie.hasDefeatedProtobot " + com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.hasDefeatedProtobot);
            return(com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.hasDefeatedProtobot);
        }
        function init() {
            itemButtonHolder = new Object();
            setupUI();
            setupItems();
            setupRobos();
            _view.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onInitialized);
        }
        function setupUI() {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("setupUI()");
            _view.jetpack_mc.jetpack_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onEquipClicked);
            _view.jetpack_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onEquipClicked);
            _pointsDisplay = new com.clubpenguin.world.rooms2014.future.ui.components.AsteroidPointsDisplay(_view.pointsDisplay);
            trace("FutureParty.partyCookie.asteroidPoints " + com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.asteroidPoints);
            _view.rewards_mc.gotoAndStop(1);
            _view.oops_msg_mc.gotoAndStop(1);
            enableMoreItemsButton();
            _view.closebtn.onRelease = com.clubpenguin.util.Delegate.create(this, closeUI);
        }
        function handleTransitionToMoreItems() {
            com.clubpenguin.world.rooms2014.future.FutureParty.playSound(_view, "sfx_select");
            _view.moreItems_Btn.onRelease = null;
            com.greensock.TweenMax.to(_view.rewards_mc, 0.5, {_alpha:0, onComplete:com.clubpenguin.util.Delegate.create(this, showWeekItems)});
        }
        function showWeekItems() {
            com.greensock.TweenMax.to(_view.rewards_mc, 0.5, {_alpha:100, onComplete:com.clubpenguin.util.Delegate.create(this, enableMoreItemsButton)});
            _view.rewards_mc.gotoAndStop(((_view.rewards_mc._currentframe == 2) ? 1 : 2));
            setupItems();
        }
        function enableMoreItemsButton() {
            _view.moreItems_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, handleTransitionToMoreItems);
        }
        function setupItems() {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("setupDayItems()");
            setCountdownDate();
            var _local_9 = ((_view.rewards_mc._currentframe == 1) ? 4 : 8);
            var _local_10 = ((_view.rewards_mc._currentframe == 1) ? 0 : 4);
            var _local_2 = _local_10;
            while (_local_2 < _local_9) {
                var _local_4 = com.clubpenguin.world.rooms2014.future.FutureParty.getNonmemberPartyItemByUnlockDay(_local_2);
                if (_local_4 != undefined) {
                    var _local_7 = MovieClip(_view.rewards_mc[("item" + _local_2) + "_n_mc"]);
                    _local_7.gotoAndStop((((_local_2 == 7) && (isProtobotRewardActive)) ? "available" : "unlocked"));
                    var _local_6 = com.clubpenguin.ui.itembuttons.BuyPaperItemButton(com.clubpenguin.ui.itembuttons.BuyButtonFactory.getBuyButton(_local_4, _local_7));
                    _local_6.customPurchase = com.clubpenguin.util.Delegate.create(this, onPurchaseButtonClicked, _local_4.id, _local_7);
                    _local_6.purchaseSound = "sfx_collect";
                    _local_6.callback = com.clubpenguin.util.Delegate.create(this, handleItemPurchased, _local_4.id, _local_7);
                    _local_6.create();
                    itemButtonHolder["id" + _local_4.id] = _local_6;
                }
                var _local_5 = com.clubpenguin.party.items.PartyItem(com.clubpenguin.world.rooms2014.future.FutureParty.getMemberPartyItemByUnlockDay(_local_2));
                if (_local_5 != undefined) {
                    var _local_8 = MovieClip(_view.rewards_mc[("item" + _local_2) + "_mc"]);
                    _local_8.gotoAndStop((((_local_2 == 7) && (isProtobotRewardActive)) ? "available" : "unlocked"));
                    var _local_3 = com.clubpenguin.ui.itembuttons.BuyPaperItemButton(com.clubpenguin.ui.itembuttons.BuyButtonFactory.getBuyButton(_local_5, _local_8));
                    _local_3.oopsMsgPath = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE;
                    _local_3.customPurchase = com.clubpenguin.util.Delegate.create(this, onPurchaseButtonClicked, _local_5.id, _local_8);
                    _local_3.purchaseSound = "sfx_collect";
                    _local_3.callback = com.clubpenguin.util.Delegate.create(this, handleItemPurchased, _local_5.id, _local_8);
                    _local_3.create();
                    itemButtonHolder["id" + _local_5.id] = _local_3;
                }
                _local_2++;
            }
        }
        function onPurchaseButtonClicked(itemId, itemMC) {
            var _local_2 = itemButtonHolder["id" + itemId];
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("onPurchaseButtonClicked() itemId " + _local_2);
            var _local_7 = com.clubpenguin.ui.itembuttons.BuyItemButtonBase(_local_2);
            var _local_6 = _shell.getInventoryObjectById(itemId);
            var _local_5 = _local_6.cost;
            if ((com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.asteroidPoints - _local_5) < 0) {
                showPointsOopsMessage();
                _local_2.removeItemPurchasedListener();
                return(undefined);
            }
            _purchasedItemsInQueue.push(itemId);
            itemMC.attachMovie("loadingMC", "loadingMC" + itemId, itemMC.getNextHighestDepth(), {_x:itemMC._width / 2, _y:itemMC._height / 2});
            _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.future.FutureParty, com.clubpenguin.world.rooms2014.future.FutureParty.sendPurchaseFutureItem, itemId));
        }
        function handleItemPurchased(itemId, itemMC) {
            itemMC["loadingMC" + itemId].removeMovieClip();
        }
        function setCountdownDate() {
            var _local_3 = _view.rewards_mc[PROTOBOT_BATTLE_MC];
            var _local_2 = Number(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.PROTOBOT_BATTLE_PARTY_DAY - com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.PARTY_DAY);
            trace("numDays " + _local_2);
            var _local_4 = ((_local_2 < 10) ? ("0" + _local_2) : (_local_2.toString()));
            _local_3.countdown.timer.text = (((!isNaN(_local_2)) && (_local_2 > 0)) ? ((_local_4 + " ") + getTranslatedDayString(_local_2)) : "");
            if (_local_2 <= 0) {
                if (_protobotCountdown == undefined) {
                    addListenerForProtobotCountdown();
                } else {
                    handleUpdateProtobotCountdown();
                }
            }
        }
        function getTranslatedDayString(numDays) {
            return(((numDays == 1) ? (_shell.getLocalizedString("Day")) : (_shell.getLocalizedString("Days"))));
        }
        function addListenerForProtobotCountdown() {
            _airtower = _global.getCurrentAirtower();
            _handleUpdateProtobotCountdownDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdateProtobotCountdown);
            _airtower.addListener(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.GET_PROTOBOT_COUNTDOWN, _handleUpdateProtobotCountdownDelegate);
            com.clubpenguin.world.rooms2014.future.FutureParty.sendGetProtobotCountdown();
            clearInterval(_countdownInterval);
            _handleUpdateProtobotCountdownUpdateDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdateProtobotCountdown);
            _countdownInterval = setInterval(_handleUpdateProtobotCountdownUpdateDelegate, 1000);
        }
        function handleUpdateProtobotCountdown(data) {
            if (data != undefined) {
                _airtower.removeListener(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.GET_PROTOBOT_COUNTDOWN, _handleUpdateProtobotCountdownDelegate);
            }
            var _local_6 = _view.rewards_mc[PROTOBOT_BATTLE_MC];
            var _local_4 = ((data == undefined) ? (_protobotCountdown) : (Number(data[1])));
            _protobotCountdown = _local_4;
            if (_protobotCountdown > 0) {
                _protobotCountdown = _protobotCountdown - 1000;
            }
            var _local_5 = Math.round(_local_4 / 1000);
            var _local_3 = Math.floor(_local_5 / 60);
            var _local_2 = _local_5 - (_local_3 * 60);
            if ((_local_3 < 0) || (isNaN(_local_3))) {
                _local_3 = 0;
            }
            if ((_local_2 < 0) || (isNaN(_local_2))) {
                _local_2 = 0;
            }
            var _local_7 = ((_local_2 < 10) ? ("0" + _local_2) : (_local_2));
            _local_6.countdown.timer.text = (_local_3 + ":") + _local_7;
        }
        function setupProtobotAwardItems() {
            var _local_2 = _view[PROTOBOT_BATTLE_MC];
            var _local_3 = MovieClip(_local_2[PROTOBOT_NON_ITEM_MC]);
            var _local_5 = true;
            var _local_7 = new com.clubpenguin.world.rooms2014.future.ui.components.FuturePartyItem(_local_3, CLAIM_BUTTON, com.clubpenguin.party.items.PaperItem(com.clubpenguin.world.rooms2014.future.FutureParty.getNonmemberPartyItemByUnlockDay(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.PROTOBOT_BATTLE_PARTY_DAY)), com.clubpenguin.util.Delegate.create(this, onPurchaseButtonClicked));
            var _local_4 = MovieClip(_local_2[PROTOBOT_MEMBER_ITEM_MC]);
            var _local_6 = new com.clubpenguin.world.rooms2014.future.ui.components.FuturePartyItem(_local_4, CLAIM_BUTTON, com.clubpenguin.party.items.PaperItem(com.clubpenguin.world.rooms2014.future.FutureParty.getMemberPartyItemByUnlockDay(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.PROTOBOT_BATTLE_PARTY_DAY)), com.clubpenguin.util.Delegate.create(this, onPurchaseButtonClicked));
        }
        function onInitialized() {
            _view._visible = true;
            _view.onEnterFrame = undefined;
        }
        function onEquipClicked() {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("onEquipClicked()");
            com.clubpenguin.world.rooms2014.future.FutureParty.playSound(_view, "sfx_select");
            if (!_shell.isItemInMyInventory(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.JETPACK_ITEM_ID)) {
                _buyJetpackDelegate = com.clubpenguin.util.Delegate.create(this, onJetpackBought);
                _shell.addListener(_shell.BUY_INVENTORY, _buyJetpackDelegate);
                _shell.sendBuyInventory(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.JETPACK_ITEM_ID);
            } else {
                equipJetpack();
            }
        }
        function onJetpackBought(event) {
            _shell.removeListener(_shell.BUY_INVENTORY, _buyJetpackDelegate);
            if (event.success) {
                trace("update player neck item");
                setTimeout(com.clubpenguin.util.Delegate.create(this, equipJetpack), 1000);
            }
        }
        function equipJetpack() {
            _shell.sendUpdatePlayerNeck(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.JETPACK_ITEM_ID);
            closeUI();
        }
        function setupRobos() {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("setupRobos()");
            var _local_2 = 0;
            while (_local_2 < NUM_MECHS) {
                _view["robot_" + _local_2].gotoAndStop("inactive");
                _view["robot_" + _local_2].robobtn.onRelease = com.clubpenguin.util.Delegate.create(this, onTransformClicked, _local_2);
                _local_2++;
            }
            var _local_3 = com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotType(_shell.getMyPlayerId());
            if (_local_3 >= 0) {
                _view["robot_" + _local_3].gotoAndStop("active");
                enableCustomizeButton();
            }
        }
        function onTransformClicked(roboNum) {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("onTransformClicked()" + this);
            if (isMember) {
                toggleRobo(roboNum);
                enableCustomizeButton();
            } else {
                showRoboOopsMessage();
            }
        }
        function toggleRobo(roboNum) {
            var _local_2;
            var _local_3 = com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.getRoboPaint(roboNum);
            if (roboNum == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_A) {
                _local_2 = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_A_IDS[_local_3];
            }
            if (roboNum == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_B) {
                _local_2 = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_B_IDS[_local_3];
            }
            if (roboNum == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_C) {
                _local_2 = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_C_IDS[_local_3];
            }
            if (_local_2 != undefined) {
                com.clubpenguin.world.rooms2014.future.FutureParty.sendMechTransformation(_local_2);
                com.clubpenguin.world.rooms2014.future.FutureParty.playSound(_view, "sfx_transform");
                setTimeout(com.clubpenguin.util.Delegate.create(this, closeUI), 1000);
            }
        }
        function enableCustomizeButton() {
            _view.customizeButton.gotoAndStop(2);
            _view.customizeButton.paint_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, onCustomizeButtonClicked);
        }
        function showMemberItemOopsMessage() {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("showMemberItemOopsMessage()");
            _interface.showContent(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE);
        }
        function showRoboOopsMessage() {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("showRoboOopsMessage()");
            _interface.showContent(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.OOPS_MEMBER_MECHS_MESSAGE);
        }
        function showPointsOopsMessage() {
            var _local_2 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_view.oops_msg_mc, com.clubpenguin.util.Delegate.create(this, configureOopsButtons), 2, 10);
        }
        function configureOopsButtons() {
            _view.oops_msg_mc.ok_btn.onRelease = com.clubpenguin.util.Delegate.create(this, closeOopsMessage);
            _view.oops_msg_mc.close_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, closeOopsMessage);
            _view.oops_msg_mc.map_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openPartyMap);
        }
        function closeOopsMessage() {
            _view.oops_msg_mc.play();
        }
        function openPartyMap() {
            _interface.showContent(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.PARTY_MAP);
        }
        function closeUI() {
            clean();
            com.clubpenguin.world.rooms2014.future.FutureParty.playSound(_view, "sfx_close");
            setTimeout(com.clubpenguin.util.Delegate.create(_interface, _interface.closeContent), 500);
        }
        function clean() {
            _pointsDisplay.clean();
            clearInterval(_countdownInterval);
            _shell.removeListener(_shell.BUY_INVENTORY, _buyJetpackDelegate);
        }
        function onCustomizeButtonClicked() {
            com.clubpenguin.world.rooms2014.future.FutureParty.pebug("onCustomizeButtonClicked()");
            _shell.sendJoinRoom("party5");
            closeUI();
        }
        function toString() {
            return("[FuturePartyInterface Object]");
        }
        static var NON_MEMBER = false;
        static var MEMBER = true;
        static var NUM_MECHS = 3;
        static var NUM_DAYS = 5;
        static var MECH_FRAME_PREFIX = "robot";
        static var MECH_STUB = "robot%s_btn";
        static var DAYS_STUB = "day%s_mc";
        static var ITEM_DAY0_NON = "item_day0_non_mc";
        static var ITEM_DAY0 = "item_day0_mc";
        static var PROTOBOT_NON_ITEM_MC = "item7_non_mc";
        static var PROTOBOT_MEMBER_ITEM_MC = "item7_mc";
        static var FREE_BUY_BUTTON = "free_buy";
        static var MEMBER_BUY_BUTTON = "member_buy";
        static var CLAIM_BUTTON = "claim_btn";
        static var ASTEROID_POINTS = "asteroidPoints";
        static var PROTOBOT_BATTLE_MC = "protobot_mc";
        static var PROTOBOT_COUNTDOWN_FRAME = 1;
        static var PROTOBOT_UNLOCK_FRAME = 2;
        static var PROTOBOT_ITEMS_FRAME = 3;
        var isMember = true;
        var _purchasedItemsInQueue = new Array();
    }
