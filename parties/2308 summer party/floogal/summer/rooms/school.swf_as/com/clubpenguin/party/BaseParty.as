dynamic class com.clubpenguin.party.BaseParty
{
    static var OBJECT_UNDEFINED: String = "****[ERROR:Object Undefined]**** ";
    static var CLASS_NAME: String = "BaseParty";
    static var _this = com.clubpenguin.party.BaseParty;
    static var _firstTimeLogin: Boolean = false;

    function BaseParty()
    {
    }

    static function init(cookieVO)
    {
        com.clubpenguin.party.BaseParty.pebug("BASE PARTY - INIT");
        com.clubpenguin.party.BaseParty._shell = _global.getCurrentShell();
        com.clubpenguin.party.BaseParty._airtower = _global.getCurrentAirtower();
        com.clubpenguin.party.BaseParty._interface = _global.getCurrentInterface();
        com.clubpenguin.party.BaseParty._engine = _global.getCurrentEngine();
        com.clubpenguin.party.BaseParty._party = _global.getCurrentParty();
        com.clubpenguin.party.BaseParty.initServerCookie(cookieVO);
        com.clubpenguin.party.BaseParty.addListenerForPartySettings(com.clubpenguin.party.BaseParty.CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
    }

    static function initServerCookie(cookieVO)
    {
        com.clubpenguin.party.BaseParty._serverCookieService = com.clubpenguin.party.BaseParty._shell.getServerCookieService();
        com.clubpenguin.party.BaseParty._serverCookie = cookieVO;
        com.clubpenguin.party.BaseParty._serverCookieService.registerCookieVO(com.clubpenguin.party.BaseParty._serverCookie.getID(), com.clubpenguin.party.BaseParty._serverCookie);
    }

    static function get serverCookie()
    {
        return com.clubpenguin.party.BaseParty._serverCookie;
    }

    static function pebug(msg, prefix)
    {
        if (undefined == prefix) 
        {
            prefix = com.clubpenguin.party.BaseParty.CLASS_NAME;
        }
        com.clubpenguin.util.Log.debug(prefix + "::" + msg, com.clubpenguin.util.Log.PARTY);
    }

    static function addListenerForPartySettings(listenerName)
    {
        com.clubpenguin.party.BaseParty.pebug("addListenerForPartySettings " + listenerName);
        com.clubpenguin.party.BaseParty._airtower.addListener(listenerName, com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._this, com.clubpenguin.party.BaseParty.handleUpdatePartySettings));
    }

    static function handleUpdatePartySettings(data)
    {
        com.clubpenguin.party.BaseParty.pebug("Handle Party Settings");
        var __reg1 = com.clubpenguin.util.JSONParser.parse(data[1]);
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE = __reg1;
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().configurePartySettings();
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_DAY = com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex;
    }

    static function playSound(ui, soundId, volume)
    {
        if (volume == undefined) 
        {
            volume = 100;
        }
        var __reg1 = new Sound(ui);
        __reg1.attachSound(soundId);
        __reg1.setVolume(volume);
        __reg1.start();
    }

    static function soundButton(ui, soundId, callback, timeout)
    {
        com.clubpenguin.party.BaseParty._this.playSound(ui, soundId);
        setTimeout(callback, timeout);
    }

    static function setConditionalPartyIconVisibility()
    {
        if (com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible != undefined) 
        {
            com.clubpenguin.party.BaseParty.activatePartyIconOverrides();
            return undefined;
        }
        com.clubpenguin.party.BaseParty.pebug("setConditionalPartyIconVisibility(): The current party does not have a getter called partyIconVisible(), please define.", com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
    }

    static function checkForFirstTimeLogin(playerObj)
    {
        com.clubpenguin.party.BaseParty.pebug("Check for first time login");
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().checkForFirstTimeLogin(playerObj);
    }

    static function showPartyMap()
    {
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_MAP_PATH);
    }

    static function openQuestUI()
    {
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.QUEST_UI_PATH);
    }

    static function showIglooList()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.BI_IGLOOLIST_ACTION, "view");
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_LIST_PATH);
    }

    static function showIglooPrompt()
    {
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_PROMPT_PATH);
    }

    static function get updatePlayerFrame()
    {
        if (com.clubpenguin.party.BaseParty._updatePlayerFrame == undefined) 
        {
            com.clubpenguin.party.BaseParty._updatePlayerFrame = new org.osflash.signals.Signal(Number);
        }
        return com.clubpenguin.party.BaseParty._updatePlayerFrame;
    }

    static function dispatchUpdatePlayerFrame(player_id)
    {
        com.clubpenguin.party.BaseParty.pebug("dispatchUpdatePlayerFrame");
        com.clubpenguin.party.BaseParty._updatePlayerFrame.dispatch(player_id);
    }

    static function set CURRENT_PARTY(party)
    {
        com.clubpenguin.party.BaseParty._currentParty = party;
    }

    static function get CURRENT_PARTY()
    {
        if (com.clubpenguin.party.BaseParty._currentParty != undefined) 
        {
            return com.clubpenguin.party.BaseParty._currentParty;
        }
        com.clubpenguin.party.BaseParty.pebug("CURRENT_PARTY is undefined - make sure your main party class sets this value in its init function. Returning BaseParty.", com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
        return com.clubpenguin.party.BaseParty._this;
    }

    static function get partySettings()
    {
        return com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE;
    }

    static function get interfaceOverrides()
    {
        if (com.clubpenguin.party.BaseParty._interfaceOverrides == null) 
        {
            com.clubpenguin.party.BaseParty._interfaceOverrides = new com.clubpenguin.party.Party_InterfaceOverrides();
        }
        return com.clubpenguin.party.BaseParty._interfaceOverrides;
    }

    static function get isPartyRoom()
    {
        var __reg1 = com.clubpenguin.party.BaseParty._shell.getRoomObject().room_id;
        if (__reg1 != undefined && __reg1 >= com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.FIRST_PARTY_ROOM_ID && __reg1 <= com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.LAST_PARTY_ROOM_ID) 
        {
            return true;
        }
        return false;
    }

    static function get itemForSaleOnIglooList()
    {
        return com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().itemOnIglooList;
    }

    static function get partyIglooListItems()
    {
        return com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_LIST_ITEMS;
    }

    static function showPartyIcon(firstTimeLogin)
    {
        if (firstTimeLogin != undefined && firstTimeLogin == true) 
        {
            com.clubpenguin.party.BaseParty._firstTimeLogin = true;
        }
        com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = true;
    }

    static function hidePartyIcon()
    {
        com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = false;
    }

    static function partyIconState()
    {
        if (com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible) 
        {
            com.clubpenguin.party.BaseParty.showPartyIcon();
            return undefined;
        }
        com.clubpenguin.party.BaseParty.hidePartyIcon();
    }

    static function activatePartyIconOverrides()
    {
        com.clubpenguin.party.BaseParty.pebug("Activate interface overrides");
        com.clubpenguin.party.BaseParty._interface.showPartyIcon = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface, com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.showPartyIcon);
        com.clubpenguin.party.BaseParty._interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface, com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.onPartyIconLoad);
    }

    static function sendBIIglooVisit(isPartyIgloo, itemId)
    {
        var __reg3 = "party_igloo_visit";
        var __reg2 = String("iglooID_" + itemId);
        var __reg1 = new Object();
        __reg1.message = isPartyIgloo ? "party_item_present" : "party_item_missing";
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(__reg2, __reg3, __reg1);
    }

}
