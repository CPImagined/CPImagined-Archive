//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.view
{
    import flash.events.EventDispatcher;
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.vo.CardVO;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import flash.geom.ColorTransform;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class CardView extends EventDispatcher 
    {

        public const created:Signal = new Signal(CardView);

        private var _skin:CardThumbView;
        private var _cardVO:CardVO;
        private var _localText:LocalText;

        public function CardView(cardVO:CardVO)
        {
            this._cardVO = cardVO;
            this._localText = (LocalTextProxy.localText as LocalText);
            this._skin = new CardThumbView(EmbeddedAssets.CarrdThumbAsset);
            this._skin.onCompleted.addOnce(this.onSkinViewCompleted);
        }

        private function onSkinViewCompleted():void
        {
            var cardColor:ColorTransform = new ColorTransform();
            cardColor.color = this._cardVO.colorHex;
            MovieClip(this._skin.card.element).gotoAndStop(this._cardVO.element);
            this._localText.setText(ILocalTextComponent(this._skin.card.value.valueText).localTextField, String(this._cardVO.value));
            MovieClip(this._skin.card.border).transform.colorTransform = cardColor;
            this.setPower(cardColor);
            this._skin.memberOnly.visible = false;
            this.loadArt();
        }

        private function loadArt():void
        {
            var loader:Loader = new Loader();
            var request:URLRequest = new URLRequest(((CardVO.CARD_LOADER_DATA[CardVO.ICON_URL] + this._cardVO.cardId) + ".swf"));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onArtLoaded);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onArtError);
            loader.load(request);
            this._skin.card.art.addChild(loader);
        }

        private function onArtLoaded(event:Event):void
        {
            this._skin.placeholder.visible = false;
            this._skin.loading.visible = false;
            this.created.dispatch(this);
        }

        private function onArtError(event:IOErrorEvent):void
        {
        }

        private function setPower(cardColor:ColorTransform):void
        {
            if (this._cardVO.isPowercard)
            {
                MovieClip(this._skin.card.powercardOutline).transform.colorTransform = cardColor;
            }
            else
            {
                this._skin.card.removeChild(this._skin.card.powercardOutline);
            };
        }

        public function memberOnly(visible:Boolean):void
        {
            this._skin.memberOnly.visible = visible;
        }

        public function get skin():MovieClip
        {
            return (this._skin);
        }


    }
}//package com.clubpenguin.main.view
