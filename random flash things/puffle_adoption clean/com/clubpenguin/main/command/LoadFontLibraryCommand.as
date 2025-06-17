//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import org.osflash.signals.Signal;
    import com.clubpenguin.tools.localtext.core.ILocalText;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.signal.loadingScreen.ShowLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import com.clubpenguin.main.signal.loadingScreen.UpdateLoadingScreenSignal;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import com.clubpenguin.tools.localtext.core.events.FontLibraryEvent;
    import flash.events.ProgressEvent;
    import flash.events.Event;

    public class LoadFontLibraryCommand extends SignalCommand 
    {

        [Inject]
        public var _onLoaded:Signal;
        [Inject]
        public var localText:ILocalText;
        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var signalBus:IAppSignalBus;
        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var showLoadingScreen:ShowLoadingScreenSignal;
        [Inject]
        public var hideLoadingScreen:HideLoadingScreenSignal;
        [Inject]
        public var updateLoadingScreen:UpdateLoadingScreenSignal;


        override public function execute():void
        {
            var envData:EnvironmentDataVO = this.mainModel.getEnvironmentData();
            var fontLibUrl:String = ((((envData.clientPath + "/fonts/") + envData.language) + "/FontLibrary.swf") + CacheTypeEnum.getCacheAsStringByType("client"));
            this.localText.addEventListener(FontLibraryEvent.LOAD_COMPLETE, this.onFontLibraryComplete);
            this.localText.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.localText.loadFontLibrary(fontLibUrl);
            this.showLoadingScreen.dispatch("");
        }

        private function onProgress(event:ProgressEvent):void
        {
            this.updateLoadingScreen.dispatch(((event.bytesLoaded / event.bytesTotal) * 100));
        }

        private function onFontLibraryComplete(event:Event):void
        {
            this._onLoaded.dispatch();
        }


    }
}//package com.clubpenguin.main.command
