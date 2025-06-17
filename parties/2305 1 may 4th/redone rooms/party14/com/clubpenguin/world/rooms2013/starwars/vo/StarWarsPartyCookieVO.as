//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.vo.StarWarsPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var jediPointsChanged, numBattlesWonChanged, lightsaberTutorialCompletedChanged, cinematicViewedChanged, soloRoomVisitedChanged, blasterGamePlayedChanged, icejamLevelChanged, blasterGameLevelChanged, xwingLevelChanged, _jsonObject, deathStarVisitedChanged, yavinVisitedChanged, deathstarDestroyedChanged;
        function StarWarsPartyCookieVO (cookieId) {
            super(cookieId);
            jediPointsChanged = new org.osflash.signals.Signal(Number);
            numBattlesWonChanged = new org.osflash.signals.Signal(Number);
            lightsaberTutorialCompletedChanged = new org.osflash.signals.Signal(Number);
            cinematicViewedChanged = new org.osflash.signals.Signal(Boolean);
            soloRoomVisitedChanged = new org.osflash.signals.Signal(Boolean);
            blasterGamePlayedChanged = new org.osflash.signals.Signal(Boolean);
            icejamLevelChanged = new org.osflash.signals.Signal(Boolean);
            blasterGameLevelChanged = new org.osflash.signals.Signal(Boolean);
            xwingLevelChanged = new org.osflash.signals.Signal(Boolean);
        }
        function getCookieHandlerName() {
            return(STARWARS_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(STARWARS_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(STARWARS_RECEIVE_COMMAND_NAME);
        }
        function get jediPoints() {
            if ((_jsonObject[0] == null) || (_jsonObject[0] < 0)) {
                return(0);
            }
            return(_jsonObject[0]);
        }
        function set jediPoints(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("jediPoints", String(value));
                return;
            }
            _jsonObject[0] = value;
            jediPointsChanged.dispatch(value);
            //return(jediPoints);
        }
        function get numBattlesWon() {
            if ((_jsonObject[1] == null) || (_jsonObject[1] < 0)) {
                return(0);
            }
            return(_jsonObject[1]);
        }
        function set numBattlesWon(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("battlesWon", String(value));
                return;
            }
            _jsonObject[1] = value;
            numBattlesWonChanged.dispatch(value);
            //return(numBattlesWon);
        }
        function get cinematicViewed() {
            var _local_2 = Array(_jsonObject);
            if (_jsonObject[5] == null) {
                return(false);
            }
            return(_jsonObject[5]);
        }
        function set cinematicViewed(value) {
            if (value == null) {
                traceSetError("cinematicViewed", String(value));
                return;
            }
            _jsonObject[5] = value;
            cinematicViewedChanged.dispatch(value);
            //return(cinematicViewed);
        }
        function get soloRoomVisited() {
            if (_jsonObject[6] == null) {
                return(false);
            }
            return(_jsonObject[6]);
        }
        function set soloRoomVisited(value) {
            if (value == null) {
                traceSetError("soloRoomVisited", String(value));
                return;
            }
            _jsonObject[6] = value;
            soloRoomVisitedChanged.dispatch(value);
            //return(soloRoomVisited);
        }
        function get tatooineWelcomeViewed() {
            if (_jsonObject[7] == null) {
                return(false);
            }
            return(_jsonObject[7]);
        }
        function set tatooineWelcomeViewed(value) {
            if (value == null) {
                traceSetError("tatooineWelcomeViewed", String(value));
                return;
            }
            _jsonObject[7] = value;
            soloRoomVisitedChanged.dispatch(value);
            //return(tatooineWelcomeViewed);
        }
        function get tatooineCongratulationsViewed() {
            if (_jsonObject[8] == null) {
                return(false);
            }
            return(_jsonObject[8]);
        }
        function set tatooineCongratulationsViewed(value) {
            if (value == null) {
                traceSetError("tatooineCongratulationsViewed", String(value));
                return;
            }
            _jsonObject[8] = value;
            blasterGamePlayedChanged.dispatch(value);
            //return(tatooineCongratulationsViewed);
        }
        function get blasterGameLevel() {
            if ((_jsonObject[2] == null) || (_jsonObject[2] < 0)) {
                return(0);
            }
            return(_jsonObject[2]);
        }
        function set blasterGameLevel(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("blasterGameLevel", String(value));
                return;
            }
            _jsonObject[2] = value;
            blasterGameLevelChanged.dispatch(value);
            //return(blasterGameLevel);
        }
        function get deathStarWelcomeViewed() {
            if (_jsonObject[9] == null) {
                return(false);
            }
            return(_jsonObject[9]);
        }
        function set deathStarWelcomeViewed(value) {
            if (value == null) {
                traceSetError("deathStarWelcomeViewed", String(value));
                return;
            }
            _jsonObject[9] = value;
            deathStarVisitedChanged.dispatch(value);
            //return(deathStarWelcomeViewed);
        }
        function get deathStarCongratulationsViewed() {
            if (_jsonObject[10] == null) {
                return(false);
            }
            return(_jsonObject[10]);
        }
        function set deathStarCongratulationsViewed(value) {
            if (value == null) {
                traceSetError("deathStarCongratulationsViewed", String(value));
                return;
            }
            _jsonObject[10] = value;
            deathStarVisitedChanged.dispatch(value);
            //return(deathStarCongratulationsViewed);
        }
        function get icejamLevel() {
            if ((_jsonObject[3] == null) || (_jsonObject[3] < 0)) {
                return(0);
            }
            return(_jsonObject[3]);
        }
        function set icejamLevel(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("icejamLevel", String(value));
                return;
            }
            _jsonObject[3] = value;
            icejamLevelChanged.dispatch(value);
            //return(icejamLevel);
        }
        function get yavinWelcomeViewed() {
            if (_jsonObject[11] == null) {
                return(false);
            }
            return(_jsonObject[11]);
        }
        function set yavinWelcomeViewed(value) {
            if (value == null) {
                traceSetError("yavinWelcomeViewed", String(value));
                return;
            }
            _jsonObject[11] = value;
            yavinVisitedChanged.dispatch(value);
            //return(yavinWelcomeViewed);
        }
        function get xwingLevel() {
            if ((_jsonObject[4] == null) || (_jsonObject[4] < 0)) {
                return(0);
            }
            return(_jsonObject[4]);
        }
        function set xwingLevel(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("blasterGameLevel", String(value));
                return;
            }
            _jsonObject[4] = value;
            xwingLevelChanged.dispatch(value);
            //return(xwingLevel);
        }
        function get yavinCongratulationsViewed() {
            if (_jsonObject[12] == null) {
                return(false);
            }
            return(_jsonObject[12]);
        }
        function set yavinCongratulationsViewed(value) {
            if (value == null) {
                traceSetError("yavinCongratulationsViewed", String(value));
                return;
            }
            _jsonObject[12] = value;
            deathstarDestroyedChanged.dispatch(value);
            //return(yavinCongratulationsViewed);
        }
        function traceSetError(propertyName, value) {
        }
        static var STARWARS_COOKIE_HANDLER_NAME = "stwr";
        static var STARWARS_RECEIVE_COMMAND_NAME = "swpc";
    }
