class com.clubpenguin.world.rooms2015.automated.vo.TemplatedQuestTaskVO
{
   function TemplatedQuestTaskVO()
   {
      this.memberItemIds = new Array();
      this.memberItemVOs = new Array();
      this.nonMemberItemIds = new Array();
      this.nonMemberItemVOs = new Array();
   }
   function setMemberItemId(itemId, itemType)
   {
      this.memberItemIds.push(itemId);
      var _loc3_ = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId,itemType,true,this.getPaperItemCost(itemId));
      this.memberItemVOs.push(_loc3_);
   }
   function setNonMemberItemId(itemId, itemType)
   {
      this.nonMemberItemIds.push(itemId);
      var _loc2_ = com.clubpenguin.party.items.PartyItemFactory.getPartyItem(itemId,itemType,false,this.getPaperItemCost(itemId));
      this.nonMemberItemVOs.push(_loc2_);
   }
   function getPaperItemCost(itemId)
   {
      return _global.getCurrentShell().getInventoryObjectById(itemId).cost;
   }
   function get toString()
   {
      return "\tTemplatedQuestTaskVO:  questTaskIndex: " + this.questTaskIndex + " " + " taskName: " + this.taskName + " " + " unlockDay: " + this.unlockDay + " " + " taskLockNumber: " + this.taskLockNumber + " " + " gothere: " + this.gothere + " " + " nonMemberItemIds: " + this.nonMemberItemIds + " " + " memberItemIds: " + this.memberItemIds + " ";
   }
}
