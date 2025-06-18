//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.coupler.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.NinjaProgressClassicCoupler;
    import com.clubpenguin.lib.module.IAppModel;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.vo.CardDataVO;
    import com.adobe.serialization.json.JSONDecoder;

    public class LoadCardsJsonCommand extends SignalCommand 
    {

        private static const CARDS_JSON:String = "cards.json";

        [Inject]
        public var coupler:NinjaProgressClassicCoupler;
        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var webServicePath:String;


        override public function execute():void
        {
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, this.onJSONLoaded);
            loader.load(new URLRequest((this.webServicePath + CARDS_JSON)));
        }

        private function onJSONLoaded(event:Event):void
        {
            var card:Object;
            var cardDataVO:CardDataVO;
            var jsonDecoder:JSONDecoder = new JSONDecoder(event.target.data, false);
            var decodedObject:Object = jsonDecoder.getValue();
            var cardDataVOs:Array = [];
            for each (card in decodedObject)
            {
                cardDataVO = new CardDataVO(card.card_id, card.element, card.color, card.value, card.power_id);
                cardDataVOs.push(cardDataVO);
            };
            this.coupler.onCardsJsonLoaded(cardDataVOs);
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.coupler.command
