//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.controller
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.display.IScreen;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.PanelView;
    import flash.events.MouseEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.StateChangeEvent;

    public class PanelEffectController extends EventDispatcher 
    {

        public static const PANEL_CLOSED:String = "panelClosed";
        public static const PANEL_OPEN:String = "panelOpen";

        private var _skin:MovieClip;
        private var _localeTextReplacer:ILocaleTextReplacer;
        private var _panels:Dictionary;

        public function PanelEffectController(skin:MovieClip, localeTextReplacer:ILocaleTextReplacer)
        {
            this._skin = skin;
            this._localeTextReplacer = localeTextReplacer;
        }

        public function init():void
        {
            var panel:IScreen;
            this._panels = new Dictionary();
            this._panels[StateConstants.SNOW_STATE] = new PanelView(StateConstants.SNOW_STATE, this._skin[StateConstants.SNOW_STATE], PANEL_OPEN, this._localeTextReplacer, 2, false);
            this._panels[StateConstants.CARD_STATE] = new PanelView(StateConstants.CARD_STATE, this._skin[StateConstants.CARD_STATE], PANEL_OPEN, this._localeTextReplacer, 2);
            this._panels[StateConstants.PROGRESS_STATE] = new PanelView(StateConstants.PROGRESS_STATE, this._skin[StateConstants.PROGRESS_STATE], PANEL_OPEN, this._localeTextReplacer, 2);
            for each (panel in this._panels)
            {
                panel.addEventListener(MouseEvent.CLICK, this.panelOnMouseClick);
            };
        }

        public function localize():void
        {
            this._panels[StateConstants.SNOW_STATE].localize();
            this._panels[StateConstants.CARD_STATE].localize();
            this._panels[StateConstants.PROGRESS_STATE].localize();
        }

        public function setPanel(panelName:String):void
        {
            switch (panelName)
            {
                case StateConstants.SNOW_STATE:
                    this._panels[StateConstants.CARD_STATE].hide();
                    this._panels[StateConstants.PROGRESS_STATE].hide();
                    this._panels[StateConstants.SNOW_STATE].disable();
                    this._panels[StateConstants.CARD_STATE].enable();
                    this._panels[StateConstants.PROGRESS_STATE].enable();
                    break;
                case StateConstants.CARD_STATE:
                    this._panels[StateConstants.CARD_STATE].show();
                    this._panels[StateConstants.PROGRESS_STATE].hide();
                    this._panels[StateConstants.SNOW_STATE].enable();
                    this._panels[StateConstants.CARD_STATE].disable();
                    this._panels[StateConstants.PROGRESS_STATE].enable();
                    break;
                case StateConstants.PROGRESS_STATE:
                    this._panels[StateConstants.CARD_STATE].show();
                    this._panels[StateConstants.PROGRESS_STATE].show();
                    this._panels[StateConstants.SNOW_STATE].enable();
                    this._panels[StateConstants.CARD_STATE].enable();
                    this._panels[StateConstants.PROGRESS_STATE].disable();
                    break;
            };
        }

        private function panelOnMouseClick(event:MouseEvent):void
        {
            var stateConstant:String = event.currentTarget.name;
            dispatchEvent(new StateChangeEvent(StateChangeEvent.CHANGE_STATE, stateConstant));
        }

        public function destroy():void
        {
            var panel:PanelView;
            for each (panel in this._panels)
            {
                panel.removeEventListener(MouseEvent.CLICK, this.panelOnMouseClick);
                panel.destroy();
                panel = null;
            };
            this._panels = new Dictionary();
            this._skin = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.controller
