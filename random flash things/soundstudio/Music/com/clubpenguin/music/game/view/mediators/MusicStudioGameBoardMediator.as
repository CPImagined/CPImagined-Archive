//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioGameBoard;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.view.events.MusicStudioGameBoardEvent;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;

    public class MusicStudioGameBoardMediator extends Mediator 
    {

        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var musicPlayer:IMusicPlayer;


        public function get view():IMusicStudioGameBoard
        {
            return (viewComponent as IMusicStudioGameBoard);
        }

        override public function onRegister():void
        {
            super.onRegister();
            Log.debug("");
            addViewListener(MusicStudioGameBoardEvent.CAN_RECORD_QUESTION, this.onCanRecordQuestion);
            addViewListener(MusicStudioGameBoardEvent.RECORDING_REQUEST_START, this.onRecordingRequestStart);
            addViewListener(MusicStudioGameBoardEvent.RECORDING_REQUEST_STOP, this.onRecordingRequestStop);
            addViewListener(MusicStudioGameBoardEvent.TRIGGER_SOUND, this.onSoundTriggerRequest);
            addViewListener(MusicStudioGameBoardEvent.GENRE_SELECTED, this.onGenreSelected);
            addViewListener(MusicStudioGameBoardEvent.RECORD_CANCEL, this.onRecordCancel);
            (contextView as BaseModule).getContext().eventDispatcher.addEventListener(MusicModuleEvent.HIDE_MYSONGLIST, this.onSongListHidden);
            addContextListener(MusicStudioEvent.RECORD_PERMISSION_STATUS_UPDATE, this.onRecordPermissionStatusHandler);
            addContextListener(MusicStudioEvent.START_RECORDING_SUCCESS, this.onStartRecordingReceived);
            addContextListener(MusicStudioEvent.STOP_RECORDING_SUCCESS, this.onStopRecordingReceived);
            addContextListener(MusicStudioEvent.GENRE_LOADED, this.onGenreLoaded);
            addContextListener(MusicStudioEvent.PULSE, this.onMusicPulse);
        }

        private function onSongListHidden(eL:MusicModuleEvent):void
        {
            Log.debug("");
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, this.view.getGenre()));
        }

        private function onCanRecordQuestion(e:MusicStudioGameBoardEvent):void
        {
            Log.debug("");
            dispatch(new MusicStudioEvent(MusicStudioEvent.RECORD_PERMISSION_REQUEST, e.payload));
        }

        private function onRecordCancel(e:MusicStudioGameBoardEvent):void
        {
            this.musicPlayer.unmute();
        }

        override public function onRemove():void
        {
            super.onRemove();
            Log.debug("");
            (contextView as BaseModule).getContext().eventDispatcher.removeEventListener(MusicModuleEvent.HIDE_MYSONGLIST, this.onSongListHidden);
        }

        private function onRecordPermissionStatusHandler(e:MusicStudioEvent):void
        {
            Log.debug(("permission: " + e.payload));
            this.view.recordingPermissionUpdate((e.payload as Boolean));
            if (e.payload == true)
            {
                this.musicPlayer.mute();
            };
        }

        private function onGenreLoaded(e:MusicStudioEvent):void
        {
            Log.debug("");
            this.view.setGenre((e.payload as int));
        }

        private function onGenreSelected(e:MusicStudioGameBoardEvent):void
        {
            Log.debug("");
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, e.payload));
        }

        private function onStartRecordingReceived(e:MusicStudioEvent):void
        {
            this.view.recordingStarted();
        }

        private function onStopRecordingReceived(e:MusicStudioEvent):void
        {
            this.view.recordingStopped();
        }

        private function onSoundTriggerRequest(e:MusicStudioGameBoardEvent):void
        {
            if (this.model.getRecordingStatus() == MusicStudioRecordingStatusEnum.ON)
            {
                dispatch(new MusicStudioEvent(MusicStudioEvent.RECORD_PULSE, e.payload));
            };
            dispatch(new MusicStudioEvent(MusicStudioEvent.PLAY_SOUNDS, e.payload));
        }

        private function onMusicPulse(e:MusicStudioEvent):void
        {
            if (this.model.getRecordingStatus() == MusicStudioRecordingStatusEnum.ON)
            {
                this.view.updateRecordingTime((e.payload.elapsed as Number));
            };
        }

        private function onRecordingRequestStop(e:MusicStudioGameBoardEvent):void
        {
            Log.debug(("" + e.payload.timestamp));
            dispatch(new MusicStudioEvent(MusicStudioEvent.STOP_RECORDING, e.payload));
        }

        private function onRecordingRequestStart(e:MusicStudioGameBoardEvent):void
        {
            Log.debug(("" + e.payload));
            dispatch(new MusicStudioEvent(MusicStudioEvent.START_RECORDING, e.payload));
        }

        private function startRecording():void
        {
        }


    }
}//package com.clubpenguin.music.game.view.mediators
