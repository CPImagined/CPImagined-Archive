//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.model.MapDataModel;
    import com.clubpenguin.lib.services.http.HTTPServiceRequest;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import com.clubpenguin.lib.services.http.HTTPResponse;

    public class LoadMapTriggersCommand extends SignalCommand 
    {

        private const MAP_TRIGGERS_PATH:String = "v2/content/global/content/map_triggers.json";

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var mapDataModel:MapDataModel;
        private var _mapDataService:HTTPServiceRequest;

        public function LoadMapTriggersCommand()
        {
            this._mapDataService = new HTTPServiceRequest();
        }

        override public function execute():void
        {
            this._mapDataService.setURL(((this.mainModel.getEnvironmentData().getBaseConfigPath() + this.MAP_TRIGGERS_PATH) + CacheTypeEnum.getCacheAsStringByType("content")), HTTPServiceRequest.JSON_ENCODING);
            this._mapDataService.responseReceived.add(this.onMapDataComplete);
            this._mapDataService.requestFailed.add(this.onMapDataFailed);
            this._mapDataService.send();
        }

        private function onMapDataComplete(response:HTTPResponse):void
        {
            this.mapDataModel.initFromObject(response.data);
        }

        private function onMapDataFailed(response:HTTPResponse):void
        {
        }


    }
}//package com.clubpenguin.main.command
