//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.songList.itemRenderer
{
    import com.clubpenguin.music.game.view.components.base.UIView;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.music.view.components.likes.LikesButton;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.view.events.MusicStudioSongListItemEvent;

    public class SongListItem extends UIView 
    {

        public var playButton:MovieClip;
        public var label:TextField;
        public var likes:LikesButton;
        public var index:uint;
        private var _songDetails:SongDetailsVO;
        private var _playing:Boolean = false;

        public function SongListItem(skin:MovieClip, index:uint=0)
        {
            super(skin);
            this.likes.likesCount = 100;
            this.index = index;
            this.init();
        }

        public function set songDetails(details:SongDetailsVO):void
        {
            var resetLikes:Boolean = ((this._songDetails) ? (((!(this._songDetails.playing == details.playing)) && (this._songDetails.playerId == details.playerId)) && (this._songDetails.songId == details.songId)) : (true));
            this._songDetails = details;
            this.updateView(resetLikes);
        }

        public function get songDetails():SongDetailsVO
        {
            return (this._songDetails);
        }

        public function set playing(bool:Boolean):void
        {
            this._playing = bool;
            skin.playButton.gotoAndStop(((bool) ? 2 : 1));
        }

        public function get playing():Boolean
        {
            return (this._playing);
        }

        private function updateView(resetLikes:Boolean):void
        {
            this.playing = this._songDetails.playing;
            this.label.text = this._songDetails.playerName;
            if (resetLikes)
            {
                this.likes.enabled = this._songDetails.canLikeSong;
                this.likes.likesCount = this._songDetails.likesCount;
            };
        }

        private function init():void
        {
            (skin.background as MovieClip).gotoAndStop(((this.index % 3) + 1));
            this.playButton = skin.playButton;
            this.label = (skin.label as TextField);
            this.playButton.stop();
            this.label.text = "";
        }

        override protected function createChildComponents():void
        {
            super.createChildComponents();
            skin.background.gotoAndStop(((this.index % 3) + 1));
            this.likes = new LikesButton(skin.likes);
            (skin.likes as MovieClip).buttonMode = true;
            (skin.likes as MovieClip).addEventListener(MouseEvent.CLICK, this.onLikesSkinClicked);
            (skin.likes as MovieClip).addEventListener(Event.REMOVED_FROM_STAGE, this.onLikesSkinRemovedFromStage);
        }

        public function localize(localizationManager:ILocalizationManager):void
        {
            this.likes.localize(localizationManager);
        }

        protected function onLikesSkinClicked(event:MouseEvent):void
        {
            this.parent.swapChildren(this, this.parent.getChildAt((this.parent.numChildren - 1)));
            this.likes.showNotificationBubble();
        }

        protected function onLikesSkinRemovedFromStage(event:Event):void
        {
            (skin.likes as MovieClip).removeEventListener(MouseEvent.CLICK, this.onLikesSkinClicked);
            (skin.likes as MovieClip).removeEventListener(Event.REMOVED_FROM_STAGE, this.onLikesSkinRemovedFromStage);
        }

        override protected function addListeners():void
        {
            super.addListeners();
            this.likes.addEventListener(MouseEvent.CLICK, this.onLikesClicked);
            skin.playButton.addEventListener(MouseEvent.CLICK, this.onPlayButtonClicked);
        }

        protected function onPlayButtonClicked(event:MouseEvent):void
        {
            Log.debug("");
            if (!this.playing)
            {
                dispatchEvent(new MusicStudioSongListItemEvent(MusicStudioSongListItemEvent.PLAY_BUTTON_CLICKED, this._songDetails));
            }
            else
            {
                dispatchEvent(new MusicStudioSongListItemEvent(MusicStudioSongListItemEvent.STOP_BUTTON_CLICKED, this._songDetails));
            };
        }

        protected function onLikesClicked(event:MouseEvent):void
        {
            Log.debug("");
            dispatchEvent(new MusicStudioSongListItemEvent(MusicStudioSongListItemEvent.LIKE_BUTTON_CLICKED, this._songDetails));
        }


    }
}//package com.clubpenguin.music.game.view.components.songList.itemRenderer
