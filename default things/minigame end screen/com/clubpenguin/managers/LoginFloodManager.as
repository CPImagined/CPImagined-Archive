//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.managers
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.net.SharedObject;
    import flash.net.ObjectEncoding;
    import com.clubpenguin.lib.util.MathUtil;
    import flash.events.TimerEvent;

    public class LoginFloodManager extends EventDispatcher 
    {

        private static const SHARED_OBJECT_NAME:String = "floodControl";
        private static const NEXT_LOGIN_TIME:String = "nlt";
        private static const LOGIN_ATTEMPTS:String = "att";
        private static const LOGIN_DELAYS:Array = [0, 20, 40];
        private static const RANDOM_RANGE:int = 20;
        private static const MIN_DELAY:int = 10;
        private static const ONE_SECOND:int = 1000;
        private static const TICK_THRESHOLD:int = 0;

        private var nextLoginTime:Number;
        private var loginAttempts:int;
        private var loginFloodDelayTimer:Timer;
        private var totalTicks:int;
        private var tickCount:int;
        private var tickPct:Number;


        public function init():Boolean
        {
            var so:SharedObject;
            var now:Number = this.getCurrentTime();
            this.nextLoginTime = now;
            this.loginAttempts = -1;
            try
            {
                so = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
                so.objectEncoding = ObjectEncoding.AMF0;
                if (so.data[NEXT_LOGIN_TIME] != undefined)
                {
                    this.nextLoginTime = so.data[NEXT_LOGIN_TIME];
                };
                if (so.data[LOGIN_ATTEMPTS] != undefined)
                {
                    this.loginAttempts = so.data[LOGIN_ATTEMPTS];
                };
            }
            catch(error:Error)
            {
                return (false);
            };
            return (true);
        }

        public function get isFloodControlActive():Boolean
        {
            return (false);
        }

        public function getNextLoginTime():Number
        {
            return (this.nextLoginTime);
        }

        public function getLoginAttempts():int
        {
            return (this.loginAttempts);
        }

        private function setNextLoginTime(loginAttempts:int):void
        {
            var randomMin:int = ((loginAttempts > 0) ? 0 : MIN_DELAY);
            this.nextLoginTime = (this.getCurrentTime() + ((LOGIN_DELAYS[loginAttempts] + MathUtil.randomRange(RANDOM_RANGE, randomMin)) * ONE_SECOND));
        }

        public function setLoginAttempt():Boolean
        {
            var soResult:String;
            var so:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME, "/");
            try
            {
                so.data[LOGIN_ATTEMPTS] = ((this.loginAttempts++ > (LOGIN_DELAYS.length - 1)) ? 0 : this.loginAttempts);
                so.objectEncoding = ObjectEncoding.AMF0;
                this.setNextLoginTime(this.loginAttempts);
                so.data[NEXT_LOGIN_TIME] = this.getNextLoginTime();
                soResult = so.flush();
            }
            catch(error:Error)
            {
                return (false);
            };
            return (true);
        }

        public function getTickPct():Number
        {
            return (this.tickPct);
        }

        public function startTimer():void
        {
            var timeDelta:Number = (this.getNextLoginTime() - this.getCurrentTime());
            this.totalTicks = Math.floor((timeDelta / ONE_SECOND));
            if (this.totalTicks > TICK_THRESHOLD)
            {
                this.tickCount = 0;
                this.loginFloodDelayTimer = new Timer(ONE_SECOND, this.totalTicks);
                this.loginFloodDelayTimer.addEventListener(TimerEvent.TIMER, this.onTimerTick);
                this.loginFloodDelayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
                this.loginFloodDelayTimer.start();
            }
            else
            {
                dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
            };
        }

        private function onTimerTick(event:TimerEvent):void
        {
            this.tickCount++;
            this.tickPct = (this.tickCount / this.totalTicks);
            dispatchEvent(event);
        }

        private function onTimerComplete(event:TimerEvent):void
        {
            this.loginFloodDelayTimer.removeEventListener(TimerEvent.TIMER, this.onTimerTick);
            this.loginFloodDelayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.loginFloodDelayTimer = null;
            dispatchEvent(event);
        }

        public function getCurrentTime():Number
        {
            var now:Date = new Date();
            return (now.getTime());
        }


    }
}//package com.clubpenguin.managers
