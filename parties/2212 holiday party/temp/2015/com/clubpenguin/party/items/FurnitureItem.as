class com.clubpenguin.party.items.FurnitureItem extends com.clubpenguin.party.items.PartyItem
{
   static var TYPE = "furniture";
   function FurnitureItem(id, member, cost)
   {
      super(id,com.clubpenguin.party.items.FurnitureItem.TYPE,member,cost);
   }
}
