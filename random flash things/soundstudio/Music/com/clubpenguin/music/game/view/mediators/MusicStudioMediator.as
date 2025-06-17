//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.music.game.view.components.MusicStudio;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.events.MusicModuleEvent;
    import com.clubpenguin.music.game.events.MusicStudioViewEvent;
    import com.clubpenguin.music.game.events.MusicStudioEvent;

    public class MusicStudioMediator extends Mediator 
    {


        public function get view():MusicStudio
        {
            return (viewComponent as MusicStudio);
        }

        override public function onRegister():void
        {
            super.onRegister();
            Log.debug("");
            addContextListener(MusicModuleEvent.STUDIO_ASSETS_LOADED, this.onStudioAssetsLoaded);
            addContextListener(MusicStudioViewEvent.SHOW_GAME_VIEW, this.onShowGameView);
            addContextListener(MusicStudioViewEvent.SHOW_INSTRUCTIONS_VIEW, this.onShowInstructionsRequested);
            addContextListener(MusicStudioViewEvent.HIDE_INSTRUCTIONS_VIEW, this.onHideInstructionsRequested);
            addContextListener(MusicStudioEvent.SHOW_SAVED_TRACKS, this.onShowSavedTracksRequested);
            addContextListener(MusicStudioViewEvent.SHOW_START_SCREEN_VIEW, this.onShowStartScreenRequested);
            addViewListener(MusicStudioViewEvent.CLOSE_GAME, this.onCloseGameViewRequest);
        }

        override public function onRemove():void
        {
            super.onRemove();
            Log.debug("");
        }

        private function onCloseGameViewRequest(e:MusicStudioViewEvent):void
        {
            Log.debug("");
            if (this.view.startScreen.isVisible)
            {
                dispatch(new MusicStudioEvent(MusicStudioEvent.EXIT_GAME));
            }
            else
            {
                dispatch(new MusicStudioEvent(MusicStudioEvent.SHOW_START_SCREEN));
            };
        }

        private function onShowGameView(e:MusicStudioViewEvent):void
        {
            this.view.board.show();
            this.view.startScreen.hide();
        }

        private function onShowInstructionsRequested(e:MusicStudioViewEvent):void
        {
            Log.debug("");
            this.view.board.show();
            this.view.startScreen.hide();
        }

        private function onHideInstructionsRequested(e:MusicStudioViewEvent):void
        {
            Log.debug("");
            this.view.board.hide();
            this.view.startScreen.show();
        }

        private function onShowSavedTracksRequested(e:MusicStudioEvent):void
        {
        }

        private function onShowStartScreenRequested(e:MusicStudioViewEvent):void
        {
            Log.debug("");
            this.view.startScreen.show();
        }

        private function onStudioAssetsLoaded(e:*):void
        {
            Log.debug(("" + this.view));
            this.createChildrenMediators();
        }

        private function createChildrenMediators():void
        {
            mediatorMap.createMediator(this.view.startScreen);
            mediatorMap.createMediator(this.view.board);
            mediatorMap.createMediator(this.view.prompts);
            mediatorMap.createMediator(this.view.instructions);
        }


    }
}//package com.clubpenguin.music.game.view.mediators
