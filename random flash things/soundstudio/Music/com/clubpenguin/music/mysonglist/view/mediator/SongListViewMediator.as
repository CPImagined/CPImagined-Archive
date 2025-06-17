//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.view.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.music.mysonglist.model.MySongListModel;
    import com.clubpenguin.music.mysonglist.view.component.SongListView;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.music.mysonglist.events.MySongListEvent;
    import flash.events.EventDispatcher;
    import com.clubpenguin.music.player.MusicPlayer;
    import com.clubpenguin.lib.util.Log;
    import flash.events.Event;

    public class SongListViewMediator extends Mediator 
    {

        [Inject]
        public var model:MySongListModel;
        [Inject]
        public var view:SongListView;
        [Inject]
        public var _localizationManager:ILocalizationManager;
        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var mainModel:IAppModel;


        override public function onRegister():void
        {
            this.model.dataLoadedSignal.addOnce(this.model_SongListLoaded_Handler);
            this.model.songDeletedResponseSignal.add(this.model_songDeleteResponse_Handler);
            this.model.songSharedResponseSignal.add(this.model_songShareResponse_Handler);
            this.model.getLikesResponseSignal.add(this.model_getSongLikesResponse_Handler);
            this.model.language = this.mainModel.getEnvironmentData().language;
            this.view.addEventListener(MySongListEvent.SONG_DELETE, this.songView_Delete_Handler);
            this.view.addEventListener(MySongListEvent.SONG_SHARE, this.songView_Share_Handler);
            this.view.addEventListener(MySongListEvent.SONG_PLAY, this.songView_Play_Handler);
            this.view.addEventListener(MySongListEvent.MODULE_CLOSE, this.songView_Close_Handler);
            this.view.addEventListener(MySongListEvent.SONG_LIKES, this.songView_GetLikes_Handler);
            this.view.addEventListener(MySongListEvent.SONG_STOP, this.songView_Stop_Handler);
            this.view.addEventListener(MySongListEvent.OPEN_STUDIO, this.songView_OpenStudio_Handler);
            EventDispatcher(this.musicPlayer).addEventListener(MusicPlayer.EVENT_SONG_COMPLETE, this.musicPlayer_SongComplete_Handler);
        }

        private function model_SongListLoaded_Handler():void
        {
            Log.debug((this._localizationManager + ""));
            Log.debug(this.model.initData);
            this.view.localize(this._localizationManager, this.mainModel.getEnvironmentData().language);
            this.view.displaySongs(this.model.songVOList, this.model.initData, this.model.isMember);
        }

        private function model_songDeleteResponse_Handler(songID:String):void
        {
            Log.debug(songID);
            this.view.deleteSong(songID);
        }

        private function model_songShareResponse_Handler(data:String):void
        {
            Log.debug(data);
            this.view.shareSong(data.split("|")[0], data.split("|")[1]);
        }

        private function model_getSongLikesResponse_Handler(data:String):void
        {
            this.view.updateLikeCount(data.split("|")[0], data.split("|")[1]);
        }

        private function songView_Delete_Handler(e:MySongListEvent):void
        {
            Log.debug(e.target.name);
            this.model.songDeletedSignal.dispatch((e.payload as String));
        }

        private function songView_Share_Handler(e:MySongListEvent):void
        {
            Log.debug(e.target.name);
            this.model.songSharedSignal.dispatch((e.payload as String));
        }

        private function songView_Play_Handler(e:MySongListEvent):void
        {
            Log.debug(e.target.name);
            this.model.songPlayedSignal.dispatch((e.payload as String));
        }

        private function songView_Stop_Handler(e:MySongListEvent):void
        {
            this.model.songStopSignal.dispatch((e.payload as String));
        }

        private function songView_Close_Handler(e:MySongListEvent):void
        {
            Log.debug(e.target.name);
            this.model.closeModuleSignal.dispatch();
        }

        private function songView_OpenStudio_Handler(e:MySongListEvent):void
        {
            Log.debug("dispatch create track");
            this.model.openStudioSignal.dispatch();
            this.model.createTrackSignal.dispatch();
        }

        private function songView_GetLikes_Handler(e:MySongListEvent):void
        {
            this.model.getLikesSignal.dispatch((e.payload as String));
        }

        private function musicPlayer_SongComplete_Handler(e:Event):void
        {
            this.view.songComplete();
        }

        override public function onRemove():void
        {
            Log.debug("");
            this.view.clean();
            this.view.removeEventListener(MySongListEvent.SONG_DELETE, this.songView_Delete_Handler);
            this.view.removeEventListener(MySongListEvent.SONG_SHARE, this.songView_Share_Handler);
            this.view.removeEventListener(MySongListEvent.SONG_PLAY, this.songView_Play_Handler);
            this.view.removeEventListener(MySongListEvent.MODULE_CLOSE, this.songView_Close_Handler);
            this.view.removeEventListener(MySongListEvent.SONG_LIKES, this.songView_GetLikes_Handler);
            this.view.removeEventListener(MySongListEvent.SONG_STOP, this.songView_Stop_Handler);
            this.view.removeEventListener(MySongListEvent.OPEN_STUDIO, this.songView_OpenStudio_Handler);
            this.model.dataLoadedSignal.remove(this.model_SongListLoaded_Handler);
            this.model.songDeletedResponseSignal.remove(this.model_songDeleteResponse_Handler);
            this.model.songSharedResponseSignal.remove(this.model_songShareResponse_Handler);
            this.model.getLikesResponseSignal.remove(this.model_getSongLikesResponse_Handler);
        }


    }
}//package com.clubpenguin.music.mysonglist.view.mediator
