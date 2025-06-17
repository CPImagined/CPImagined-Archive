class com.clubpenguin.party.items.PartyItemFactory
{
    function PartyItemFactory()
    {
    } // End of the function
    static function getPartyItem(itemID, type, member, cost)
    {
        switch (type)
        {
            case com.clubpenguin.party.items.FurnitureItem.TYPE:
            {
                return (new com.clubpenguin.party.items.FurnitureItem(itemID, member, cost));
            } 
            case com.clubpenguin.party.items.IglooItem.TYPE:
            {
                return (new com.clubpenguin.party.items.IglooItem(itemID, member, cost));
            } 
            case com.clubpenguin.party.items.PaperItem.TYPE:
            {
                return (new com.clubpenguin.party.items.PaperItem(itemID, member, cost));
            } 
            case com.clubpenguin.party.items.PuffleItem.TYPE:
            {
                return (new com.clubpenguin.party.items.PuffleItem(itemID, member, cost));
            } 
        } // End of switch
        return (null);
    } // End of the function
} // End of Class
