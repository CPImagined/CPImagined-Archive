class com.clubpenguin.party.items.PaperItem extends com.clubpenguin.party.items.PartyItem
{
   static var TYPE = "paper";
   function PaperItem(id, member, cost)
   {
      super(id,com.clubpenguin.party.items.PaperItem.TYPE,member,cost);
   }
}
