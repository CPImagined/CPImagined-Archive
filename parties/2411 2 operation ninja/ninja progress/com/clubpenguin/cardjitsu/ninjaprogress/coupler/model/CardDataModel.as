//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.coupler.model
{
    import flash.events.EventDispatcher;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.vo.CardDataVO;

    public class CardDataModel extends EventDispatcher 
    {

        private var _cardDataVOs:Array;


        public function setCardDataVOs(cardDataVOs:Array):void
        {
            this._cardDataVOs = cardDataVOs;
        }

        public function getCardDataVOById(cardId:Number):CardDataVO
        {
            var cardDataVO:CardDataVO;
            var foundCard:CardDataVO;
            for each (cardDataVO in this._cardDataVOs)
            {
                if (cardDataVO.cardId == cardId)
                {
                    foundCard = cardDataVO;
                    break;
                };
            };
            return (foundCard);
        }

        public function isReady():Boolean
        {
            return (!(this._cardDataVOs == null));
        }

        public function destroy():void
        {
            var cardDataVO:CardDataVO;
            for each (cardDataVO in this._cardDataVOs)
            {
                cardDataVO.destroy();
                cardDataVO = null;
            };
            this._cardDataVOs = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.coupler.model
