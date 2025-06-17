//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.disneylearning.managers
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLRequestHeader;
    import flash.net.URLVariables;
    import flash.events.SecurityErrorEvent;
    import com.adobe.crypto.MD5;
    import flash.events.IOErrorEvent;
    import com.disney.disneylearning.events.DLSEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.ProgressEvent;
    import flash.events.IEventDispatcher;
    import flash.events.*;
    import com.adobe.crypto.*;
    import flash.net.*;

    public class DLSManager extends EventDispatcher 
    {

        private static var __instance:DLSManager;
        private static var __learnerID:String;
        private static var __host:String;

        private var __URLLoaderCookieId:int = 0;
        private var __sequenceID:int = 0;
        private var __URLCallbacks:Array = new Array();


        public static function get instance():DLSManager
        {
            if (__instance == null)
            {
                __instance = new (DLSManager)();
            };
            return (__instance);
        }

        public static function init(_arg_1:String="Penguin", _arg_2:String="api.dlsnetwork.com"):void
        {
            __learnerID = _arg_1;
            __host = _arg_2;
        }


        private function openHandler(_arg_1:Event):void
        {
            trace(("openHandler: " + _arg_1));
        }

        public function getAvailableContent(guid:String, callback:Function, sortingOrder:String="depth"):int
        {
            var cookie:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[cookie] = callback;
            var url:String = (((((((("http://" + __host) + "/v1/content/getAvailableContent/") + __learnerID) + "/") + guid) + "/") + sortingOrder) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.id = cookie;
            loader.learner = __learnerID;
            loader.callback = callback;
            this.configureListeners(loader);
            var request:URLRequest = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = "";
            var d:Date = new Date();
            var time:Number = Math.round((d.getTime() / 1000));
            var header:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var header2:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(url, time.toString(), "ClubPenguin") + "|") + this.encryptTime(time.toString())));
            var header3:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            request.requestHeaders.push(header);
            request.requestHeaders.push(header2);
            request.requestHeaders.push(header3);
            var variables:URLVariables = new URLVariables();
            variables.noCache = Number(new Date().getTime());
            request.data = variables;
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
        }

        public function pushOpcode(opcode:String, guid:String, callback:Function, register1:String="100", register2:String="null", register3:String="null"):int
        {
            var d:Date = new Date();
            var time:Number = Math.round((d.getTime() / 1000));
            if (__learnerID == "")
            {
                __learnerID = "-1";
            };
            if (opcode == "")
            {
                opcode = "no_opcode_given";
            };
            var url:String = (((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + time) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.learner = __learnerID;
            loader.opcode = opcode;
            loader.target = guid;
            loader.callback = callback;
            var cookie:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[cookie] = callback;
            loader.id = cookie;
            this.configureListeners(loader);
            var request:URLRequest = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = "";
            var header:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var header2:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(url, time.toString(), "ClubPenguin") + "|") + this.encryptTime(time.toString())));
            var header3:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            request.requestHeaders.push(header);
            request.requestHeaders.push(header2);
            request.requestHeaders.push(header3);
            loader.request = request;
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
        }

        private function securityErrorHandler(_arg_1:SecurityErrorEvent):void
        {
            trace(("securityErrorHandler: " + _arg_1));
        }

        private function encryptURL(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            var _local_4:* = (((_arg_1 + _arg_2) + _arg_3) + "_Salt");
            var _local_5:String = MD5.hash(_local_4);
            return (_local_5);
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            trace(("ioErrorHandler: " + _arg_1));
            this.reload(DLSManagerURLLoader(_arg_1.target));
        }

        public function set host(_arg_1:String):void
        {
            __host = _arg_1;
        }

        private function completeHandler(event:Event):void
        {
            var e:DLSEvent;
            var loader:DLSManagerURLLoader = DLSManagerURLLoader(event.target);
            var cookie:int = loader.id;
            var rValue:* = null;
            try
            {
                rValue = this.__URLCallbacks[cookie](loader.data);
            }
            catch(error:Error)
            {
                trace("Unable to invoke callback.");
            };
            try
            {
                e = new DLSEvent(loader.opcode, loader.learner, loader.target, loader.data, cookie);
                this.dispatchEvent(e);
            }
            catch(error:Error)
            {
                trace("Unable to dispatch DLS Event");
            };
        }

        private function httpStatusHandler(_arg_1:HTTPStatusEvent):void
        {
            trace(("httpStatusHandler: " + _arg_1));
        }

        private function encryptTime(_arg_1:String):String
        {
            return (_arg_1);
        }

        public function getLearnerScoreByNode(guid:String, callback:Function):int
        {
            var cookie:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[cookie] = callback;
            var url:String = (((((("http://" + __host) + "/v1/reports/getLearnerScoreByNode/") + __learnerID) + "/") + guid) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.id = cookie;
            this.configureListeners(loader);
            var request:URLRequest = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = "";
            var d:Date = new Date();
            var time:Number = Math.round((d.getTime() / 1000));
            var header:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var header2:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(url, time.toString(), "ClubPenguin") + "|") + this.encryptTime(time.toString())));
            var header3:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            request.requestHeaders.push(header);
            request.requestHeaders.push(header2);
            request.requestHeaders.push(header3);
            var variables:URLVariables = new URLVariables();
            variables.noCache = Number(new Date().getTime());
            request.data = variables;
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
        }

        public function set learnerID(_arg_1:String):void
        {
            __learnerID = _arg_1;
        }

        private function configureListeners(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener(Event.COMPLETE, this.completeHandler);
            _arg_1.addEventListener(Event.OPEN, this.openHandler);
            _arg_1.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
            _arg_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            _arg_1.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            _arg_1.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
        }

        private function reload(_arg_1:DLSManagerURLLoader):void
        {
            _arg_1.reloadCount++;
            if (_arg_1.reloadCount < 10)
            {
                _arg_1.load(_arg_1.request);
            };
        }

        public function getLearnerScores(callback:Function):int
        {
            var cookie:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[cookie] = callback;
            var url:String = (((("http://" + __host) + "/v1/reports/getLearnerScores/") + __learnerID) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.id = cookie;
            this.configureListeners(loader);
            var request:URLRequest = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = "";
            var d:Date = new Date();
            var time:Number = Math.round((d.getTime() / 1000));
            var header:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var header2:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(url, time.toString(), "ClubPenguin") + "|") + this.encryptTime(time.toString())));
            var header3:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            request.requestHeaders.push(header);
            request.requestHeaders.push(header2);
            request.requestHeaders.push(header3);
            var variables:URLVariables = new URLVariables();
            variables.learner = __learnerID;
            request.data = variables;
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
        }

        private function progressHandler(_arg_1:ProgressEvent):void
        {
            trace(((("progressHandler loaded:" + _arg_1.bytesLoaded) + " total: ") + _arg_1.bytesTotal));
        }


    }
}//package com.disney.disneylearning.managers

import flash.net.URLLoader;
import flash.net.URLRequest;

class DLSManagerURLLoader extends URLLoader 
{

    public var callback:Function = null;
    public var opcode:String = "";
    public var request:URLRequest = null;
    public var learner:String = "";
    public var target:String = "";
    public var id:int = 0;
    public var reloadCount:int = 0;


}

