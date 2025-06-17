//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.items.IglooPartyItem extends com.clubpenguin.party.items.PartyItem
    {
        var __get__id;
        function IglooPartyItem (id) {
            super(id, "igloo");
        }
        function configureButton(itemMC, member, prompt) {
            member = ((member != undefined) ? (member) : true);
            var _local_3 = new com.clubpenguin.ui.itembuttons.BuyIglooItemButton(itemMC, __get__id(), member, prompt);
        }
    }
