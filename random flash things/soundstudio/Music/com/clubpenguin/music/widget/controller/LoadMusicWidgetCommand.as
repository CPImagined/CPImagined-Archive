//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.util.Log;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import flash.net.URLRequest;
    import flash.display.LoaderInfo;
    import flash.display.MovieClip;
    import com.clubpenguin.music.widget.view.component.MainWidgetView;
    import com.clubpenguin.music.MusicModule;
    import com.clubpenguin.music.widget.MusicPlayerWidget;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;

    public class LoadMusicWidgetCommand extends Command 
    {

        [Inject]
        public var mainModel:IAppModel;


        override public function execute():void
        {
            Log.debug("");
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
            var envData:EnvironmentDataVO = this.mainModel.getEnvironmentData();
            loader.load(new URLRequest((envData.clientPath + "/music/assets/music_widget.swf")));
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
            this.removeLoaderListeners(event);
            var assets:MovieClip = event.currentTarget.content;
            var mainView:MainWidgetView = new MainWidgetView(assets);
            var module:MusicPlayerWidget = (contextView.getChildByName(MusicModule.MUSIC_WIDGET_INSTANCE_NAME) as MusicPlayerWidget);
            if (module.numChildren == 0)
            {
                module.addChild(mainView);
                mediatorMap.createMediator(mainView);
                dispatch(new MusicWidgetEvent(MusicWidgetEvent.WIDGET_ASSETS_LOADED));
            }
            else
            {
                Log.error("Another studio is being added, why??");
                Log.debug("");
            };
        }


    }
}//package com.clubpenguin.music.widget.controller
