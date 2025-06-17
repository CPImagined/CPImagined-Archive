//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.context
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import org.osflash.signals.Signal;
    import com.clubpenguin.music.game.service.SongNameValidationService;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.music.game.service.INameValidationService;
    import com.clubpenguin.music.commands.JoinPreviousRoomCommand;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.view.components.MusicStudio;
    import com.clubpenguin.music.game.view.mediators.MusicStudioMediator;
    import org.robotlegs.core.IMediator;
    import com.clubpenguin.music.game.view.components.MusicStudioPrompts;
    import com.clubpenguin.music.game.view.mediators.MusicStudioPromptsMediator;
    import com.clubpenguin.music.game.view.components.MusicStudioInstructions;
    import com.clubpenguin.music.game.view.mediators.MusicStudioInstructionsMediator;
    import com.clubpenguin.music.game.view.components.MusicStudioStartScreen;
    import com.clubpenguin.music.game.view.mediators.MusicStudioStartScreenMediator;
    import com.clubpenguin.music.game.view.components.MusicStudioGameBoard;
    import com.clubpenguin.music.game.view.mediators.MusicStudioGameBoardMediator;
    import com.clubpenguin.music.game.view.components.songList.MusicStudioSongList;
    import com.clubpenguin.music.game.view.mediators.songList.MusicStudioSongListMediator;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.controller.PlayGameCommand;
    import com.clubpenguin.music.game.controller.ExitGameCommand;
    import com.clubpenguin.music.game.controller.StartRecordingCommand;
    import com.clubpenguin.music.game.controller.StopRecordingCommand;
    import com.clubpenguin.music.game.controller.PlaySoundsCommand;
    import com.clubpenguin.music.game.controller.RecordMusicPulseCommand;
    import com.clubpenguin.music.game.controller.LoadGenreCommand;
    import com.clubpenguin.music.game.controller.ShowSavedTracksCommand;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.music.game.controller.SetSongNameCommand;
    import com.clubpenguin.music.game.controller.SaveSongCommand;
    import com.clubpenguin.music.game.controller.LikeSongCommand;
    import com.clubpenguin.music.game.controller.GetSharedSongsCommand;
    import com.clubpenguin.music.game.controller.PreviewSongCommand;
    import com.clubpenguin.music.game.controller.PreviewStopSongCommand;
    import com.clubpenguin.music.game.controller.PlaySongInMusicPlayerCommand;
    import com.clubpenguin.music.game.controller.StopSongInMusicPlayerCommand;
    import com.clubpenguin.music.game.events.MusicStudioSongNameEvent;
    import com.clubpenguin.music.game.controller.ValidateSongNameCommand;
    import com.clubpenguin.music.game.controller.ShowInstructionsCommand;
    import com.clubpenguin.music.game.controller.ShowStartScreenCommand;
    import com.clubpenguin.music.game.controller.HideInstructionsCommand;
    import com.clubpenguin.music.game.controller.CheckForEmptySaveSlotCommand;
    import com.clubpenguin.music.game.controller.InitializeServicesCommand;
    import com.clubpenguin.music.game.controller.LoadMusicStudioCommand;

    public class MusicStudioContext extends BaseModuleContext 
    {

        public var model:MusicStudioModel;
        public var joinRoomSignal:Signal = new Signal();
        private var nameValidationService:SongNameValidationService;

        public function MusicStudioContext(contextView:BaseModule, injector:IInjector, autoStartup:Boolean=true)
        {
            super(contextView, injector);
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            this.nameValidationService = new SongNameValidationService();
            injector.mapValue(INameValidationService, this.nameValidationService);
            this.model = new MusicStudioModel();
            injector.injectInto(this.model);
            injector.mapValue(MusicStudioContext, this);
            injector.mapValue(MusicStudioModel, this.model);
            signalCommandMap.mapSignal(this.joinRoomSignal, JoinPreviousRoomCommand);
        }

        public function mediateViews():void
        {
            Log.info("");
            Log.debug(("MusicStudio: " + mediatorMap.hasMapping(MusicStudio)));
            Log.debug(("MusicStudioMediator: " + mediatorMap.hasMediator((MusicStudioMediator as IMediator))));
            mediatorMap.mapView(MusicStudio, MusicStudioMediator, null, false);
            mediatorMap.mapView(MusicStudioPrompts, MusicStudioPromptsMediator, null, false);
            mediatorMap.mapView(MusicStudioInstructions, MusicStudioInstructionsMediator, null, false);
            mediatorMap.mapView(MusicStudioStartScreen, MusicStudioStartScreenMediator, null, false);
            mediatorMap.mapView(MusicStudioGameBoard, MusicStudioGameBoardMediator, null, false);
            mediatorMap.mapView(MusicStudioSongList, MusicStudioSongListMediator, null, false);
        }

        public function mapCommands():void
        {
            commandMap.mapEvent(MusicStudioEvent.PLAY_GAME, PlayGameCommand);
            commandMap.mapEvent(MusicStudioEvent.EXIT_GAME, ExitGameCommand);
            commandMap.mapEvent(MusicStudioEvent.START_RECORDING, StartRecordingCommand);
            commandMap.mapEvent(MusicStudioEvent.STOP_RECORDING, StopRecordingCommand);
            commandMap.mapEvent(MusicStudioEvent.PLAY_SOUNDS, PlaySoundsCommand);
            commandMap.mapEvent(MusicStudioEvent.RECORD_PULSE, RecordMusicPulseCommand);
            commandMap.mapEvent(MusicStudioEvent.LOAD_GENRE, LoadGenreCommand);
            commandMap.mapEvent(MusicStudioEvent.SHOW_SAVED_TRACKS, ShowSavedTracksCommand);
            commandMap.mapEvent(MusicStudioSongEvent.SET_SONG_NAME, SetSongNameCommand);
            commandMap.mapEvent(MusicStudioSongEvent.SONG_NAME_UPDATE_SUCCESS, SaveSongCommand);
            commandMap.mapEvent(MusicStudioSongEvent.LIKE_SONG, LikeSongCommand);
            commandMap.mapEvent(MusicStudioSongEvent.GET_SHARED_SONGS, GetSharedSongsCommand);
            commandMap.mapEvent(MusicStudioSongEvent.PREVIEW_SONG, PreviewSongCommand);
            commandMap.mapEvent(MusicStudioSongEvent.PREVIEW_STOP_SONG, PreviewStopSongCommand);
            commandMap.mapEvent(MusicStudioSongEvent.PLAY_SONG, PlaySongInMusicPlayerCommand);
            commandMap.mapEvent(MusicStudioSongEvent.STOP_SONG, StopSongInMusicPlayerCommand);
            commandMap.mapEvent(MusicStudioSongNameEvent.VALIDATE_SONG_NAME, ValidateSongNameCommand);
            commandMap.mapEvent(MusicStudioEvent.SHOW_INSTRUCTIONS, ShowInstructionsCommand);
            commandMap.mapEvent(MusicStudioEvent.SHOW_START_SCREEN, ShowStartScreenCommand);
            commandMap.mapEvent(MusicStudioEvent.HIDE_INSTRUCTIONS, HideInstructionsCommand);
            commandMap.mapEvent(MusicStudioEvent.RECORD_PERMISSION_REQUEST, CheckForEmptySaveSlotCommand);
            commandMap.execute(InitializeServicesCommand);
            commandMap.execute(LoadMusicStudioCommand);
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
}//package com.clubpenguin.music.game.context
