class com.clubpenguin.party.BaseParty
{
    static var _shell, _airtower, _interface, _engine, _party, CONSTANTS, _serverCookieService, _serverCookie, __get__CURRENT_PARTY, _updatePlayerFrame, _currentParty, _interfaceOverrides, __set__CURRENT_PARTY, __get__interfaceOverrides, __get__isPartyRoom, __get__itemForSaleOnIglooList, __get__partyIglooListItems, __get__partySettings, __get__serverCookie, __get__updatePlayerFrame;
    function BaseParty()
    {
    } // End of the function
    static function init(cookieVO)
    {
        com.clubpenguin.party.BaseParty.pebug("BASE PARTY - INIT");
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        com.clubpenguin.party.BaseParty.initServerCookie(cookieVO);
        com.clubpenguin.party.BaseParty.addListenerForPartySettings(com.clubpenguin.party.BaseParty.CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
    } // End of the function
    static function initServerCookie(cookieVO)
    {
        _serverCookieService = com.clubpenguin.party.BaseParty._shell.getServerCookieService();
        _serverCookie = cookieVO;
        com.clubpenguin.party.BaseParty._serverCookieService.registerCookieVO(com.clubpenguin.party.BaseParty._serverCookie.getID(), com.clubpenguin.party.BaseParty._serverCookie);
    } // End of the function
    static function get serverCookie()
    {
        return (com.clubpenguin.party.BaseParty._serverCookie);
    } // End of the function
    static function pebug(msg, prefix)
    {
        if (prefix == undefined)
        {
            prefix = com.clubpenguin.party.BaseParty.CLASS_NAME;
        } // end if
        com.clubpenguin.util.Log.debug(prefix + "::" + msg, com.clubpenguin.util.Log.PARTY);
    } // End of the function
    static function addListenerForPartySettings(listenerName)
    {
        com.clubpenguin.party.BaseParty.pebug("BaseParty.addListenerForPartySettings");
        com.clubpenguin.party.BaseParty._airtower.addListener(listenerName, com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._this, com.clubpenguin.party.BaseParty.handleUpdatePartySettings));
    } // End of the function
    static function handleUpdatePartySettings(data)
    {
        com.clubpenguin.party.BaseParty.pebug("BaseParty.handleUpdatePartySettings");
        var _loc1 = com.clubpenguin.util.JSONParser.parse(data[1]);
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE = _loc1;
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().configurePartySettings();
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_DAY = com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex;
    } // End of the function
    static function playSound(ui, soundId, volume)
    {
        if (volume == undefined)
        {
            volume = 100;
        } // end if
        var _loc1 = new Sound(ui);
        _loc1.attachSound(soundId);
        _loc1.setVolume(volume);
        _loc1.start();
    } // End of the function
    static function soundButton(ui, soundId, callback, timeout)
    {
        com.clubpenguin.party.BaseParty._this.playSound(ui, soundId);
        setTimeout(callback, timeout);
    } // End of the function
    static function setConditionalPartyIconVisibility()
    {
        if (com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible != undefined)
        {
            com.clubpenguin.party.BaseParty.activatePartyIconOverrides();
        }
        else
        {
            com.clubpenguin.party.BaseParty.pebug("setConditionalPartyIconVisibility(): The current party does not have a getter called partyIconVisible(), please define.", com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
        } // end else if
    } // End of the function
    static function checkForFirstTimeLogin(playerObj)
    {
        com.clubpenguin.party.BaseParty.pebug("Check for first time login");
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().checkForFirstTimeLogin(playerObj);
    } // End of the function
    static function showPartyMap()
    {
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_MAP_PATH);
    } // End of the function
    static function openQuestUI()
    {
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.QUEST_UI_PATH);
    } // End of the function
    static function showIglooList()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.BI_IGLOOLIST_ACTION, "view");
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_LIST_PATH);
    } // End of the function
    static function showIglooPrompt()
    {
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_PROMPT_PATH);
    } // End of the function
    static function get updatePlayerFrame()
    {
        if (com.clubpenguin.party.BaseParty._updatePlayerFrame == undefined)
        {
            _updatePlayerFrame = new org.osflash.signals.Signal(Number);
        } // end if
        return (com.clubpenguin.party.BaseParty._updatePlayerFrame);
    } // End of the function
    static function dispatchUpdatePlayerFrame(player_id)
    {
        com.clubpenguin.party.BaseParty.pebug("dispatchUpdatePlayerFrame");
        com.clubpenguin.party.BaseParty._updatePlayerFrame.dispatch(player_id);
    } // End of the function
    static function set CURRENT_PARTY(party)
    {
        _currentParty = party;
        //return (com.clubpenguin.party.BaseParty.CURRENT_PARTY());
        null;
    } // End of the function
    static function get CURRENT_PARTY()
    {
        if (com.clubpenguin.party.BaseParty._currentParty != undefined)
        {
            return (com.clubpenguin.party.BaseParty._currentParty);
        } // end if
        com.clubpenguin.party.BaseParty.pebug("CURRENT_PARTY is undefined - make sure your main party class sets this value in its init function. Returning BaseParty.", com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
        return (com.clubpenguin.party.BaseParty._this);
    } // End of the function
    static function get partySettings()
    {
        //return (com.clubpenguin.party.BaseParty.CURRENT_PARTY().CONSTANTS.PARTY_SERVICE);
    } // End of the function
    static function get interfaceOverrides()
    {
        if (com.clubpenguin.party.BaseParty._interfaceOverrides == null)
        {
            _interfaceOverrides = new com.clubpenguin.party.Party_InterfaceOverrides();
        } // end if
        return (com.clubpenguin.party.BaseParty._interfaceOverrides);
    } // End of the function
    static function get isPartyRoom()
    {
        var _loc1 = com.clubpenguin.party.BaseParty._shell.getRoomObject().room_id;
        if (_loc1 != undefined && _loc1 >= com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.FIRST_PARTY_ROOM_ID && _loc1 <= com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.LAST_PARTY_ROOM_ID)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function get itemForSaleOnIglooList()
    {
        //return (com.clubpenguin.party.BaseParty.CURRENT_PARTY().itemOnIglooList);
    } // End of the function
    static function get partyIglooListItems()
    {
        //return (com.clubpenguin.party.BaseParty.CURRENT_PARTY().CONSTANTS.IGLOO_LIST_ITEMS);
    } // End of the function
    static function showPartyIcon(firstTimeLogin)
    {
        if (firstTimeLogin != undefined && firstTimeLogin == true)
        {
            _firstTimeLogin = true;
        } // end if
        com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = true;
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().activateFirstTimeUserPartyFunctionality();
    } // End of the function
    static function hidePartyIcon()
    {
        com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = false;
    } // End of the function
    static function partyIconState()
    {
        if (com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible || com.clubpenguin.party.BaseParty._firstTimeLogin)
        {
            com.clubpenguin.party.BaseParty.showPartyIcon();
        }
        else
        {
            com.clubpenguin.party.BaseParty.hidePartyIcon();
        } // end else if
    } // End of the function
    static function activatePartyIconOverrides()
    {
        com.clubpenguin.party.BaseParty.pebug("Activate interface overrides");
        com.clubpenguin.party.BaseParty._interface.showPartyIcon = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface, com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.showPartyIcon);
        com.clubpenguin.party.BaseParty._interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface, com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.onPartyIconLoad);
    } // End of the function
    static function sendBIIglooVisit(isPartyIgloo, itemId)
    {
        var _loc2 = "party_igloo_visit";
        var _loc3 = String("iglooID_" + itemId);
        var _loc1 = new Object();
        _loc1.message = isPartyIgloo ? ("party_item_present") : ("party_item_missing");
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_loc3, _loc2, _loc1);
    } // End of the function
    static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
    static var CLASS_NAME = "BaseParty";
    static var _this = com.clubpenguin.party.BaseParty;
    static var _firstTimeLogin = false;
} // End of Class
