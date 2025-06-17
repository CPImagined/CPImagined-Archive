//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioStartSreen;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.view.events.MusicStudioStartScreenEvent;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import flash.display.DisplayObject;

    public class MusicStudioStartScreenMediator extends Mediator 
    {

        [Inject]
        public var appModel:IAppModel;


        public function get view():IMusicStudioStartSreen
        {
            return (viewComponent as IMusicStudioStartSreen);
        }

        override public function onRegister():void
        {
            super.onRegister();
            Log.debug("");
            addViewListener(MusicStudioStartScreenEvent.PLAY_GAME_REQUEST, this.onPlayGameRequest);
            addViewListener(MusicStudioStartScreenEvent.SHOW_INSTRUCTIONS_REQUEST, this.onShowInstructionsRequest);
            addViewListener(MusicStudioStartScreenEvent.SHOW_SONGLIST_REQUEST, this.onShowSongListRequest);
            this.createChildrenMediators();
            this.localizeView();
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, 0));
        }

        private function localizeView():void
        {
            this.view.localize(this.appModel.getLanguage());
        }

        private function createChildrenMediators():void
        {
            var child:DisplayObject;
            for each (child in this.view.mediatedChildren)
            {
                mediatorMap.createMediator(child);
            };
        }

        override public function onRemove():void
        {
            super.onRemove();
            Log.debug("");
        }

        private function onPlayGameRequest(e:MusicStudioStartScreenEvent):void
        {
            dispatch(new MusicStudioEvent(MusicStudioEvent.PLAY_GAME));
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, 0));
        }

        private function onShowInstructionsRequest(e:MusicStudioStartScreenEvent):void
        {
            Log.debug("");
            dispatch(new MusicStudioEvent(MusicStudioEvent.SHOW_INSTRUCTIONS));
        }

        private function onShowSongListRequest(e:MusicStudioStartScreenEvent):void
        {
            dispatch(new MusicStudioEvent(MusicStudioEvent.SHOW_SAVED_TRACKS));
        }


    }
}//package com.clubpenguin.music.game.view.mediators
