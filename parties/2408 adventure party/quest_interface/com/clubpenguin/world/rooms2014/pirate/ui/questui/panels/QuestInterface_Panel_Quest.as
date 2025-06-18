//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.ui.questui.panels.QuestInterface_Panel_Quest
    {
        var _view, _vendingMachine, _questVO, _questDisplay;
        function QuestInterface_Panel_Quest (skin, roomID, vendingMachine) {
            _view = skin;
            _vendingMachine = vendingMachine;
            getQuestVO(roomID);
            configureQuestDisplay();
        }
        function getQuestVO(roomID) {
            _questVO = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getQuestVOByRoomID(roomID);
        }
        function configureQuestDisplay() {
            _questDisplay = _view.questdisplay;
            if (com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.PARTY_DAY < _questVO.unlockDay) {
                showStateLocked();
            } else {
                trace("Has the task been completed? " + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getTaskStatus(_questVO));
                if (com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getTaskStatus(_questVO)) {
                    showStateComplete();
                } else {
                    showStateIncomplete();
                }
            }
        }
        function showStateLocked() {
            _questDisplay.gotoAndStop(FRAME_LOCKED);
        }
        function showStateIncomplete() {
            _questDisplay.gotoAndStop(FRAME_UNLOCKED);
            _questDisplay.buttongothere.onRelease = com.clubpenguin.util.Delegate.create(this, buttonGoThere_Click_Handler);
        }
        function showStateComplete() {
            trace("------showStateComplete!!");
            _questDisplay.gotoAndStop(FRAME_COMPLETE);
            createBuyButton(_questVO.memberItemVO, _questDisplay.item_member);
            createBuyButton(_questVO.nonMemberItemVO, _questDisplay.item_nonmember);
            if ((_questDisplay.item_member._currentframe == _questDisplay.item_member._totalframes) && (_questDisplay.item_nonmember._currentframe == _questDisplay.item_member._totalframes)) {
                _questDisplay.chestMC.gotoAndStop("empty");
            } else {
                _questDisplay.chestMC.gotoAndStop("open");
            }
        }
        function createBuyButton(partyItem, movieClip) {
            var _local_2 = com.clubpenguin.ui.itembuttons.BuyButtonFactory.getBuyButton(partyItem, movieClip);
            _local_2.prompt = false;
            _local_2.purchaseSound = "sfx_collect";
            _local_2.setIsEquipable(true);
            _local_2.oopsMsgPath = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE;
            if (partyItem.id == com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.PARTY_SERVICE.piratePuffleReward) {
                _local_2.callback = com.clubpenguin.util.Delegate.create(this, handlePuffleItemPurchased);
                com.clubpenguin.ui.itembuttons.BuyPuffleItemButton(_local_2).quantityTextName = "quantityText";
            }
            _vendingMachine.add(_local_2);
        }
        function handlePuffleItemPurchased() {
            com.clubpenguin.util.TrackerAS2.getInstance().trackRewardEarned(com.clubpenguin.util.TrackerAS2.CURRENCY_ITEMS, -1, "puffle_hat", "Swashbuckler Hat", _global.getCurrentShell().getMyPlayerTotalCoins());
        }
        function buttonGoThere_Click_Handler() {
            var _local_3 = _global.getCurrentShell().getRoomNameById(_questVO.roomId);
            _global.getCurrentParty().BaseParty.sendGoThereBI(_local_3);
            _global.getCurrentParty().BaseParty.soundButton(_questDisplay.buttongothere, "sfx_gothere", com.clubpenguin.util.Delegate.create(this, closeUI, _local_3), 1200);
        }
        function closeUI(roomName) {
            _global.getCurrentShell().sendJoinRoom(roomName);
            _global.getCurrentInterface().closeContent();
        }
        static var FRAME_LOCKED = 1;
        static var FRAME_UNLOCKED = 2;
        static var FRAME_COMPLETE = 3;
    }
