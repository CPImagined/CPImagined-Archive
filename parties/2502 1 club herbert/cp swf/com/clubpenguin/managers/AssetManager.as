//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.managers
{
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import org.osflash.signals.Signal;
    import com.clubpenguin.managers.vo.AssetVO;
    import com.clubpenguin.lib.services.http.LoadSWFService;
    import flash.utils.Dictionary;
    import flash.display.Loader;
    import com.clubpenguin.lib.services.http.LoadSWFResponse;

    public class AssetManager 
    {

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var signalBus:SignalBus;
        public var assetLoaded:Signal = new Signal(AssetVO);
        public var assetFailed:Signal = new Signal();
        public var loadingAsset:Signal = new Signal(LoadSWFService);
        public var progressReceived:Signal = new Signal(uint, uint);
        private var assetLookup:Dictionary = new Dictionary();
        private var loadSWFService:LoadSWFService;


        public function loadAsset(loadableAsset:ILoadableAsset):void
        {
            var loadURL:String;
            var clientPath:String = this.mainModel.getEnvironmentData().clientPath;
            var playPath:String = this.mainModel.getEnvironmentData().playPath;
            if (loadableAsset.isExternal)
            {
                loadURL = (playPath + loadableAsset.url);
            }
            else
            {
                if (loadableAsset.isAbsoluteURL)
                {
                    loadURL = loadableAsset.url;
                }
                else
                {
                    loadURL = (clientPath + loadableAsset.url);
                };
            };
            this.loadSWFService = new LoadSWFService(loadURL);
            this.loadSWFService.requestFailed.addOnce(this.onResponseFail);
            this.loadSWFService.responseReceived.addOnce(this.onResponse);
            this.loadSWFService.progressReceived.add(this.onProgress);
            this.loadSWFService.send();
            this.loadingAsset.dispatch(this.loadSWFService);
            var assetVO:AssetVO = new AssetVO();
            assetVO.url = loadURL;
            assetVO.id = loadableAsset.getID();
            this.assetLookup[loadURL] = assetVO;
        }

        private function onResponse(response:LoadSWFResponse):void
        {
            var assetVO:AssetVO;
            if (response.success)
            {
                try
                {
                    assetVO = AssetVO(this.assetLookup[response.id]);
                    assetVO.content = Loader(response.data);
                    this.assetLookup[assetVO.url] = null;
                    delete this.assetLookup[assetVO.url];
                    this.assetLoaded.dispatch(assetVO);
                }
                catch(error:Error)
                {
                    throw (error);
                };
            };
            this.loadSWFService.progressReceived.removeAll();
        }

        private function onResponseFail(response:LoadSWFResponse):void
        {
            this.loadSWFService.progressReceived.removeAll();
            this.assetFailed.dispatch();
        }

        private function onProgress(bytesLoaded:uint, bytesTotal:uint):void
        {
            this.progressReceived.dispatch(bytesLoaded, bytesTotal);
        }


    }
}//package com.clubpenguin.managers
