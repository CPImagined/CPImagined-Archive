//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.security
{
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.data.ProjectGlobals;
    import flash.display.DisplayObject;
    import org.osflash.signals.ISignal;

    public class SecurityHandler implements ISecurityHandler 
    {

        public static const ALLOWED_URL:String = "clubpenguin.com";
        private static const REQUEST_TYPE_HTTP:String = "http";
        private static const REQUEST_TYPE_HTTPS:String = "https";
        private static const REQUEST_TYPE_FILE:String = "file";

        private var __domains:Domains;
        private var __securityCheckSuccess:Signal;
        private var __altURL:String;

        public function SecurityHandler()
        {
            this.__securityCheckSuccess = new Signal();
            this.__domains = Domains.getDomains();
        }

        public function doSecurityCheck(_content:DisplayObject):void
        {
            var workingURL:String;
            var requestType:String;
            var serverPath:Array;
            workingURL = _content.loaderInfo.url;
            requestType = workingURL.substring(0, workingURL.indexOf(":"));
            try
            {
                if (_content.parent == null)
                {
                    this.failSecurityCheck(_content);
                }
                else
                {
                    switch (requestType)
                    {
                        case REQUEST_TYPE_HTTP:
                        case REQUEST_TYPE_HTTPS:
                            serverPath = workingURL.split("/");
                            if (String(serverPath[2]).substr((0 - ALLOWED_URL.length)) == ALLOWED_URL)
                            {
                                this.__securityCheckSuccess.dispatch();
                            }
                            else
                            {
                                this.failSecurityCheck(_content);
                            };
                            break;
                        case REQUEST_TYPE_FILE:
                            if (ProjectGlobals.debugMode)
                            {
                                this.__securityCheckSuccess.dispatch();
                            }
                            else
                            {
                                this.failSecurityCheck(_content);
                            };
                            break;
                        default:
                            this.failSecurityCheck(_content);
                    };
                };
            }
            catch(e:Error)
            {
            };
        }

        private function failSecurityCheck(_content:DisplayObject):void
        {
            throw (("[SecurityHandler] security check FAILED! (" + _content.loaderInfo.url) + ")");
        }

        public function setAlternateURL(_str:String):void
        {
        }

        public function getSecurityCheckSuccess():ISignal
        {
            return (this.__securityCheckSuccess);
        }


    }
}//package com.clubpenguin.lib.security
