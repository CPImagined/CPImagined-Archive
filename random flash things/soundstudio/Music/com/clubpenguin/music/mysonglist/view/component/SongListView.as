//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.view.component
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.mysonglist.MySongList;
	import com.clubpenguin.music.game.view.components.MusicStudioStartScreen;
    import flash.text.TextField;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import com.clubpenguin.music.mysonglist.events.MySongListEvent;
    import com.clubpenguin.music.mysonglist.model.SongDataVO;
    import __AS3__.vec.*;

    public class SongListView extends Sprite 
    {

        private const MAX_SONGS:Number = 12;

        private var _skin:MovieClip;
        private var songViews:Vector.<SongView>;
        private var _sharedTrackView:SharedTrackView;
        private var _state:String;
        private var _localizationManager:ILocalizationManager;
        private var _language:String;

        public function SongListView(skin:MovieClip)
        {
            Log.debug("");
            this._skin = skin;
            this._skin.visible = false;
            addChild(this._skin);
        }

        public function displaySongs(mySongs:Vector.<SongDataVO>, initData:String, isMember:Boolean):void
        {
            var tempSongView:SongView;
            Log.debug("Entering");
            this.songViews = new Vector.<SongView>();
            this._skin.visible = true;
            switch (initData)
            {
                case MySongList.INIT_CLUB:
                    this._skin.gotoAndStop("init_club");
                    this.localizeLogo();
                    break;
                case MySongList.INIT_STUDIO_SAVE:
                    this._skin.gotoAndStop("init_studio");
                    this.localizeLogo();
                    break;
                case MySongList.INIT_STUDIO_DELETE:
                    this._skin.gotoAndStop("init_studio");
                    MovieClip(this._skin["songList"]).gotoAndStop("delete a track");
                    TextField(this._skin["songList"]["text_header1"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_DELETE_HEADER1);
                    TextField(this._skin["songList"]["text_header2"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_DELETE_HEADER2);
                    break;
                default:
                    this._skin.gotoAndStop("init_studio");
                    this.localizeLogo();
            };
            if (!isMember)
            {
                MovieClip(this._skin["songList"]).gotoAndStop("not a member");
                TextField(this._skin["songList"]["text_notmember"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_NOTMEMBER);
                this.localizeLogo();
            }
            else
            {
                if (mySongs.length == 0)
                {
                    MovieClip(this._skin["songList"]).gotoAndStop("never saved music");
                    SimpleButton(this._skin["songList"]["button_startstudio"]).addEventListener(MouseEvent.CLICK, this.startStudio_Click_Handler);
                    TextField(this._skin["songList"]["text_notrack1"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_NOTRACK1);
                    TextField(this._skin["songList"]["text_startstudio"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_STARTSTUDIO);
                    TextField(this._skin["songList"]["text_startstudio"]).mouseEnabled = false;
                    this.localizeLogo();
                };
            };
            (this._skin["close_button"] as SimpleButton).addEventListener(MouseEvent.CLICK, this.closeButton_Click_Handler);
            var songIndex:Number = 0;
            var j:Number = 0;
            while (j < this.MAX_SONGS)
            {
                tempSongView = (new SongView(this._skin["songList"]["scrollControl"]["scrollArea"]["scrollarea_content"][("song_" + j.toString())]) as SongView);
                tempSongView.localize(this._localizationManager);
                tempSongView.addEventListener(MySongListEvent.SONG_DELETE, this.songView_Delete_Handler);
                tempSongView.addEventListener(MySongListEvent.SONG_SHARE, this.songView_Share_Handler);
                tempSongView.addEventListener(MySongListEvent.SONG_PLAY, this.songView_Play_Handler);
                tempSongView.addEventListener(MySongListEvent.SONG_LIKES, this.songView_GetLikes_Handler);
                tempSongView.addEventListener(MySongListEvent.SONG_STOP, this.songView_Stop_Handler);
                tempSongView.addEventListener(MySongListEvent.OPEN_STUDIO, this.songView_OpenStudio_Handler);
                if (songIndex < mySongs.length)
                {
                    tempSongView.showState(SongView.STATE_SONG, mySongs[songIndex]);
                    songIndex++;
                }
                else
                {
                    tempSongView.showState(SongView.STATE_EMPTY);
                };
                this.songViews.push(tempSongView);
                j++;
            };
            if (((initData == MySongList.INIT_STUDIO_DELETE) || (initData == MySongList.INIT_STUDIO_SAVE)))
            {
                this._sharedTrackView = new SharedTrackView(this._skin["sharedtrackview"]);
                this._sharedTrackView.localize(this._localizationManager);
                this._sharedTrackView.addEventListener(MySongListEvent.SONG_SHARE, this.songView_Share_Handler);
                this._sharedTrackView.addEventListener(MySongListEvent.SONG_PLAY, this.songView_Play_Handler);
                this._sharedTrackView.addEventListener(MySongListEvent.SONG_STOP, this.songView_Stop_Handler);
                this.updateSharedTrack();
                Log.debug(MovieClip(this._skin["songList"]).currentFrameLabel);
                if (((MovieClip(this._skin["songList"]).currentFrameLabel == "not a member") || (MovieClip(this._skin["songList"]).currentFrameLabel == "never saved music")))
                {
                    Log.debug("Showing overlay");
                    this._sharedTrackView.showOverlay();
                };
            };
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_LIKES, null, false));
        }

        public function songComplete():void
        {
            var songView:SongView;
            for each (songView in this.songViews)
            {
                if (songView.state == SongView.STATE_SONG)
                {
                    songView.showPaused();
                };
            };
            Log.debug((this._sharedTrackView + ""));
            if (this._sharedTrackView != null)
            {
                this._sharedTrackView.showPaused();
            };
        }

        private function updateSharedTrack():void
        {
            var sharedTrack:SongDataVO;
            var songView:SongView;
            for each (songView in this.songViews)
            {
                if (((songView.state == SongView.STATE_SONG) && (songView.songData.shared == 1)))
                {
                    sharedTrack = songView.songData;
                };
            };
            if (this._sharedTrackView != null)
            {
                if (sharedTrack != null)
                {
                    Log.debug((sharedTrack.likeCount + ""));
                    this._sharedTrackView.showSharedSong(sharedTrack);
                }
                else
                {
                    this._sharedTrackView.removeSharedSong();
                };
            };
        }

        private function songView_Delete_Handler(e:MySongListEvent):void
        {
            Log.debug("");
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_DELETE, e.payload, false));
        }

        private function songView_Share_Handler(e:MySongListEvent):void
        {
            Log.debug("");
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_SHARE, e.payload, false));
        }

        private function songView_Play_Handler(e:MySongListEvent):void
        {
            var songView:SongView;
            Log.debug("");
            for each (songView in this.songViews)
            {
                if (songView.state == SongView.STATE_SONG)
                {
                    if (songView.songData.id != String(e.payload))
                    {
                        Log.debug("songView.showPaused();");
                        songView.showPaused();
                        if (songView.songData.shared == true)
                        {
                            Log.debug("_sharedTrackView.showPaused();");
                            if (this._sharedTrackView != null)
                            {
                                this._sharedTrackView.showPaused();
                            };
                        };
                    }
                    else
                    {
                        Log.debug("songView.showPlaying();");
                        songView.showPlaying();
                        if (songView.songData.shared == true)
                        {
                            Log.debug("_sharedTrackView.showPlaying();");
                            if (this._sharedTrackView != null)
                            {
                                this._sharedTrackView.showPlaying();
                            };
                        };
                    };
                };
            };
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_PLAY, e.payload, false));
        }

        private function songView_GetLikes_Handler(e:MySongListEvent):void
        {
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_LIKES, e.payload, false));
        }

        private function songView_OpenStudio_Handler(e:MySongListEvent):void
        {
            dispatchEvent(new MySongListEvent(MySongListEvent.OPEN_STUDIO, e.payload, false));
        }

        private function closeButton_Click_Handler(e:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MySongListEvent(MySongListEvent.MODULE_CLOSE, null, false));
			MusicStudioStartScreen.show();
        }

        private function songView_Stop_Handler(e:MySongListEvent):void
        {
            var songView:SongView;
            for each (songView in this.songViews)
            {
                if (songView.state == SongView.STATE_SONG)
                {
                    if (songView.songData.id == String(e.payload))
                    {
                        Log.debug("songView.showPaused();");
                        songView.showPaused();
                        if (songView.songData.shared == true)
                        {
                            Log.debug("_sharedTrackView.showPaused();");
                            this._sharedTrackView.showPaused();
                        };
                    };
                };
            };
            dispatchEvent(new MySongListEvent(MySongListEvent.SONG_STOP, e.payload, false));
        }

        public function deleteSong(songID:String):void
        {
            var i:Number = 0;
            while (i < this.songViews.length)
            {
                if (((this.songViews[i].state == SongView.STATE_DELETE) && (this.songViews[i].songData.id == songID)))
                {
                    if (((!(this._sharedTrackView == null)) && (this.songViews[i].songData.shared == 1)))
                    {
                        this._sharedTrackView.removeSharedSong();
                    };
                    this.songViews[i].showState(SongView.STATE_EMPTY);
                    this.songViews.splice(i, 1);
                    i--;
                    break;
                };
                i++;
            };
        }

        public function shareSong(songID:String, shareFlag:String):void
        {
            var songView:SongView;
            var songView2:SongView;
            Log.debug(((songID + " ") + shareFlag));
            if (shareFlag == "1")
            {
                for each (songView in this.songViews)
                {
                    if (songView.state == SongView.STATE_SONG)
                    {
                        Log.debug(((("shareSong Loop " + songView.state) + " ") + songView.songData.shared));
                    };
                    if (((songView.state == SongView.STATE_SONG) && (songView.songData.id == songID)))
                    {
                        songView.showShared();
                    }
                    else
                    {
                        if (((songView.state == SongView.STATE_SONG) && (songView.songData.shared == 1)))
                        {
                            songView.showNotShared();
                        };
                    };
                };
            }
            else
            {
                if (shareFlag == "0")
                {
                    for each (songView2 in this.songViews)
                    {
                        if (((songView2.state == SongView.STATE_SONG) && (songView2.songData.id == songID)))
                        {
                            songView2.showNotShared();
                        };
                    };
                };
            };
            this.updateSharedTrack();
        }

        public function updateLikeCount(songID:String, likeCount:String):void
        {
            var songView:SongView;
            for each (songView in this.songViews)
            {
                if (((songView.state == SongView.STATE_SONG) && (songView.songData.id == songID)))
                {
                    songView.showLikes(Number(likeCount));
                    if (((songView.songData.shared == true) && (!(this._sharedTrackView == null))))
                    {
                        this._sharedTrackView.showLikes(Number(likeCount));
                    };
                };
            };
        }

        public function localize(localizationManager:ILocalizationManager, language:String):void
        {
            Log.debug(((localizationManager + " ") + language));
            this._localizationManager = localizationManager;
            this._language = language;
        }

        private function localizeLogo():void
        {
            TextField(this._skin["songList"]["header"]["savedtrackstext"]).text = this._localizationManager.getLocalizedString(MySongListModel.TOKEN_LOGO);
            MovieClip(this._skin["songList"]["header"]["logo"]).gotoAndStop(this._language);
        }

        private function startStudio_Click_Handler(e:MouseEvent):void
        {
            dispatchEvent(new MySongListEvent(MySongListEvent.OPEN_STUDIO, null, false));
        }

        public function get skin():MovieClip
        {
            return (this._skin);
        }

        public function clean():void
        {
            var songView:SongView;
            Log.debug("");
            if (this._sharedTrackView != null)
            {
                this._sharedTrackView.removeEventListener(MySongListEvent.SONG_SHARE, this.songView_Share_Handler);
                this._sharedTrackView.removeEventListener(MySongListEvent.SONG_PLAY, this.songView_Play_Handler);
                this._sharedTrackView.removeEventListener(MySongListEvent.SONG_STOP, this.songView_Stop_Handler);
            };
            for each (songView in this.songViews)
            {
                songView.removeEventListener(MySongListEvent.SONG_DELETE, this.songView_Delete_Handler);
                songView.removeEventListener(MySongListEvent.SONG_SHARE, this.songView_Share_Handler);
                songView.removeEventListener(MySongListEvent.SONG_PLAY, this.songView_Play_Handler);
                songView.removeEventListener(MySongListEvent.SONG_LIKES, this.songView_GetLikes_Handler);
                songView.removeEventListener(MySongListEvent.SONG_STOP, this.songView_Stop_Handler);
                songView.removeEventListener(MySongListEvent.OPEN_STUDIO, this.songView_OpenStudio_Handler);
            };
            (this._skin["close_button"] as SimpleButton).removeEventListener(MouseEvent.CLICK, this.closeButton_Click_Handler);
            if (this._skin["songList"]["button_startstudio"])
            {
                SimpleButton(this._skin["songList"]["button_startstudio"]).removeEventListener(MouseEvent.CLICK, this.startStudio_Click_Handler);
            };
        }


    }
}//package com.clubpenguin.music.mysonglist.view.component
