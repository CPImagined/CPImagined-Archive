//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components
{
    import flash.display.MovieClip;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioPrompts;
    import com.clubpenguin.music.game.view.components.base.UIView;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.events.Event;
    import com.clubpenguin.music.game.view.events.MusicStudioPromptEvent;
    import com.clubpenguin.music.game.view.components.prompts.SaveSongPrompt;
    import __AS3__.vec.Vector;

    public class MusicStudioPrompts extends MovieClip implements IMusicStudioPrompts 
    {

        public static const PROMPTS_CLOSED_FRAME:uint = 1;
        public static const SAVE_FRAME:uint = 2;
        public static const SAVE_SUCCESS_FRAME:uint = 3;
        public static const DELETE_SUCCESS_FRAME:uint = 5;
        public static const OOPS_FRAME:uint = 6;

        private var frameToReach:uint = 1;
        protected var skin:MovieClip;
        protected var currentPrompt:UIView;
        private var _songDetails:SongDetailsVO;
        private var _localizationManager:ILocalizationManager;

        public function MusicStudioPrompts(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            this.skin = skin;
            skin.stop();
            this._localizationManager = localizationManager;
            this.addListeners();
        }

        private function addListeners():void
        {
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        protected function onRemovedFromStage(event:Event):void
        {
            this.removeListeners();
        }

        private function removeListeners():void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            this.removeEnterFrameListener();
        }

        public function onSongSaveSuccess():void
        {
        }

        public function onSongSaveFail(message:String):void
        {
        }

        public function showSavePrompt(songDetails:SongDetailsVO):void
        {
            this._songDetails = songDetails;
            this.skin.visible = false;
            this.gotoFrame(SAVE_FRAME);
        }

        public function hideSavePrompt():void
        {
            this.gotoFrame(PROMPTS_CLOSED_FRAME);
        }

        private function gotoFrame(frameNumber:uint):void
        {
            this.releaseCurrentPrompt();
            this.frameToReach = frameNumber;
            this.skin.gotoAndStop(this.frameToReach);
            this.skin.addEventListener(Event.ENTER_FRAME, this.onNewPromptFrameReached);
        }

        private function releaseCurrentPrompt():void
        {
            if (this.currentPrompt)
            {
                this.currentPrompt.removeEventListener(MusicStudioPromptEvent.CLOSE, this.onClosePromptsRequested);
                this.currentPrompt.destroy();
                this.currentPrompt = null;
            };
        }

        protected function onNewPromptFrameReached(event:Event):void
        {
            if (this.skin.currentFrame == this.frameToReach)
            {
                this.removeEnterFrameListener();
                this.setPromptController();
                this.skin.visible = true;
            };
        }

        private function removeEnterFrameListener():void
        {
            if (this.skin.hasEventListener(Event.ENTER_FRAME))
            {
                this.skin.removeEventListener(Event.ENTER_FRAME, this.onNewPromptFrameReached);
            };
        }

        private function setPromptController():void
        {
            switch (this.skin.currentFrame)
            {
                case SAVE_FRAME:
                    this.waitUntilIntroAnimationIsComplete();
                    break;
            };
        }

        private function waitUntilIntroAnimationIsComplete():void
        {
            (this.skin.saveTrack as MovieClip).addEventListener(Event.ENTER_FRAME, this.onSaveTrackEnterFrameHandler);
            (this.skin.saveTrack as MovieClip).gotoAndPlay(1);
        }

        protected function onSaveTrackEnterFrameHandler(event:Event):void
        {
            var trackMC:MovieClip = (this.skin.saveTrack as MovieClip);
            if (this.skin.saveTrack.savePrompt)
            {
                trackMC.removeEventListener(Event.ENTER_FRAME, this.onSaveTrackEnterFrameHandler);
                this.onIntroAnimationComplete();
            };
        }

        private function onIntroAnimationComplete():void
        {
            this.createSavePromptFromSkin();
        }

        private function createSavePromptFromSkin():void
        {
            this.currentPrompt = new SaveSongPrompt(this.skin.saveTrack.savePrompt, this._localizationManager);
            (this.currentPrompt as SaveSongPrompt).setSongDetails(this._songDetails);
            this.currentPrompt.addEventListener(MusicStudioPromptEvent.VALIDATE_SONG_NAME, this.onSongNameValidationRequest);
            this.currentPrompt.addEventListener(MusicStudioPromptEvent.CLOSE, this.onClosePromptsRequested);
            this.currentPrompt.addEventListener(MusicStudioPromptEvent.SET_SONG_NAME, this.onSetSongNameRequested);
            this.currentPrompt.addEventListener(MusicStudioPromptEvent.PLAY, this.onPlaySongRequested);
            this.currentPrompt.addEventListener(MusicStudioPromptEvent.STOP, this.onStopSongRequested);
        }

        protected function onSongNameValidationRequest(e:MusicStudioPromptEvent):void
        {
            e.stopImmediatePropagation();
            dispatchEvent(e);
        }

        protected function onSetSongNameRequested(e:MusicStudioPromptEvent):void
        {
            e.stopImmediatePropagation();
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.SET_SONG_NAME, e.payload));
        }

        protected function onPlaySongRequested(e:MusicStudioPromptEvent):void
        {
            e.stopImmediatePropagation();
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.PLAY, e.payload));
        }

        protected function onStopSongRequested(e:MusicStudioPromptEvent):void
        {
            e.stopImmediatePropagation();
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.STOP, e.payload));
        }

        protected function onClosePromptsRequested(e:MusicStudioPromptEvent):void
        {
            e.stopImmediatePropagation();
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.CLOSE));
        }

        public function songPlayBackUpdate(songs:Vector.<SongDetailsVO>):void
        {
            (this.currentPrompt as SaveSongPrompt).setStatusPlaying(songs[0].playing);
        }

        public function updateNameValidation(isValid:Boolean):void
        {
            (this.currentPrompt as SaveSongPrompt).setNameValid(isValid);
        }


    }
}//package com.clubpenguin.music.game.view.components
