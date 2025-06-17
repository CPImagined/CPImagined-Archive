class com.clubpenguin.world.rooms2014.music.party.MusicParty
{
    static var _shell, _airtower, _interface, _engine, _party, __get__interfaceOverrides, _questRewards, __get__CONSTANTS, __get__partyCookie, _interfaceOverrides, __get__isActive, __get__itemOnIglooList, __get__partyIconVisible;
    function MusicParty()
    {
    } // End of the function
    static function init()
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("MUSIC PARTY - INIT");
        _isActive = true;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__interfaceOverrides().init();
        com.clubpenguin.world.rooms2014.music.party.MusicParty.activateInterfaceOverrides();
    } // End of the function
    static function configurePartySettings()
    {
        _questRewards = new Array();
        com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().IGLOO_LIST_ITEM_ID = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().PARTY_SERVICE.partySettings.partyIglooItems[0];
        com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().IGLOO_LIST_ITEMS = [new com.clubpenguin.party.items.IglooItem(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().IGLOO_LIST_ITEM_ID)];
        var _loc4 = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().PARTY_SERVICE.musicJamRewards;
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("musicItemList " + _loc4.length);
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc2 = new com.clubpenguin.world.rooms2014.music.vo.MusicPartyRewardVO();
            var _loc1 = _loc4[_loc3];
            _loc2.unlockday = _loc1.unlockDay;
            _loc2.createMemberItemVO(_loc1.memberItemId, _loc1.memberItemId == com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().PARTY_SERVICE.musicJamPuffleReward ? ("puffle") : ("paper"), com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.getInventoryObjectById(_loc1.memberItemId).cost);
            _loc2.createNonMemberItemVO(_loc1.nonmemberItemId, "paper", com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.getInventoryObjectById(_loc1.nonmemberItemId).cost);
            com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards.push(_loc2);
        } // end of for
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("_questRewards " + com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards);
    } // End of the function
    static function get partyCookie()
    {
        //return ((com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO)(com.clubpenguin.party.BaseParty.serverCookie()));
    } // End of the function
    static function get isActive()
    {
        return (com.clubpenguin.world.rooms2014.music.party.MusicParty._isActive);
    } // End of the function
    static function get CONSTANTS()
    {
        return (com.clubpenguin.party.BaseParty.CONSTANTS);
    } // End of the function
    static function pebug(msg, prefix)
    {
        com.clubpenguin.party.BaseParty.pebug(msg, prefix);
    } // End of the function
    static function playSound(ui, soundId, volume)
    {
        com.clubpenguin.party.BaseParty.playSound(ui, soundId, volume);
    } // End of the function
    static function checkForFirstTimeLogin(playerObj)
    {
        if (com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.getMyPlayerId() != playerObj.player_id || com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.getRoomObject().room_id == 112)
        {
            return;
        } // end if
        if (com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__partyCookie().__get__msgViewedArray()[0] == 0)
        {
            com.clubpenguin.world.rooms2014.music.party.MusicParty._interface.showContent(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().LOGIN_PROMPT_PATH);
        } // end if
    } // End of the function
    static function showMemberContentOopsMessage()
    {
        _global.getCurrentInterface().showContent(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().OOPS_MEMBER_PUFFLES_MESSAGE);
    } // End of the function
    static function showMemberItemOopsMessage()
    {
        _global.getCurrentInterface().showContent(com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().OOPS_MEMBER_ITEM_MESSAGE);
    } // End of the function
    static function get itemOnIglooList()
    {
        //return (new com.clubpenguin.party.items.IglooItem(com.clubpenguin.world.rooms2014.music.party.MusicParty.CONSTANTS().IGLOO_LIST_ITEM_ID, true, 1800, "Tour Bus Igloo"));
    } // End of the function
    static function get interfaceOverrides()
    {
        if (com.clubpenguin.world.rooms2014.music.party.MusicParty._interfaceOverrides == null)
        {
            _interfaceOverrides = new com.clubpenguin.world.rooms2014.music.party.MusicParty_InterfaceOverrides();
        } // end if
        return (com.clubpenguin.world.rooms2014.music.party.MusicParty._interfaceOverrides);
    } // End of the function
    static function get partyIconVisible()
    {
        if (com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__partyCookie().__get__msgViewedArray()[0] == 1)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function getUnlockDayByArrayIndex(index)
    {
        return (com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards[index].unlockday);
    } // End of the function
    static function getNonmemberPartyItemByUnlockDay(index)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards[_loc1].unlockday == index)
            {
                return (com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards[_loc1].nonMemberItemVO);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getMemberPartyItemByUnlockDay(index)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards.length; ++_loc1)
        {
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("index " + index);
            com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("_questRewards[i].unlockday " + com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards[_loc1].unlockday);
            if (com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards[_loc1].unlockday == index)
            {
                return (com.clubpenguin.world.rooms2014.music.party.MusicParty._questRewards[_loc1].memberItemVO);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getPerformerNameByID(index)
    {
        var _loc2 = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().PARTY_SERVICE.concertList;
        for (var _loc1 = 0; _loc1 < _loc2.length; ++_loc1)
        {
            if (_loc2[_loc1].id == index)
            {
                return (_loc2[_loc1].name);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getIsValidConcertId(id)
    {
        var _loc2 = com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().PARTY_SERVICE.concertList;
        for (var _loc1 = 0; _loc1 < _loc2.length; ++_loc1)
        {
            if (_loc2[_loc1].id == id)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function launchMusicGame()
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty.pebug("MusicParty.launchMusicGame");
        var _loc1 = com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.getLocalizedString("soundstudio_prompt");
        com.clubpenguin.world.rooms2014.music.party.MusicParty._interface.closePrompt();
        com.clubpenguin.world.rooms2014.music.party.MusicParty._interface.showPrompt("game", _loc1, undefined, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.music.party.MusicParty._this, com.clubpenguin.world.rooms2014.music.party.MusicParty.clickJoinGamePrompt));
        com.clubpenguin.world.rooms2014.music.party.MusicParty.sendLaunchMusicGameBI();
    } // End of the function
    static function clickJoinGamePrompt()
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.sendJoinRoom("soundroom", 312, 308);
    } // End of the function
    static function activateInterfaceOverrides()
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty._interface.showMapIcon = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.music.party.MusicParty._interface, com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__interfaceOverrides().showMapIcon);
    } // End of the function
    static function sendGetConcertCountdown()
    {
        com.clubpenguin.world.rooms2014.music.party.MusicParty._airtower.send(com.clubpenguin.world.rooms2014.music.party.MusicParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO.MUSIC_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().GET_CONCERT_COUNTDOWN, [0], "str", com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.getCurrentServerRoomId());
    } // End of the function
    static function sendPartyMapOpenBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "music_jam_map_open");
    } // End of the function
    static function sendAttendPerformanceBI(performerName)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(performerName, "music_jam_performance");
    } // End of the function
    static function sendQuestUIGoThereBI()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(null, "quest_interface_go_there");
    } // End of the function
    static function sendLaunchMusicGameBI()
    {
        var _loc1;
        var _loc2 = com.clubpenguin.world.rooms2014.music.party.MusicParty._shell.getRoomObject().room_id;
        switch (_loc2)
        {
            case com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().CRUISE_STAGE_ROOM_ID:
            {
                _loc1 = "cruise_stage";
                break;
            } 
            case com.clubpenguin.world.rooms2014.music.party.MusicParty.__get__CONSTANTS().CRUISE_BUFFET_ROOM_ID:
            {
                _loc1 = "cruise_buffet";
                break;
            } 
        } // End of switch
        if (_loc1 != undefined)
        {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_loc1, "soundstudio_open");
        } // end if
    } // End of the function
    static var CLASS_NAME = "BaseParty";
    static var _this = com.clubpenguin.world.rooms2014.music.party.MusicParty;
    static var _isActive = false;
} // End of Class
