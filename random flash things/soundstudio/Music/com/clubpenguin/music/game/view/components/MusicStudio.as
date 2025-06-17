//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.events.Event;
    import com.clubpenguin.lib.util.Log;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import com.clubpenguin.music.game.events.MusicStudioViewEvent;

    public class MusicStudio extends Sprite 
    {

        protected var skin:MovieClip;
        public var startScreen:MusicStudioStartScreen;
        public var board:MusicStudioGameBoard;
        public var prompts:MusicStudioPrompts;
        public var instructions:MusicStudioInstructions;
        private var _localizationManager:ILocalizationManager;

        public function MusicStudio(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            this.skin = skin;
            this._localizationManager = localizationManager;
            addChild(skin);
            this.createChildComponents();
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        protected function onRemovedFromStage(event:Event):void
        {
            Log.debug("");
            removeChild(this.board);
            removeChild(this.startScreen);
            removeChild(this.prompts);
            removeChild(this.instructions);
            this.board = null;
            this.startScreen = null;
            this.prompts = null;
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            (this.skin.close_button as SimpleButton).removeEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
        }

        protected function createChildComponents():void
        {
            this.prompts = new MusicStudioPrompts(this.skin.prompts, this._localizationManager);
            this.instructions = new MusicStudioInstructions(this.skin.instructions, this._localizationManager);
            this.startScreen = new MusicStudioStartScreen(this.skin.startScreen, this._localizationManager);
            this.board = new MusicStudioGameBoard(this.skin.board, this._localizationManager);
            addChild(this.startScreen);
            addChild(this.board);
            addChild(this.instructions);
            addChild(this.prompts);
            (this.skin.close_button as SimpleButton).addEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
        }

        protected function onCloseButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioViewEvent(MusicStudioViewEvent.CLOSE_GAME));
        }


    }
}//package com.clubpenguin.music.game.view.components
