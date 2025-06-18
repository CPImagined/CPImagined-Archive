//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.view
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.NinjaConstants;
    import com.clubpenguin.cardjitsu.ninjaprogress.model.vo.LocalizationVO;
    import flash.events.MouseEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.OverlayEvent;

    public class OverlayView extends EventDispatcher 
    {

        private static const TITLE_TEXT_CONTAINER:String = "titleTextContainer";
        private static const TITLE_TEXT:String = "titleText";
        private static const BODY_TEXT:String = "bodyText";
        private static const NOT_NOW_BTN:String = "notNowBtn";
        private static const NOT_NOW_TEXT:String = "notNowText";
        private static const LOGOUT_BTN:String = "logoutBtn";
        private static const LOGOUT_TEXT:String = "logoutText";
        private static const CLOSE_BTN:String = "closeBtn";
        private static const UIO_LOGO:String = "uioLogo";

        private var _skin:MovieClip;
        private var _localeTextReplacer:ILocaleTextReplacer;

        public function OverlayView(skin:MovieClip, localeTextReplacer:ILocaleTextReplacer)
        {
            this._skin = skin;
            this._skin[NOT_NOW_BTN].gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
            this._skin[NOT_NOW_BTN].buttonMode = true;
            this._skin[NOT_NOW_BTN].mouseChildren = false;
            this._skin[LOGOUT_BTN].gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
            this._skin[LOGOUT_BTN].buttonMode = true;
            this._skin[LOGOUT_BTN].mouseChildren = false;
            this._skin.visible = false;
            this._localeTextReplacer = localeTextReplacer;
        }

        public function localize():void
        {
            this._localeTextReplacer.replaceText(this._skin[TITLE_TEXT_CONTAINER][TITLE_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.REDEEM_TITLE]);
            this._localeTextReplacer.replaceText(this._skin[BODY_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.REDEEM_BODY]);
            this._localeTextReplacer.replaceText(this._skin[NOT_NOW_BTN][NOT_NOW_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.REDEEM_NOT_NOW]);
            this._localeTextReplacer.replaceText(this._skin[LOGOUT_BTN][LOGOUT_TEXT], LocalizationVO.LOCALIZATION_TOKENS[LocalizationVO.REDEEM_LOG_OUT]);
            this._skin[UIO_LOGO].gotoAndStop(LocalizationVO.LANGUAGE_FRAME[LocalizationVO.CURRENT_LANGUAGE]);
        }

        public function show():void
        {
            this._skin.visible = true;
            this.addEventListeners();
        }

        public function hide():void
        {
            this._skin.visible = false;
            this.removeEventListeners();
        }

        public function addEventListeners():void
        {
            this._skin[CLOSE_BTN].addEventListener(MouseEvent.CLICK, this.onCloseBtnClick);
            this._skin[NOT_NOW_BTN].addEventListener(MouseEvent.CLICK, this.onCloseBtnClick);
            this._skin[NOT_NOW_BTN].addEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOver);
            this._skin[NOT_NOW_BTN].addEventListener(MouseEvent.MOUSE_DOWN, this.onBtnMouseDown);
            this._skin[NOT_NOW_BTN].addEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOut);
            this._skin[LOGOUT_BTN].addEventListener(MouseEvent.CLICK, this.onLogoutBtnClick);
            this._skin[LOGOUT_BTN].addEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOver);
            this._skin[LOGOUT_BTN].addEventListener(MouseEvent.MOUSE_DOWN, this.onBtnMouseDown);
            this._skin[LOGOUT_BTN].addEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOut);
        }

        public function removeEventListeners():void
        {
            this._skin[CLOSE_BTN].removeEventListener(MouseEvent.CLICK, this.onCloseBtnClick);
            this._skin[NOT_NOW_BTN].removeEventListener(MouseEvent.CLICK, this.onCloseBtnClick);
            this._skin[NOT_NOW_BTN].removeEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOver);
            this._skin[NOT_NOW_BTN].removeEventListener(MouseEvent.MOUSE_DOWN, this.onBtnMouseDown);
            this._skin[NOT_NOW_BTN].removeEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOut);
            this._skin[LOGOUT_BTN].removeEventListener(MouseEvent.CLICK, this.onLogoutBtnClick);
            this._skin[LOGOUT_BTN].removeEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOver);
            this._skin[LOGOUT_BTN].removeEventListener(MouseEvent.MOUSE_DOWN, this.onBtnMouseDown);
            this._skin[LOGOUT_BTN].removeEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOut);
        }

        public function onCloseBtnClick(event:MouseEvent):void
        {
            dispatchEvent(new OverlayEvent(OverlayEvent.CLOSE));
        }

        public function onLogoutBtnClick(event:MouseEvent):void
        {
            dispatchEvent(new OverlayEvent(OverlayEvent.LOGOUT));
        }

        public function onBtnMouseOver(event:MouseEvent):void
        {
            event.currentTarget.gotoAndStop(NinjaConstants.BUTTON_OVER_FRAME);
        }

        public function onBtnMouseDown(event:MouseEvent):void
        {
            event.currentTarget.gotoAndStop(NinjaConstants.BUTTON_DOWN_FRAME);
        }

        public function onBtnMouseOut(event:MouseEvent):void
        {
            event.currentTarget.gotoAndStop(NinjaConstants.BUTTON_UP_FRAME);
        }

        public function destroy():void
        {
            this.removeEventListeners();
            this._skin = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.view
