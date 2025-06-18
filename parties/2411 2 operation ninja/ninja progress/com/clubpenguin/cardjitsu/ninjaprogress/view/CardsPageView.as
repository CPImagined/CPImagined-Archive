//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import flash.events.MouseEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;

    public class CardsPageView extends EventDispatcher 
    {

        private static const CARD_THUMBS:String = "cardThumbs";
        private static const PAGE_PREV_BTN:String = "pagePrevBtn";
        private static const PAGE_NEXT_BTN:String = "pageNextBtn";
        private static const PAGE_COUNTER:String = "pageCounter";
        private static const CARDS_PER_PAGE:Number = 10;

        private var _skin:MovieClip;
        private var _cardVOs:Array;
        private var _currentCards:Array;
        private var _currentPage:Number;
        private var _totalPages:Number;
        private var _localeTextReplacer:ILocaleTextReplacer;

        public function CardsPageView(skin:MovieClip, localeTextReplacer:ILocaleTextReplacer)
        {
            this._skin = skin;
            this._skin.visible = false;
            this._localeTextReplacer = localeTextReplacer;
            this.setCards([]);
        }

        public function show():void
        {
            this._skin.visible = true;
            this.addEventListeners();
        }

        public function hide():void
        {
            this.removeEventListeners();
        }

        private function addEventListeners():void
        {
            if (this._skin[PAGE_PREV_BTN].buttonMode == true)
            {
                this._skin[PAGE_PREV_BTN].addEventListener(MouseEvent.CLICK, this.pagePrevOnClick);
                this._skin[PAGE_PREV_BTN].addEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
                this._skin[PAGE_PREV_BTN].addEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
                this._skin[PAGE_PREV_BTN].addEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
            };
            if (this._skin[PAGE_NEXT_BTN].buttonMode == true)
            {
                this._skin[PAGE_NEXT_BTN].addEventListener(MouseEvent.CLICK, this.pageNextOnClick);
                this._skin[PAGE_NEXT_BTN].addEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
                this._skin[PAGE_NEXT_BTN].addEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
                this._skin[PAGE_NEXT_BTN].addEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
            };
        }

        private function removeEventListeners():void
        {
            if (this._skin[PAGE_PREV_BTN].buttonMode == true)
            {
                this._skin[PAGE_PREV_BTN].removeEventListener(MouseEvent.CLICK, this.pagePrevOnClick);
                this._skin[PAGE_PREV_BTN].removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
                this._skin[PAGE_PREV_BTN].removeEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
                this._skin[PAGE_PREV_BTN].removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
            };
            if (this._skin[PAGE_NEXT_BTN].buttonMode == true)
            {
                this._skin[PAGE_NEXT_BTN].removeEventListener(MouseEvent.CLICK, this.pageNextOnClick);
                this._skin[PAGE_NEXT_BTN].removeEventListener(MouseEvent.MOUSE_OVER, this.buttonOnMouseOver);
                this._skin[PAGE_NEXT_BTN].removeEventListener(MouseEvent.MOUSE_DOWN, this.buttonOnMouseDown);
                this._skin[PAGE_NEXT_BTN].removeEventListener(MouseEvent.MOUSE_OUT, this.buttonOnMouseOut);
            };
        }

        private function pagePrevOnClick(event:MouseEvent):void
        {
            this._currentPage = (this._currentPage - 1);
            this._currentPage = ((this._currentPage >= 1) ? this._currentPage : this._totalPages);
            this.loadCurrentPage();
        }

        private function pageNextOnClick(event:MouseEvent):void
        {
            this._currentPage = (this._currentPage + 1);
            this._currentPage = ((this._currentPage <= this._totalPages) ? this._currentPage : 1);
            this.loadCurrentPage();
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

        public function setCards(cardVOs:Array):void
        {
            this._cardVOs = cardVOs;
            this._currentPage = 1;
            this._totalPages = Math.ceil((this._cardVOs.length / CARDS_PER_PAGE));
            this._totalPages = ((this._totalPages >= 1) ? this._totalPages : 1);
            this.updatePageControls();
            this.loadCurrentPage();
        }

        private function updatePageControls():void
        {
            if (this._totalPages > 1)
            {
                this._skin[PAGE_PREV_BTN].gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
                this._skin[PAGE_PREV_BTN].buttonMode = true;
                this._skin[PAGE_PREV_BTN].mouseChildren = false;
                this._skin[PAGE_NEXT_BTN].gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
                this._skin[PAGE_NEXT_BTN].buttonMode = true;
                this._skin[PAGE_NEXT_BTN].mouseChildren = false;
                this.addEventListeners();
            }
            else
            {
                this._skin[PAGE_PREV_BTN].gotoAndStop(NinjaConstants.BUTTON_DISABLED_FRAME);
                this._skin[PAGE_PREV_BTN].buttonMode = false;
                this._skin[PAGE_NEXT_BTN].gotoAndStop(NinjaConstants.BUTTON_DISABLED_FRAME);
                this._skin[PAGE_NEXT_BTN].buttonMode = false;
            };
        }

        private function loadCurrentPage():void
        {
            var cardMC:MovieClip;
            var card:CardView;
            this.clearCurrentPage();
            var indexOffset:Number = ((this._currentPage - 1) * CARDS_PER_PAGE);
            var i:Number = 0;
            while (i < CARDS_PER_PAGE)
            {
                cardMC = this._skin[CARD_THUMBS][("card" + (i + 1))];
                if ((i + indexOffset) <= (this._cardVOs.length - 1))
                {
                    card = new CardView(this._cardVOs[(i + indexOffset)], cardMC);
                    this._currentCards.push(card);
                    cardMC.visible = true;
                }
                else
                {
                    cardMC.visible = false;
                };
                i++;
            };
            this.updatePageCounter();
        }

        private function clearCurrentPage():void
        {
            var card:CardView;
            for each (card in this._currentCards)
            {
                card.destroy();
                card = null;
            };
            this._currentCards = [];
        }

        private function updatePageCounter():void
        {
            this._localeTextReplacer.replaceText(this._skin[PAGE_COUNTER], ((this._currentPage + "/") + this._totalPages));
        }

        public function destroy():void
        {
            this.removeEventListeners();
            this.clearCurrentPage();
            this._cardVOs = [];
            this._skin = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
