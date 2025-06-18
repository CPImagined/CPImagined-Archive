//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.coupler.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.NinjaProgressClassicCoupler;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.NinjaAirtowerConstants;

    public class NinjaProgressServerResponseCommand extends SignalCommand 
    {

        [Inject]
        public var coupler:NinjaProgressClassicCoupler;
        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var messageType:String;
        [Inject]
        public var payload:Array;


        override public function execute():void
        {
            if (this.messageType == NinjaAirtowerConstants.GET_CARD_DATA)
            {
                this.mainModel.cardsCache = this.payload;
            };
            this.coupler.receivedPayload(this.messageType, this.payload);
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.coupler.command
