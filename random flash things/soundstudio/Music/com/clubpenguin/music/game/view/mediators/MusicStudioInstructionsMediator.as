//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.mediators
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.music.game.view.interfaces.IMusicStudioInstructions;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.events.MusicStudioViewEvent;
    import com.clubpenguin.music.game.view.events.MusicStudioInstructionsEvent;
    import com.clubpenguin.music.game.events.MusicStudioEvent;

    public class MusicStudioInstructionsMediator extends Mediator 
    {


        public function get view():IMusicStudioInstructions
        {
            return (viewComponent as IMusicStudioInstructions);
        }

        override public function onRegister():void
        {
            super.onRegister();
            Log.debug("");
            addContextListener(MusicStudioViewEvent.SHOW_INSTRUCTIONS_VIEW, this.onShowInstructionsView);
            addViewListener(MusicStudioInstructionsEvent.BACK, this.onBackButtonClicked);
            addViewListener(MusicStudioInstructionsEvent.NEXT, this.onNextButtonClicked);
            addViewListener(MusicStudioInstructionsEvent.CLOSE, this.onCloseButtonClicked);
            addViewListener(MusicStudioInstructionsEvent.PLAY, this.onPlayButtonClicked);
        }

        override public function onRemove():void
        {
            super.onRemove();
            Log.debug("");
            this.view.clean();
        }

        private function onShowInstructionsView(e:MusicStudioViewEvent):void
        {
            this.view.showInstructions();
        }

        private function onBackButtonClicked(e:MusicStudioInstructionsEvent):void
        {
            this.view.goToPreviousPage();
        }

        private function onNextButtonClicked(e:MusicStudioInstructionsEvent):void
        {
            this.view.goToNextPage();
        }

        private function onCloseButtonClicked(e:MusicStudioInstructionsEvent):void
        {
            this.view.hideInstructions();
            dispatch(new MusicStudioEvent(MusicStudioEvent.HIDE_INSTRUCTIONS));
        }

        private function onPlayButtonClicked(e:MusicStudioInstructionsEvent):void
        {
            this.view.hideInstructions();
            dispatch(new MusicStudioEvent(MusicStudioEvent.LOAD_GENRE, 0));
        }


    }
}//package com.clubpenguin.music.game.view.mediators
