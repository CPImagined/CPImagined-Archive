//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.controller
{
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.endscreens.MiniGameEndScreensContext;
    import com.clubpenguin.endscreens.model.MiniGameEndScreensModel;
    import com.clubpenguin.endscreens.view.MiniGameEndScreensView;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.endscreens.view.CoinsView;
    import com.clubpenguin.endscreens.view.ScrollingStampsView;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.endscreens.model.StampVO;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;

    public class MiniGameEndScreensController 
    {

        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var context:MiniGameEndScreensContext;
        [Inject]
        public var model:MiniGameEndScreensModel;
        [Inject]
        public var view:MiniGameEndScreensView;
        [Inject]
        public var closeSignal:CloseModuleSignal;
        private var _showCoins:Boolean = false;
        private var _coinsView:CoinsView;
        private var _showStamps:Boolean = false;
        private var _scrollingStampsView:ScrollingStampsView;


        public function init():void
        {
            this.model.update.add(this.modelUpdated);
            var environmentData:EnvironmentDataVO = this.mainModel.getEnvironmentData();
            StampVO.STAMP_LOADER_DATA[StampVO.ICON_URL] = (environmentData.contentPath + StampVO.STAMP_SUBDIRECTORY);
        }

        private function modelUpdated():void
        {
            this.context.joinRoomSignal.dispatch();
            if (((this._coinsView == null) && (this._scrollingStampsView == null)))
            {
                this.addOptionalViews();
            };
        }

        private function addOptionalViews():void
        {
            if (((this.model.gameHasStamps()) || (this.model.gameWithStamps)))
            {
                this.setupScrollingStampsView(this.model.stamps);
            };
            if (!this.model.isCardJitsu)
            {
                this.setupCoinsView(this.model.coinsEarnedInSession, this.model.playerTotalCoins, this.checkAllStampsEarned());
            };
            this.setupMain();
        }

        private function setupCoinsView(newCoins:int, totalCoins:int, isDouble:Boolean):void
        {
            this._showCoins = true;
            this._coinsView = new CoinsView();
            this._coinsView.setValues(newCoins, totalCoins, isDouble);
            this.context.contextView.addChild(this._coinsView);
        }

        private function setupScrollingStampsView(stamps:Array):void
        {
            this._showStamps = true;
            this._scrollingStampsView = new ScrollingStampsView();
            this._scrollingStampsView.setStamps(stamps);
            this.context.contextView.addChild(this._scrollingStampsView);
        }

        private function checkAllStampsEarned():Boolean
        {
            if (((this.model.gameHasStamps()) && (this.model.numberOfStampsEarnedForGame == this.model.numberOfGameStamps)))
            {
                return (true);
            };
            return (false);
        }

        private function setupMain():void
        {
            if (((this._showCoins) && (this._showStamps)))
            {
                this.view.showFrame(MiniGameEndScreensConstants.FRAME_COINS_STAMPS);
                this._coinsView.showFrame(MiniGameEndScreensConstants.FRAME_COINS_STAMPS);
                this._scrollingStampsView.showFrame(MiniGameEndScreensConstants.FRAME_COINS_STAMPS);
                this.context.contextView.swapChildren(this._scrollingStampsView, this._coinsView);
            }
            else
            {
                if (this._showCoins)
                {
                    this.view.showFrame(MiniGameEndScreensConstants.FRAME_COINS);
                    this._coinsView.showFrame(MiniGameEndScreensConstants.FRAME_COINS);
                }
                else
                {
                    this.view.showFrame(MiniGameEndScreensConstants.FRAME_STAMPS);
                    this._scrollingStampsView.showFrame(MiniGameEndScreensConstants.FRAME_STAMPS);
                };
            };
        }


    }
}//package com.clubpenguin.endscreens.controller
