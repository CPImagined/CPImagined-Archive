//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioPrompts;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.events.MusicStudioViewEvent;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.music.game.events.MusicStudioSongNameEvent;
    import com.clubpenguin.music.game.view.events.MusicStudioPromptEvent;
    import com.clubpenguin.music.game.model.vo.SongNameValidationVO;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import __AS3__.vec.Vector;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import __AS3__.vec.*;

    public class MusicStudioPromptsMediator extends Mediator 
    {

        [Inject]
        public var model:MusicStudioModel;


        public function get view():IMusicStudioPrompts
        {
            return (viewComponent as IMusicStudioPrompts);
        }

        override public function onRegister():void
        {
            super.onRegister();
            Log.debug("");
            addContextListener(MusicStudioViewEvent.SHOW_SAVE_PROMPT, this.onShowSavePromptRequested);
            addContextListener(MusicStudioViewEvent.CLOSE_SAVE_PROMPT, this.onCloseSavePromptRequested);
            addContextListener(MusicStudioSongEvent.SAVE_SONG_SUCCESS, this.onSaveSongSuccess);
            addContextListener(MusicStudioSongEvent.SONG_NAME_UPDATE_SUCCESS, this.onSongNameUpdateSuccess);
            addContextListener(MusicStudioSongEvent.SONG_NAME_UPDATE_FAIL, this.onSongNameUpdateFail);
            addContextListener(MusicStudioSongEvent.PREVIEW_SONG_PLAYBACK_UPDATED, this.onSongPlaybackUpdated);
            addContextListener(MusicStudioSongNameEvent.SONG_NAME_VALIDATION_RESULT, this.onSongNameValiationResult);
            addViewListener(MusicStudioPromptEvent.VALIDATE_SONG_NAME, this.onValidateSongNameRequest);
            addViewListener(MusicStudioPromptEvent.SET_SONG_NAME, this.onSetSongNameRequest);
            addViewListener(MusicStudioPromptEvent.CLOSE, this.onClosePromptsRequest);
            addViewListener(MusicStudioPromptEvent.PLAY, this.onPlaySongsRequest);
            addViewListener(MusicStudioPromptEvent.STOP, this.onStopSongsRequest);
        }

        private function onSaveSongSuccess(e:MusicStudioSongEvent):void
        {
            this.view.hideSavePrompt();
        }

        private function onValidateSongNameRequest(e:MusicStudioPromptEvent):void
        {
            var vo:SongNameValidationVO = new SongNameValidationVO((e.payload as String), false);
            dispatch(new MusicStudioSongNameEvent(MusicStudioSongNameEvent.VALIDATE_SONG_NAME, vo));
        }

        private function onSongNameValiationResult(e:MusicStudioSongNameEvent):void
        {
            this.view.updateNameValidation(e.songNameValidationVO.isValid);
        }

        private function onSongPlaybackUpdated(e:MusicStudioSongEvent):void
        {
            this.view.songPlayBackUpdate(e.songDetails);
        }

        private function onPlaySongsRequest(e:MusicStudioPromptEvent):void
        {
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.PREVIEW_SONG, this.wrapPayload(e.payload)));
        }

        private function onStopSongsRequest(e:MusicStudioPromptEvent):void
        {
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.PREVIEW_STOP_SONG, this.wrapPayload(e.payload)));
        }

        private function wrapPayload(payload:Object):Vector.<SongDetailsVO>
        {
            var vector:Vector.<SongDetailsVO> = new Vector.<SongDetailsVO>();
            vector.push((payload as SongDetailsVO));
            return (vector);
        }

        private function onClosePromptsRequest(e:MusicStudioPromptEvent):void
        {
            this.view.hideSavePrompt();
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, this.model.currentSongDetails.genreId));
        }

        private function onSongNameUpdateSuccess(e:MusicStudioSongEvent):void
        {
            this.view.onSongSaveSuccess();
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, this.model.currentSongDetails.genreId));
        }

        private function onSongNameUpdateFail(e:MusicStudioSongEvent):void
        {
            this.view.onSongSaveFail("no go");
        }

        private function onSetSongNameRequest(e:MusicStudioPromptEvent):void
        {
            var songName:String = (e.payload as String);
            var details:SongDetailsVO = new SongDetailsVO(NaN);
            details.setSongName(songName);
            var detailsVector:Vector.<SongDetailsVO> = new Vector.<SongDetailsVO>();
            detailsVector.push(details);
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SET_SONG_NAME, detailsVector));
        }

        override public function onRemove():void
        {
            super.onRemove();
            Log.debug("");
        }

        private function onShowSavePromptRequested(e:MusicStudioViewEvent):void
        {
            this.view.showSavePrompt((e.payload as SongDetailsVO));
        }

        private function onCloseSavePromptRequested(e:MusicStudioViewEvent):void
        {
            this.view.hideSavePrompt();
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, this.model.currentSongDetails.genreId));
        }


    }
}//package com.clubpenguin.music.game.view.mediators
