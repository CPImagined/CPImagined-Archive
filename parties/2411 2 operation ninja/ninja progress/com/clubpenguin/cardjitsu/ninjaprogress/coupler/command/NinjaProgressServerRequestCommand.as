//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.coupler.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.NinjaProgressClassicCoupler;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.NinjaAirtowerConstants;

    public class NinjaProgressServerRequestCommand extends SignalCommand 
    {

        [Inject]
        public var coupler:NinjaProgressClassicCoupler;
        [Inject]
        public var connection:IConnection;
        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var requestType:String;


        override public function execute():void
        {
            var cardsCache:Array;
            if (this.requestType == NinjaAirtowerConstants.GET_CARD_DATA)
            {
                cardsCache = this.mainModel.getCardsCache();
                if (cardsCache != null)
                {
                    this.coupler.receivedPayload(NinjaAirtowerConstants.GET_CARD_DATA, cardsCache);
                    return;
                };
                this.connection.sendMessage(NinjaAirtowerConstants.CARDS_HANDLER, this.requestType);
            }
            else
            {
                this.connection.sendMessage(NinjaAirtowerConstants.NINJA_HANDLER, this.requestType);
            };
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.coupler.command
