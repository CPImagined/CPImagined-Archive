//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.events.EventDispatcher;
    import flash.display.Loader;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.CardVO;
    import flash.display.MovieClip;
    import fl.motion.Color;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class CardView extends EventDispatcher 
    {

        private static const UNAVAILABLE_HEX:Number = 15774305;
        private static const UNAVAILABLE_MULTIPLIER:Number = 0.6;

        private var _loader:Loader = new Loader();
        private var _cardVO:CardVO;
        private var _skin:MovieClip;

        public function CardView(cardVO:CardVO, skin:MovieClip)
        {
            this._cardVO = cardVO;
            this._skin = skin;
            this.setupSkin();
            this.loadArt();
        }

        private function setupSkin():void
        {
            var cardColor:Color = new Color();
            cardColor.setTint(this._cardVO.colorHex, 1);
            this.setLoading(true);
            this.setCount(this._cardVO.count);
            this.setAvailable(this._cardVO.available);
            this._skin.card.powercardOutline.visible = this._cardVO.isPowercard;
            this._skin.card.element.gotoAndStop(this._cardVO.element);
            this._skin.card.value.valueText.text = this._cardVO.value;
            this._skin.card.border.transform.colorTransform = cardColor;
            this._skin.card.powercardOutline.transform.colorTransform = cardColor;
            this._skin.card.powercardOutline.stop();
            this._skin.memberOnly.visible = this._cardVO.memberOnly;
        }

        public function loadArt():void
        {
            var request:URLRequest = new URLRequest(((CardVO.CARD_LOADER_DATA[CardVO.ICON_URL] + this._cardVO.cardId) + ".swf"));
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onArtLoaded);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onArtError);
            this._loader.load(request);
            this._skin.card.art.addChild(this._loader);
        }

        private function onArtLoaded(event:Event):void
        {
            this.setLoading(false);
        }

        private function onArtError(event:IOErrorEvent):void
        {
        }

        private function setCount(cardCount:Number):void
        {
            cardCount = ((cardCount <= 999) ? cardCount : 999);
            var numberLength:Number = String(cardCount).length;
            numberLength = (([1, 2, 3].indexOf(numberLength) >= 0) ? numberLength : 1);
            this._skin.count.gotoAndStop(numberLength);
            LocalTextProxy.localText.setText(((this._skin.count.countText as ILocalTextComponent).localTextField as ILocalTextField), (cardCount + ""));
        }

        private function setAvailable(isAvailable:Boolean):void
        {
            var colorTransform:Color = new Color();
            if (isAvailable == true)
            {
                colorTransform.setTint(UNAVAILABLE_HEX, 0);
            }
            else
            {
                colorTransform.setTint(UNAVAILABLE_HEX, UNAVAILABLE_MULTIPLIER);
            };
            this._skin.card.transform.colorTransform = colorTransform;
        }

        private function setLoading(isLoading:Boolean):void
        {
            this._skin.placeholder.visible = isLoading;
            this._skin.loading.visible = isLoading;
            if (isLoading == true)
            {
                this._skin.loading.play();
            }
            else
            {
                this._skin.loading.stop();
            };
        }

        public function destroy():void
        {
            this._skin.card.art.removeChild(this._loader);
            this._loader.unloadAndStop();
            this._skin;
            this._cardVO = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
