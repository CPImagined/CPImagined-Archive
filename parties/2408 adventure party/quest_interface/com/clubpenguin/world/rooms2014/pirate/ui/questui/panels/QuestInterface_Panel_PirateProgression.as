//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.ui.questui.panels.QuestInterface_Panel_PirateProgression
    {
        var _view, _currentPoints, _purchaseItemThrottler, _starterSwordVO, _progressBarMeter;
        function QuestInterface_Panel_PirateProgression (skin) {
            _view = skin;
            _currentPoints = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.partyCookie.points;
            configureProgressionPanelState();
            _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
            _purchaseItemThrottler.delayBetweenEvents = 2000;
        }
        function configureProgressionPanelState() {
            _starterSwordVO = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getSwordVOByID(WOODEN_SWORD_ID);
            createBuyButton(_starterSwordVO.itemVO, _view.woodenSwordButton);
            _progressBarMeter = _view.progressBar.meter;
            _progressBarMeter.gotoAndStop(1);
            if (_global.getCurrentShell().isItemInMyInventory(_starterSwordVO.itemID)) {
                configurePanelUnlockedState();
            } else {
                _view.gotoAndStop(FRAME_LOCKED);
            }
        }
        function configurePanelUnlockedState() {
            trace("configurePanelUnlockedState");
            _view.gotoAndStop(FRAME_UNLOCKED);
            configureEquipSword();
            configureSwordRewards();
            configureCoinRewards();
            configureFinalRewards();
            configureProgressBar();
        }
        function configureEquipSword() {
            _view.equipWoodenSword_btn.onRelease = com.clubpenguin.util.Delegate.create(this, equipStarterSword);
        }
        function equipStarterSword() {
            _global.getCurrentShell().sendUpdatePlayerHand(_starterSwordVO.itemID);
            _global.getCurrentParty().BaseParty.soundButton(_view.equipWoodenSword_btn, "sfx_close", com.clubpenguin.util.Delegate.create(this, closeUI), 500);
        }
        function configureSwordRewards() {
            var _local_2 = 1;
            while (_local_2 < com.clubpenguin.world.rooms2014.pirate.party.PirateParty.swordVOs.length) {
                var _local_3 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getSwordVOByID(_local_2);
                if (_currentPoints < _local_3.points) {
                    _view.swordRewardsView["duelitem_" + _local_2].gotoAndStop(FRAME_LOCKED);
                } else {
                    unlockSword(_view.swordRewardsView["duelitem_" + _local_2], _local_3);
                }
                _local_2++;
            }
        }
        function unlockSword(swordMC, swordVO) {
            swordMC.gotoAndStop(FRAME_UNLOCKED);
            createBuyButton(swordVO.itemVO, swordMC);
        }
        function configureCoinRewards() {
            var _local_2 = 1;
            while (_local_2 < com.clubpenguin.world.rooms2014.pirate.party.PirateParty.swordVOs.length) {
                var _local_3 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getSwordVOByID(_local_2);
                if (_currentPoints < _local_3.points) {
                    _view.coinRewardsView["coinreward_" + _local_2].gotoAndStop(FRAME_LOCKED);
                } else {
                    unlockCoinReward(_view.coinRewardsView["coinreward_" + _local_2], _local_2);
                }
                _local_2++;
            }
        }
        function unlockCoinReward(mc, coinRewardID) {
            trace("PirateParty.partyCookie.coinRewards " + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.partyCookie.coinRewards);
            trace("PirateParty.partyCookie.coinRewards[coinRewardID-1] " + com.clubpenguin.world.rooms2014.pirate.party.PirateParty.partyCookie.coinRewards[coinRewardID - 1]);
            if (Number(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.partyCookie.coinRewards[coinRewardID - 1]) == 1) {
                mc.gotoAndStop(FRAME_COMPLETE);
                return(undefined);
            }
            mc.gotoAndStop(FRAME_UNLOCKED);
            mc.claim_btn.onRelease = com.clubpenguin.util.Delegate.create(this, sendCollectCoinReward, mc, coinRewardID);
        }
        function sendCollectCoinReward(mc, coinRewardID) {
            if (mc.loadingMC != undefined) {
                mc.loadingMC._visible = true;
            } else {
                mc.attachMovie("loadingMC", "loadingMC", mc.getNextHighestDepth(), {_x:mc._width / 2, _y:mc._height / 2});
            }
            _purchasedItemsInQueue.push(coinRewardID);
            _purchaseItemThrottler.queueFunction(com.clubpenguin.util.Delegate.create(this, collectCoinReward, mc, coinRewardID));
        }
        function isItemInLoadingQueue(coinRewardID) {
            if (_purchasedItemsInQueue.length == 0) {
                return(false);
            }
            var _local_2 = 0;
            while (_local_2 < _purchasedItemsInQueue.length) {
                if (_purchasedItemsInQueue[_local_2] == coinRewardID) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function removePurchasedItemFromQueue(coinRewardID) {
            var _local_2 = 0;
            while (_local_2 < _purchasedItemsInQueue.length) {
                if (_purchasedItemsInQueue[_local_2] == coinRewardID) {
                    _purchasedItemsInQueue.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
        }
        function collectCoinReward(mc, coinRewardID) {
            trace("mc[loadingMC] " + mc.loadingMC);
            mc.loadingMC.removeMovieClip();
            mc.loadingMC = undefined;
            mc.gotoAndStop(FRAME_COMPLETE);
            com.clubpenguin.world.rooms2014.pirate.party.PirateParty.sendCollectSwordReward(coinRewardID);
            removePurchasedItemFromQueue(coinRewardID);
        }
        function configureFinalRewards() {
            var _local_2 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.finalRewardsVO;
            if (_currentPoints >= Number(_local_2.points)) {
                _view.final_nonmember.gotoAndStop(FRAME_UNLOCKED);
                _view.final_member.gotoAndStop(FRAME_UNLOCKED);
                createBuyButton(_local_2.memberItemVO, _view.final_member);
                createBuyButton(_local_2.nonMemberItemVO, _view.final_nonmember);
            }
        }
        function configureProgressBar() {
            var _local_7 = com.clubpenguin.world.rooms2014.pirate.vo.PiratePartySwordVO(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.swordVOs[com.clubpenguin.world.rooms2014.pirate.party.PirateParty.swordVOs.length - 1]).points;
            var _local_2 = currentSwordLevelReached;
            var _local_4 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getSwordVOByID(_local_2 + 1).points;
            var _local_5 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getSwordVOByID(_local_2).points;
            if (isNaN(_local_4)) {
                _local_4 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.finalRewardsVO.points;
            }
            var _local_3 = 1;
            if (_currentPoints == _local_5) {
                _local_3 = Number(_local_2 - 1) * 20;
            }
            _local_3 = Number(_local_2) * 20;
            if (_currentPoints > _local_5) {
                var _local_6 = 1 - ((_local_4 - _currentPoints) / (_local_4 - _local_5));
                _local_3 = (Number(_local_2) * 20) + Math.round(_local_6 * 20);
            }
            _progressBarMeter.gotoAndStop(_local_3);
        }
        function get currentSwordLevelReached() {
            var _local_3 = 1;
            while (_local_3 < com.clubpenguin.world.rooms2014.pirate.party.PirateParty.swordVOs.length) {
                var _local_2 = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.getSwordVOByID(_local_3);
                if (_currentPoints < _local_2.points) {
                    return(Number(_local_2.swordID - 1));
                } else if ((_currentPoints == _local_2.points) || ((_currentPoints < Number(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.finalRewardsVO.points)) && (_local_3 == (com.clubpenguin.world.rooms2014.pirate.party.PirateParty.swordVOs.length - 1)))) {
                    return(Number(_local_2.swordID));
                } else if (_currentPoints >= Number(com.clubpenguin.world.rooms2014.pirate.party.PirateParty.finalRewardsVO.points)) {
                    return(Number(_local_2.swordID + 1));
                } else {
                }
                _local_3++;
            }
        }
        function createBuyButton(paperItem, movieClip, member) {
            var _local_1 = com.clubpenguin.ui.itembuttons.BuyButtonFactory.getBuyButton(paperItem, movieClip);
            _local_1.prompt = false;
            _local_1.purchaseSound = "sfx_collect";
            _local_1.setIsEquipable(true);
            _local_1.oopsMsgPath = com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE;
            _local_1.create();
        }
        function closeUI() {
            _global.getCurrentInterface().closeContent();
        }
        static var WOODEN_SWORD_ID = 0;
        static var FINAL_QUEST_ID = 7;
        static var FRAME_LOCKED = 1;
        static var FRAME_UNLOCKED = 2;
        static var FRAME_COMPLETE = 3;
        static var TIMEOUT_PERIOD = 5000;
        var _purchasedItemsInQueue = new Array();
    }
