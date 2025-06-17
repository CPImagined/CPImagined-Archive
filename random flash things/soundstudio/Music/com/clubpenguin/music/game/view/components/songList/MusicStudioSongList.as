//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.songList
{
    import com.clubpenguin.music.game.view.components.base.UIView;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioSongList;
    import com.clubpenguin.music.resources.scrollbar.ScrollControl_Studio;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import __AS3__.vec.Vector;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import flash.display.MovieClip;
    import flash.system.ApplicationDomain;
    import com.clubpenguin.music.game.view.components.songList.itemRenderer.SongListItem;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.view.events.MusicStudioSongListItemEvent;
    import flash.text.TextField;
    import com.clubpenguin.music.game.view.events.MusicStudioSongListEvent;

    public class MusicStudioSongList extends UIView implements IMusicStudioSongList 
    {

        private static const SKIN_CLASS:String = "SongListItemSkin";

        private var _scrollControl:ScrollControl_Studio;
        private var _localizationManager:ILocalizationManager;
        private var _dataProvider:Vector.<SongDetailsVO>;

        public function MusicStudioSongList(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            super(skin);
            this._localizationManager = localizationManager;
            this._scrollControl = new ScrollControl_Studio(skin["scrollControl"]);
        }

        private function get SongListSkin():Class
        {
            return (ApplicationDomain.currentDomain.getDefinition(SKIN_CLASS) as Class);
        }

        public function get dataProvider():Vector.<SongDetailsVO>
        {
            return (this._dataProvider);
        }

        public function set dataProvider(songs:Vector.<SongDetailsVO>):void
        {
            this._dataProvider = songs;
            this.updateList();
        }

        protected function get container():MovieClip
        {
            return (skin["scrollControl"]["scrollArea"]["scrollArea_content"] as MovieClip);
        }

        protected function updateList():void
        {
            var item:SongListItem;
            Log.debug((this._dataProvider.length + ""));
            var ITEM_HEIGHT:int = 117;
            var VERTICAL_PADDING:int = 10;
            var yPos:Number = 0;
            var index:int;
            while (index < this.dataProvider.length)
            {
                if (this.container.numChildren > index)
                {
                    item = (this.container.getChildAt(index) as SongListItem);
                }
                else
                {
                    item = new SongListItem((new this.SongListSkin() as MovieClip), index);
                    item.addEventListener(MusicStudioSongListItemEvent.PLAY_BUTTON_CLICKED, this.onSongItemPlayClicked);
                    item.addEventListener(MusicStudioSongListItemEvent.STOP_BUTTON_CLICKED, this.onSongItemStopClicked);
                    item.addEventListener(MusicStudioSongListItemEvent.LIKE_BUTTON_CLICKED, this.onSongItemLikeClicked);
                    item.localize(this._localizationManager);
                    this.container.addChildAt(item, index);
                };
                item.songDetails = this.dataProvider[index];
                item.y = yPos;
                yPos = (yPos + (ITEM_HEIGHT + VERTICAL_PADDING));
                index++;
            };
            var extra:int = (this.container.numChildren - 1);
            while (extra > index)
            {
                item = (this.container.removeChildAt(extra) as SongListItem);
                if (((item) && (item.hasEventListener(MusicStudioSongListItemEvent.PLAY_BUTTON_CLICKED))))
                {
                    item.removeEventListener(MusicStudioSongListItemEvent.PLAY_BUTTON_CLICKED, this.onSongItemPlayClicked);
                    item.removeEventListener(MusicStudioSongListItemEvent.STOP_BUTTON_CLICKED, this.onSongItemStopClicked);
                    item.removeEventListener(MusicStudioSongListItemEvent.LIKE_BUTTON_CLICKED, this.onSongItemLikeClicked);
                };
                extra--;
            };
            if (this.dataProvider.length > 0)
            {
                TextField(skin["text_notracks"]).visible = false;
            }
            else
            {
                TextField(skin["text_notracks"]).visible = true;
            };
            this._scrollControl.init();
        }

        override protected function removeListeners():void
        {
            var item:SongListItem;
            super.removeListeners();
            var i:uint;
            while (i < this.container.numChildren)
            {
                item = (this.container.getChildAt(i) as SongListItem);
                if (((item) && (item.hasEventListener(MusicStudioSongListItemEvent.PLAY_BUTTON_CLICKED))))
                {
                    item.removeEventListener(MusicStudioSongListItemEvent.PLAY_BUTTON_CLICKED, this.onSongItemPlayClicked);
                    item.removeEventListener(MusicStudioSongListItemEvent.STOP_BUTTON_CLICKED, this.onSongItemStopClicked);
                    item.removeEventListener(MusicStudioSongListItemEvent.LIKE_BUTTON_CLICKED, this.onSongItemLikeClicked);
                };
                i++;
            };
        }

        protected function onSongItemStopClicked(event:MusicStudioSongListItemEvent):void
        {
            dispatchEvent(new MusicStudioSongListEvent(MusicStudioSongListEvent.STOP_SONG, event.payload));
        }

        protected function onSongItemPlayClicked(event:MusicStudioSongListItemEvent):void
        {
            dispatchEvent(new MusicStudioSongListEvent(MusicStudioSongListEvent.PLAY_SONG, event.payload));
        }

        protected function onSongItemLikeClicked(event:MusicStudioSongListItemEvent):void
        {
            dispatchEvent(new MusicStudioSongListEvent(MusicStudioSongListEvent.LIKE_SONG, event.payload));
        }

        public function songPlayBackUpdate(songs:Vector.<SongDetailsVO>):void
        {
            this.updateItems(songs);
        }

        public function updateSongLikes(songs:Vector.<SongDetailsVO>):void
        {
            this.updateItems(songs);
        }

        private function updateItems(songs:Vector.<SongDetailsVO>):void
        {
            var item:SongListItem;
            this.stopAllSongItems(songs[0]);
            Log.debug((songs.length + ""));
            Log.debug((songs[0].playing + ""));
            var i:uint;
            while (i < songs.length)
            {
                item = this.findSongItemBySongID(songs[i].songId);
                if (item == null)
                {
                    Log.debug("Cant find item of song ID, shouldnt happen!");
                };
                item.songDetails = songs[i];
                i++;
            };
        }

        private function stopAllSongItems(exception:SongDetailsVO):void
        {
            var itemAtIndex:SongListItem;
            var updatedSongDetails:SongDetailsVO;
            var i:Number = 0;
            while (i < this.container.numChildren)
            {
                itemAtIndex = (this.container.getChildAt(i) as SongListItem);
                updatedSongDetails = itemAtIndex.songDetails;
                if (updatedSongDetails == exception)
                {
                }
                else
                {
                    updatedSongDetails.playing = false;
                    itemAtIndex.songDetails = updatedSongDetails;
                };
                i++;
            };
        }

        private function findSongItemBySongID(songID:int):SongListItem
        {
            var itemAtIndex:SongListItem;
            var i:Number = 0;
            while (i < this.container.numChildren)
            {
                itemAtIndex = (this.container.getChildAt(i) as SongListItem);
                if (itemAtIndex.songDetails.songId == songID)
                {
                    return (itemAtIndex);
                };
                i++;
            };
            return (null);
        }

        public function updateSharedSongs(songs:Vector.<SongDetailsVO>):void
        {
            this.dataProvider = songs;
        }


    }
}//package com.clubpenguin.music.game.view.components.songList
