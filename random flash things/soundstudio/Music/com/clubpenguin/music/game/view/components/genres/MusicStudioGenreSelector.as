//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.genres
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.view.events.MusicStudioGameBoardEvent;
    import flash.text.TextField;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;

    public class MusicStudioGenreSelector extends EventDispatcher 
    {

        public var skin:MovieClip;
        private var _genreId:int;

        public function MusicStudioGenreSelector(skin:MovieClip)
        {
            this.skin = skin;
            this.addListeners();
        }

        public function get genre():int
        {
            return (this._genreId);
        }

        public function set genre(index:int):void
        {
            var button:MovieClip;
            this._genreId = index;
            var i:uint;
            while (i < this.skin.numChildren)
            {
                button = (this.skin.getChildAt(i) as MovieClip);
                if (button)
                {
                    button.gotoAndStop(((index == i) ? 2 : 1));
                };
                i++;
            };
        }

        protected function addListeners():void
        {
            var button:MovieClip;
            var i:uint;
            while (i < this.skin.numChildren)
            {
                button = (this.skin.getChildAt(i) as MovieClip);
                if (button)
                {
                    button.gotoAndStop(1);
                    button.mouseChildren = false;
                    button.buttonMode = true;
                    button.addEventListener(MouseEvent.CLICK, this.onButtonClicked);
                };
                i++;
            };
        }

        protected function onButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            var button:MovieClip = (event.currentTarget as MovieClip);
            dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.GENRE_BUTTON_CLICKED, this.skin.getChildIndex(button)));
        }

        public function localize(_localizationManager:ILocalizationManager):void
        {
            var button:MovieClip;
            var j:uint;
            var label:TextField;
            var i:uint;
            while (i < this.skin.numChildren)
            {
                button = (this.skin.getChildAt(i) as MovieClip);
                if (button)
                {
                    j = 0;
                    while (j < button.numChildren)
                    {
                        label = (button.getChildAt(j) as TextField);
                        if (label)
                        {
                            label.text = _localizationManager.getLocalizedString(("w.app.music.game.board.genre." + i));
                        };
                        j++;
                    };
                };
                i++;
            };
        }


    }
}//package com.clubpenguin.music.game.view.components.genres
