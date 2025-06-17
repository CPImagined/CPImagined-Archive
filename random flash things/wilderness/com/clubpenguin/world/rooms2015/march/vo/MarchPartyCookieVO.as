class com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
    var _jsonObject, __get__didCompleteAtLeastOneTask, __get__isQuestComplete, __get__msgViewedArray, __get__numTasksCompleted, __get__qcMsgViewedArray, __get__questItems;
    static var _airtower;
    function MarchPartyCookieVO(cookieId)
    {
        super(cookieId);
        trace ("MarchPartyCookieVO()");
        _airtower = _global.getCurrentAirtower();
    } // End of the function
    function getCookieHandlerName()
    {
        return (com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_COOKIE_HANDLER_NAME);
    } // End of the function
    function getSendCommandName()
    {
        return ("ERROR-NO-COOKIE-SEND-COMMAND");
    } // End of the function
    function getReceiveCommandName()
    {
        return (com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_RECEIVE_COMMAND_NAME);
    } // End of the function
    function get msgViewedArray()
    {
        if (_jsonObject.msgViewedArray == undefined)
        {
            return ([0, 0, 0, 0, 0, 0, 0, 0, 0]);
        } // end if
        return (_jsonObject.msgViewedArray);
    } // End of the function
    function get qcMsgViewedArray()
    {
        if (_jsonObject.qcMessageArray == undefined)
        {
            return ([0, 0, 0]);
        } // end if
        return (_jsonObject.qcMessageArray);
    } // End of the function
    function get questItems()
    {
        for (var _loc3 in _jsonObject)
        {
            var _loc2 = _jsonObject[_loc3];
        } // end of for...in
        if (_jsonObject.questTaskStatus == undefined)
        {
            return ([0, 0, 0, 0]);
        } // end if
        return (_jsonObject.questTaskStatus);
    } // End of the function
    static function sendRequestPartyCookie()
    {
        com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.PLAY_EXT, com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_COOKIE_HANDLER_NAME, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function setMessageViewed(messageIndex)
    {
        com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.PLAY_EXT, com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function setQCMessageViewed(messageIndex)
    {
        var _loc2 = _global.getCurrentAirtower();
        _loc2.send(_loc2.PLAY_EXT, com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.QC_MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    static function sendItemCollected(itemIndex)
    {
        com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.PLAY_EXT, com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.COLLECT_QUEST_ITEM_COMMAND, [itemIndex.toString()], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function sendTaskComplete(id)
    {
        com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO._airtower.PLAY_EXT, com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.MARCH_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.march.vo.MarchPartyCookieVO.QUEST_TASK_COMPLETE, [id], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function get numTasksCompleted()
    {
        var _loc3 = 0;
        for (var _loc2 = 0; _loc2 < _jsonObject.questTaskStatus.length - 1; ++_loc2)
        {
            if (_jsonObject.questTaskStatus[_loc2] == 1)
            {
                ++_loc3;
            } // end if
        } // end of for
        return (_loc3);
    } // End of the function
    function get didCompleteAtLeastOneTask()
    {
        for (var _loc2 = 1; _loc2 < _jsonObject.questTaskStatus.length - 1; ++_loc2)
        {
            if (_jsonObject.questTaskStatus[_loc2] == 1)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    function get isQuestComplete()
    {
        for (var _loc2 = 0; _loc2 < _jsonObject.questTaskStatus.length; ++_loc2)
        {
            if (_jsonObject.questTaskStatus[_loc2] == 0)
            {
                return (false);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    function traceSetError(propertyName, value)
    {
        trace ("MarchPartyCookieVO - ERROR - " + value + " is not a valid value for " + propertyName);
    } // End of the function
    static var MARCH_COOKIE_HANDLER_NAME = "puffle2015";
    static var MARCH_RECEIVE_COMMAND_NAME = "partycookie";
    static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
    static var MESSAGE_VIEWED_COMMAND = "msgviewed";
    static var QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed";
    static var COLLECT_QUEST_ITEM_COMMAND = "collectquestitem";
    static var QUEST_TASK_COMPLETE = "qtaskcomplete";
} // End of Class
