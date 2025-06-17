//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.main.model.MainModel;
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.service.GetJSONConfigService;
    import com.disney.loader.XMLLoader;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import com.clubpenguin.lib.services.http.HTTPResponse;

    public class LoadConfigCommand extends SignalCommand 
    {

        private static const ENVIRONMENT_DATA_XML_LOCATION:String = "web_service/environment_data.xml";
        private static const ENVIRONMENT_DATA_XML_TAG:String = "data";
        private static const ENVIRONMENT_DATA_XML_NAME_ATTRIBUTE:String = "name";
        private static const ENVIRONMENT_DATA_XML_VALUE_ATTRIBUTE:String = "value";

        [Inject(name="flashVars")]
        public var flashVars:Object;
        [Inject]
        public var _mainContext:MainContext;
        [Inject]
        public var _model:MainModel;
        [Inject]
        public var _onLoaded:Signal;
        [Inject]
        public var _signalBus:SignalBus;
        private var _service:GetJSONConfigService;
        private var _xmlLoader:XMLLoader;
        private var _environmentDataObject:Object = new Object();

        public function LoadConfigCommand()
        {
            this._service = new GetJSONConfigService();
        }

        override public function execute():void
        {
            var prop:*;
            var autoLoginLocation:String;
            for (prop in this.flashVars)
            {
            };
            this._environmentDataObject.lang = this.flashVars.lang;
            this._environmentDataObject.a = this.flashVars.a;
            this._environmentDataObject.p = this.flashVars.p;
            this._environmentDataObject.field_op = this.flashVars.field_op;
            this._environmentDataObject.clientSubDir = this.flashVars.clientSubDir;
            this._environmentDataObject.contentSubDir = this.flashVars.contentSubDir;
            this._environmentDataObject.useStaticConnectionId = this.flashVars.useStaticConnectionId;
            this._environmentDataObject.connectionID = this.flashVars.connectionID;
            this._model.buildParam = ("?cacheVersion=" + this.flashVars.cacheVersion);
            CacheTypeEnum.getCacheTypeByType("client").cacheValue = this.flashVars.clientVersion;
            CacheTypeEnum.getCacheTypeByType("content").cacheValue = this.flashVars.contentVersion;
            CacheTypeEnum.getCacheTypeByType("games").cacheValue = this.flashVars.minigameVersion;
            CacheTypeEnum.getCacheTypeByType("config").cacheValue = this.flashVars.configVersion;
            if (((this.flashVarHasValue("nau")) && (this.flashVarHasValue("nal"))))
            {
                autoLoginLocation = ((this.flashVarHasValue("nad")) ? this.flashVars.nad : "login");
                if (((!(autoLoginLocation == "redeem")) && (!(autoLoginLocation == "login"))))
                {
                    autoLoginLocation = "login";
                };
                this._model.autoLoginLocation = autoLoginLocation;
                this._model.isAutoLogin = true;
                this._signalBus.autoLogin.dispatch();
            };
            this._xmlLoader = new XMLLoader((((this.flashVars.play + ENVIRONMENT_DATA_XML_LOCATION) + "?configVersion=") + this.flashVars.configVersion), this.onEnvironmentDataXMLLoaderComplete);
        }

        private function onEnvironmentDataXMLLoaderComplete(environmentDataXML:XML):void
        {
            var dataEntries:XMLList;
            var name:String;
            var value:String;
            var entry:XML;
            this._xmlLoader = null;
            if (environmentDataXML != null)
            {
                dataEntries = environmentDataXML.child(ENVIRONMENT_DATA_XML_TAG);
                if (dataEntries)
                {
                    for each (entry in dataEntries)
                    {
                        name = entry.attribute(ENVIRONMENT_DATA_XML_NAME_ATTRIBUTE);
                        value = entry.attribute(ENVIRONMENT_DATA_XML_VALUE_ATTRIBUTE);
                        this.flashVars[name] = value;
                    };
                    this._model.setEnvironmentData(this.flashVars);
                    this._onLoaded.dispatch();
                }
                else
                {
                    throw (new Error((this + " -> onEnvironmentDataXMLLoaderComplete(): no entries in environment data xml")));
                };
            }
            else
            {
                throw (new Error((this + " -> onEnvironmentDataXMLLoaderComplete(): failed to load environment data xml")));
            };
        }

        private function onResponseReceived(response:HTTPResponse):void
        {
            this._model.setEnvironmentData(response.data);
            this._onLoaded.dispatch();
        }

        private function onRequestFailed(response:HTTPResponse):void
        {
            throw (new Error("LoadConfigCommand -> failed to load JSON at local_config/flashvars.json"));
        }

        private function flashVarHasValue(varName:String):Boolean
        {
            if (!this.flashVars[varName])
            {
                return (false);
            };
            if (((this.flashVars[varName] == "") || (this.flashVars[varName] == null)))
            {
                return (false);
            };
            return (true);
        }


    }
}//package com.clubpenguin.main.command
