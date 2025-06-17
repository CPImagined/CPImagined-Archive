//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel3
    {
        var _view;
        function QuestInterface_Panel3 (view) {
            _view = view;
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("QuestInterface_Panel3 *** _view : " + _view, CLASS_NAME);
            if (com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PARTY_DAY >= 6) {
                configurePanel();
            } else {
                com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("NOT PARTY DAY 7 YET - PANEL_3 REMAINS LOCKED", CLASS_NAME);
            }
        }
        function configurePanel() {
            _view.lockedPanel_mc._visible = false;
            var _local_2 = 0;
            _local_2 = 0;
            while (_local_2 < 3) {
                com.clubpenguin.world.rooms2015.may.party.MayParty.pebug((("PANEL 3 - MEMBER ITEM " + _local_2) + " : ") + _view["member_" + String(_local_2)], CLASS_NAME);
                var _local_3 = _view["member_" + String(_local_2)];
                _local_3.nextFrame();
                com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.configurePurchaseableItem(_local_3, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PANEL3_MEMBER_REWARD_IDS[_local_2], com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.PAPER_ITEM_TAG, true, false, true);
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < 2) {
                com.clubpenguin.world.rooms2015.may.party.MayParty.pebug((("PANEL 3 - PUFFLE ITEM " + _local_2) + " : ") + _view["puffle_" + String(_local_2)], CLASS_NAME);
                var _local_3 = _view["puffle_" + String(_local_2)];
                _local_3.nextFrame();
                com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.configurePurchaseableItem(_local_3, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PANEL3_PUFFLE_REWARD_IDS[_local_2], com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.PUFFLE_ITEM_TAG, true, false, true);
                _local_2++;
            }
        }
        static var CLASS_NAME = "QuestInterface_Panel3";
    }
