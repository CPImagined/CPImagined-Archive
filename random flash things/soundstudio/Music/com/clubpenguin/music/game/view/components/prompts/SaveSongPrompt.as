//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.prompts
{
    import com.clubpenguin.music.game.view.components.base.UIView;
    import flash.display.SimpleButton;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import com.clubpenguin.lib.util.Log;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.events.FocusEvent;
    import flash.events.Event;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    import com.clubpenguin.music.game.view.events.MusicStudioPromptEvent;
    import flash.utils.getTimer;

    public class SaveSongPrompt extends UIView 
    {

        private static const TYPING_TIMEOUT:Number = 500;
        private static const SONG_NAME_MAX_CHAR:int = 12;

        public var closeButton:SimpleButton;
        public var playButton:MovieClip;
        public var songNameInput:MovieClip;
        public var inputField:TextField;
        public var saveButton:SimpleButton;
        public var saveButtonLabel:TextField;
        public var cancelButton:SimpleButton;
        public var cancelButtonLabel:TextField;
        private var _localizationManager:ILocalizationManager;
        private var _details:SongDetailsVO;
        private var _waitTimeoutID:int;
        private var startTime:int;

        public function SaveSongPrompt(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            super(skin);
            Log.info("");
            this._localizationManager = localizationManager;
            this.init();
        }

        public function setSongDetails(details:SongDetailsVO):void
        {
            this._details = details;
            this.updateUI();
        }

        private function updateUI():void
        {
            this.setStatusPlaying(this._details.playing);
        }

        private function init():void
        {
            this.songNameInput.mouseEnabled = false;
            skin.stage.focus = this.inputField;
            this.setStatusPlaying(false);
            skin.saveButtonLabel.mouseEnabled = false;
            skin.cancelButtonLabel.mouseEnabled = false;
            this.localize();
        }

        public function localize():void
        {
            skin.nameYourTrackField.text = this._localizationManager.getLocalizedString("w.app.music.game.board.prompt.nameTrack");
            skin.saveButtonLabel.text = this._localizationManager.getLocalizedString("w.app.music.game.board.prompt.save");
            skin.cancelButtonLabel.text = this._localizationManager.getLocalizedString("w.app.music.game.board.prompt.cancel");
        }

        override protected function createChildComponents():void
        {
            this.closeButton = (skin.close_button as SimpleButton);
            this.playButton = (skin.playButton as MovieClip);
            this.playButton.mouseChildren = false;
            this.playButton.buttonMode = true;
            this.playButton.useHandCursor = true;
            this.saveButton = (skin.saveButton as SimpleButton);
            this.cancelButton = (skin.cancelButton as SimpleButton);
            this.songNameInput = (skin.songNameInput as MovieClip);
            this.inputField = (skin.inputField as TextField);
            this.inputField.maxChars = SONG_NAME_MAX_CHAR;
            skin.saveButtonLabel.mouseEnabled = false;
            skin.cancelButtonLabel.mouseEnabled = false;
        }

        override protected function addListeners():void
        {
            super.addListeners();
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
            this.playButton.addEventListener(MouseEvent.CLICK, this.onPlayButtonClicked);
            this.saveButton.addEventListener(MouseEvent.CLICK, this.onSaveButtonClicked);
            this.cancelButton.addEventListener(MouseEvent.CLICK, this.onCancelButtonClicked);
            this.inputField.addEventListener(KeyboardEvent.KEY_DOWN, this.onNameInputKeyDown);
            this.inputField.addEventListener(KeyboardEvent.KEY_UP, this.onNameInputChange);
            this.inputField.addEventListener(FocusEvent.FOCUS_IN, this.onInputFieldFocus);
        }

        protected function onNameInputKeyDown(event:KeyboardEvent):void
        {
            skin.nameYourTrackField.visible = false;
        }

        protected function onInputFieldFocus(event:FocusEvent):void
        {
            this.inputField.setSelection(0, this.inputField.text.length);
            this.songNameInput.gotoAndStop(1);
        }

        public function setNameValid(isValid:Boolean):void
        {
            this.songNameInput.gotoAndStop(((isValid) ? 3 : 4));
            this.saveButton.enabled = isValid;
        }

        protected function onNameInputChange(event:Event):void
        {
            this.saveButton.enabled = false;
            skin.nameYourTrackField.visible = (this.inputField.text == "");
            if (this.inputField.text != "")
            {
                this.waitUntilUserStopsTyping();
            };
        }

        private function waitUntilUserStopsTyping():void
        {
            this.songNameInput.gotoAndStop(2);
            clearTimeout(this._waitTimeoutID);
            this._waitTimeoutID = setTimeout(this.onWaitUntilUserStopsTypingIsOver, TYPING_TIMEOUT);
        }

        private function onWaitUntilUserStopsTypingIsOver():void
        {
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.VALIDATE_SONG_NAME, this.inputField.text));
            clearTimeout(this._waitTimeoutID);
        }

        public function setStatusPlaying(playing:Boolean):void
        {
            if (playing)
            {
                this.startTimer();
            }
            else
            {
                this.stopTimer();
            };
            this.playButton.gotoAndStop(((playing) ? 2 : 1));
        }

        private function startTimer():void
        {
            this.startTime = getTimer();
            Log.debug(("" + this.startTime));
        }

        private function stopTimer():void
        {
            var elapsedTime:int = (getTimer() - this.startTime);
            Log.debug(("song played for " + elapsedTime));
        }

        protected function onPlayButtonClicked(event:MouseEvent):void
        {
            if (!this._details.playing)
            {
                dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.PLAY, this._details));
            }
            else
            {
                dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.STOP, this._details));
            };
        }

        protected function onSaveButtonClicked(event:MouseEvent):void
        {
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.SET_SONG_NAME, this.inputField.text));
        }

        protected function onCancelButtonClicked(event:MouseEvent):void
        {
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.CLOSE));
        }

        protected function onCloseButtonClicked(event:MouseEvent):void
        {
            dispatchEvent(new MusicStudioPromptEvent(MusicStudioPromptEvent.CLOSE));
        }

        override protected function removeListeners():void
        {
            super.removeListeners();
            this.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
            this.playButton.removeEventListener(MouseEvent.CLICK, this.onPlayButtonClicked);
            this.saveButton.removeEventListener(MouseEvent.CLICK, this.onSaveButtonClicked);
            this.cancelButton.removeEventListener(MouseEvent.CLICK, this.onCancelButtonClicked);
            this.inputField.removeEventListener(KeyboardEvent.KEY_UP, this.onNameInputChange);
            this.inputField.removeEventListener(FocusEvent.FOCUS_IN, this.onInputFieldFocus);
            clearTimeout(this._waitTimeoutID);
        }


    }
}//package com.clubpenguin.music.game.view.components.prompts
