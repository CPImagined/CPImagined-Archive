//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.items.PartyItemFactory
    {
        function PartyItemFactory () {
        }
        static function getPartyItem(itemID, type, member, cost) {
            switch (type) {
                case com.clubpenguin.party.items.FurnitureItem.TYPE : 
                    return(new com.clubpenguin.party.items.FurnitureItem(itemID, member, cost));
                case com.clubpenguin.party.items.IglooItem.TYPE : 
                    return(new com.clubpenguin.party.items.IglooItem(itemID, member, cost));
                case com.clubpenguin.party.items.PaperItem.TYPE : 
                    return(new com.clubpenguin.party.items.PaperItem(itemID, member, cost));
                case com.clubpenguin.party.items.PuffleItem.TYPE : 
                    return(new com.clubpenguin.party.items.PuffleItem(itemID, member, cost));
            }
            return(null);
        }
    }
