//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.controller
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaProgressModel;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateMachine;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.NinjaModuleEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.state.ProgressState;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.state.CardState;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.state.SnowState;

    public class NinjaProgressMainController extends EventDispatcher 
    {

        private static const PANEL_CONTENT:String = "content";
        private static const REDEEM_OVERLAY:String = "redeemOverlay";

        private var _skin:MovieClip;
        private var _model:NinjaProgressModel;
        private var _panelController:PanelEffectController;
        private var _overlayController:OverlayController;
        private var _states:StateMachine;
        private var _initialState:String;
        private var _localeTextReplacer:ILocaleTextReplacer;

        public function NinjaProgressMainController(skin:MovieClip, model:NinjaProgressModel, initialState:String, localeTextReplacer:ILocaleTextReplacer)
        {
            this._skin = skin;
            this._model = model;
            this._localeTextReplacer = localeTextReplacer;
            this._initialState = initialState;
        }

        public function init():void
        {
            this._panelController = new PanelEffectController(this._skin, this._localeTextReplacer);
            this._panelController.init();
            this._overlayController = new OverlayController(this._skin[REDEEM_OVERLAY], this._localeTextReplacer);
            this._overlayController.addEventListener(NinjaModuleEvent.GOTO_REDEMPTION, dispatchEvent);
            this.setupStates();
        }

        private function setupStates():void
        {
            this._states = new StateMachine();
            this._states.addState(StateConstants.PROGRESS_STATE, new ProgressState(this._skin[StateConstants.PROGRESS_STATE][PANEL_CONTENT], this._model, this._panelController, this._localeTextReplacer));
            this._states.addState(StateConstants.CARD_STATE, new CardState(this._skin[StateConstants.CARD_STATE][PANEL_CONTENT], this._model, this._panelController, this._overlayController, this._localeTextReplacer));
            this._states.addState(StateConstants.SNOW_STATE, new SnowState(this._skin[StateConstants.SNOW_STATE][PANEL_CONTENT], this._model, this._panelController, this._localeTextReplacer));
            this._states.states[StateConstants.SNOW_STATE].addEventListener(NinjaModuleEvent.PLAY_VIDEO, dispatchEvent);
            this._states.states[StateConstants.CARD_STATE].addEventListener(NinjaModuleEvent.BUY_POWERCARDS, dispatchEvent);
            this._states.changeState(this._initialState);
        }

        public function localize():void
        {
            this._panelController.localize();
            this._overlayController.localize();
            this._states.states[StateConstants.PROGRESS_STATE].localize();
        }

        public function destroy():void
        {
            this._overlayController.removeEventListener(NinjaModuleEvent.GOTO_REDEMPTION, dispatchEvent);
            this._states.states[StateConstants.SNOW_STATE].removeEventListener(NinjaModuleEvent.PLAY_VIDEO, dispatchEvent);
            this._states.states[StateConstants.CARD_STATE].removeEventListener(NinjaModuleEvent.BUY_POWERCARDS, dispatchEvent);
            this._states.destroy();
            this._panelController.destroy();
            this._overlayController.destroy();
            this._skin;
            this._model;
            this._panelController;
            this._overlayController;
            this._states = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.controller
