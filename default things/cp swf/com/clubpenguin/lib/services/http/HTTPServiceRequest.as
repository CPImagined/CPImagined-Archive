//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.http
{
    import org.robotlegs.mvcs.Actor;
    import org.osflash.signals.Signal;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLRequestMethod;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import flash.net.URLVariables;
    import com.adobe.serialization.json.JSON;

    public class HTTPServiceRequest extends Actor 
    {

        public static const JSON_ENCODING:String = "json";
        public static const XML_ENCODING:String = "xml";
        public static const TEXT_ENCODING:String = "text";

        public var responseReceived:Signal = new Signal(HTTPResponse);
        public var requestFailed:Signal = new Signal(HTTPResponse);
        public var response:HTTPResponse;
        private var _url:String;
        private var _request:URLRequest;
        private var _loader:URLLoader;
        private var _responseEncoding:String;
        private var _method:String;
        private var _headers:Array;

        public function HTTPServiceRequest()
        {
            this.setMethod(null);
            this.setRequestHeaders(null);
        }

        public function destroy():void
        {
            this.responseReceived.removeAll();
            this.requestFailed.removeAll();
        }

        public function setURL(__url:String, __encoding:String):void
        {
            this._url = __url;
            if (__encoding)
            {
                this._responseEncoding = __encoding;
            }
            else
            {
                this._responseEncoding = TEXT_ENCODING;
            };
        }

        public function setMethod(__method:String):void
        {
            this._method = ((__method != null) ? __method : URLRequestMethod.POST);
        }

        public function setRequestHeaders(__headers:Array):void
        {
            this._headers = [];
            if (__headers == null)
            {
                return;
            };
            var i:Number = 0;
            while (i < __headers.length)
            {
                this._headers.push(__headers[i]);
                i++;
            };
        }

        public function send(variables:URLVariables=null):void
        {
            if (!this._url)
            {
                throw (new Error("HTTPServiceRequest.send called when url not set."));
            };
            this._request = new URLRequest(this._url);
            this._request.data = variables;
            this._request.method = this._method;
            this._request.requestHeaders = this._headers;
            this._loader = new URLLoader();
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHTTPStatus);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._loader.addEventListener(Event.COMPLETE, this.onComplete);
            this.response = new HTTPResponse();
            this._loader.load(this._request);
        }

        public function onComplete(event:Event):void
        {
            if (this.response.success)
            {
                try
                {
                    switch (this._responseEncoding)
                    {
                        case JSON_ENCODING:
                            this.response.data = com.adobe.serialization.json.JSON.decode((this._loader.data as String));
                            break;
                        case XML_ENCODING:
                            break;
                        case TEXT_ENCODING:
                            break;
                        default:
                            throw (new Error(("HTTPServiceRequest.onComplete :: Invalid responseEncoding specified: " + this._responseEncoding)));
                    };
                }
                catch(error:Error)
                {
                    response.errorMessage = ((error.name + ":: ") + error.message);
                    requestFailed.dispatch(response);
                    return;
                };
                this.responseReceived.dispatch(this.response);
            }
            else
            {
                this.requestFailed.dispatch(this.response);
            };
        }

        public function onHTTPStatus(event:HTTPStatusEvent):void
        {
            this.response.status = event.status;
            switch (event.status)
            {
                case 0:
                    this.response.success = true;
                    break;
                case 200:
                    this.response.success = true;
                    break;
                default:
                    this.response.errorMessage = ("HTTP Error " + event.status.toString());
            };
        }

        public function onSecurityError(event:SecurityErrorEvent):void
        {
            this.response.errorMessage = event.text;
            this.requestFailed.dispatch(this.response);
        }

        public function onIOError(event:IOErrorEvent):void
        {
            this.response.errorMessage = event.text;
            this.requestFailed.dispatch(this.response);
        }


    }
}//package com.clubpenguin.lib.services.http
