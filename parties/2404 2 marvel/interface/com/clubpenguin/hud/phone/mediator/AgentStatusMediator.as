//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.AgentStatusMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var agentStatusView, epfService, inventory, inventoryCrumbs, player, INTERFACE, SHELL, context, view, setLanguageCode, onClosed, delayedServiceCall, itemsList, itemsList2, itemsList3, itemsList4, itemsList5, purchaseItemID, unusedPoints;
        function AgentStatusMediator (view, context) {
            super(view, context.appClosed, context.languageCode);
            agentStatusView = view;
            epfService = context.epfService;
            inventory = context.inventory;
            inventoryCrumbs = context.inventoryCrumbs;
            player = context.player;
            INTERFACE = context.INTERFACE;
            SHELL = context.SHELL;
            this.context = context;
        }
        function initView(view) {
            if (SHELL.isMyIgloo() || (SHELL.getIsRoomIgloo())) {
                SHELL.sendHideLikeWindow();
            }
            this.view = view;
            view.closed.add(closeMe, this);
            agentStatusView = view;
            epfService.pointsReceived.add(onPointsReceived, this);
            epfService.itemBought.add(onItemBought, this);
            agentStatusView.insufficientPoints._visible = false;
            agentStatusView.insufficientPoints.modal.onPress = null;
            agentStatusView.insufficientPoints.modal.useHandCursor = false;
            agentStatusView.insufficientPoints.ok.onPress = com.clubpenguin.util.Delegate.create(this, confirmInsufficientPoints);
            setupInstructions();
            setupItemWindowTabs();
            setupItemDialogs();
            showPage5();
            showPage4();
            showPage3();
            showPage2();
            showPage1();
            setLanguageCode(context.languageCode);
            epfService.getPoints();
        }
        function closeMe() {
            if (SHELL.isMyIgloo() || (SHELL.getIsRoomIgloo())) {
                SHELL.sendShowLikeWindow();
            }
            onClosed();
        }
        function setupDelay() {
            _global.clearTimeout(delayedServiceCall);
            delayedServiceCall = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, delayedSetup), 40);
        }
        function delayedSetup() {
            _global.clearTimeout(delayedServiceCall);
        }
        function delayedGetPointsServiceCall() {
            _global.clearTimeout(delayedServiceCall);
            epfService.getPoints();
        }
        function setupInstructions() {
            agentStatusView.instructions._visible = false;
            agentStatusView.instructions.modal.onPress = null;
            agentStatusView.instructions.modal.useHandCursor = false;
            var _local_2 = com.clubpenguin.util.Delegate.create(this, toggleInstructions);
            agentStatusView.instructionsButton["button"].onPress = _local_2;
            agentStatusView.instructions.close["button"].onPress = _local_2;
        }
        function hideAllPages() {
            agentStatusView.itemsList._visible = false;
            agentStatusView.itemsList2._visible = false;
            agentStatusView.itemsList3._visible = false;
            agentStatusView.itemsList4._visible = false;
            agentStatusView.itemsList5._visible = false;
            agentStatusView.windowTab1._visible = false;
            agentStatusView.windowTab2._visible = false;
            agentStatusView.windowTab3._visible = false;
            agentStatusView.windowTab4._visible = false;
            agentStatusView.windowTab5._visible = false;
        }
        function showPage1() {
            hideAllPages();
            agentStatusView.itemsList._visible = true;
            agentStatusView.windowTab1._visible = true;
            setupItemsList(agentStatusView.itemsList);
        }
        function showPage2() {
            hideAllPages();
            agentStatusView.itemsList2._visible = true;
            agentStatusView.windowTab2._visible = true;
            setupItemsList(agentStatusView.itemsList2);
        }
        function showPage3() {
            hideAllPages();
            agentStatusView.itemsList3._visible = true;
            agentStatusView.windowTab3._visible = true;
            setupItemsList(agentStatusView.itemsList3);
        }
        function showPage4() {
            hideAllPages();
            agentStatusView.itemsList4._visible = true;
            agentStatusView.windowTab4._visible = true;
            setupItemsList(agentStatusView.itemsList4);
        }
        function showPage5() {
            hideAllPages();
            agentStatusView.itemsList5._visible = true;
            agentStatusView.windowTab5._visible = true;
            setupItemsList(agentStatusView.itemsList5);
        }
        function setupItemWindowTabs() {
            var _local_4 = com.clubpenguin.util.Delegate.create(this, showPage1);
            var _local_3 = com.clubpenguin.util.Delegate.create(this, showPage2);
            var _local_2 = com.clubpenguin.util.Delegate.create(this, showPage3);
            var _local_6 = com.clubpenguin.util.Delegate.create(this, showPage4);
            var _local_5 = com.clubpenguin.util.Delegate.create(this, showPage5);
            agentStatusView.eliteGearBackdrop.windowButton1.onPress = _local_4;
            agentStatusView.eliteGearBackdrop.windowButton2.onPress = _local_3;
            agentStatusView.eliteGearBackdrop.windowButton3.onPress = _local_2;
            agentStatusView.eliteGearBackdrop.windowButton4.onPress = _local_6;
            agentStatusView.eliteGearBackdrop.windowButton5.onPress = _local_5;
        }
        function setupItemDialogs() {
            agentStatusView.itemConfirmation._visible = false;
            agentStatusView.itemConfirmation.modal.onPress = null;
            agentStatusView.itemConfirmation.modal.useHandCursor = false;
            agentStatusView.itemConfirmation.ok.onPress = com.clubpenguin.util.Delegate.create(this, confirmBuyItem);
            agentStatusView.itemConfirmation.cancel.onPress = com.clubpenguin.util.Delegate.create(this, cancelBuyItem);
            agentStatusView.itemExists._visible = false;
            agentStatusView.itemExists.modal.onPress = null;
            agentStatusView.itemExists.ok.onPress = com.clubpenguin.util.Delegate.create(this, confirmItemExists);
        }
        function setupItemsList(listClip) {
            var _local_5;
            if (listClip == agentStatusView.itemsList) {
                itemsList = new com.clubpenguin.scrollinglist.ScrollingList(listClip);
                _local_5 = agentStatusView.itemsList.content;
            } else if (listClip == agentStatusView.itemsList2) {
                itemsList2 = new com.clubpenguin.scrollinglist.ScrollingList(listClip);
                _local_5 = agentStatusView.itemsList2.content;
            } else if (listClip == agentStatusView.itemsList3) {
                itemsList3 = new com.clubpenguin.scrollinglist.ScrollingList(listClip);
                _local_5 = agentStatusView.itemsList3.content;
            } else if (listClip == agentStatusView.itemsList4) {
                itemsList4 = new com.clubpenguin.scrollinglist.ScrollingList(listClip);
                _local_5 = agentStatusView.itemsList4.content;
            } else if (listClip == agentStatusView.itemsList5) {
                itemsList5 = new com.clubpenguin.scrollinglist.ScrollingList(listClip);
                _local_5 = agentStatusView.itemsList5.content;
            }
            var _local_2;
            var _local_3 = -1;
            var _local_7 = "";
            var _local_4 = 0;
            var _local_6 = false;
            var _local_10;
            for (var _local_9 in _local_5) {
                _local_2 = MovieClip(_local_5[_local_9]);
                if (!_local_2) {
                    continue;
                }
                if (_local_2._name.indexOf(ITEM_PREFIX) != 0) {
                    continue;
                }
                _local_3 = parseInt(_local_2._name.slice(ITEM_PREFIX.length));
                _local_7 = inventoryCrumbs[_local_3].name;
                _local_4 = parseInt(inventoryCrumbs[_local_3].cost);
                _local_6 = Boolean(inventoryCrumbs[_local_3].is_member);
                _local_2.name.text = _local_7;
                _local_2.cost.text = _local_4;
                _local_2.onPress = com.clubpenguin.util.Delegate.create(this, onItemClicked, _local_3, _local_4, _local_6);
            }
        }
        function confirmInsufficientPoints() {
            agentStatusView.insufficientPoints._visible = false;
        }
        function onItemBought(unusedPoints) {
            agentStatusView.unusedPoints.text = String(unusedPoints);
            SHELL.addItemToInventory(purchaseItemID);
        }
        function onPointsReceived(unusedPoints, totalPoints) {
            this.unusedPoints = unusedPoints;
            agentStatusView.unusedPoints.text = String(unusedPoints);
            agentStatusView.totalPoints.text = String(totalPoints);
        }
        function toggleInstructions() {
            agentStatusView.instructions._visible = !agentStatusView.instructions._visible;
        }
        function confirmBuyItem() {
            epfService.buyItem(purchaseItemID);
            agentStatusView.itemConfirmation._visible = false;
            _global.clearTimeout(delayedServiceCall);
            delayedServiceCall = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, delayedGetPointsServiceCall), 1000);
        }
        function confirmItemExists() {
            agentStatusView.itemExists._visible = false;
        }
        function cancelBuyItem() {
            agentStatusView.itemConfirmation._visible = false;
        }
        function onItemClicked(itemID, itemCost, itemMembership) {
            if (itemMembership && (!player.is_member)) {
                INTERFACE.showWindow("oops_epf_gear", null, "oops_epf_gear");
                return(undefined);
            }
            SHELL.updateListeners(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, new com.clubpenguin.shell.events.MembershipEvent(com.clubpenguin.shell.events.MembershipEvent.MEMBER_ONLY_ACTIVITY, com.clubpenguin.shell.events.MembershipEventContext.BUY_AGENT_CATALOG_ITEM, "epfitem_" + String(itemID)));
            if (checkPlayerOwnsItem(itemID)) {
                agentStatusView.itemExists._visible = true;
                return(undefined);
            }
            if (itemCost > unusedPoints) {
                agentStatusView.insufficientPoints._visible = true;
                return(undefined);
            }
            purchaseItemID = itemID;
            agentStatusView.itemConfirmation._visible = true;
        }
        function checkPlayerOwnsItem(itemID) {
            var _local_2 = 0;
            while (_local_2 < inventory.length) {
                if (inventory[_local_2].id == itemID) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        static var ITEM_PREFIX = "item_";
    }
