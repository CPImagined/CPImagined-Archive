class com.clubpenguin.party.items.IglooItem extends com.clubpenguin.party.items.PartyItem
{
    function IglooItem(id, member, cost, biName)
    {
        super(id, com.clubpenguin.party.items.IglooItem.TYPE, member, cost, biName);
    } // End of the function
    static var TYPE = "igloo";
} // End of Class
