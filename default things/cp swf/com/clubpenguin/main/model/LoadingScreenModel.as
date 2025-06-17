//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import com.clubpenguin.managers.LoginFloodManager;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import flash.events.TimerEvent;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class LoadingScreenModel extends Actor 
    {

        public static const LOADING_SCREEN_NAME:String = "loadingScreen";
        private static const LOGIN_SCREEN_PREFIX:String = "loginScreenPrefix#";
        private static const LOGO_LOADING_SCREEN_NAME:String = "logoLoadingScreen#";

        public const viewStateChanged:Signal = new Signal();
        public const progressChanged:Signal = new Signal();
        public const closingLoadingScreen:Signal = new Signal();

        [Inject]
        public var loginFloodManager:LoginFloodManager;
        [Inject]
        public var bridge:IAVMBridgeService;
        private var _isShowing:Boolean = false;
        private var _progress:Number = 0;
        private var _loadingText:String = "";
        private var _isLoginScreen:Boolean = false;
        private var _isLogoScreen:Boolean = false;
        private var _logoAnimationComplete:Boolean = false;
        private var _anyKeyPressedDuringLogo:Boolean = false;
        private var _loadingComplete:Boolean = false;


        public function get isShowing():Boolean
        {
            return (this._isShowing);
        }

        public function get progress():Number
        {
            return (this._progress);
        }

        public function get loadingText():String
        {
            return (this._loadingText);
        }

        public function get isLogoScreen():Boolean
        {
            return (this._isLogoScreen);
        }

        public function get isLoginFloodControlActive():Boolean
        {
            return (this.loginFloodManager.isFloodControlActive);
        }

        public function show(loadingText:String):void
        {
            this._loadingText = loadingText;
            if (this._loadingText.indexOf(LOGIN_SCREEN_PREFIX) != -1)
            {
                this._isLoginScreen = true;
                this._loadingText = loadingText.split("#")[1];
            }
            else
            {
                if (this._loadingText.indexOf(LOGO_LOADING_SCREEN_NAME) != -1)
                {
                    this._loadingText = "";
                    this._isLogoScreen = true;
                }
                else
                {
                    this._isLogoScreen = false;
                    this._isLoginScreen = false;
                };
            };
            if (!this._isShowing)
            {
                this._isShowing = true;
                this.viewStateChanged.dispatch();
            };
        }

        public function hide():void
        {
            if (this._isShowing)
            {
                if (((this._isLogoScreen) && ((!(this._logoAnimationComplete)) && (!(this._anyKeyPressedDuringLogo)))))
                {
                    this._loadingComplete = true;
                    return;
                };
                this._isShowing = false;
                this.viewStateChanged.dispatch();
                this.closingLoadingScreen.dispatch();
            };
        }

        public function updateProgress(value:Number):void
        {
            this._progress = Math.min(Math.max(value, 0), 1);
            this.progressChanged.dispatch();
        }

        public function checkLoginFloodControl():void
        {
            if (((this._isLoginScreen) && (this.isLoginFloodControlActive)))
            {
                this.loginFloodManager.addEventListener(TimerEvent.TIMER, this.onTimerTick);
                this.loginFloodManager.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
                this.loginFloodManager.startTimer();
            };
        }

        public function onKeyPressedDuringLogo(event:KeyboardEvent):void
        {
            this._anyKeyPressedDuringLogo = true;
            if (this._loadingComplete)
            {
                this.hide();
            };
        }

        public function onLogoAnimationComplete(event:Event):void
        {
            this._logoAnimationComplete = true;
            if (this._loadingComplete)
            {
                this.hide();
            };
        }

        private function onTimerTick(event:TimerEvent):void
        {
            this.updateProgress(this.loginFloodManager.getTickPct());
        }

        private function onTimerComplete(event:TimerEvent):void
        {
            this.returnLoginControlToAS2();
        }

        private function returnLoginControlToAS2():void
        {
            this.loginFloodManager.removeEventListener(TimerEvent.TIMER, this.onTimerTick);
            this.loginFloodManager.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            var msg:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_CONTINUE_LOGIN);
            this.bridge.send(msg);
        }


    }
}//package com.clubpenguin.main.model
