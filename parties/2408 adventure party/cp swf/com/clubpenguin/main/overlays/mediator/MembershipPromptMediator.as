//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.overlays.mediator
{
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.services.socket.IConnection;
    import flash.display.MovieClip;
    import com.clubpenguin.main.overlays.view.OverlayView;
    import org.osflash.signals.Signal;
    import flash.display.SimpleButton;
    import flash.utils.getTimer;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.navigateToURL;
    import com.hurlant.crypto.hash.MD5;
    import flash.utils.ByteArray;
    import com.hurlant.util.Hex;
    import flash.external.ExternalInterface;

    public class MembershipPromptMediator 
    {

        private static const EVENT_TYPE_ENCOUNTER:String = "enc";
        private static const EVENT_TYPE_BUY:String = "buy";
        private static const EVENT_TYPE_CLOSE:String = "cls";
        private static const DIMG_BI_CONTEXT:String = "oops_message";

        [Inject]
        public var dimgTracker:Tracker;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var model:MainModel;
        [Inject]
        public var connection:IConnection;
        protected var _view:MovieClip;
        private var _overlayView:OverlayView;
        private var _onClosed:Signal;
        private var _data:Object;
        private var _tag:String;
        private var _hasActionBeenTaken:Boolean = false;
        private var _openedTime:int;
        private var _buyMembershipButton:SimpleButton;
        private var _closeButton:SimpleButton;
        private var _memberBadge:MovieClip;
        private var _logo:MovieClip;


        public function setDependencies(view:MovieClip, overlayView:OverlayView, onClosed:Signal, data:Object):void
        {
            var currLanguage:String;
            var lang:String;
            this._view = view;
            this._overlayView = overlayView;
            this._onClosed = onClosed;
            this._data = data;
            this.setupButtons();
            if (this._view.hasOwnProperty("member_badge_mc"))
            {
                this._memberBadge = this._view.member_badge_mc;
                if (this._memberBadge.hasOwnProperty("ribbon_mc"))
                {
                    currLanguage = this.model.getLanguage();
                    this._memberBadge.ribbon_mc.gotoAndStop(currLanguage);
                };
            };
            if (this._view.hasOwnProperty("logo_mc"))
            {
                this._logo = this._view.logo_mc;
                lang = this.model.getLanguage();
                this._logo.gotoAndStop(lang);
            };
            if (this._view.oopsTag != null)
            {
                data.oopsTag = this._view.oopsTag;
            };
            this._view.stop();
            this.trackDimgBiTimingEvent("start");
            this._tag = ((this._data.oopsTag != null) ? this._data.oopsTag : this._data.fileKey);
            this.bridge.trackEvent(((("oops_" + EVENT_TYPE_ENCOUNTER) + "_") + this._tag));
            this._openedTime = getTimer();
            this.logServerEvent(this._tag, EVENT_TYPE_ENCOUNTER, 0);
        }

        protected function setupButtons():void
        {
            this._buyMembershipButton = this._view.buyMembershipBtn;
            this._buyMembershipButton.addEventListener(MouseEvent.CLICK, this.onBuyMembership);
            this._closeButton = this._view.closeBtn;
            this._closeButton.addEventListener(MouseEvent.CLICK, this.onCloseView);
        }

        protected function onCloseView(event:MouseEvent=null):void
        {
            var msg:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_ENABLE_QUICK_KEYS);
            this.model.getAVMBridge().send(msg);
            if (!this._hasActionBeenTaken)
            {
                this.logServerEvent(this._tag, EVENT_TYPE_CLOSE, this.getDurationOpened());
                this.trackDimgBiTimingEvent(("btn_" + EVENT_TYPE_CLOSE));
            };
            this._onClosed.dispatch(this._overlayView);
        }

        private function onBuyMembership(event:MouseEvent):void
        {
            this._hasActionBeenTaken = true;
            this.bridge.trackEvent(((("oops_" + EVENT_TYPE_BUY) + "_") + this._tag));
            this.logServerEvent(this._tag, EVENT_TYPE_BUY, this.getDurationOpened());
            this.trackDimgBiTimingEvent(("btn_" + EVENT_TYPE_BUY));
            var lang:String = this.model.getEnvironmentData().language;
            var webTag:String = "";
            if (this._data.oopsTag != null)
            {
                webTag = ((("oops_" + this._data.oopsTag) + "_") + lang);
            }
            else
            {
                webTag = ((this._data.fileKey + "_") + lang);
            };
            this.navigateToMembershipPage(webTag);
        }

        private function navigateToMembershipPage(webTag:String):void
        {
            var lang:String = this.model.getEnvironmentData().language;
            var URL:String = this.model.pathsVO.data["link"]["member_web"];
            var hashedKey:String = this.hashActiveLoginKey(this.model.myPlayerVO.activeKey);
            var urlVars:URLVariables = new URLVariables();
            urlVars.tag = webTag;
            urlVars.player_id = this.model.myPlayerVO.player_id;
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

        private function logServerEvent(name:String, event:String, duration:int):void
        {
            var lang:String = this.model.getEnvironmentData().language;
            this.connection.sendMessage("bi", "bioops", [((((((((name + "|") + event) + "|") + "0") + "|") + lang) + "|") + String(duration))]);
        }

        private function trackDimgBiTimingEvent(step:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("window.metrics.stepTime", DIMG_BI_CONTEXT, step, {"path_name":this._data.oopsTag});
            };
        }

        private function getDurationOpened():int
        {
            return (getTimer() - this._openedTime);
        }


    }
}//package com.clubpenguin.main.overlays.mediator
