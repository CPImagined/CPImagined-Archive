//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.disneylearning.managers
{
    import flash.events.EventDispatcher;
    import com.disney.disneylearning.managers.debug.DLSLocalConnectionProducer;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLRequestHeader;
    import flash.net.URLVariables;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.IEventDispatcher;
    import com.disney.disneylearning.events.DLSEvent;
    import com.adobe.crypto.MD5;
    import flash.events.*;
    import flash.net.*;
    import com.adobe.serialization.json.*;
    import com.adobe.crypto.*;

    public class DLSManager extends EventDispatcher 
    {

        private static var __instance:DLSManager;
        private static var __learnerID:String;
        private static var __host:String;
        public static var LEARNER_SCORE:String = "Learnerscore";
        public static var GAME_SCORE:String = "Gamescore";
        public static var START:String = "Start";
        public static var STOP:String = "Stop";
        public static var SELECTED:String = "Selected";
        public static var NOTIFY:String = "Notify";
        public static var PRESENTED:String = "Presented";
        public static var USED:String = "Used";

        private var __URLLoaderCookieId:int = 0;
        private var __URLCallbacks:Array = new Array();
        private var __lc:DLSLocalConnectionProducer = null;
        private var __sequenceID:int = 0;
        private var __enable_lc:Boolean = false;

        public function DLSManager()
        {
            this.__lc = new DLSLocalConnectionProducer();
        }

        public static function init(learner_id:String="Penguin", host:String="api.dlsnetwork.com"):void
        {
            __learnerID = learner_id;
            __host = host;
        }

        public static function get instance():DLSManager
        {
            if (__instance == null)
            {
                __instance = new (DLSManager)();
            };
            return (__instance);
        }

        public static function set learnerID(id:String):void
        {
            __learnerID = id;
        }

        public static function get learnerID():String
        {
            return (__learnerID);
        }

        public static function set host(host:String):void
        {
            __host = host;
        }

        public static function get host():String
        {
            return (__host);
        }


        public function pushOpcode(opcode:String, guid:String, callback:Function, register1:String="100", register2:String="null", register3:String="null", register4:String="null"):int
        {
            if (!this.isValidOpcode(opcode))
            {
                return (0);
            };
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
            var url:String = (((((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + time) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/");
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
            if (((__learnerID == "-1") || (__learnerID == "Penguin")))
            {
                this.__lc.sendMessage("API", url);
            };
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
        }

        private function isValidOpcode(opcode:String):Boolean
        {
            var opcodeString:String = opcode.toLowerCase();
            if (((((((((opcodeString == LEARNER_SCORE.toLowerCase()) || (opcodeString == GAME_SCORE.toLowerCase())) || (opcodeString == START.toLowerCase())) || (opcodeString == STOP.toLowerCase())) || (opcodeString == SELECTED.toLowerCase())) || (opcodeString == PRESENTED.toLowerCase())) || (opcodeString == NOTIFY.toLowerCase())) || (opcodeString == USED.toLowerCase())))
            {
                return (true);
            };
            return (false);
        }

        public function pushOpcodeToHost(host:String, opcode:String, guid:String, callback:Function, register1:String="100", register2:String="null", register3:String="null", register4:String="null"):int
        {
            if (!this.isValidOpcode(opcode))
            {
                return (0);
            };
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
            if (host == "")
            {
                host = "k.api.dlsnetwork.com";
            };
            var url:String = (((((((((((((((((("http://" + host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + time) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/");
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
            if (((__learnerID == "-1") || (__learnerID == "Penguin")))
            {
                this.__lc.sendMessage("API", url);
            };
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
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
            this.__lc.sendMessage("API", url);
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
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
            variables.learner = DLSManager.__learnerID;
            request.data = variables;
            this.__lc.sendMessage("API", url);
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
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
            this.__lc.sendMessage("API", url);
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
            };
            return (cookie);
        }

        private function configureListeners(dispatcher:IEventDispatcher):void
        {
            dispatcher.addEventListener(Event.COMPLETE, this.completeHandler);
            dispatcher.addEventListener(Event.OPEN, this.openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
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
            };
            try
            {
                this.__lc.sendMessage("RESULT", loader.data);
                e = new DLSEvent(loader.opcode, loader.learner, loader.target, loader.data, cookie);
                this.dispatchEvent(e);
            }
            catch(error:Error)
            {
            };
        }

        private function openHandler(event:Event):void
        {
        }

        private function progressHandler(event:ProgressEvent):void
        {
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void
        {
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void
        {
        }

        private function ioErrorHandler(event:IOErrorEvent):void
        {
            this.reload(DLSManagerURLLoader(event.target));
        }

        private function reload(loader:DLSManagerURLLoader):void
        {
            loader.reloadCount++;
            if (loader.reloadCount < 10)
            {
                loader.load(loader.request);
            };
        }

        private function encryptURL(url:String, timeStamp:String, developerId:String):String
        {
            var str:* = (((url + timeStamp) + developerId) + "_Salt");
            var hash:String = MD5.hash(str);
            return (hash);
        }

        private function encryptTime(time:String):String
        {
            return (time);
        }


    }
}//package com.disney.disneylearning.managers

import flash.net.URLLoader;
import flash.net.URLRequest;

class DLSManagerURLLoader extends URLLoader 
{

    public var id:int = 0;
    public var opcode:String = "";
    public var learner:String = "";
    public var target:String = "";
    public var callback:Function = null;
    public var reloadCount:int = 0;
    public var request:URLRequest = null;


}

