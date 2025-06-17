class com.clubpenguin.party.items.FurnitureItem extends com.clubpenguin.party.items.PartyItem
{
    function FurnitureItem(id, member, cost)
    {
        super(id, com.clubpenguin.party.items.FurnitureItem.TYPE, member, cost);
    } // End of the function
    static var TYPE = "furniture";
} // End of Class
