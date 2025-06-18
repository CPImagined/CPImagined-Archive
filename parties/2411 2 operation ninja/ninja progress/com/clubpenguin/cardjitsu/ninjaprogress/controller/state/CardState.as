//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.controller.state
{
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.BaseState;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.IState;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaProgressModel;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.PanelEffectController;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.OverlayController;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.CardsPageView;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.ModelUpdateEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.StateChangeEvent;
    import flash.events.MouseEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.CardVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.NinjaModuleEvent;

    public class CardState extends BaseState implements IState 
    {

        private static const CARD_COLLECTION:String = "cardCollection";
        private static const HAVE_CODE_BTN:String = "haveCodeBtn";
        private static const BUY_POWERCARDS_BTN:String = "buyPowercardsBtn";
        private static const TOTAL_COUNT:String = "totalCount";
        private static const COUNT_TEXT_CONTAINER:String = "countTextContainer";
        private static const COUNT_TEXT:String = "countText";

        private var _skin:MovieClip;
        private var _model:NinjaProgressModel;
        private var _panelController:PanelEffectController;
        private var _overlayController:OverlayController;
        private var _pageView:CardsPageView;
        private var _isActive:Boolean;
        private var _localeTextReplacer:ILocaleTextReplacer;

        public function CardState(skin:MovieClip, model:NinjaProgressModel, panelController:PanelEffectController, overlayController:OverlayController, localeTextReplacer:ILocaleTextReplacer)
        {
            model.addEventListener(ModelUpdateEvent.MODEL_UPDATED, this.onModelUpdated);
            this._skin = skin;
            this._model = model;
            this._panelController = panelController;
            this._overlayController = overlayController;
            this._localeTextReplacer = localeTextReplacer;
            this._pageView = new CardsPageView(skin[CARD_COLLECTION], localeTextReplacer);
            this._skin[HAVE_CODE_BTN].gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
            this._skin[HAVE_CODE_BTN].buttonMode = true;
            this._skin[HAVE_CODE_BTN].mouseChildren = false;
            this._skin[BUY_POWERCARDS_BTN].gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
            this._skin[BUY_POWERCARDS_BTN].buttonMode = true;
            this._skin[BUY_POWERCARDS_BTN].mouseChildren = false;
            this._skin[TOTAL_COUNT][COUNT_TEXT_CONTAINER][COUNT_TEXT].visible = false;
        }

        public function enter():void
        {
            this._panelController.setPanel(StateConstants.CARD_STATE);
            this.addEventListeners();
            this.showViews();
            this._isActive = true;
        }

        public function exit():void
        {
            this.hideViews();
            this.removeEventListeners();
            this._isActive = false;
        }

        private function showViews():void
        {
            this._pageView.show();
        }

        private function hideViews():void
        {
            this._pageView.hide();
        }

        private function destroyViews():void
        {
            this._pageView.destroy();
            this._pageView = null;
        }

        private function addEventListeners():void
        {
            this._panelController.addEventListener(StateChangeEvent.CHANGE_STATE, dispatchEvent);
            this._skin[HAVE_CODE_BTN].addEventListener(MouseEvent.CLICK, this.showOverlay);
            this._skin[HAVE_CODE_BTN].addEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
            this._skin[HAVE_CODE_BTN].addEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
            this._skin[HAVE_CODE_BTN].addEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
            this._skin[BUY_POWERCARDS_BTN].addEventListener(MouseEvent.CLICK, this.buyPowercards);
            this._skin[BUY_POWERCARDS_BTN].addEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
            this._skin[BUY_POWERCARDS_BTN].addEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
            this._skin[BUY_POWERCARDS_BTN].addEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
        }

        private function removeEventListeners():void
        {
            this._panelController.removeEventListener(StateChangeEvent.CHANGE_STATE, dispatchEvent);
            this._skin[HAVE_CODE_BTN].removeEventListener(MouseEvent.CLICK, this.showOverlay);
            this._skin[HAVE_CODE_BTN].removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
            this._skin[HAVE_CODE_BTN].removeEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
            this._skin[HAVE_CODE_BTN].removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
            this._skin[BUY_POWERCARDS_BTN].removeEventListener(MouseEvent.CLICK, this.buyPowercards);
            this._skin[BUY_POWERCARDS_BTN].removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
            this._skin[BUY_POWERCARDS_BTN].removeEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
            this._skin[BUY_POWERCARDS_BTN].removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
        }

        private function onModelUpdated(event:ModelUpdateEvent):void
        {
            var cardCollection:Array;
            var totalCount:Number;
            var cardVO:CardVO;
            if (event.propertyUpdated == NinjaConstants.CARD_COLLECTION)
            {
                cardCollection = this._model.getCardCollection();
                totalCount = 0;
                for each (cardVO in cardCollection)
                {
                    totalCount = (totalCount + cardVO.count);
                };
                this._localeTextReplacer.replaceText(this._skin[TOTAL_COUNT][COUNT_TEXT_CONTAINER][COUNT_TEXT], (totalCount + ""));
                this._skin[TOTAL_COUNT][COUNT_TEXT_CONTAINER][COUNT_TEXT].visible = true;
                this._pageView.setCards(cardCollection);
                if (this._isActive)
                {
                    this.showViews();
                };
            };
        }

        private function buyPowercards(event:MouseEvent):void
        {
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.BUY_POWERCARDS, null));
        }

        private function showOverlay(event:MouseEvent):void
        {
            this._overlayController.showOverlay();
        }

        private function buttonOnMouseOver(event:MouseEvent):void
        {
            event.currentTarget.gotoAndStop(NinjaConstants.BUTTON_OVER_FRAME);
        }

        private function buttonOnMouseDown(event:MouseEvent):void
        {
            event.currentTarget.gotoAndStop(NinjaConstants.BUTTON_DOWN_FRAME);
        }

        private function buttonOnMouseOut(event:MouseEvent):void
        {
            event.currentTarget.gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
        }

        public function destroy():void
        {
            this.removeEventListeners();
            this.destroyViews();
            this._skin;
            this._model;
            this._panelController;
            this._overlayController = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.controller.state
