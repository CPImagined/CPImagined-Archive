//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.view
{
    import com.clubpenguin.lib.view.BaseEmbeddedAssetView;
    import com.clubpenguin.endscreens.mediator.CoinsViewMediator;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.media.SoundChannel;
    import flash.media.Sound;
    import com.clubpenguin.minigame_end_screens.sfx.CoinSound;
    import com.clubpenguin.minigame_end_screens.sfx.CoinSoundDoubleCoins;
    import flash.utils.Timer;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import flash.display.MovieClip;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.ILocalTextComponent;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.display.DisplayObject;

    public class CoinsView extends BaseEmbeddedAssetView 
    {

        private const TALLY_MAX:int = 15;
        private const TALLY_DELAY:int = 50;
        private const ANIM_END_LABEL:String = "end";

        private var _mediator:CoinsViewMediator;
        private var _localizer:ILocalizationManager;
        private var _newCoins:int;
        private var _totalCoins:int;
        private var _isDouble:Boolean;
        private var _soundChannel:SoundChannel;
        private var _sfxCoinReward:Sound = new CoinSound();
        private var _sfcCoinRewardDouble:Sound = new CoinSoundDoubleCoins();
        private var _frame:String;
        private var _coinTallyTimer:Timer;
        private var _tallyCount:int = 0;

        public function CoinsView()
        {
            super(EndGameViewAssets.CoinSkin, MiniGameEndScreensConstants.SKIN_INSTANCE_NAME_COINS);
            instance.visible = false;
        }

        public function initView(mediator:CoinsViewMediator, localizer:ILocalizationManager):void
        {
            this._mediator = mediator;
            this._localizer = localizer;
        }

        public function setValues(newCoins:int, totalCoins:int, isDouble:Boolean):void
        {
            this._newCoins = newCoins;
            this._totalCoins = totalCoins;
            this._isDouble = isDouble;
        }

        public function showFrame(frame:String):void
        {
            this._frame = frame;
            if (view == null)
            {
                onCompleted.addOnce(this.updateFrameAndText);
            }
            else
            {
                this.updateFrameAndText();
            };
        }

        private function updateFrameAndText():void
        {
            (view as MovieClip).gotoAndStop(this._frame);
            instance.visible = true;
            this.updateText();
            this.beginCoinTally();
            this.updateClips();
        }

        private function updateText():void
        {
            var newCoinsText:String = this._localizer.getLocalizedString(MiniGameEndScreensConstants.TOKEN_NEW_COINS);
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.COINS_NEW_COINS_TEXT]).localTextField, newCoinsText);
            var totalCoinsText:String = this._localizer.getLocalizedString(MiniGameEndScreensConstants.TOKEN_TOTAL_COINS).replace(MiniGameEndScreensConstants.TEXT_REPLACEMENT_IDENTIFIER, this._totalCoins);
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.COINS_TOTAL_COINS_TEXT]).localTextField, totalCoinsText);
            this.adjustCoinAmountTextLocation(this._newCoins);
        }

        private function beginCoinTally():void
        {
            this._coinTallyTimer = new Timer(this.TALLY_DELAY);
            this._coinTallyTimer.addEventListener(TimerEvent.TIMER, this.tally);
            this._coinTallyTimer.start();
        }

        private function tally(event:Event=null):void
        {
            var newCoinsAmountText:String;
            var tallycharacter:String;
            this._tallyCount++;
            if (this._tallyCount == this.TALLY_MAX)
            {
                this._coinTallyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.tally);
                this._coinTallyTimer.stop();
                newCoinsAmountText = String(this._newCoins);
                if (this._isDouble)
                {
                    this._soundChannel = this._sfcCoinRewardDouble.play();
                }
                else
                {
                    this._soundChannel = this._sfxCoinReward.play();
                };
            }
            else
            {
                tallycharacter = String(this._tallyCount);
                tallycharacter = tallycharacter.charAt((tallycharacter.length - 1));
                newCoinsAmountText = (((tallycharacter + tallycharacter) + tallycharacter) + tallycharacter);
            };
            LocalTextProxy.localText.setText(ILocalTextComponent(view[MiniGameEndScreensConstants.COINS_NEW_COINS_AMOUNT_TEXT]).localTextField, newCoinsAmountText);
        }

        private function updateClips():void
        {
            var coinArtClip:MovieClip = view[MiniGameEndScreensConstants.COINS_COIN_ART];
            if (this._isDouble)
            {
                coinArtClip.gotoAndStop(MiniGameEndScreensConstants.COINS_AMOUNT_DOUBLE);
                (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_MULTIPLIER_1] as MovieClip).play();
                (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_MULTIPLIER_2] as MovieClip).play();
            }
            else
            {
                coinArtClip.gotoAndStop(MiniGameEndScreensConstants.COINS_AMOUNT_REGULAR);
            };
            (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_COIN_1] as MovieClip).gotoAndStop(this.ANIM_END_LABEL);
            (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_COIN_2] as MovieClip).gotoAndStop(this.ANIM_END_LABEL);
            (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_COIN_3] as MovieClip).gotoAndStop(this.ANIM_END_LABEL);
            (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_COIN_4] as MovieClip).gotoAndStop(this.ANIM_END_LABEL);
            (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_FRAME_1] as MovieClip).gotoAndStop(this.ANIM_END_LABEL);
            (coinArtClip[MiniGameEndScreensConstants.COINS_COIN_ART_FRAME_2] as MovieClip).gotoAndStop(this.ANIM_END_LABEL);
        }

        private function adjustCoinAmountTextLocation(number:int):void
        {
            if (number < 10)
            {
                DisplayObject(view[MiniGameEndScreensConstants.COINS_NEW_COINS_AMOUNT_TEXT]).x = (DisplayObject(view[MiniGameEndScreensConstants.COINS_NEW_COINS_AMOUNT_TEXT]).x - 12);
            }
            else
            {
                if (number < 100)
                {
                    DisplayObject(view[MiniGameEndScreensConstants.COINS_NEW_COINS_AMOUNT_TEXT]).x = (DisplayObject(view[MiniGameEndScreensConstants.COINS_NEW_COINS_AMOUNT_TEXT]).x - 8);
                }
                else
                {
                    if (number < 1000)
                    {
                        DisplayObject(view[MiniGameEndScreensConstants.COINS_NEW_COINS_AMOUNT_TEXT]).x = (DisplayObject(view[MiniGameEndScreensConstants.COINS_NEW_COINS_AMOUNT_TEXT]).x - 4);
                    };
                };
            };
        }


    }
}//package com.clubpenguin.endscreens.view
