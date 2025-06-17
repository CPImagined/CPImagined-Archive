class com.clubpenguin.world.rooms2014.school.SchoolRoom extends com.clubpenguin.world.rooms.BaseRoom
{
    var _airtower, _destroyDelegate, _SHELL, huntItems, _stage, partycookieUpdateHandlerDelegate;
    function SchoolRoom(stageReference)
    {
        super(stageReference);
        trace ("SchoolRoom: Entering");
        _airtower = _global.getCurrentAirtower();
        com.clubpenguin.util.Log.info(com.clubpenguin.world.rooms2014.school.SchoolRoom.CLASS_NAME + "()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_global.getCurrentShell().ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function configureRoomElements()
    {
        trace ("SchoolRoom.configureSchoolRoomElements");
        this.gatherHuntItems();
        this.configureHuntItems();
    } // End of the function
    function gatherHuntItems()
    {
        huntItems = [];
        for (var _loc2 = 1; _loc2 <= com.clubpenguin.world.rooms2014.school.SchoolRoom.NUM_ITEMS; ++_loc2)
        {
            var _loc3 = (MovieClip)(_stage.foreground_mc["item_" + _loc2]);
            huntItems.push(_loc3);
        } // end of for
    } // End of the function
    function configureHuntItems()
    {
        com.clubpenguin.util.Log.info(com.clubpenguin.world.rooms2014.school.SchoolRoom.CLASS_NAME + "configureHuntItems" + _stage.foreground_mc);
        trace ("SchoolRoom.configureHuntItems");
        for (var _loc3 = 0; _loc3 < huntItems.length; ++_loc3)
        {
            var _loc2 = (MovieClip)(huntItems[_loc3]);
            _loc2.onRelease = com.clubpenguin.util.Delegate.create(this, huntItemClick, _loc2);
            _loc2._visible = false;
            _loc2._yscale = com.clubpenguin.world.rooms2014.school.SchoolRoom.ITEM_SCALE;
            _loc2._xscale = com.clubpenguin.world.rooms2014.school.SchoolRoom.ITEM_SCALE;
        } // end of for
        this.getScavengerProgress();
    } // End of the function
    function getScavengerProgress()
    {
        var _loc3 = _SHELL.getCurrentRoomId();
        var _loc2 = com.clubpenguin.world.rooms2014.school.SchoolParty.getQuestDataForRoom(_loc3);
        trace ("SchoolRoom.getScavengerProgress: " + _loc2);
        if (_loc2)
        {
            this.updateHuntItems(_loc2);
        }
        else if (!partycookieUpdateHandlerDelegate)
        {
            com.clubpenguin.util.Log.info(com.clubpenguin.world.rooms2014.school.SchoolRoom.CLASS_NAME + "partycookieUpdateHandler adding it " + getTimer());
            partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(this, partycookieUpdateHandler);
            _airtower.addListener("partycookie", partycookieUpdateHandlerDelegate);
        } // end else if
    } // End of the function
    function partycookieUpdateHandler()
    {
        com.clubpenguin.util.Log.info(com.clubpenguin.world.rooms2014.school.SchoolRoom.CLASS_NAME + "partycookieUpdateHandler removing it " + getTimer());
        this.getScavengerProgress();
        _airtower.removeListener("partycookie", partycookieUpdateHandlerDelegate);
    } // End of the function
    function updateHuntItems(ids)
    {
        for (var _loc2 = 0; _loc2 < ids.length; ++_loc2)
        {
            var _loc3 = (MovieClip)(huntItems[_loc2]);
            var _loc4 = Boolean(ids[_loc2]);
            _loc3._visible = !_loc4;
        } // end of for
    } // End of the function
    function huntItemClick(snowflake)
    {
        com.clubpenguin.util.Log.info(snowflake.toString());
        com.greensock.TweenMax.to(snowflake, 0.250000, {_xscale: 0, _yscale: 0, ease: com.greensock.easing.Back.easeIn});
        var _loc3 = this.getHuntItemIndex(snowflake);
        var _loc5 = _SHELL.getCurrentRoomId();
        com.clubpenguin.world.rooms2014.school.SchoolParty.setHuntItemCollectedForRoomAtIndex(_loc5, _loc3);
        com.clubpenguin.world.rooms2014.school.SchoolParty.playSound(_root, "sfx_collect");
        partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(this, questItemClickedHandler);
        _airtower.addListener("partycookie", partycookieUpdateHandlerDelegate);
    } // End of the function
    function questItemClickedHandler()
    {
        com.clubpenguin.util.Log.info(com.clubpenguin.world.rooms2014.school.SchoolRoom.CLASS_NAME + "questItemClickedHandler");
        _airtower.removeListener("partycookie", partycookieUpdateHandlerDelegate);
        var _loc3 = com.clubpenguin.world.rooms2014.school.SchoolParty.getQuestDataForRoom(_SHELL.getCurrentRoomId());
        com.clubpenguin.util.Log.info(com.clubpenguin.world.rooms2014.school.SchoolRoom.CLASS_NAME + " itemsArray " + _loc3);
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            if (_loc3[_loc2] == 0)
            {
                return;
            } // end if
        } // end of for
        com.clubpenguin.util.Log.info(com.clubpenguin.world.rooms2014.school.SchoolRoom.CLASS_NAME + "all items collected");
        com.clubpenguin.world.rooms2014.school.SchoolParty.playPartyIconSparkles();
    } // End of the function
    function getHuntItemIndex(flake)
    {
        for (var _loc2 = 0; _loc2 < huntItems.length; ++_loc2)
        {
            var _loc3 = (MovieClip)(huntItems[_loc2]);
            if (flake == _loc3)
            {
                return (_loc2);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    function centerItemMC(itemMC)
    {
        for (var _loc3 in itemMC)
        {
            var _loc1 = (MovieClip)(itemMC[_loc3]);
            if (_loc1)
            {
                itemMC._y = itemMC._y + (_loc1._y + _loc1._height / 2);
                _loc1._x = -_loc1._width / 2;
                _loc1._y = -_loc1._height / 2;
                _loc1._xscale = _loc1._yscale = com.clubpenguin.world.rooms2014.school.SchoolRoom.ITEM_SCALE;
                break;
            } // end if
        } // end of for...in
    } // End of the function
    function destroy()
    {
        _airtower.removeListener("partycookie", partycookieUpdateHandlerDelegate);
    } // End of the function
    static var CLASS_NAME = "SchoolRoom";
    static var NUM_ITEMS = 3;
    static var ITEM_SCALE = 60;
} // End of Class
