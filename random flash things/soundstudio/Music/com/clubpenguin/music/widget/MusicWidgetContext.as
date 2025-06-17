//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.widget.view.component.MainWidgetView;
    import com.clubpenguin.music.widget.view.mediator.MainWidgetViewMediator;
    import com.clubpenguin.music.commands.MusicWidgetOnOverlayCountAdd;
    import com.clubpenguin.music.commands.MusicWidgetOnOverlayCountSubtract;
    import com.clubpenguin.music.widget.controller.HandleBroadcastMusicTracksCommand;
    import com.clubpenguin.music.widget.controller.LoadMusicWidgetCommand;
    import com.clubpenguin.music.widget.controller.GetPlayerIgnoreListCommand;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;
    import com.clubpenguin.music.widget.controller.ShowSongListCommand;
    import com.clubpenguin.music.widget.controller.GetBroadcastMusicTracksCommand;
    import com.clubpenguin.music.widget.controller.LikeSongCommand;

    public class MusicWidgetContext extends BaseModuleContext 
    {

        public var musicService:IMusicService;
        public var musicWidgetModel:MusicWidgetModel;
        private var bridge:IAVMBridgeService;

        public function MusicWidgetContext(contextView:BaseModule, injector:IInjector, musicService:IMusicService)
        {
            this.bridge = IAVMBridgeService(injector.getInstance(IAVMBridgeService));
            this.musicService = musicService;
            super(contextView, injector);
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            this.musicWidgetModel = new MusicWidgetModel();
            injector.injectInto(this.musicWidgetModel);
            injector.mapValue(MusicWidgetModel, this.musicWidgetModel);
        }

        public function mediateViews():void
        {
            Log.info("");
            mediatorMap.mapView(MainWidgetView, MainWidgetViewMediator, null, false);
        }

        public function mapCommands():void
        {
            signalCommandMap.mapSignal(this.bridge.getStopNotificationServices(), MusicWidgetOnOverlayCountAdd);
            signalCommandMap.mapSignal(this.bridge.getStartNotificationServices(), MusicWidgetOnOverlayCountSubtract);
            signalCommandMap.mapSignal(this.musicService.broadcastMusicTracksSignal, HandleBroadcastMusicTracksCommand);
            commandMap.execute(LoadMusicWidgetCommand);
            commandMap.execute(GetPlayerIgnoreListCommand);
            commandMap.mapEvent(MusicWidgetEvent.SHOW_MYSONGLIST, ShowSongListCommand);
            commandMap.mapEvent(MusicWidgetEvent.GET_BROADCASTS, GetBroadcastMusicTracksCommand);
            commandMap.mapEvent(MusicWidgetEvent.LIKE_SONG, LikeSongCommand);
        }

        override public function startup():void
        {
            Log.info("");
            super.startup();
            this.mediateViews();
            this.mapCommands();
        }

        override public function shutdown():void
        {
            super.shutdown();
            Log.debug("");
        }


    }
}//package com.clubpenguin.music.widget
