//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel4
    {
        var _view;
        function QuestInterface_Panel4 (view) {
            _view = view;
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("QuestInterface_Panel4 *** _view : " + _view, CLASS_NAME);
            configurePanel();
        }
        function configurePanel() {
            var _local_4 = [4, 5, 6, 7, 8];
            var _local_2 = 0;
            while (_local_2 < 5) {
                if (com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PARTY_DAY >= _local_4[_local_2]) {
                    var _local_3 = _view["nonMember_" + String(_local_2)];
                    com.clubpenguin.world.rooms2015.may.party.MayParty.pebug((("PANEL 4 - NON-MEMBER " + _local_2) + " : ") + _local_3, CLASS_NAME);
                    _local_3.nextFrame();
                    com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.configurePurchaseableItem(_local_3, com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PANEL4_NONMEMBER_REWARD_IDS[_local_2], com.clubpenguin.world.rooms2015.may.party.MayPurchasePartyItems.PAPER_ITEM_TAG, false, false, true);
                }
                _local_2++;
            }
        }
        static var CLASS_NAME = "QuestInterface_Panel4";
    }
