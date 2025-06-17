//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.context
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.services.socket.music.MusicService;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.music.player.MusicPlayer;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.music.view.IMusicModuleContextView;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.music.commands.InitializeWidgetCommand;
    import com.clubpenguin.music.commands.HideMusicWidgetCommand;
    import com.clubpenguin.music.commands.MuteMusicPlayerCommand;
    import com.clubpenguin.music.commands.UnmuteMusicPlayerCommand;
    import com.clubpenguin.music.commands.HideMusicModuleCommand;
    import com.clubpenguin.music.TemporaryTriggers;
    import com.clubpenguin.music.TemporaryTriggersMediator;
    import com.clubpenguin.music.commands.InitializeMusicStudiobySignalCommand;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.music.commands.InitializeMusicStudioCommand;
    import com.clubpenguin.music.commands.InitializeMySongListCommand;
    import com.clubpenguin.music.commands.HideMusicStudioCommand;
    import com.clubpenguin.music.commands.HideMySongListCommand;

    public class MusicContext extends BaseModuleContext 
    {

        private var _musicService:MusicService;
        private var _mockConnection:IConnection;
        private var _musicPlayer:MusicPlayer;
        private var mainModel:MainModel;
        private var signalBus:SignalBus;

        public function MusicContext(contextView:BaseModule, injector:IInjector, autoStartup:Boolean=true)
        {
            this.mainModel = MainModel(injector.getInstance(MainModel));
            this.signalBus = SignalBus(injector.getInstance(SignalBus));
            super(contextView, injector);
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(IMusicModuleContextView, contextView);
            this._musicPlayer = new MusicPlayer();
            injector.injectInto(this._musicPlayer);
            this._musicPlayer.init();
            injector.mapValue(IMusicPlayer, this._musicPlayer);
            injector.mapValue(MusicContext, this);
            injector.mapValue(SignalBus, this.signalBus);
            signalCommandMap.mapSignal(this.mainModel.showMusicPlayerWidget, InitializeWidgetCommand);
            signalCommandMap.mapSignal(this.mainModel.hideMusicPlayerWidget, HideMusicWidgetCommand);
            signalCommandMap.mapSignal(this.mainModel.muteMusicPlayer, MuteMusicPlayerCommand);
            signalCommandMap.mapSignal(this.mainModel.unmuteMusicPlayer, UnmuteMusicPlayerCommand);
            signalCommandMap.mapSignal(this.signalBus.leavingRoom, HideMusicModuleCommand);
        }

        public function mediateViews():void
        {
            mediatorMap.mapView(TemporaryTriggers, TemporaryTriggersMediator);
        }

        public function mapCommands():void
        {
            signalCommandMap.mapSignal(this.mainModel.startSoundStudio, InitializeMusicStudiobySignalCommand);
            commandMap.mapEvent(MusicModuleEvent.SHOW_STUDIO, InitializeMusicStudioCommand);
            commandMap.mapEvent(MusicModuleEvent.INITIALIZE_WIDGET, InitializeWidgetCommand);
            commandMap.mapEvent(MusicModuleEvent.SHOW_MYSONGLIST, InitializeMySongListCommand);
            commandMap.mapEvent(MusicModuleEvent.HIDE_STUDIO, HideMusicStudioCommand);
            commandMap.mapEvent(MusicModuleEvent.HIDE_WIDGET, HideMusicWidgetCommand);
            commandMap.mapEvent(MusicModuleEvent.HIDE_MYSONGLIST, HideMySongListCommand);
        }

        override public function startup():void
        {
            super.startup();
            this.mediateViews();
            this.mapCommands();
        }


    }
}//package com.clubpenguin.music.context
