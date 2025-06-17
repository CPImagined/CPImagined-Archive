//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components
{
    import flash.display.MovieClip;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioInstructions;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.util.Log;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import com.clubpenguin.music.game.view.events.MusicStudioInstructionsEvent;

    public class MusicStudioInstructions extends MovieClip implements IMusicStudioInstructions 
    {

        private static const PAGE_ONE:int = 2;

        protected var skin:MovieClip;
        private var _localizationManager:ILocalizationManager;

        public function MusicStudioInstructions(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            Log.debug(("CONSTRUCTOR " + skin));
            this.skin = skin;
            this._localizationManager = localizationManager;
            if (skin)
            {
                skin.stop();
            };
            this.addListeners();
        }

        public function get backButton():SimpleButton
        {
            return ((this.skin) ? this.skin.backbtn : null);
        }

        public function get nextButton():SimpleButton
        {
            return ((this.skin) ? this.skin.nextbtn : null);
        }

        public function get closeButton():SimpleButton
        {
            return ((this.skin) ? this.skin.close_button : null);
        }

        public function get playButton():SimpleButton
        {
            return ((this.skin) ? this.skin.playButton : null);
        }

        private function localizeText():void
        {
            var descriptionText:String = ("w.app.music.instructions." + (this.skin.currentFrame - 1));
            TextField(this.skin.description).text = this._localizationManager.getLocalizedString(descriptionText);
        }

        private function addListeners():void
        {
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function addButtonListeners():void
        {
            Log.debug("");
            this.backButton.addEventListener(MouseEvent.CLICK, this.onBackButtonClicked);
            this.backButton.addEventListener(Event.REMOVED_FROM_STAGE, this.onBackButtonRemoved);
            this.nextButton.addEventListener(MouseEvent.CLICK, this.onNextButtonClicked);
            this.nextButton.addEventListener(Event.REMOVED_FROM_STAGE, this.onNextButtonRemoved);
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
            this.closeButton.addEventListener(Event.REMOVED_FROM_STAGE, this.onCloseButtonRemoved);
        }

        protected function onBackButtonRemoved(event:Event):void
        {
            Log.debug("");
            this.backButton.removeEventListener(MouseEvent.CLICK, this.onBackButtonClicked);
            this.backButton.removeEventListener(Event.REMOVED_FROM_STAGE, this.onBackButtonRemoved);
        }

        protected function onNextButtonRemoved(event:Event):void
        {
            Log.debug("");
            this.nextButton.removeEventListener(MouseEvent.CLICK, this.onNextButtonClicked);
            this.nextButton.removeEventListener(Event.REMOVED_FROM_STAGE, this.onNextButtonRemoved);
        }

        protected function onCloseButtonRemoved(event:Event):void
        {
            Log.debug("");
            this.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
            this.closeButton.removeEventListener(Event.REMOVED_FROM_STAGE, this.onCloseButtonRemoved);
        }

        private function gotoFrame(frameNumber:uint):void
        {
            Log.debug(("frameNumber " + frameNumber));
            var frameToReach:uint = frameNumber;
            this.skin.gotoAndStop(frameToReach);
        }

        protected function onBackButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioInstructionsEvent(MusicStudioInstructionsEvent.BACK));
        }

        protected function onNextButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioInstructionsEvent(MusicStudioInstructionsEvent.NEXT));
        }

        protected function onCloseButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioInstructionsEvent(MusicStudioInstructionsEvent.CLOSE));
        }

        protected function onPlayButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioInstructionsEvent(MusicStudioInstructionsEvent.PLAY));
        }

        public function showInstructions():void
        {
            Log.info("");
            this.skin.visible = true;
            this.gotoFrame(PAGE_ONE);
            this.addButtonListeners();
            this.localizeText();
            this.skin.blockLayer.useHandCursor = false;
        }

        public function goToPreviousPage():void
        {
            if (this.skin.currentFrame > PAGE_ONE)
            {
                this.gotoFrame(int((this.skin.currentFrame - 1)));
            };
            if (this.skin.currentFrame == int((this.skin.totalFrames - 1)))
            {
                this.addButtonListeners();
            };
            this.localizeText();
        }

        public function goToNextPage():void
        {
            if (this.skin.currentFrame < this.skin.totalFrames)
            {
                this.gotoFrame(int((this.skin.currentFrame + 1)));
            };
            this.localizeText();
            if (this.skin.currentFrame == this.skin.totalFrames)
            {
                this.playButton.addEventListener(MouseEvent.CLICK, this.onPlayButtonClicked);
                this.skin.playButtonLabel.mouseEnabled = false;
                TextField(this.skin.playButtonLabel).text = this._localizationManager.getLocalizedString("m.game.soundstudio.makeMusic");
            };
        }

        public function hideInstructions():void
        {
            Log.info("");
            this.skin.visible = false;
            this.removeListeners();
            this.gotoFrame(1);
        }

        protected function onRemovedFromStage(event:Event):void
        {
            this.removeListeners();
        }

        private function removeListeners():void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        public function clean():void
        {
            this.removeListeners();
        }


    }
}//package com.clubpenguin.music.game.view.components
