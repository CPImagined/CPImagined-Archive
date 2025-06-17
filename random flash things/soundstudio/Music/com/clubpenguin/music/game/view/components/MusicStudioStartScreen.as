//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components
{
    import flash.display.Sprite;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioStartSreen;
    import com.clubpenguin.music.game.view.components.songList.MusicStudioSongList;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.display.MovieClip;
    import com.clubpenguin.lib.util.Log;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.SimpleButton;
    import flash.text.TextField;
	import flash.media.Sound;
    import flash.media.SoundChannel;
    import com.clubpenguin.music.game.view.events.MusicStudioStartScreenEvent;

    public class MusicStudioStartScreen extends Sprite implements IMusicStudioStartSreen 
    {

        public var songList:MusicStudioSongList;
        private var _localizationManager:ILocalizationManager;
        private var fieldsStartPos:Array;
        protected var skin:MovieClip;
		private var menuSnd:menuAmb = new menuAmb();
		private var menuChannel:SoundChannel = new SoundChannel(); 

        public function MusicStudioStartScreen(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            Log.debug("");
            this.skin = skin;
            this._localizationManager = localizationManager;
            this.init();
            this.createChildren();
            this.addListeners();
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        public function get isVisible():Boolean
        {
            return (this.skin.visible);
        }

        public function show():void
        {
            this.skin.visible = true;
			this.playSound();
        }
		
        public function hide():void
        {
            this.skin.visible = false;
			this.stopSound();
        }

        public function get mediatedChildren():Array
        {
            return ([this.songList]);
			this.playSound();
        }

        private function createChildren():void
        {
            this.songList = new MusicStudioSongList((this.skin.removeChild(this.skin.songList) as MovieClip), this._localizationManager);
            this.skin.addChild(this.songList);
        }

        protected function onLikesClicked(event:MouseEvent):void
        {
            dispatchEvent(new Event("likesClicked"));
        }

        protected function onRemovedFromStage(event:Event):void
        {
            Log.debug("");
            this.removeListeners();
        }

        private function removeListeners():void
        {
            (this.skin.playButton as SimpleButton).addEventListener(MouseEvent.CLICK, this.onPlayGameButtonClicked);
            (this.skin.instructionsButton as SimpleButton).removeEventListener(MouseEvent.CLICK, this.onInstructionsButtonClicked);
            (this.skin.savedTracksButton as SimpleButton).removeEventListener(MouseEvent.CLICK, this.onSavedTracksButtonClicked);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function init():void
        {
            this.localizeText();
            this.updateButtonLabels();
            this.repositionLabelsYpositionBasedOnTextHeight();
        }

        public function localize(language:String="en"):void
        {
            (this.skin.logo as MovieClip).gotoAndStop(language);
        }

        private function localizeText():void
        {
            this.trackTextFieldsStartPositionForLocalization();
            TextField(this.skin.playButtonLabel).text = this._localizationManager.getLocalizedString("m.game.soundstudio.makeMusic");
            TextField(this.skin.instructionsButtonLabel).text = this._localizationManager.getLocalizedString("m.game.soundstudio.instructions");
            TextField(this.skin.savedTracksButtonLabel).text = this._localizationManager.getLocalizedString("m.game.soundstudio.savedTracks");
            TextField(this.skin.songList.sharedTracksText).text = this._localizationManager.getLocalizedString("m.game.soundstudio.sharedTracks");
            TextField(this.skin.songList.text_notracks).text = this._localizationManager.getLocalizedString("m.game.soundstudio.noSavedTracks");
            if (((!(this.skin.bg == null)) && (!(this.skin.bg.promoText == null))))
            {
                this.skin.bg.gotoAndStop(3);
                TextField(this.skin.bg.promoText).text = this._localizationManager.getLocalizedString("m.game.soundstudio.spookyPromo");
            };
        }

        private function trackTextFieldsStartPositionForLocalization():void
        {
            var fields:Array;
            var i:int;
            var tf:TextField;
            if (!this.fieldsStartPos)
            {
                this.fieldsStartPos = [];
                fields = [this.skin.playButtonLabel, this.skin.instructionsButtonLabel, this.skin.savedTracksButtonLabel, this.skin.songList.sharedTracksText, this.skin.songList.text_notracks];
                i = 0;
                while (i < fields.length)
                {
                    tf = (fields[i] as TextField);
                    this.fieldsStartPos.push(tf.y);
                    i++;
                };
            };
        }

        private function updateButtonLabels():void
        {
            (this.skin.playButtonLabel as TextField).mouseEnabled = false;
            (this.skin.instructionsButtonLabel as TextField).mouseEnabled = false;
            (this.skin.savedTracksButtonLabel as TextField).mouseEnabled = false;
        }

        private function repositionLabelsYpositionBasedOnTextHeight():void
        {
            var tf:TextField;
            var startY:Number;
            var fields:Array = [this.skin.playButtonLabel, this.skin.instructionsButtonLabel, this.skin.savedTracksButtonLabel, this.skin.songList.sharedTracksText, this.skin.songList.text_notracks];
            var i:int;
            while (i < fields.length)
            {
                tf = (fields[i] as TextField);
                startY = (this.fieldsStartPos[i] as Number);
                tf.y = ((startY + (tf.height / 2)) - (tf.textHeight / 2));
                i++;
            };
			this.playSound();
        }

        private function addListeners():void
        {
            (this.skin.playButton as SimpleButton).addEventListener(MouseEvent.CLICK, this.onPlayGameButtonClicked);
            (this.skin.instructionsButton as SimpleButton).addEventListener(MouseEvent.CLICK, this.onInstructionsButtonClicked);
            (this.skin.savedTracksButton as SimpleButton).addEventListener(MouseEvent.CLICK, this.onSavedTracksButtonClicked);
        }

        protected function onPlayGameButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioStartScreenEvent(MusicStudioStartScreenEvent.PLAY_GAME_REQUEST));
			this.stopSound();
        }

        protected function onInstructionsButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioStartScreenEvent(MusicStudioStartScreenEvent.SHOW_INSTRUCTIONS_REQUEST));
			this.stopSound();
        }

        protected function onSavedTracksButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioStartScreenEvent(MusicStudioStartScreenEvent.SHOW_SONGLIST_REQUEST));
        }
		
		private function playSound():void
		{
			this.menuChannel = this.menuSnd.play();
			this.menuChannel.addEventListener(Event.SOUND_COMPLETE, this.loopSound);
		}
		
		private function stopSound():void
		{
			this.menuChannel.stop();
		}
		
		private function loopSound(event:Event):void
		{
			this.menuChannel = this.menuSnd.play();
			this.menuChannel.addEventListener(Event.SOUND_COMPLETE, this.loopSound);
		}

    }
}//package com.clubpenguin.music.game.view.components
