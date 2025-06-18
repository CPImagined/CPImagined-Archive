//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.EPFService extends com.clubpenguin.services.AbstractService
    {
        var _agentStatusReceived, _pointsReceived, _itemBought, _comMessagesReceived, _newComMessageReceived, _epfHotSauceEvidenceSubmitted, connection, extension, messageFormat;
        function EPFService (connection) {
            super(connection);
            _agentStatusReceived = new org.osflash.signals.Signal(Boolean);
            _pointsReceived = new org.osflash.signals.Signal(Number, Number);
            _itemBought = new org.osflash.signals.Signal(Number);
            _comMessagesReceived = new org.osflash.signals.Signal(Array, Boolean);
            _newComMessageReceived = new org.osflash.signals.Signal(Array);
            _epfHotSauceEvidenceSubmitted = new org.osflash.signals.Signal();
            connection.getResponded().add(onResponded, this);
        }
        function get agentStatusReceived() {
            return(_agentStatusReceived);
        }
        function get pointsReceived() {
            return(_pointsReceived);
        }
        function get itemBought() {
            return(_itemBought);
        }
        function get comMessagesReceived() {
            return(_comMessagesReceived);
        }
        function get newComMessageReceived() {
            return(_newComMessageReceived);
        }
        function get epfHotSauceEvidenceSubmitted() {
            return(_epfHotSauceEvidenceSubmitted);
        }
        function get traceTrackerStateUpdated() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getFootPrintVisibilityChangedSignal());
        }
        function get missionStateUpdated() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getQuestStateUpdatedSignal());
        }
        function get facetimeCallReceived() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getFacetimeCallSignal());
        }
        function get inventoryDropped() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getInventoryItemDroppedSignal());
        }
        function get inventoryAdded() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getInventory().getItemsAdded());
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case SET_AGENT_STATUS : 
                    dispatchAgentStatusReceived("1");
                    break;
                case GET_AGENT_STATUS : 
                    dispatchAgentStatusReceived(responseData[1]);
                    break;
                case GET_POINTS : 
                    dispatchPointsReceived(responseData[1], responseData[2]);
                    break;
                case BUY_ITEM : 
                    dispatchItemBought(responseData[1]);
                    break;
                case GET_COM_MESSAGES : 
                    dispatchComMessagesReceived(responseData);
                    break;
                case NEW_COM_MESSAGE : 
                    dispatchNewComMessageReceived(responseData);
            }
        }
        function dispatchAgentStatusReceived(agentStatus) {
            _agentStatusReceived.dispatch(Boolean(Number(agentStatus)));
        }
        function dispatchItemBought(unusedPoints) {
            _itemBought.dispatch(Number(unusedPoints));
        }
        function dispatchPointsReceived(totalPoints, unusedPoints) {
            _pointsReceived.dispatch(Number(unusedPoints), Number(totalPoints));
        }
        function dispatchComMessagesReceived(data) {
            var _local_3 = ((String(data[1]) == "0") ? false : true);
            _comMessagesReceived.dispatch(parseComMessageArray(data, 2), _local_3);
        }
        function dispatchNewComMessageReceived(data) {
            _newComMessageReceived.dispatch(parseComMessageArray(data, 1));
        }
        function parseComMessageArray(data, startIndex) {
            var _local_4 = [];
            var _local_2 = startIndex;
            while (_local_2 < data.length) {
                _local_4.push(parseComMessageString(data[_local_2]));
                _local_2++;
            }
            _local_4.reverse();
            return(_local_4);
        }
        function parseComMessageString(str) {
            var _local_2 = str.split("|");
            var _local_1 = new com.clubpenguin.hud.phone.model.ComMessage();
            _local_1.message = _local_2[0];
            _local_1["date"] = new Date(Number(_local_2[1]) * 1000);
            _local_1.mascotID = _local_2[2];
            return(_local_1);
        }
        function getAgentStatus() {
            connection.sendXtMessage(extension, EPF_HANDLER + GET_AGENT_STATUS, [], messageFormat, -1);
            return(_agentStatusReceived);
        }
        function setAgentStatus() {
            connection.sendXtMessage(extension, EPF_HANDLER + SET_AGENT_STATUS, [], messageFormat, -1);
            return(_agentStatusReceived);
        }
        function onEvidenceSubmitted() {
            _epfHotSauceEvidenceSubmitted.dispatch();
        }
        function hasUsedFur() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_FUR.isUsed);
        }
        function hasCollectedFur() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.playerHasQuestItem(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_FUR));
        }
        function hasUsedHotSauce() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_HOT_SAUCE.isUsed);
        }
        function hasCollectedHotSauce() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.playerHasQuestItem(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.INVENTORY_HOT_SAUCE));
        }
        function getTrackerState() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.isTraceTrackerActive());
        }
        function activateTraceTracker() {
            com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.activateTraceTracker();
        }
        function deactivateTraceTracker() {
            com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.deactivateTraceTracker();
        }
        function isFacetimeCallWaiting() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.isFacetimeCallWaiting());
        }
        function getWaitingFacetimeArgs() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getWaitingFacetimeArgs());
        }
        function getMissionState() {
            return(com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.getQuestState());
        }
        function getPoints() {
            connection.sendXtMessage(extension, EPF_HANDLER + GET_POINTS, [], messageFormat, -1);
            return(_pointsReceived);
        }
        function buyItem(itemID) {
            connection.sendXtMessage(extension, EPF_HANDLER + BUY_ITEM, [itemID], messageFormat, -1);
            return(_itemBought);
        }
        function getComMessages() {
            connection.sendXtMessage(extension, EPF_HANDLER + GET_COM_MESSAGES, [], messageFormat, -1);
            return(_comMessagesReceived);
        }
        static var EPF_HANDLER = "f#";
        static var GET_AGENT_STATUS = "epfga";
        static var SET_AGENT_STATUS = "epfsa";
        static var GET_POINTS = "epfgr";
        static var BUY_ITEM = "epfai";
        static var GET_COM_MESSAGES = "epfgm";
        static var NEW_COM_MESSAGE = "epfsm";
        var QUEST_STATE_MISSION_AVAILABLE = com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.QUEST_STATE_MISSION_AVAILABLE;
        var QUEST_STATE_MISSION_ACCEPTED = com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.QUEST_STATE_MISSION_ACCEPTED;
        var QUEST_STATE_EVIDENCE_SUBMITTED = com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.QUEST_STATE_EVIDENCE_SUBMITTED;
        var QUEST_STATE_DOOR_UNLOCKED = com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.QUEST_STATE_DOOR_UNLOCKED;
        var QUEST_STATE_DONE = com.clubpenguin.world.rooms2013.epfhotsauce.EPFHotSauce.QUEST_STATE_DONE;
    }
