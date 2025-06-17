//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.endscreens.view.CoinsView;
    import com.clubpenguin.endscreens.model.MiniGameEndScreensModel;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;

    public class CoinsViewMediator extends Mediator 
    {

        [Inject]
        public var view:CoinsView;
        [Inject]
        public var model:MiniGameEndScreensModel;
        [Inject]
        public var localizer:ILocalizationManager;


        override public function onRegister():void
        {
            this.view.initView(this, this.localizer);
            this.view.onCompleted.addOnce(this.onViewComplete);
        }

        private function onViewComplete():void
        {
            this.view.setValues(this.model.coinsEarnedInSession, this.model.playerTotalCoins, this.model.isdoubleCoins());
        }


    }
}//package com.clubpenguin.endscreens.mediator
