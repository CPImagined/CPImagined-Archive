//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.PanelEffectController;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.state.StateConstants;
    import flash.events.MouseEvent;
    import com.greensock.TweenLite;
    import com.greensock.easing.Quint;

    public class PanelView extends EventDispatcher implements IPanel 
    {

        private static const SCROLL_CLIP:String = "scroll";
        private static const CONTENT_CLIP:String = "content";
        private static const TITLE_FIELD:String = "title";
        private static const TITLE_FIELD_SHADOW:String = "titleShadow";
        private static const SUB_TITLE_FIELD:String = "subTitle";
        private static const REDEEM_BTN:String = "haveCodeBtn";
        private static const REDEEM_FIELD:String = "code";
        private static const BUY_BTN:String = "buyPowercardsBtn";
        private static const BUY_FIELD:String = "powercards";
        private static const MEMBERS_FIELD:String = "membersOnly";
        private static const PANEL_MASK:String = "panelMask";

        private var _skin:MovieClip;
        private var _currentState:String;
        private var _tweenDuration:Number;
        private var _maskOffset:Number;
        private var _canClose:Boolean;
        private var _firstTransition:Boolean;
        private var _localeTextReplacer:ILocaleTextReplacer;
        public var name:String;

        public function PanelView(name:String, skin:MovieClip, currentState:String, localeTextReplacer:ILocaleTextReplacer, tweenDuration:Number=1, canClose:Boolean=true)
        {
            this.name = name;
            this._skin = skin;
            this._currentState = currentState;
            this._tweenDuration = tweenDuration;
            this._canClose = canClose;
            this._firstTransition = true;
            this._localeTextReplacer = localeTextReplacer;
            this._maskOffset = (skin[PANEL_MASK].x - skin[SCROLL_CLIP].x);
            this._skin[SCROLL_CLIP].mouseChildren = false;
            if (((currentState == PanelEffectController.PANEL_CLOSED) && (canClose)))
            {
                this._skin[SCROLL_CLIP].x = 540;
                this._skin[CONTENT_CLIP].x = -50;
                this._skin[PANEL_MASK].x = (this._skin[SCROLL_CLIP].x + this._maskOffset);
            };
        }

        public function localize():void
        {
            switch (this.name)
            {
                case StateConstants.PROGRESS_STATE:
                    this._localeTextReplacer.replaceText(this._skin[SCROLL_CLIP][TITLE_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][TITLE_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][TITLE_FIELD_SHADOW], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.PROGRESS_TITLE]);
                    break;
                case StateConstants.CARD_STATE:
                    this._localeTextReplacer.replaceText(this._skin[SCROLL_CLIP][TITLE_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.CARDS_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][TITLE_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.CARDS_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][TITLE_FIELD_SHADOW], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.CARDS_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][REDEEM_BTN][REDEEM_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.CARDS_REDEEM_BUTTON_TEXT]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][BUY_BTN][BUY_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.CARDS_BUY_BUTTON_TEXT]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][MEMBERS_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.CARDS_MEMBERS_ONLY_TEXT]);
                    break;
                case StateConstants.SNOW_STATE:
                    this._localeTextReplacer.replaceText(this._skin[SCROLL_CLIP][TITLE_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][TITLE_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][TITLE_FIELD_SHADOW], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_TITLE]);
                    this._localeTextReplacer.replaceText(this._skin[CONTENT_CLIP][SUB_TITLE_FIELD], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.STORY_SUB_TITLE]);
                    break;
            };
        }

        public function enable():void
        {
            this._skin[SCROLL_CLIP].buttonMode = true;
            this._skin[SCROLL_CLIP].addEventListener(MouseEvent.CLICK, dispatchEvent);
        }

        public function disable():void
        {
            this._skin[SCROLL_CLIP].buttonMode = false;
            this._skin[SCROLL_CLIP].removeEventListener(MouseEvent.CLICK, dispatchEvent);
        }

        public function show():void
        {
            var tweenDuration:Number = ((this._firstTransition) ? 0 : this._tweenDuration);
            TweenLite.to(this._skin[SCROLL_CLIP], tweenDuration, {
                "x":0,
                "ease":Quint.easeOut,
                "onUpdate":this.onTransitionUpdate
            });
            this._firstTransition = false;
        }

        public function hide():void
        {
            var tweenDuration:Number = ((this._firstTransition) ? 0 : this._tweenDuration);
            TweenLite.to(this._skin[SCROLL_CLIP], tweenDuration, {
                "x":540,
                "ease":Quint.easeOut,
                "onUpdate":this.onTransitionUpdate
            });
            this._firstTransition = false;
        }

        private function onTransitionUpdate():void
        {
            this._skin[PANEL_MASK].x = (this._skin[SCROLL_CLIP].x + this._maskOffset);
        }

        public function destroy():void
        {
            TweenLite.killTweensOf(this._skin[SCROLL_CLIP]);
            this.disable();
            this._skin = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
