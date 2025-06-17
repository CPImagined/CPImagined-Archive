//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.view.component
{
    import flash.display.MovieClip;
    import com.clubpenguin.music.mysonglist.model.SongDataVO;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.mysonglist.events.MySongListEvent;

    public class SharedTrackView extends MovieClip 
    {

        private const STATE_NOTSHARED:String = "state_notshared";
        private const STATE_SHARED:String = "state_shared";

        private var _skin:MovieClip;
        private var _songData:SongDataVO;
        private var _localizationManager:ILocalizationManager;

        public function SharedTrackView(skin:MovieClip)
        {
            this._skin = skin;
            MovieClip(this._skin["overlay"]).visible = false;
        }

        public function localize(localizationManager:ILocalizationManager):void
        {
            this._localizationManager = localizationManager;
        }

        public function showSharedSong(songData:SongDataVO):void
        {
            this.cleanListeners();
            this._songData = songData;
            this._skin.gotoAndStop(this.STATE_SHARED);
            TextField(this._skin["text_songname"]).text = songData.name;
            MovieClip(this._skin["button_share"]).gotoAndStop("state_shared");
            MovieClip(this._skin["button_share"]).addEventListener(MouseEvent.CLICK, this.shareToggle_Click_handler);
            MovieClip(this._skin["button_play"]).addEventListener(MouseEvent.CLICK, this.playButton_Click_Handler);
            TextField(this._skin["text_danceclub"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARED_CLUB);
            TextField(this._skin["text_currentlyshared"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARED_HEADER);
            var likesText:String = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SONG_LIKES);
            if (this._songData.likeCount > -1)
            {
                likesText = (likesText + ("\n" + this._songData.likeCount));
            }
            else
            {
                likesText = (likesText + "\n###");
            };
            TextField(this._skin["text_likes"]).text = likesText;
            TextField(this._skin["button_share"]["text_share_off"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARE_OFF);
            TextField(this._skin["button_share"]["text_share_on"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARE_ON);
            TextField(this._skin["button_share"]["shareTextMC"]["text_sharing"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARE_SHARING);
        }

        public function showLikes(likeCount:Number):void
        {
            var likesText:String = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SONG_LIKES);
            if (this._songData.likeCount > -1)
            {
                likesText = (likesText + ("\n" + this._songData.likeCount));
            }
            else
            {
                likesText = (likesText + "\n###");
            };
            TextField(this._skin["text_likes"]).text = likesText;
        }

        public function removeSharedSong():void
        {
            Log.debug("");
            this.cleanListeners();
            this._songData = null;
            this._skin.gotoAndStop(this.STATE_NOTSHARED);
            TextField(this._skin["text_noshared1"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARED_NONE1);
            TextField(this._skin["text_noshared2"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARED_NONE2);
        }

        public function showPaused():void
        {
            MovieClip(this._skin["button_play"]).gotoAndStop(1);
        }

        public function showPlaying():void
        {
            MovieClip(this._skin["button_play"]).gotoAndStop(2);
        }

        public function showOverlay():void
        {
            MovieClip(this._skin["overlay"]).visible = true;
        }

        private function playButton_Click_Handler(e:MouseEvent):void
        {
            if (MovieClip(this._skin["button_play"]).currentFrame == 1)
            {
                dispatchEvent(new MySongListEvent(MySongListEvent.SONG_PLAY, this._songData.id, false));
                MovieClip(this._skin["button_play"]).gotoAndStop(2);
            }
            else
            {
                if (MovieClip(this._skin["button_play"]).currentFrame == 2)
                {
                    dispatchEvent(new MySongListEvent(MySongListEvent.SONG_STOP, this._songData.id, false));
                    MovieClip(this._skin["button_play"]).gotoAndStop(1);
                };
            };
        }

        private function shareToggle_Click_handler(e:MouseEvent):void
        {
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_SHARE, (this._songData.id + "|0"), false));
        }

        private function cleanListeners():void
        {
            if (this._skin)
            {
                if (this._skin["button_share"] != null)
                {
                    MovieClip(this._skin["button_share"]).removeEventListener(MouseEvent.CLICK, this.shareToggle_Click_handler);
                };
                if (this._skin["button_play"] != null)
                {
                    MovieClip(this._skin["button_play"]).removeEventListener(MouseEvent.CLICK, this.playButton_Click_Handler);
                };
            };
        }


    }
}//package com.clubpenguin.music.mysonglist.view.component
