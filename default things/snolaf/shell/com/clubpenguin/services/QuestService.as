//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.QuestService extends com.clubpenguin.services.AbstractService
    {
        function QuestService (connection) {
            super(connection);
            connection.getResponded().add(onResponded, this);
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case QUEST_SETTINGS : 
                    _global.getCurrentShell().sendQuestSettingsToAS3(responseData[1]);
                    break;
                case QUEST_STATUS : 
                    _global.getCurrentShell().sendQuestStatusToAS3(responseData[1]);
                    break;
                default : 
                    return(undefined);
            }
        }
        static var QUEST_HANDLER = "nx#";
        static var QUEST_SETTINGS = "nxquestsettings";
        static var QUEST_STATUS = "nxquestdata";
        static var QUEST_ACTIVATE = "nxquestactivate";
    }
