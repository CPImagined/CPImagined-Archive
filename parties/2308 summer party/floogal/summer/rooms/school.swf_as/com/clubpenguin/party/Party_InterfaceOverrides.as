dynamic class com.clubpenguin.party.Party_InterfaceOverrides
{

    function Party_InterfaceOverrides()
    {
    }

    function Party_thisOverrides()
    {
    }

    function showPartyIcon(partyIcon)
    {
        var __reg2 = this;
        var __reg3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        if (__reg2.PARTY_ICON) 
        {
            __reg2.PARTY.BaseParty.partyIconState();
            __reg2.setPartyIconPositionForLikeWindow();
            return undefined;
        }
        var __reg5 = __reg2.SHELL.getPath(partyIcon);
        var __reg4 = com.clubpenguin.util.URLUtils.getCacheResetURL(__reg5);
        __reg2.PARTY_ICON = __reg2.ICONS.createEmptyMovieClip(__reg2.PARTY_ICON_INSTANCE_NAME, 1);
        __reg3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, __reg2.onPartyIconLoad));
        __reg3.loadClip(__reg4, __reg2.PARTY_ICON, "icons.as loadPartyIcon()");
    }

    function onPartyIconLoad(event)
    {
        var __reg2 = this;
        if (__reg2.EGG_TIMER_ICON._visible) 
        {
            __reg2.PARTY_ICON._x = __reg2.PARTY_ICON._x - 58;
        }
        __reg2.defaultPartyIconPos = __reg2.PARTY_ICON._x;
        __reg2.setPartyIconPositionForLikeWindow();
        __reg2.PARTY.BaseParty.partyIconState();
    }

}
