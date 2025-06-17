package com.clubpenguin.lib.security{
    import flash.system.Security;

    internal class Domains {

        private static var __instance:Domains = null;

        private var __allowedDomains:Array;

        public function Domains(){
            __instance = this;
            this.init();
        }

        public static function getDomains():Domains{
            if (__instance != null){
                return (__instance);
            };
            return (new (Domains)());
        }


        public function addDomain(_arg_1:String):void{
            if (!this.isAllowedDomain(_arg_1)){
                trace((("[Domains] adding " + _arg_1) + " to allowed domain list!"));
                Security.allowDomain(_arg_1);
                this.__allowedDomains.push(_arg_1);
            };
        }

        public function isAllowedDomain(_arg_1:String):Boolean{
            var _local_2:String;
            for each (_local_2 in this.__allowedDomains) {
                if (_arg_1 == _local_2){
                    trace((("[Domains] " + _arg_1) + " is allowed!"));
                    return (true);
                };
            };
            trace((("[Domains] " + _arg_1) + " is NOT allowed!"));
            return (false);
        }

        private function init():void{
            var _local_2:String;
            var _local_3:String;
            trace("[Domains] initializing domain list.");
            this.__allowedDomains = new Array();
            this.__allowedDomains.push("play.clubpenguin.com");
            this.__allowedDomains.push("play2.clubpenguin.com");
            this.__allowedDomains.push("media.clubpenguin.com");
            this.__allowedDomains.push("media1.clubpenguin.com");
            this.__allowedDomains.push("media2.clubpenguin.com");
            this.__allowedDomains.push("cdn.clubpenguin.com");
            this.__allowedDomains.push("play.critteroo.com");
            this.__allowedDomains.push("play2.critteroo.com");
            this.__allowedDomains.push("media.critteroo.com");
            this.__allowedDomains.push("media1.critteroo.com");
            this.__allowedDomains.push("media2.critteroo.com");
            this.__allowedDomains.push("cdn.critteroo.com");
            this.__allowedDomains.push("play.clubpenguin.co.uk");
            this.__allowedDomains.push("play2.clubpenguin.co.uk");
            this.__allowedDomains.push("media.clubpenguin.co.uk");
            this.__allowedDomains.push("media1.clubpenguin.co.uk");
            this.__allowedDomains.push("media2.clubpenguin.co.uk");
            this.__allowedDomains.push("cdn.clubpenguin.co.uk");
            this.__allowedDomains.push("play.critteroo.co.uk");
            this.__allowedDomains.push("play2.critteroo.co.uk");
            this.__allowedDomains.push("media.critteroo.co.uk");
            this.__allowedDomains.push("media1.critteroo.co.uk");
            this.__allowedDomains.push("media2.critteroo.co.uk");
            this.__allowedDomains.push("cdn.critteroo.co.uk");
            var _local_1:int = 1;
            while (_local_1 < 100) {
                _local_3 = ((_local_1 < 10) ? ("0" + _local_1) : String(_local_1));
                this.__allowedDomains.push((("qa" + _local_3) + ".sandbox.play.clubpenguin.com"));
                this.__allowedDomains.push((("qa" + _local_3) + ".sandbox.media1.clubpenguin.com"));
                _local_1++;
            };
            this.__allowedDomains.push("mg01.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("mg01.sandbox.play2.clubpenguin.com");
            this.__allowedDomains.push("mg01.sandbox.media.clubpenguin.com");
            this.__allowedDomains.push("mg01.sandbox.media1.clubpenguin.com");
            this.__allowedDomains.push("mg01.sandbox.media2.clubpenguin.com");
            this.__allowedDomains.push("mg01.sandbox.cdn.clubpenguin.com");
            this.__allowedDomains.push("mg02.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("mg02.sandbox.play2.clubpenguin.com");
            this.__allowedDomains.push("mg02.sandbox.media.clubpenguin.com");
            this.__allowedDomains.push("mg02.sandbox.media1.clubpenguin.com");
            this.__allowedDomains.push("mg02.sandbox.media2.clubpenguin.com");
            this.__allowedDomains.push("mg02.sandbox.cdn.clubpenguin.com");
            this.__allowedDomains.push("mg03.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("mg03.sandbox.play2.clubpenguin.com");
            this.__allowedDomains.push("mg03.sandbox.media.clubpenguin.com");
            this.__allowedDomains.push("mg03.sandbox.media1.clubpenguin.com");
            this.__allowedDomains.push("mg03.sandbox.media2.clubpenguin.com");
            this.__allowedDomains.push("mg03.sandbox.cdn.clubpenguin.com");
            this.__allowedDomains.push("qa01.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("qa01.sandbox.play2.clubpenguin.com");
            this.__allowedDomains.push("qa01.sandbox.media.clubpenguin.com");
            this.__allowedDomains.push("qa01.sandbox.media1.clubpenguin.com");
            this.__allowedDomains.push("qa01.sandbox.media2.clubpenguin.com");
            this.__allowedDomains.push("qa01.sandbox.cdn.clubpenguin.com");
            this.__allowedDomains.push("qa02.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("qa02.sandbox.play2.clubpenguin.com");
            this.__allowedDomains.push("qa02.sandbox.media.clubpenguin.com");
            this.__allowedDomains.push("qa02.sandbox.media1.clubpenguin.com");
            this.__allowedDomains.push("qa02.sandbox.media2.clubpenguin.com");
            this.__allowedDomains.push("qa02.sandbox.cdn.clubpenguin.com");
            this.__allowedDomains.push("qa03.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("qa03.sandbox.play2.clubpenguin.com");
            this.__allowedDomains.push("qa03.sandbox.media.clubpenguin.com");
            this.__allowedDomains.push("qa03.sandbox.media1.clubpenguin.com");
            this.__allowedDomains.push("qa03.sandbox.media2.clubpenguin.com");
            this.__allowedDomains.push("qa03.sandbox.cdn.clubpenguin.com");
            this.__allowedDomains.push("qa04.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("qa04.sandbox.media1.clubpenguin.com");
            this.__allowedDomains.push("sandbox01.play.clubpenguin.com");
            this.__allowedDomains.push("sandbox01.play2.clubpenguin.com");
            this.__allowedDomains.push("sandbox01.media.clubpenguin.com");
            this.__allowedDomains.push("sandbox01.media1.clubpenguin.com");
            this.__allowedDomains.push("sandbox01.media2.clubpenguin.com");
            this.__allowedDomains.push("sandbox01.cdn.clubpenguin.com");
            this.__allowedDomains.push("sandbox02.play.clubpenguin.com");
            this.__allowedDomains.push("sandbox02.play2.clubpenguin.com");
            this.__allowedDomains.push("sandbox02.media.clubpenguin.com");
            this.__allowedDomains.push("sandbox02.media1.clubpenguin.com");
            this.__allowedDomains.push("sandbox02.media2.clubpenguin.com");
            this.__allowedDomains.push("sandbox02.cdn.clubpenguin.com");
            this.__allowedDomains.push("sandbox03.play.clubpenguin.com");
            this.__allowedDomains.push("sandbox03.play2.clubpenguin.com");
            this.__allowedDomains.push("sandbox03.media.clubpenguin.com");
            this.__allowedDomains.push("sandbox03.media1.clubpenguin.com");
            this.__allowedDomains.push("sandbox03.media2.clubpenguin.com");
            this.__allowedDomains.push("sandbox03.cdn.clubpenguin.com");
            this.__allowedDomains.push("sandbox04.play.clubpenguin.com");
            this.__allowedDomains.push("sandbox04.play2.clubpenguin.com");
            this.__allowedDomains.push("sandbox04.media.clubpenguin.com");
            this.__allowedDomains.push("sandbox04.media1.clubpenguin.com");
            this.__allowedDomains.push("sandbox04.media2.clubpenguin.com");
            this.__allowedDomains.push("sandbox04.cdn.clubpenguin.com");
            this.__allowedDomains.push("sandbox05.play.clubpenguin.com");
            this.__allowedDomains.push("sandbox05.play2.clubpenguin.com");
            this.__allowedDomains.push("sandbox05.media.clubpenguin.com");
            this.__allowedDomains.push("sandbox05.media1.clubpenguin.com");
            this.__allowedDomains.push("sandbox05.media2.clubpenguin.com");
            this.__allowedDomains.push("sandbox05.cdn.clubpenguin.com");
            this.__allowedDomains.push("dev06web01.online.disney.com");
            this.__allowedDomains.push("dev10.sandbox.play.clubpenguin.com");
            this.__allowedDomains.push("istage1.play.clubpenguin.com");
            this.__allowedDomains.push("stage.play.clubpenguin.com");
            this.__allowedDomains.push("localhost");
            for each (_local_2 in this.__allowedDomains) {
                Security.allowDomain(_local_2);
            };
        }


    }
}//package com.clubpenguin.lib.security
