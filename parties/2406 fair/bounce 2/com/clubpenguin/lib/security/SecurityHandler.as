package com.clubpenguin.lib.security{
    import org.osflash.signals.Signal;
    import flash.display.DisplayObject;
    import com.clubpenguin.lib.data.ProjectGlobals;
    import org.osflash.signals.ISignal;

    public class SecurityHandler implements ISecurityHandler {

        public static const ALLOWED_URL:String = "clubpenguin.com";
        private static const REQUEST_TYPE_HTTP:String = "http";
        private static const REQUEST_TYPE_HTTPS:String = "https";
        private static const REQUEST_TYPE_FILE:String = "file";

        private var __domains:Domains;
        private var __securityCheckSuccess:Signal;
        private var __altURL:String;

        public function SecurityHandler(){
            this.__securityCheckSuccess = new Signal();
            this.__domains = Domains.getDomains();
        }

        public function doSecurityCheck(_arg_1:DisplayObject):void{
            var workingURL:String;
            var requestType:String;
            var serverPath:Array;
            var _content:DisplayObject = _arg_1;
            trace("[SecurityHandler] starting security check...");
            workingURL = _content.loaderInfo.url;
            requestType = workingURL.substring(0, workingURL.indexOf(":"));
            trace(("[SecurityHandler] url request type is: " + requestType));
            try {
                if (_content.parent == null){
                    trace("[SecurityHandler] content parent is null!");
                    this.failSecurityCheck(_content);
                } else {
                    switch (requestType){
                        case REQUEST_TYPE_HTTP:
                        case REQUEST_TYPE_HTTPS:
                            serverPath = workingURL.split("/");
                            if (String(serverPath[2]).substr((0 - ALLOWED_URL.length)) == ALLOWED_URL){
                                trace("[SecurityHandler] security check SUCCESS!");
                                this.__securityCheckSuccess.dispatch();
                            } else {
                                trace((("[SecurityHandler] " + workingURL) + " not running in an allowed domain!"));
                                this.failSecurityCheck(_content);
                            };
                            break;
                        case REQUEST_TYPE_FILE:
                            if (ProjectGlobals.debugMode){
                                trace("[SecurityHandler] security check SUCCESS!");
                                this.__securityCheckSuccess.dispatch();
                            } else {
                                trace((("[SecurityHandler] " + workingURL) + " not running in an allowed domain!"));
                                this.failSecurityCheck(_content);
                            };
                            break;
                        default:
                            trace((("[SecurityHandler] " + workingURL) + " unknown request type!"));
                            this.failSecurityCheck(_content);
                    };
                };
            } catch(e:Error) {
                trace(("[SecurityHandler] Error while doing security check!\n" + e.getStackTrace()));
            };
        }

        private function failSecurityCheck(_arg_1:DisplayObject):void{
            throw (("[SecurityHandler] security check FAILED! (" + _arg_1.loaderInfo.url) + ")");
        }

        public function setAlternateURL(_arg_1:String):void{
        }

        public function getSecurityCheckSuccess():ISignal{
            return (this.__securityCheckSuccess);
        }


    }
}//package com.clubpenguin.lib.security
