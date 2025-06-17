class com.clubpenguin.party.Party_InterfaceOverrides
{
   function Party_InterfaceOverrides()
   {
   }
   function Party_thisOverrides()
   {
   }
   function showPartyIcon(partyIcon)
   {
      var _loc2_ = this;
      var _loc3_ = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      if(_loc2_.PARTY_ICON)
      {
         _loc2_.PARTY.BaseParty.partyIconState();
         _loc2_.setPartyIconPositionForLikeWindow();
         return undefined;
      }
      var _loc4_ = _loc2_.SHELL.getPath(partyIcon);
      var _loc5_ = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc4_);
      _loc2_.PARTY_ICON = _loc2_.ICONS.createEmptyMovieClip(_loc2_.PARTY_ICON_INSTANCE_NAME,1);
      _loc3_.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE,com.clubpenguin.util.Delegate.create(this,_loc2_.onPartyIconLoad));
      _loc3_.loadClip(_loc5_,_loc2_.PARTY_ICON,"icons.as loadPartyIcon()");
   }
   function onPartyIconLoad(event)
   {
      var _loc2_ = this;
      if(_loc2_.EGG_TIMER_ICON._visible)
      {
         _loc2_.PARTY_ICON._x -= 58;
      }
      _loc2_.defaultPartyIconPos = _loc2_.PARTY_ICON._x;
      _loc2_.setPartyIconPositionForLikeWindow();
      _loc2_.PARTY.BaseParty.partyIconState();
   }
}
