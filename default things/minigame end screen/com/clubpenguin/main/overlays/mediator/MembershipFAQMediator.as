//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.MainModel;
    import flash.display.MovieClip;
    import com.clubpenguin.main.overlays.view.OverlayView;
    import org.osflash.signals.Signal;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import com.hurlant.crypto.hash.MD5;
    import flash.utils.ByteArray;
    import com.hurlant.util.Hex;

    public class MembershipFAQMediator extends Mediator 
    {

        private static const INDEX_FRAME:String = "index";
        private static const IGLOO_FRAME:String = "igloo";
        private static const CLOTHING_FRAME:String = "clothing";
        private static const PUFFLE_FRAME:String = "puffle";
        private static const GAME_FRAME:String = "game";
        private static const ACCESS_FRAME:String = "access";
        private static const EVENT_TYPE_ENCOUNTER:String = "enc";
        private static const EVENT_TYPE_BACK:String = "back";
        private static const EVENT_TYPE_BUY:String = "buy";
        private static const EVENT_TYPE_CLOSE:String = "cls";
        private static const TAG_INDEX:String = "exp_faqlist";
        private static const TAG_IGLOO:String = "exp_faqigloo";
        private static const TAG_CLOTHING:String = "exp_faqclothing";
        private static const TAG_PUFFLE:String = "exp_faqpuffle";
        private static const TAG_GAME:String = "exp_faqgames";
        private static const TAG_ACCESS:String = "exp_faqparties";

        private var _bridge:IAVMBridgeService;
        private var _model:MainModel;
        private var _view:MovieClip;
        private var _overlayView:OverlayView;
        private var _onClosed:Signal;
        private var _data:Object;
        private var _tag:String;
        private var _closeBtn:SimpleButton;
        private var _backBtn:SimpleButton;
        private var _buyMembershipBtn:SimpleButton;
        private var _igloo:SimpleButton;
        private var _game:SimpleButton;
        private var _puffle:SimpleButton;
        private var _clothing:SimpleButton;
        private var _access:SimpleButton;
        private var _viewingIndex:Boolean = true;


        public function setDependencies(mainModel:MainModel, view:MovieClip, overlayView:OverlayView, onClosed:Signal, data:Object):void
        {
            this._bridge = mainModel.getAVMBridge();
            this._model = mainModel;
            this._view = view;
            this._overlayView = overlayView;
            this._onClosed = onClosed;
            this._data = data;
            this._closeBtn = this._view.closeBtn;
            this._backBtn = this._view.backBtn;
            this._buyMembershipBtn = this._view.buyMembershipBtn;
            this._igloo = this._view.igloo;
            this._clothing = this._view.clothing;
            this._puffle = this._view.puffle;
            this._game = this._view.game;
            this._access = this._view.access;
            this._tag = TAG_INDEX;
            this._closeBtn.addEventListener(MouseEvent.MOUSE_UP, this.close);
            this._backBtn.addEventListener(MouseEvent.MOUSE_UP, this.back);
            this._buyMembershipBtn.addEventListener(MouseEvent.MOUSE_UP, this.membership);
            this._igloo.addEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._clothing.addEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._puffle.addEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._game.addEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._access.addEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._bridge.trackEvent(((EVENT_TYPE_ENCOUNTER + "_") + this._tag));
        }

        private function close(event:Event=null):void
        {
            this._bridge.trackEvent(((EVENT_TYPE_CLOSE + "_") + this._tag));
            this._closeBtn.removeEventListener(MouseEvent.MOUSE_UP, this.close);
            this._backBtn.removeEventListener(MouseEvent.MOUSE_UP, this.back);
            this._buyMembershipBtn.removeEventListener(MouseEvent.MOUSE_UP, this.membership);
            this._igloo.removeEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._clothing.removeEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._puffle.removeEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._game.removeEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._access.removeEventListener(MouseEvent.MOUSE_UP, this.changeState);
            this._onClosed.dispatch(this._overlayView);
        }

        private function back(event:Event):void
        {
            if (this._viewingIndex)
            {
                this.close();
            }
            else
            {
                this._bridge.trackEvent(((EVENT_TYPE_BACK + "_") + this._tag));
                this._view.gotoAndStop(INDEX_FRAME);
                this._viewingIndex = true;
                this._tag = TAG_INDEX;
            };
        }

        private function membership(event:Event):void
        {
            this._bridge.trackEvent(((EVENT_TYPE_BUY + "_") + this._tag));
            var lang:String = this._model.getEnvironmentData().language;
            var webTag:String = ("?membership_faq_" + lang);
            this.navigateToMembershipPage(webTag);
        }

        private function navigateToMembershipPage(webTag:String):void
        {
            var URL:String = this._model.pathsVO.getLinkPath("member_web");
            var hashedKey:String = this.hashActiveLoginKey(this._model.myPlayerVO.activeKey);
            var urlVars:URLVariables = new URLVariables();
            urlVars.tag = webTag;
            urlVars.player_id = this._model.myPlayerVO.player_id;
            urlVars.active_key = hashedKey;
            var request:URLRequest = new URLRequest(URL);
            request.method = URLRequestMethod.GET;
            request.data = urlVars;
            navigateToURL(request);
        }

        private function hashActiveLoginKey(key:String):String
        {
            var md5:MD5 = new MD5();
            var input:ByteArray = new ByteArray();
            input.writeUTFBytes(("(LHny:TyGynR" + key));
            var output:ByteArray = md5.hash(input);
            var hashedKey:String = Hex.fromArray(output);
            return (hashedKey);
        }

        private function changeState(event:Event):void
        {
            var newFrame:String;
            switch (event.target)
            {
                case this._igloo:
                    newFrame = IGLOO_FRAME;
                    this._tag = TAG_IGLOO;
                    break;
                case this._clothing:
                    newFrame = CLOTHING_FRAME;
                    this._tag = TAG_CLOTHING;
                    break;
                case this._puffle:
                    newFrame = PUFFLE_FRAME;
                    this._tag = TAG_PUFFLE;
                    break;
                case this._game:
                    newFrame = GAME_FRAME;
                    this._tag = TAG_GAME;
                    break;
                case this._access:
                    newFrame = ACCESS_FRAME;
                    this._tag = TAG_ACCESS;
                    break;
            };
            this._viewingIndex = false;
            this._view.gotoAndStop(newFrame);
            this._bridge.trackEvent(((EVENT_TYPE_ENCOUNTER + "_") + this._tag));
        }


    }
}//package com.clubpenguin.main.overlays.mediator
