//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.boot.EnvironmentData
    {
        var affiliateID, promotionID, isAS3WebServicesOn, isLoginFloodControlActive, localLoginServerPortOdd, localLoginServerPortEven, localGameServerDescriptions, devWebDomain, redemptionServerIp, redemptionServerPort, nau, nal, clientCacheValue, contentCacheValue, gameCacheValue, configCacheValue;
        function EnvironmentData () {
        }
        function update(bootData) {
            language = bootData.language;
            affiliateID = bootData.affiliateID;
            promotionID = bootData.promotionID;
            playPath = bootData.playPath;
            basePath = bootData.basePath;
            baseConfigPath = bootData.baseConfigPath;
            clientPath = bootData.clientPath;
            contentPath = bootData.contentPath;
            gamesPath = bootData.gamesPath;
            phraseChatPath = bootData.phraseChatPath;
            isAS3WebServicesOn = bootData.isAS3WebServicesOn;
            isLoginFloodControlActive = bootData.isLoginFloodControlActive;
            localLoginServerIp = bootData.localLoginServerIp;
            localLoginServerPortOdd = bootData.localLoginServerPortOdd;
            localLoginServerPortEven = bootData.localLoginServerPortEven;
            localGameServerDescriptions = bootData.localGameServerDescriptions;
            devWebDomain = bootData.devWebDomain;
            redemptionServerIp = bootData.redemptionServerIp;
            redemptionServerPort = bootData.redemptionServerPort;
            if (bootDataHasValue(bootData, "nau") && (bootDataHasValue(bootData, "nal"))) {
                nau = bootData.nau;
                nal = bootData.nal;
                autoLoginLocation = bootData.nad;
                if (autoLogin == null) {
                    autoLogin = true;
                }
            }
            clientCacheValue = bootData.clientCacheValue;
            contentCacheValue = bootData.contentCacheValue;
            gameCacheValue = bootData.gameCacheValue;
            configCacheValue = bootData.configCacheValue;
        }
        function getBasePath() {
            return(basePath);
        }
        function getBaseConfigPath() {
            return(baseConfigPath);
        }
        function getClientPath() {
            return(basePath + clientPath);
        }
        function getGamesPath() {
            return(basePath + gamesPath);
        }
        function getContentPath() {
            return(basePath + contentPath);
        }
        function getPhraseChatPath() {
            return(phraseChatPath);
        }
        function getGlobalContentPath() {
            return((basePath + contentPath) + "global/");
        }
        function getLocalContentPath() {
            return((((basePath + contentPath) + "local/") + language) + "/");
        }
        function getWebServiceContentPath() {
            return((baseConfigPath + language) + "/web_service/");
        }
        function getClientCacheVersion() {
            return("?clientVersion=" + clientCacheValue);
        }
        function getContentCacheVersion() {
            return("?contentVersion=" + contentCacheValue);
        }
        function getGameCacheVersion() {
            return("?minigameVersion=" + gameCacheValue);
        }
        function getConfigCacheVersion() {
            return("?configVersion=" + configCacheValue);
        }
        function bootDataHasValue(bootData, varName) {
            if (!bootData[varName]) {
                return(false);
            }
            if (((bootData[varName] == "") || (bootData[varName] == null)) || (bootData[varName] == undefined)) {
                return(false);
            }
            return(true);
        }
        var language = "";
        var playPath = "";
        var basePath = "";
        var baseConfigPath = "";
        var clientPath = "";
        var contentPath = "";
        var gamesPath = "";
        var phraseChatPath = "";
        var username = "";
        var password = "";
        var isUsingBuildLoader = false;
        var connectionID = "testConnectionID";
        var localLoginServerIp = "";
        var autoLogin = null;
        var autoLoginLocation = "";
    }
