//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.ElementLevelVO;
    import flash.display.DisplayObject;
    import fl.motion.Color;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;
    import flash.events.MouseEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.NinjaModuleConstants;

    public class ProgressView extends EventDispatcher 
    {

        protected static const NOT_PLAYED_FRAME:String = "notYetPlayed";
        protected static const PROGRESS_FRAME:String = "progress";
        protected static const PROGRESS_DETAILS_FRAME:String = "progressDetail";
        private static const FINAL_CHALLENGE_FRAME:String = "finalChallenge";
        protected static const MASTERED_FRAME:String = "mastered";
        private static const LOGO_CLIP:String = "logoClip";
        protected static const MY_PROGRESS_BTN:String = "myProgressBtn";
        private static const MY_PROGRESS_BTN_TEXT:String = "progress";
        protected static const GO_BACK_BTN:String = "goBackBtn";
        protected static const GO_BACK_BTN_TEXT:String = "back";
        private static const BODY_TEXT:String = "bodyText";
        protected static const PROGRESS_TEXT:String = "progressText";
        private static const PROGRESS_ITEM:String = "progressItem";
        private static const PROGRESS_BAR:String = "progressBar";
        private static const PERCENT_TEXT:String = "percent";
        private static const CORNER_FLIP_BTN:String = "cornerFlipBtn";

        protected var _skin:MovieClip;
        private var _gameType:String;
        protected var _data:ElementLevelVO;
        private var _bodyText:DisplayObject;
        private var _cornerFlipBtn:MovieClip;
        private var _progressItem:MovieClip;
        private var _progressBar:MovieClip;
        private var _percent:DisplayObject;
        protected var _progressText:DisplayObject;
        private var _progressBtn:MovieClip;
        protected var _goBackBtn:MovieClip;
        protected var _enabledColor:Color;
        protected var _allowedFrames:Array;
        protected var _allowedFrameIndex:int;
        protected var _localeTextReplacer:ILocaleTextReplacer;
        private var _localizationSet:Boolean = false;

        public function ProgressView(skin:MovieClip, gameType:String, localeTextReplacer:ILocaleTextReplacer)
        {
            this._skin = skin;
            this._skin.visible = false;
            this._gameType = gameType;
            this._localeTextReplacer = localeTextReplacer;
            this._enabledColor = new Color();
            this._enabledColor.setTint(0, 0);
            this._allowedFrames = new Array();
            this._cornerFlipBtn = skin[CORNER_FLIP_BTN];
            this._cornerFlipBtn.gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
        }

        public function localize():void
        {
            this._skin[LOGO_CLIP].gotoAndStop(LocalizationVO.LANGUAGE_FRAME[LocalizationVO.CURRENT_LANGUAGE]);
            this._localizationSet = true;
            this.setView(this._allowedFrames[this._allowedFrameIndex]);
        }

        public function update(data:ElementLevelVO):void
        {
            this._data = data;
            this.setAllowedFrames();
            this.setView(this._allowedFrames[this._allowedFrameIndex]);
        }

        public function show():void
        {
            this._skin.visible = true;
            this.addEventListeners();
        }

        public function hide():void
        {
            this.removeEventListeners();
        }

        protected function addEventListeners():void
        {
            this._cornerFlipBtn.buttonMode = true;
            this._cornerFlipBtn.addEventListener(MouseEvent.CLICK, this.onCornerClick);
            this._cornerFlipBtn.addEventListener(MouseEvent.MOUSE_OVER, this.onCornerMouseOver);
            this._cornerFlipBtn.addEventListener(MouseEvent.MOUSE_OUT, this.onCornerMouseOut);
        }

        protected function removeEventListeners():void
        {
            this._cornerFlipBtn.buttonMode = false;
            this._cornerFlipBtn.removeEventListener(MouseEvent.CLICK, this.onCornerClick);
            this._cornerFlipBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.onCornerMouseOver);
            this._cornerFlipBtn.removeEventListener(MouseEvent.MOUSE_OUT, this.onCornerMouseOut);
        }

        protected function setAllowedFrames():void
        {
            this._allowedFrameIndex = 0;
            if (((this._data.level == NinjaConstants.START_LEVEL) && (this._data.progressPct == 0)))
            {
                this._allowedFrames = [NOT_PLAYED_FRAME, PROGRESS_DETAILS_FRAME];
            }
            else
            {
                if (((this._data.level >= NinjaConstants.START_LEVEL) && (this._data.level < this._data.finalChallengeLevel)))
                {
                    this._allowedFrames = [PROGRESS_FRAME, PROGRESS_DETAILS_FRAME];
                }
                else
                {
                    if (this._data.level == this._data.finalChallengeLevel)
                    {
                        this._allowedFrames = [FINAL_CHALLENGE_FRAME, PROGRESS_DETAILS_FRAME];
                    }
                    else
                    {
                        if (this._data.level == this._data.maxLevel)
                        {
                            this._allowedFrames = [MASTERED_FRAME, PROGRESS_DETAILS_FRAME];
                        };
                    };
                };
            };
        }

        private function setView(state:String):void
        {
            if (!this._localizationSet)
            {
                return;
            };
            this._skin.gotoAndStop(state);
            this.addEventListeners();
            switch (state)
            {
                case NOT_PLAYED_FRAME:
                    this.setNotPlayedFrame();
                    break;
                case PROGRESS_FRAME:
                    this.setProgressFrame();
                    break;
                case PROGRESS_DETAILS_FRAME:
                    this.setProgressDetailsFrame();
                    break;
                case FINAL_CHALLENGE_FRAME:
                    this.setFinalChallengeFrame();
                    break;
                case MASTERED_FRAME:
                    this.setMasteredFrame();
                    break;
            };
        }

        private function setNotPlayedFrame():void
        {
            this._bodyText = this._skin[BODY_TEXT];
            switch (this._gameType)
            {
                case NinjaModuleConstants.CARD_JITSU_VANILLA:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BEGIN_VANILLA]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_FIRE:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BEGIN_FIRE]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_WATER:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BEGIN_WATER]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_SNOW:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BEGIN_SNOW]);
                    break;
				case NinjaModuleConstants.CARD_JITSU_SHADOW:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BEGIN_SHADOW]);
                    break;
            };
            this._progressBtn = this._skin[MY_PROGRESS_BTN];
            this._localeTextReplacer.replaceText(this._progressBtn[MY_PROGRESS_BTN_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BUTTON_TEXT]);
        }

        private function setProgressFrame():void
        {
            var totalRewards:Number = NinjaConstants.TOTAL_REWARDS[this._data.type];
            var rewardsUnlocked:Number = ((this._data.level <= totalRewards) ? this._data.level : totalRewards);
            this._progressText = this._skin[PROGRESS_TEXT];
            this._localeTextReplacer.replaceText(this._progressText, ((rewardsUnlocked + "/") + totalRewards));
            this._bodyText = this._skin[BODY_TEXT];
            this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_NEXT_REWARD]);
            this._progressBar = this._skin[PROGRESS_BAR];
            this._progressBar.gotoAndStop(this._data.progressPct);
            this._percent = this._progressBar[PERCENT_TEXT];
            this._localeTextReplacer.replaceText(this._percent, (this._data.progressPct + "%"));
            var stopFrame:int = ((this._data.level < this._data.maxLevel) ? this._data.level : this._data.maxLevel);
            stopFrame++;
            stopFrame = ((stopFrame == 0) ? 1 : stopFrame);
            this._progressItem = this._skin[PROGRESS_ITEM];
            this._progressItem.gotoAndStop(stopFrame);
            this._progressBtn = this._skin[MY_PROGRESS_BTN];
            this._localeTextReplacer.replaceText(this._progressBtn[MY_PROGRESS_BTN_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BUTTON_TEXT]);
        }

        protected function setProgressDetailsFrame():void
        {
            var currentLevel:int;
            var totalRewards:Number = NinjaConstants.TOTAL_REWARDS[this._data.type];
            var rewardsUnlocked:Number = ((this._data.level <= totalRewards) ? this._data.level : totalRewards);
            this._progressText = this._skin[PROGRESS_TEXT];
            this._localeTextReplacer.replaceText(this._progressText, ((rewardsUnlocked + "/") + totalRewards));
            if (this._data.level > 0)
            {
                currentLevel = 1;
                while (currentLevel <= this._data.level)
                {
                    if (this._skin[("level" + currentLevel)] != undefined)
                    {
                        this._skin[("level" + currentLevel)].transform.colorTransform = this._enabledColor;
                    };
                    currentLevel++;
                };
            };
            this._goBackBtn = this._skin[GO_BACK_BTN];
            this._localeTextReplacer.replaceText(this._goBackBtn[GO_BACK_BTN_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_GO_BACK_BUTTON_TEXT]);
        }

        private function setFinalChallengeFrame():void
        {
            this._bodyText = this._skin[BODY_TEXT];
            switch (this._gameType)
            {
                case NinjaModuleConstants.CARD_JITSU_VANILLA:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_CHALLENGE_SENSEI_VANILLA]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_FIRE:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_CHALLENGE_SENSEI_FIRE]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_WATER:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_CHALLENGE_SENSEI_WATER]);
                    break;
            };
            this._progressBtn = this._skin[MY_PROGRESS_BTN];
            this._localeTextReplacer.replaceText(this._progressBtn[MY_PROGRESS_BTN_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BUTTON_TEXT]);
        }

        private function setMasteredFrame():void
        {
            this._bodyText = this._skin[BODY_TEXT];
            switch (this._gameType)
            {
                case NinjaModuleConstants.CARD_JITSU_VANILLA:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_COMPLETE_VANILLA]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_FIRE:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_COMPLETE_FIRE]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_WATER:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_COMPLETE_WATER]);
                    break;
                case NinjaModuleConstants.CARD_JITSU_SNOW:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_COMPLETE_SNOW]);
                    break;
				case NinjaModuleConstants.CARD_JITSU_SHADOW:
                    this._localeTextReplacer.replaceText(this._bodyText, LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_COMPLETE_SHADOW]);
                    break;
            };
            this._progressBtn = this._skin[MY_PROGRESS_BTN];
            this._localeTextReplacer.replaceText(this._progressBtn[MY_PROGRESS_BTN_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_BUTTON_TEXT]);
        }

        private function onCornerClick(event:MouseEvent):void
        {
            this._allowedFrameIndex++;
            if (this._allowedFrameIndex > (this._allowedFrames.length - 1))
            {
                this._allowedFrameIndex = 0;
            };
            this.setView(this._allowedFrames[this._allowedFrameIndex]);
        }

        private function onCornerMouseOver(event:MouseEvent):void
        {
            this._cornerFlipBtn.gotoAndStop(NinjaConstants.BUTTON_OVER_FRAME);
        }

        private function onCornerMouseOut(event:MouseEvent):void
        {
            this._cornerFlipBtn.gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
        }

        public function destroy():void
        {
            this.removeEventListeners();
            this._data.destroy();
            this._data = null;
            this._skin;
            this._bodyText;
            this._cornerFlipBtn;
            this._progressItem;
            this._progressBar;
            this._percent;
            this._progressText;
            this._progressBtn;
            this._goBackBtn = null;
            this._allowedFrames = [];
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
