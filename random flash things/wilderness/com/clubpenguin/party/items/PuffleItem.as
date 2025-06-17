class com.clubpenguin.party.items.PuffleItem extends com.clubpenguin.party.items.PartyItem
{
    function PuffleItem(id, member, cost)
    {
        super(id, com.clubpenguin.party.items.PuffleItem.TYPE, member, cost);
    } // End of the function
    static var TYPE = "puffle";
} // End of Class
