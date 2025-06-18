//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.model.NinjaModuleConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;

    public class SnowProgressView extends ProgressView 
    {

        private static const PROGRESS_ITEMS:String = "progressItems";
        private static const SCROLL_PANE:String = "scrollPane";

        private var _scrollPane:*;
        private var _progressItems:MovieClip;

        public function SnowProgressView(skin:MovieClip, localeTextReplacer:ILocaleTextReplacer)
        {
            super(skin, NinjaModuleConstants.CARD_JITSU_SNOW, localeTextReplacer);
        }

        override protected function setAllowedFrames():void
        {
            _allowedFrameIndex = 0;
            if (((_data.level == NinjaConstants.START_LEVEL) && (_data.progressPct == 0)))
            {
                _allowedFrames = [NOT_PLAYED_FRAME, PROGRESS_DETAILS_FRAME];
            }
            else
            {
                if (((_data.level >= NinjaConstants.START_LEVEL) && (_data.level < _data.maxLevel)))
                {
                    _allowedFrames = [PROGRESS_FRAME, PROGRESS_DETAILS_FRAME];
                }
                else
                {
                    if (_data.level == _data.maxLevel)
                    {
                        _allowedFrames = [MASTERED_FRAME, PROGRESS_DETAILS_FRAME];
                    };
                };
            };
        }

        override protected function setProgressDetailsFrame():void
        {
            var currentLevel:int;
            var totalRewards:Number = Number(NinjaConstants.TOTAL_REWARDS[_data.type]);
            var rewardsUnlocked:Number = ((_data.level <= totalRewards) ? _data.level : totalRewards);
            _progressText = _skin[PROGRESS_TEXT];
            _localeTextReplacer.replaceText(_progressText, ((rewardsUnlocked + "/") + totalRewards));
            this._progressItems = _skin[PROGRESS_ITEMS];
            this._scrollPane = _skin[SCROLL_PANE];
            this._scrollPane["init"].call(null, this._progressItems, 112.95, 131.2);
            if (_data.level > 0)
            {
                currentLevel = 1;
                while (currentLevel <= _data.level)
                {
                    if (this._progressItems[("level" + currentLevel)] != undefined)
                    {
                        this._progressItems[("level" + currentLevel)].transform.colorTransform = _enabledColor;
                    };
                    currentLevel++;
                };
            };
            _goBackBtn = _skin[GO_BACK_BTN];
            _localeTextReplacer.replaceText(_goBackBtn[GO_BACK_BTN_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_GO_BACK_BUTTON_TEXT]);
        }

        override public function destroy():void
        {
            this._scrollPane;
            this._progressItems = null;
            super.destroy();
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
