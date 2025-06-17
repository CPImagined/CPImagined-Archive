//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel1
    {
        var _view;
        function QuestInterface_Panel1 (view) {
            _view = view;
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("QuestInterface_Panel1 *** _view : " + _view, CLASS_NAME);
            configurePanel();
        }
        function configurePanel() {
            var _local_2 = 0;
            _local_2 = 0;
            while (_local_2 < 4) {
                com.clubpenguin.world.rooms2015.may.party.MayParty.pebug((("PANEL 1 - MEMBER ITEM " + _local_2) + " : ") + _view["member_" + String(_local_2)], CLASS_NAME);
                var _local_3 = _view["member_" + String(_local_2)];
                com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.configurePurchaseableItem(_local_3, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PANEL1_MEMBER_REWARD_IDS[_local_2], com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.PAPER_ITEM_TAG, true, false, true);
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < 1) {
                com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("PANEL 1 - PUFFLE ITEM 1  : " + _view.puffle_0, CLASS_NAME);
                var _local_3 = _view["puffle_" + String(_local_2)];
                com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.configurePurchaseableItem(_local_3, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PANEL1_PUFFLE_REWARD_IDS[_local_2], com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.PUFFLE_ITEM_TAG, true, false, true);
                _local_2++;
            }
        }
        static var CLASS_NAME = "QuestInterface_Panel1";
    }
