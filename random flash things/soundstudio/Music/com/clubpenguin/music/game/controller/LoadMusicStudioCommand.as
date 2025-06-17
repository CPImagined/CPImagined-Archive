//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.music.view.IMusicModuleContextView;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import flash.display.Loader;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import com.clubpenguin.lib.util.Log;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.display.LoaderInfo;
    import flash.display.MovieClip;
    import com.clubpenguin.music.game.view.components.MusicStudio;
    import com.clubpenguin.music.game.MusicStudioModule;
    import com.clubpenguin.music.events.MusicModuleEvent;

    public class LoadMusicStudioCommand extends Command 
    {

        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var musicModuleContextView:IMusicModuleContextView;
        [Inject]
        public var localization:ILocalizationManager;
        [Inject]
        public var hideLoadingScreen:HideLoadingScreenSignal;


        override public function execute():void
        {
            var loader:Loader;
            var envData:EnvironmentDataVO;
            var appDomain:ApplicationDomain;
            var loaderContext:LoaderContext;
            Log.debug("");
            if (this.musicModuleContextView.isMusicStudioOpen)
            {
                Log.warn("Don't load studio again since it is already open.");
            }
            else
            {
                loader = new Loader();
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
                loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
                envData = this.mainModel.getEnvironmentData();
                appDomain = ApplicationDomain.currentDomain;
                loaderContext = new LoaderContext(false, appDomain);
                loader.load(new URLRequest((envData.clientPath + "/music/assets/music_game.swf")), loaderContext);
            };
        }

        protected function onLoadError(event:Event):void
        {
            Log.debug("");
            this.removeLoaderListeners(event);
        }

        private function removeLoaderListeners(e:Event):void
        {
            var contentLoaderInfo:LoaderInfo = (e.currentTarget as LoaderInfo);
            contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoadComplete);
            contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
        }

        protected function onLoadComplete(event:Event):void
        {
            Log.debug(("" + contextView));
            this.hideLoadingScreen.dispatch();
            this.removeLoaderListeners(event);
            var assets:MovieClip = event.currentTarget.content;
            var studio:MusicStudio = new MusicStudio(assets, this.localization);
            var module:MusicStudioModule = (contextView.getChildByName("musicStudio") as MusicStudioModule);
            if (module.numChildren == 0)
            {
                module.addChild(studio);
                mediatorMap.createMediator(studio);
                dispatch(new MusicModuleEvent(MusicModuleEvent.STUDIO_ASSETS_LOADED));
            }
            else
            {
                Log.error("Another studio is being added, why??");
                Log.debug("");
            };
        }


    }
}//package com.clubpenguin.music.game.controller
