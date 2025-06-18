//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.controller.state
{
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.BaseState;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.IState;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaProgressModel;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.PanelEffectController;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.StoryProgressScrollView;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.ModelUpdateEvent;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.StateChangeEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.NinjaModuleEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;

    public class SnowState extends BaseState implements IState 
    {

        private static const SNOW_VIDEOS:String = "snowVideos";

        private var _model:NinjaProgressModel;
        private var _panelController:PanelEffectController;
        private var _scrollView:StoryProgressScrollView;
        private var _isActive:Boolean;

        public function SnowState(skin:MovieClip, model:NinjaProgressModel, panelController:PanelEffectController, localeTextReplacer:ILocaleTextReplacer)
        {
            model.addEventListener(ModelUpdateEvent.MODEL_UPDATED, this.onModelUpdated);
            this._model = model;
            this._panelController = panelController;
            this._scrollView = new StoryProgressScrollView(skin[SNOW_VIDEOS], localeTextReplacer);
        }

        public function enter():void
        {
            this._panelController.setPanel(StateConstants.SNOW_STATE);
            this.addEventListeners();
            this.showViews();
            this._isActive = true;
        }

        public function exit():void
        {
            this.removeEventListeners();
            this.hideViews();
            this._isActive = false;
        }

        private function showViews():void
        {
            this._scrollView.show();
        }

        private function hideViews():void
        {
            this._scrollView.hide();
        }

        private function destroyViews():void
        {
            this._scrollView.destroy();
            this._scrollView = null;
        }

        private function addEventListeners():void
        {
            this._panelController.addEventListener(StateChangeEvent.CHANGE_STATE, dispatchEvent);
            this._scrollView.addEventListener(NinjaModuleEvent.PLAY_VIDEO, dispatchEvent);
        }

        private function removeEventListeners():void
        {
            this._panelController.removeEventListener(StateChangeEvent.CHANGE_STATE, dispatchEvent);
            this._scrollView.removeEventListener(NinjaModuleEvent.PLAY_VIDEO, dispatchEvent);
        }

        private function onModelUpdated(event:ModelUpdateEvent):void
        {
            var storyProgress:Array;
            if (event.propertyUpdated == NinjaConstants.STORY_PROGRESS)
            {
                storyProgress = this._model.getStoryProgress();
                this._scrollView.setStoryItems(storyProgress);
                if (this._isActive)
                {
                    this.showViews();
                };
            };
        }

        public function destroy():void
        {
            this.removeEventListeners();
            this.destroyViews();
            this._model;
            this._panelController = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.controller.state
