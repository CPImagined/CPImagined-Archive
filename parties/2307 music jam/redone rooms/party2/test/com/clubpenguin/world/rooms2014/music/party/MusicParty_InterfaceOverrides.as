class com.clubpenguin.world.rooms2014.music.party.MusicParty_InterfaceOverrides
{
    function MusicParty_InterfaceOverrides()
    {
    } // End of the function
    function init()
    {
    } // End of the function
    function showMapIcon()
    {
        var _this = this;
        if (_this.ICONS._visible == false)
        {
        } // end if
        _this.MAP_ICON._visible = true;
        _this.mapIsVisible = true;
        var destination;
        if (_global.getCurrentParty().BaseParty.isPartyRoom)
        {
            destination = _global.getCurrentParty().MusicParty.CONSTANTS.PARTY_MAP;
        } // end if
        if (destination == null)
        {
            _this.MAP_ICON.gotoAndStop(1);
            destination = "map";
        } // end if
        _this.updateQuestRewardsReady(_this.currentRewardCount);
        _this.MAP_ICON.map_btn.onRelease = function ()
        {
            if (_this.SHELL._localLoginServerData.autoLogin)
            {
                _this.SHELL.sendHideNewPlayerGuide();
                _this.SHELL.sendAS2Clicked(_this.MAP_BUTTON);
            } // end if
            _this.showContent(destination, null, null, null, true);
        };
    } // End of the function
    function showIcons()
    {
        var _loc2 = this;
        _loc2.ICONS._visible = true;
        _loc2.MAP_ICON._visible = _loc2.mapIsVisible;
        if (_loc2.displayPartyIcon())
        {
            trace ("showing party icon");
            _loc2.showPartyIcon("party_icon");
        } // end if
    } // End of the function
} // End of Class
