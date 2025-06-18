//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import com.adobe.serialization.json.JSONDecoder;

    public class SetPathsDataCommand extends SignalCommand 
    {

        [Inject]
        public var localizer:ILocalizationManager;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var _onLoaded:Signal;
        private var currentLanguage:String;
        private var localizedDataPaths:Array;


        override public function execute():void
        {
            var urlLoader:URLLoader;
            var environmentData:EnvironmentDataVO = this.mainModel.getEnvironmentData();
            this.currentLanguage = environmentData.language;
            var webServicePath:String = "";
            this.localizedDataPaths = new Array(environmentData.paths_service_path);
            webServicePath = ((this.mainModel.getEnvironmentData().getBaseConfigPath() + this.currentLanguage) + "/");
            var i:int;
            while (i < this.localizedDataPaths.length)
            {
                urlLoader = new URLLoader();
                urlLoader.addEventListener(Event.COMPLETE, this.onResponse);
                urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
                urlLoader.load(new URLRequest((webServicePath + this.localizedDataPaths[i])));
                i++;
            };
        }

        private function onResponse(event:Event):void
        {
            var jsonDecoder:JSONDecoder;
            var decodedObject:Object;
            try
            {
                jsonDecoder = new JSONDecoder(event.target.data, false);
                decodedObject = jsonDecoder.getValue();
                this.mainModel.pathsVO.data = decodedObject;
                this._onLoaded.dispatch();
            }
            catch(error:Error)
            {
                onError(event);
            };
        }

        private function onError(event:Event):void
        {
        }


    }
}//package com.clubpenguin.main.command
