//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo
{
    import flash.system.Capabilities;
    import flash.external.ExternalInterface;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;

    public class EnvironmentDataVO 
    {

        private static const SUB_DIRECTORY_PATTERN:RegExp = new RegExp("^([A-Za-z0-9_ ]+[/]{0,1})+$");
        private static const CONNECTION_ID_PATTERN:RegExp = new RegExp("^cp\\d+$");
        private static const STATIC_CONNECTION_ID:String = "testConnectionID";

        private var _language:String = "";
        private var _affiliateID:int = 1;
        private var _promotionID:int = 1;
        public var aid:Number = 0;
        public var pid:Number = 0;
        public var sid:String = "";
        private var _connectionID:String = "testConnectionID";
        private var _clientSubDirectory:String = "";
        private var _contentSubDirectory:String = "";
        private var _gamesSubDirectory:String = "";
        public var localizedLangFrame:int = 0;
        public var playPath:String = "";
        public var basePath:String = "";
        public var clientPath:String = "client/";
        public var contentPath:String = "content/";
        public var gamesPath:String = "games/";
        public var phraseChatPath:String = "";
        public var drupalPath:String = "";
        public var securedPath:String = "";
        public var localLoginServerIp:String = "";
        public var localLoginServerPortOdd:Number;
        public var localLoginServerPortEven:Number;
        public var localGameServerDescriptions:Array;
        public var redemptionServerIp:String;
        public var redemptionServerPort:String;
        public var devWebDomain:String = "";
        public var web_service:String = "/web_service/game_configs/";
        public var web_service_zip:String = "/web_service/game_configs.bin";
        public var localized_strings:String = "web_service/game_configs/game_strings.json";
        public var paths_service_path:String = "web_service/game_configs/paths.json";
        public var world_servers_service_path:String = "web_service/game_configs/servers.php?type=game";
        public var multiClientCheckFailed:Boolean = false;
        public var nau:String = "";
        public var nal:String = "";
        public var nad:String = "";
        private var defaultWebDomain:String = "http://play.clubpenguin.com";
        public var environment:String = "live";
        public var isLoginFloodControlActive:Boolean;
        public var clientCacheValue:String;
        public var contentCacheValue:String;
        public var gameCacheValue:String;
        public var configCacheValue:String;

        public function EnvironmentDataVO()
        {
            var playerType:String = Capabilities.playerType;
        }

        public function set clientSubDirectory(subDirectory:String):void
        {
            if (((subDirectory) && (!(subDirectory.search(SUB_DIRECTORY_PATTERN) == -1))))
            {
                this._clientSubDirectory = subDirectory;
            };
        }

        public function get clientSubDirectory():String
        {
            return (this._clientSubDirectory);
        }

        public function set contentSubDirectory(subDirectory:String):void
        {
            if (((subDirectory) && (!(subDirectory.search(SUB_DIRECTORY_PATTERN) == -1))))
            {
                this._contentSubDirectory = subDirectory;
            };
        }

        public function get contentSubDirectory():String
        {
            return (this._contentSubDirectory);
        }

        public function set gamesSubDirectory(subDirectory:String):void
        {
            if (((subDirectory) && (!(subDirectory.search(SUB_DIRECTORY_PATTERN) == -1))))
            {
                this._gamesSubDirectory = subDirectory;
            };
        }

        public function get gamesSubDirectory():String
        {
            return (this._gamesSubDirectory);
        }

        public function set language(lang:String):void
        {
            if (lang == null)
            {
                lang = "en";
            };
            if (((!(lang)) || (!(lang.length == 2))))
            {
                return;
            };
            var firstChar:String = lang.charAt(0);
            var secondChar:String = lang.charAt(1);
            if ((((firstChar >= "a") && (firstChar <= "z")) && ((secondChar >= "a") && (secondChar <= "z"))))
            {
                this._language = lang;
            };
        }

        public function get language():String
        {
            return (this._language);
        }

        public function set affiliateID(id:int):void
        {
            if (!isNaN(id))
            {
                this._affiliateID = id;
            };
        }

        public function get affiliateID():int
        {
            return (this._affiliateID);
        }

        public function set promotionID(id:int):void
        {
            if (!isNaN(id))
            {
                this._promotionID = id;
            };
        }

        public function get promotionID():int
        {
            return (this._promotionID);
        }

        public function set connectionID(value:String):void
        {
            if (((value == STATIC_CONNECTION_ID) || (!(value.search(CONNECTION_ID_PATTERN) == -1))))
            {
                this._connectionID = value;
            };
        }

        public function get connectionID():String
        {
            return (this._connectionID);
        }

        public function getCurrentWebDomain():String
        {
            if (ExternalInterface.available)
            {
                this.defaultWebDomain = ("http://" + (ExternalInterface.call("window.location.href.toString") as String).split("/", 3)[2]);
            };
            if (this.defaultWebDomain.charAt((this.defaultWebDomain.length - 1)) != "/")
            {
                this.defaultWebDomain = (this.defaultWebDomain + "/");
            };
            return (this.defaultWebDomain);
        }

        public function get localContentPath():String
        {
            return ((((this.basePath + this.contentPath) + "local/") + this.language) + "/");
        }

        public function get globalContentPath():String
        {
            return (this.contentPath + "global/");
        }

        public function setDataFromObject(obj:Object):void
        {
            this.language = obj.lang;
            this.affiliateID = obj.a;
            this.promotionID = obj.p;
            this.aid = obj.aid;
            this.pid = obj.pid;
            this.sid = obj.sid;
            this.clientSubDirectory = obj.clientSubDir;
            this.contentSubDirectory = obj.contentSubDir;
            this.gamesSubDirectory = obj.gamesSubDir;
            if (obj.useStaticConnectionId == "false")
            {
                this.connectionID = obj.connectionID;
            };
            this.playPath = ((obj.play) ? obj.play : this.playPath);
            this.clientPath = ((obj.client) ? obj.client : this.clientPath);
            this.contentPath = ((obj.content) ? obj.content : this.contentPath);
            this.gamesPath = ((obj.games) ? obj.games : this.gamesPath);
            this.phraseChatPath = ((obj.phrasechat) ? obj.phrasechat : this.phraseChatPath);
            this.drupalPath = ((obj.drupal) ? obj.drupal : this.drupalPath);
            this.securedPath = ((obj.secured) ? obj.secured : this.securedPath);
            this.clientPath = (this.clientPath + this.clientSubDirectory);
            this.contentPath = (this.contentPath + this.contentSubDirectory);
            this.gamesPath = (this.gamesPath + this.gamesSubDirectory);
            this.clientCacheValue = CacheTypeEnum.getCacheTypeByType("client").cacheValue;
            this.contentCacheValue = CacheTypeEnum.getCacheTypeByType("content").cacheValue;
            this.gameCacheValue = CacheTypeEnum.getCacheTypeByType("games").cacheValue;
            this.configCacheValue = CacheTypeEnum.getCacheTypeByType("config").cacheValue;
        }


    }
}//package com.clubpenguin.lib.vo
