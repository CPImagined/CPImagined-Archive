//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.controller.state
{
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.BaseState;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.IState;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaProgressModel;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.PanelEffectController;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.ProgressView;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.SnowProgressView;
	import com.clubpenguin.cardjitsu.ninjaprogress.view.ShadowProgressView;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.AmuletView;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.ModelUpdateEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.NinjaModuleConstants;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.StateChangeEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.ElementLevelVO;

    public class ProgressState extends BaseState implements IState 
    {

        private static const AMULET:String = "amulet";

        private var _model:NinjaProgressModel;
        private var _panelController:PanelEffectController;
        private var _ninjaProgessView:ProgressView;
        private var _fireProgessView:ProgressView;
        private var _waterProgessView:ProgressView;
        private var _snowProgessView:SnowProgressView;
		private var _shadowProgessView:ShadowProgressView;
        private var _amuletView:AmuletView;
        private var _dataLoaded:Boolean;
        private var _isActive:Boolean;

        public function ProgressState(skin:MovieClip, model:NinjaProgressModel, panelController:PanelEffectController, localeTextReplacer:ILocaleTextReplacer)
        {
            model.addEventListener(ModelUpdateEvent.MODEL_UPDATED, this.onModelUpdated);
            this._model = model;
            this._panelController = panelController;
            this._ninjaProgessView = new ProgressView(skin[NinjaConstants.GAME_TYPE_NINJA], NinjaModuleConstants.CARD_JITSU_VANILLA, localeTextReplacer);
            this._fireProgessView = new ProgressView(skin[NinjaConstants.GAME_TYPE_FIRE], NinjaModuleConstants.CARD_JITSU_FIRE, localeTextReplacer);
            this._waterProgessView = new ProgressView(skin[NinjaConstants.GAME_TYPE_WATER], NinjaModuleConstants.CARD_JITSU_WATER, localeTextReplacer);
            this._snowProgessView = new SnowProgressView(skin[NinjaConstants.GAME_TYPE_SNOW], localeTextReplacer);
			this._shadowProgessView = new ShadowProgressView(skin[NinjaConstants.GAME_TYPE_SHADOW], localeTextReplacer);
            this._amuletView = new AmuletView(skin[AMULET]);
        }

        public function localize():void
        {
            this._ninjaProgessView.localize();
            this._fireProgessView.localize();
            this._waterProgessView.localize();
            this._snowProgessView.localize();
			this._shadowProgessView.localize();
        }

        public function enter():void
        {
            this._panelController.setPanel(StateConstants.PROGRESS_STATE);
            this.addEventListeners();
            if (this._dataLoaded)
            {
                this.showViews();
            };
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
            this._ninjaProgessView.show();
            this._fireProgessView.show();
            this._waterProgessView.show();
            this._snowProgessView.show();
			this._shadowProgessView.show();
            this._amuletView.show();
        }

        private function hideViews():void
        {
            this._ninjaProgessView.hide();
            this._fireProgessView.hide();
            this._waterProgessView.hide();
            this._snowProgessView.hide();
			this._shadowProgessView.hide();
            this._amuletView.hide();
        }

        private function destroyViews():void
        {
            this._ninjaProgessView.destroy();
            this._fireProgessView.destroy();
            this._waterProgessView.destroy();
            this._snowProgessView.destroy();
			this._shadowProgessView.destroy();
            this._amuletView.destroy();
            this._ninjaProgessView = null;
            this._fireProgessView = null;
            this._waterProgessView = null;
            this._snowProgessView = null;
			this._shadowProgessView = null;
            this._amuletView = null;
        }

        private function addEventListeners():void
        {
            this._panelController.addEventListener(StateChangeEvent.CHANGE_STATE, dispatchEvent);
        }

        private function removeEventListeners():void
        {
            this._panelController.removeEventListener(StateChangeEvent.CHANGE_STATE, dispatchEvent);
        }

        private function onModelUpdated(event:ModelUpdateEvent):void
        {
            var ninjaData:ElementLevelVO;
            var fireData:ElementLevelVO;
            var waterData:ElementLevelVO;
            var snowData:ElementLevelVO;
			var shadowData:ElementLevelVO;
            if (event.propertyUpdated == NinjaConstants.ELEMENT_LEVELS)
            {
                ninjaData = this._model.getElementLevel(NinjaConstants.GAME_TYPE_NINJA);
                fireData = this._model.getElementLevel(NinjaConstants.GAME_TYPE_FIRE);
                waterData = this._model.getElementLevel(NinjaConstants.GAME_TYPE_WATER);
                snowData = this._model.getElementLevel(NinjaConstants.GAME_TYPE_SNOW);
				shadowData = this._model.getElementLevel("shadow");
                this._ninjaProgessView.update(ninjaData);
                this._fireProgessView.update(fireData);
                this._waterProgessView.update(waterData);
                this._snowProgessView.update(snowData);
				this._shadowProgessView.update(shadowData);
                this._amuletView.update(fireData, waterData, snowData);
                this._dataLoaded = true;
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
