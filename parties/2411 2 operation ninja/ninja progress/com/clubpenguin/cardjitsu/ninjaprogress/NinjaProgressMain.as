//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress
{
    import flash.display.Sprite;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaProgressModel;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.NinjaProgressMainController;
    import flash.display.MovieClip;
    import com.greensock.plugins.TweenPlugin;
    import com.greensock.plugins.AutoAlphaPlugin;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.NinjaModuleEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.NinjaModuleConstants;
    import flash.events.MouseEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import flash.events.Event;

    public class NinjaProgressMain extends Sprite 
    {

        private static const CLOSE_BTN:String = "closeBtn";

        private var _model:NinjaProgressModel;
        private var _controller:NinjaProgressMainController;
        private var _skin:MovieClip;

        public function NinjaProgressMain(skin:MovieClip, initialState:String, localeTextReplacer:ILocaleTextReplacer)
        {
            TweenPlugin.activate([AutoAlphaPlugin]);
            this._skin = skin;
            this._model = new NinjaProgressModel();
            this._controller = new NinjaProgressMainController(this._skin, this._model, initialState, localeTextReplacer);
            addChild(this._skin);
        }

        public function init():void
        {
            this._controller.init();
            this._controller.addEventListener(NinjaModuleEvent.GOTO_REDEMPTION, dispatchEvent);
            this._controller.addEventListener(NinjaModuleEvent.PLAY_VIDEO, dispatchEvent);
            this._controller.addEventListener(NinjaModuleEvent.BUY_POWERCARDS, dispatchEvent);
            var localizationPayload:Object = LocalizationVO.LOCALIZATION_TOKENS;
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_REQUEST, NinjaModuleConstants.REQUEST_LOCALIZATION_DATA, localizationPayload));
            var localizedPathsPayload:Object = LocalizationVO.LOCALIZED_PATHS_TOKENS;
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_REQUEST, NinjaModuleConstants.REQUEST_LOCALIZED_PATHS, localizedPathsPayload));
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_REQUEST, NinjaModuleConstants.REQUEST_PROGRESS_DATA));
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.SERVICE_REQUEST, NinjaModuleConstants.REQUEST_CARD_DATA));
            this._skin[CLOSE_BTN].buttonMode = true;
            this._skin[CLOSE_BTN].addEventListener(MouseEvent.CLICK, this.onClose);
        }

        public function receivePayload(event:NinjaModuleEvent):void
        {
            switch (event.messageType)
            {
                case NinjaModuleConstants.REQUEST_LOCALIZATION_DATA:
                    this.localizationResponse(event.payload);
                    break;
                case NinjaModuleConstants.REQUEST_LOCALIZED_PATHS:
                    this.localizedPathsResponse(event.payload);
                    break;
                case NinjaModuleConstants.REQUEST_PROGRESS_DATA:
                    this._model.setElementLevels(event.payload);
                    break;
                case NinjaModuleConstants.REQUEST_CARD_DATA:
                    this._model.setCardCollection((event.payload as Array));
                    break;
            };
        }

        private function localizationResponse(localizationPayload:Object):void
        {
            var i:String;
            for (i in LocalizationVO.LOCALIZATION_TOKENS)
            {
                if (localizationPayload[i])
                {
                    LocalizationVO.LOCALIZATION_TOKENS[i] = localizationPayload[i];
                };
            };
            LocalizationVO.LANGUAGE_FRAME[LocalizationVO.CURRENT_LANGUAGE] = localizationPayload[NinjaConstants.CURRENT_LANG_INDEX];
            this._controller.localize();
        }

        private function localizedPathsResponse(localizedPathsPayload:Object):void
        {
            var i:String;
            for (i in LocalizationVO.LOCALIZED_PATHS_TOKENS)
            {
                if (localizedPathsPayload[i])
                {
                    LocalizationVO.LOCALIZED_PATHS_TOKENS[i] = localizedPathsPayload[i];
                };
            };
        }

        private function onClose(event:MouseEvent):void
        {
            dispatchEvent(new Event(Event.CLOSE));
        }

        public function destroy():void
        {
            this._controller.removeEventListener(NinjaModuleEvent.GOTO_REDEMPTION, dispatchEvent);
            this._controller.removeEventListener(NinjaModuleEvent.PLAY_VIDEO, dispatchEvent);
            this._controller.removeEventListener(NinjaModuleEvent.BUY_POWERCARDS, dispatchEvent);
            this._skin[CLOSE_BTN].removeEventListener(MouseEvent.CLICK, this.onClose);
            removeChild(this._skin);
            this._model.destroy();
            this._controller.destroy();
            this._skin;
            this._model;
            this._controller = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress
