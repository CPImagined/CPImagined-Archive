//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components
{
    import flash.display.Sprite;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioGameBoard;
    import flash.display.MovieClip;
    import com.clubpenguin.music.game.view.components.grid.MusicStudioGameBoardGrid;
    import com.clubpenguin.music.game.view.components.recorder.MusicStudioRecorderBar;
    import com.clubpenguin.music.game.view.components.genres.MusicStudioGenreSelector;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.utils.Timer;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import flash.text.TextField;
    import com.clubpenguin.music.game.view.events.MusicStudioGameBoardEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;

    public class MusicStudioGameBoard extends Sprite implements IMusicStudioGameBoard 
    {

        protected var skin:MovieClip;
        public var grid:MusicStudioGameBoardGrid;
        public var recorder:MusicStudioRecorderBar;
        public var genres:MusicStudioGenreSelector;
        private var _localizationManager:ILocalizationManager;
        private var countdownTimer:Timer;

        public function MusicStudioGameBoard(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            Log.debug("");
            this.skin = skin;
            this._localizationManager = localizationManager;
            this.init();
            this.localize();
            this.addListeners();
        }

        public function show():void
        {
            Log.debug("");
            this.skin.visible = true;
        }

        public function hide():void
        {
            Log.debug("");
            this.skin.visible = false;
        }

        public function recordingPermissionUpdate(canRecord:Boolean):void
        {
            if (canRecord)
            {
                this.startCountdownToBeginRecording();
            };
        }

        public function setGenre(genreId:int):void
        {
            this.grid.reset();
            this.genres.genre = genreId;
            this.grid.genre = genreId;
        }

        public function getGenre():int
        {
            return (this.genres.genre);
        }

        public function recordingStarted():void
        {
            this.recorder.status = MusicStudioRecordingStatusEnum.ON;
        }

        public function recordingStopped():void
        {
            this.recorder.status = MusicStudioRecordingStatusEnum.OFF;
            this.recorder.elapsedTime = 0;
            this.resetCountdown();
        }

        private function init():void
        {
            this.skin.visible = false;
            this.recorder = new MusicStudioRecorderBar(this.skin);
            this.grid = new MusicStudioGameBoardGrid((this.skin["grid"] as MovieClip), this._localizationManager);
            this.genres = new MusicStudioGenreSelector(this.skin.genres);
        }

        public function localize():void
        {
            this.recorder.localize(this._localizationManager);
            this.grid.localize();
            this.genres.localize(this._localizationManager);
            if (this.skin.promo != null)
            {
                TextField(this.skin.promo.promoText).text = this._localizationManager.getLocalizedString("m.game.soundstudio.spookyPromo2");
            };
        }

        public function reset():void
        {
            this.grid.reset();
            this.recordingStopped();
        }

        protected function onGenreSelected(event:MusicStudioGameBoardEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.GENRE_SELECTED, event.payload));
        }

        protected function onSoundButtonClicked(e:Event):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.TRIGGER_SOUND, this.grid.layout));
        }

        public function updateRecordingTime(elapsedTime:Number):void
        {
            Log.debug((elapsedTime + ""));
            this.recorder.elapsedTime = (this.recorder.elapsedTime + (elapsedTime / 1000));
        }

        private function addListeners():void
        {
            this.grid.addEventListener(MusicStudioGameBoardEvent.SOUND_BUTTON_CLICKED, this.onSoundButtonClicked);
            this.genres.addEventListener(MusicStudioGameBoardEvent.GENRE_BUTTON_CLICKED, this.onGenreSelected);
            this.recorder.addEventListener(MouseEvent.CLICK, this.onRecorderBarClick);
            this.recorder.addEventListener(Event.COMPLETE, this.onRecorderTotalTimeComplete);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        protected function onRecorderTotalTimeComplete(event:Event):void
        {
            this.stopRecording();
        }

        protected function onRemovedFromStage(event:Event):void
        {
            Log.debug("");
            this.removeListeners();
        }

        private function removeListeners():void
        {
            this.grid.removeEventListener(MusicStudioGameBoardEvent.SOUND_BUTTON_CLICKED, this.onSoundButtonClicked);
            this.genres.removeEventListener(MusicStudioGameBoardEvent.GENRE_BUTTON_CLICKED, this.onGenreSelected);
            this.recorder.removeEventListener(MouseEvent.CLICK, this.onRecorderBarClick);
            this.recorder.removeEventListener(Event.COMPLETE, this.onRecorderTotalTimeComplete);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (this.countdownTimer)
            {
                Log.debug("removing countdown timer");
                this.countdownTimer.removeEventListener(TimerEvent.TIMER, this.onCountdownTimerEvent);
                this.countdownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onCountdownTimerCompleteEvent);
                this.countdownTimer = null;
            };
        }

        protected function onRecorderBarClick(event:Event):void
        {
            Log.debug(this.recorder.status);
            switch (this.recorder.status)
            {
                case MusicStudioRecordingStatusEnum.PREPARING:
                    this.resetCountdown();
                    this.recorder.status = MusicStudioRecordingStatusEnum.OFF;
                    dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.RECORD_CANCEL));
                    break;
                case MusicStudioRecordingStatusEnum.ON:
                    this.stopRecording();
                    break;
                case MusicStudioRecordingStatusEnum.OFF:
                    this.sendRequestForRecordPermission();
                    break;
            };
        }

        private function sendRequestForRecordPermission():void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.CAN_RECORD_QUESTION));
        }

        private function startRecording():void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.RECORDING_REQUEST_START, this.grid.layout));
        }

        private function stopRecording():void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.RECORDING_REQUEST_STOP, {
                "layout":this.grid.layout,
                "timestamp":this.recorder.elapsedTime
            }));
            this.resetCountdown();
        }

        private function resetCountdown():void
        {
            if (this.countdownTimer)
            {
                this.countdownTimer.delay = 1000;
                this.countdownTimer.reset();
            };
            this.recorder.elapsedTime = 0;
        }

        private function startCountdownToBeginRecording():void
        {
            this.recorder.status = MusicStudioRecordingStatusEnum.PREPARING;
            if (!this.countdownTimer)
            {
                this.countdownTimer = new Timer(1000, 4);
                this.countdownTimer.addEventListener(TimerEvent.TIMER, this.onCountdownTimerEvent);
                this.countdownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onCountdownTimerCompleteEvent);
            };
            this.countdownTimer.start();
            this.recorder.elapsedTime = -3;
        }

        protected function onCountdownTimerCompleteEvent(event:TimerEvent):void
        {
            this.startRecording();
        }

        protected function onCountdownTimerEvent(event:TimerEvent):void
        {
            this.recorder.elapsedTime = (this.recorder.elapsedTime + 1);
            if (this.recorder.elapsedTime == 0)
            {
                this.countdownTimer.delay = 300;
            };
        }


    }
}//package com.clubpenguin.music.game.view.components
