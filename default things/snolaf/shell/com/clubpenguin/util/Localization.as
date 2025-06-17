//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Localization
    {
        function Localization () {
        }
        static function getLocalizedNickname(penguinID, username, approvedLanguagesBitmask, currentLanguageBitmask) {
            if (approvedLanguagesBitmask & currentLanguageBitmask) {
                return(username);
            }
            return(PENGUIN_ID_PREFIX + String(penguinID));
        }
        static var PENGUIN_ID_PREFIX = "P";
    }
