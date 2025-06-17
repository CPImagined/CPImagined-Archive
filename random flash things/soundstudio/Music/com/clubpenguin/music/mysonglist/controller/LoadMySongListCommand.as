//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import flash.display.Loader;
    import com.clubpenguin.lib.util.Log;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import flash.net.URLRequest;
    import flash.display.MovieClip;
    import com.clubpenguin.music.mysonglist.view.component.SongListView;
    import com.clubpenguin.music.MusicModule;
    import com.clubpenguin.music.mysonglist.MySongList;
    import com.clubpenguin.music.mysonglist.events.MySongListEvent;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class LoadMySongListCommand extends Command 
    {

        private static var ASSET_PATH:String = "/assets/music_mysonglist.swf";

        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var bridge:IAVMBridgeService;
        private var _loader:Loader;


        override public function execute():void
        {
            Log.debug("");
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loader_Complete_Handler);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loader_Failed_Handler);
            var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            var envData:EnvironmentDataVO = this.mainModel.getEnvironmentData();
            this._loader.load(new URLRequest(((envData.clientPath + "/music") + ASSET_PATH)), loaderContext);
        }

        private function loader_Complete_Handler(e:Event):void
        {
            Log.debug("");
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loader_Complete_Handler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loader_Failed_Handler);
            var assets:MovieClip = e.currentTarget.content;
            var songListView:SongListView = new SongListView(assets);
            var module:MySongList = (contextView.getChildByName(MusicModule.SONG_LIST_INSTANCE_NAME) as MySongList);
            if (module.numChildren == 0)
            {
                module.addChild(songListView);
                mediatorMap.createMediator(songListView);
                dispatch(new MySongListEvent(MySongListEvent.ASSETS_LOADED));
                commandMap.execute(GetSongDataCommand);
                Log.debug(" send request to mute room music");
                this.bridge.send(new AVMBridgeMessage(AVMBridgeMessage.MSG_MUTE_ROOM_MUSIC));
            }
            else
            {
                Log.error("Another studio is being added, why??");
                Log.debug("");
            };
        }

        private function loader_Failed_Handler(e:IOErrorEvent):void
        {
            Log.debug("");
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loader_Complete_Handler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loader_Failed_Handler);
        }


    }
}//package com.clubpenguin.music.mysonglist.controller
