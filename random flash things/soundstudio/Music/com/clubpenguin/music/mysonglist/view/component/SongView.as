//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.view.component
{
    import flash.display.MovieClip;
    import com.clubpenguin.music.mysonglist.model.SongDataVO;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.util.Log;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.clubpenguin.music.mysonglist.events.MySongListEvent;
    import flash.display.SimpleButton;
    import flash.events.Event;

    public class SongView extends MovieClip 
    {

        public static const STATE_EMPTY:String = "state_empty";
        public static const STATE_SONG:String = "state_song";
        public static const STATE_DELETE:String = "state_delete";

        private var _skin:MovieClip;
        private var _songData:SongDataVO;
        private var _localizationManager:ILocalizationManager;
        private var _state:String;

        public function SongView(skin:MovieClip)
        {
            this._skin = skin;
            Log.debug("");
        }

        public function localize(localizationManager:ILocalizationManager):void
        {
            Log.debug((localizationManager + ""));
            this._localizationManager = localizationManager;
        }

        public function showState(state:String, songData:SongDataVO=null):void
        {
            this.cleanListeners();
            switch (state)
            {
                case STATE_EMPTY:
                    this.showState_Empty();
                    break;
                case STATE_SONG:
                    this.showState_Song(songData);
                    break;
                case STATE_DELETE:
                    this.showState_Delete();
                    break;
            };
        }

        public function showPaused():void
        {
            MovieClip(this._skin["button_play"]).gotoAndStop(1);
        }

        public function showPlaying():void
        {
            MovieClip(this._skin["button_play"]).gotoAndStop(2);
        }

        private function showState_Empty():void
        {
            this._state = STATE_EMPTY;
            this._skin.gotoAndStop(STATE_EMPTY);
            this._skin.addEventListener(MouseEvent.CLICK, this.this_Click_Handler);
            Log.debug((this._skin + ""));
            Log.debug((this._skin["text_newtrack"] + ""));
            Log.debug((this._localizationManager + ""));
            TextField(this._skin["text_newtrack"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SONG_EMPTY);
            TextField(this._skin["text_newtrack"]).mouseEnabled = false;
        }

        private function this_Click_Handler(e:MouseEvent):void
        {
            dispatchEvent(new MySongListEvent(MySongListEvent.OPEN_STUDIO, null, false));
        }

        private function showState_Song(songData:SongDataVO):void
        {
            this._state = STATE_SONG;
            this._skin.gotoAndStop(STATE_SONG);
            this._songData = songData;
            TextField(this._skin["text_name"]).text = songData.name;
            TextField(this._skin["text_likes"]).text = (this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SONG_LIKES) + songData.likeCount.toString());
            if (songData.likeCount < 0)
            {
                TextField(this._skin["text_likes"]).visible = false;
            };
            if (songData.shared == 1)
            {
                MovieClip(this._skin["button_share"]).gotoAndStop("state_shared");
            }
            else
            {
                MovieClip(this._skin["button_share"]).gotoAndStop("state_notshared");
            };
            MovieClip(this._skin["button_play"]).addEventListener(MouseEvent.CLICK, this.playButton_Click_Handler);
            SimpleButton(this._skin["button_delete"]).addEventListener(MouseEvent.CLICK, this.deleteButton_Click_Handler);
            MovieClip(this._skin["button_share"]).addEventListener(MouseEvent.CLICK, this.shareButton_Click_Handler);
            TextField(this._skin["button_share"]["text_share_off"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARE_OFF);
            TextField(this._skin["button_share"]["text_share_on"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARE_ON);
            TextField(this._skin["button_share"]["shareTextMC"]["text_sharing"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SHARE_SHARING);
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

        private function deleteButton_Click_Handler(e:MouseEvent):void
        {
            Log.debug("");
            this.showState(STATE_DELETE);
        }

        private function shareButton_Click_Handler(e:MouseEvent):void
        {
            Log.debug(this._songData.shared.toString());
            if (this._songData.shared == 1)
            {
                dispatchEvent(new MySongListEvent(MySongListEvent.SONG_SHARE, (this._songData.id + "|0"), false));
            }
            else
            {
                if (this._songData.shared == 0)
                {
                    dispatchEvent(new MySongListEvent(MySongListEvent.SONG_SHARE, (this._songData.id + "|1"), false));
                };
            };
        }

        public function showShared():void
        {
            Log.debug("");
            this._songData.shared = 1;
            MovieClip(this._skin["button_share"]).gotoAndPlay("state_notshared");
        }

        public function showNotShared():void
        {
            Log.debug("");
            this._songData.shared = 0;
            MovieClip(this._skin["button_share"]).gotoAndPlay("state_shared");
        }

        public function showLikes(numLikes:Number):void
        {
            this._songData.likeCount = numLikes;
            var likesText:String = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_SONG_LIKES);
            if (numLikes > -1)
            {
                likesText = (likesText + numLikes.toString());
            }
            else
            {
                likesText = (likesText + " ###");
            };
            TextField(this._skin["text_likes"]).text = likesText;
            TextField(this._skin["text_likes"]).visible = true;
        }

        private function showState_Delete():void
        {
            var deleteState_EnterFrame_handler:Function;
            deleteState_EnterFrame_handler = function (e:Event):void
            {
                if (_skin.currentFrame >= _skin.totalFrames)
                {
                    _skin.removeEventListener(Event.FRAME_CONSTRUCTED, deleteState_EnterFrame_handler);
                    TextField(_skin["text_delete_warning"]).text = _localizationManager.getLocalizedString(MySongListModel.TOKEN_SONG_DELETE);
                    TextField(_skin["text_yes"]).text = _localizationManager.getLocalizedString(MySongListModel.TOKEN_YES);
                    TextField(_skin["text_no"]).text = _localizationManager.getLocalizedString(MySongListModel.TOKEN_NO);
                    TextField(_skin["text_yes"]).mouseEnabled = false;
                    TextField(_skin["text_no"]).mouseEnabled = false;
                };
            };
            this._state = STATE_DELETE;
            this._skin.gotoAndPlay(STATE_DELETE);
            SimpleButton(this._skin["button_yes"]).addEventListener(MouseEvent.CLICK, this.yesButton_Click_Handler);
            SimpleButton(this._skin["button_no"]).addEventListener(MouseEvent.CLICK, this.noButton_Click_Handler);
            this._skin.addEventListener(Event.FRAME_CONSTRUCTED, deleteState_EnterFrame_handler);
        }

        private function yesButton_Click_Handler(e:MouseEvent):void
        {
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_DELETE, this._songData.id, false));
        }

        private function noButton_Click_Handler(e:MouseEvent):void
        {
            this.showState(STATE_SONG, this._songData);
        }

        private function cleanListeners():void
        {
            if (this._skin)
            {
                this._skin.removeEventListener(MouseEvent.CLICK, this.this_Click_Handler);
                if (this._skin["button_play"])
                {
                    MovieClip(this._skin["button_play"]).removeEventListener(MouseEvent.CLICK, this.playButton_Click_Handler);
                };
                if (this._skin["button_delete"])
                {
                    SimpleButton(this._skin["button_delete"]).removeEventListener(MouseEvent.CLICK, this.deleteButton_Click_Handler);
                };
                if (this._skin["button_share"])
                {
                    MovieClip(this._skin["button_share"]).removeEventListener(MouseEvent.CLICK, this.shareButton_Click_Handler);
                };
                if (this._skin["button_yes"])
                {
                    SimpleButton(this._skin["button_yes"]).removeEventListener(MouseEvent.CLICK, this.yesButton_Click_Handler);
                };
                if (this._skin["button_no"])
                {
                    SimpleButton(this._skin["button_no"]).removeEventListener(MouseEvent.CLICK, this.noButton_Click_Handler);
                };
                if (((this._state == STATE_SONG) && (MovieClip(this._skin["button_play"]).currentFrame == 2)))
                {
                    dispatchEvent(new MySongListEvent(MySongListEvent.SONG_STOP, this._songData.id, false));
                    MovieClip(this._skin["button_play"]).gotoAndStop(1);
                };
            };
        }

        public function get songData():SongDataVO
        {
            return (this._songData);
        }

        public function get state():String
        {
            return (this._state);
        }


    }
}//package com.clubpenguin.music.mysonglist.view.component
