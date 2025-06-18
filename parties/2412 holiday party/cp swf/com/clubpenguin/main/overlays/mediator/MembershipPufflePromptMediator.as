//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.mediator
{
    import com.clubpenguin.main.signal.SignalBus;
    import flash.display.SimpleButton;
    import com.clubpenguin.lib.util.Log;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;

    public class MembershipPufflePromptMediator extends MembershipPromptMediator 
    {

        private static const ADOPT_RED:String = "adopt_red";
        private static const ADOPT_BLUE:String = "adopt_blue";
        private static const ADOPT_NEITHER:String = "close";
        private static const BI_OOPS_CONTEXT_PUFFLE_GENERIC:String = "oops_puffle_adopt";

        [Inject]
        public var signalBus:SignalBus;
        private var _adoptRedButton:SimpleButton;
        private var _adoptBlueButton:SimpleButton;

        public function MembershipPufflePromptMediator()
        {
            Log.debug("MembershipPufflePromptMediator()");
        }

        override protected function setupButtons():void
        {
            Log.debug("\tMembershipPufflePromptMediator.setupButtons()");
            super.setupButtons();
            this._adoptRedButton = _view.adoptRedBtn;
            if (this._adoptRedButton)
            {
                this._adoptRedButton.addEventListener(MouseEvent.CLICK, this.onAdoptRed);
            };
            this._adoptBlueButton = _view.adoptBlueBtn;
            if (this._adoptBlueButton)
            {
                this._adoptBlueButton.addEventListener(MouseEvent.CLICK, this.onAdoptBlue);
            };
        }

        private function onAdoptRed(event:MouseEvent):void
        {
            Log.debug("\tMembershipPufflePromptMediator.onAdoptRed()");
            var puffleVO:PuffleVO = new PuffleVO();
            puffleVO.type = PuffleTypeEnum.RED;
            this.signalBus.highlightPuffle.dispatch(puffleVO);
            this.adoptButtonBI(ADOPT_RED);
            super.onCloseView(event);
        }

        private function onAdoptBlue(event:MouseEvent):void
        {
            Log.debug("\tMembershipPufflePromptMediator.onAdoptBlue()");
            var puffleVO:PuffleVO = new PuffleVO();
            puffleVO.type = PuffleTypeEnum.BLUE;
            this.signalBus.highlightPuffle.dispatch(puffleVO);
            this.adoptButtonBI(ADOPT_BLUE);
            super.onCloseView(event);
        }

        private function adoptButtonBI(action:String):void
        {
        }

        override protected function onCloseView(event:MouseEvent=null):void
        {
            this._adoptRedButton = _view.adoptRedBtn;
            if (this._adoptRedButton)
            {
                this._adoptRedButton.removeEventListener(MouseEvent.CLICK, this.onAdoptRed);
            };
            this._adoptBlueButton = _view.adoptBlueBtn;
            if (this._adoptBlueButton)
            {
                this._adoptBlueButton.removeEventListener(MouseEvent.CLICK, this.onAdoptBlue);
            };
            this.adoptButtonBI(ADOPT_NEITHER);
            super.onCloseView(event);
        }


    }
}//package com.clubpenguin.main.overlays.mediator
