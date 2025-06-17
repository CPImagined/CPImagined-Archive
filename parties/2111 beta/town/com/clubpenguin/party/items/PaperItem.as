class com.clubpenguin.party.items.PaperItem extends com.clubpenguin.party.items.PartyItem
{
    function PaperItem(id, member, cost)
    {
        super(id, com.clubpenguin.party.items.PaperItem.TYPE, member, cost);
    } // End of the function
    static var TYPE = "paper";
} // End of Class
