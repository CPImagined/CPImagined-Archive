class com.clubpenguin.party.items.IglooLocationItem extends com.clubpenguin.party.items.PartyItem
{
    function IglooLocationItem(id, member, cost, biName)
    {
        super(id, com.clubpenguin.party.items.IglooLocationItem.TYPE, member, cost, biName);
    } // End of the function
    static var TYPE = "iglooLocation";
} // End of Class
