package com.disney.disneylearning.managers{
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
    import com.adobe.serialization.json.*;
    import flash.net.*;
    import com.adobe.crypto.*;

    public class DLSManager extends EventDispatcher {

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

        public function DLSManager(){
            this.__lc = new DLSLocalConnectionProducer();
        }

        public static function init(_arg_1:String="Penguin", _arg_2:String="api.dlsnetwork.com"):void{
            __learnerID = _arg_1;
            __host = _arg_2;
        }

        public static function get instance():DLSManager{
            if (__instance == null){
                __instance = new (DLSManager)();
            };
            return (__instance);
        }

        public static function set learnerID(_arg_1:String):void{
            __learnerID = _arg_1;
        }

        public static function get learnerID():String{
            return (__learnerID);
        }

        public static function set host(_arg_1:String):void{
            __host = _arg_1;
        }

        public static function get host():String{
            return (__host);
        }


        public function pushOpcode(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:String="100", _arg_5:String="null", _arg_6:String="null", _arg_7:String="null"):int{
            var opcode:String = _arg_1;
            var guid:String = _arg_2;
            var callback:Function = _arg_3;
            var register1:String = _arg_4;
            var register2:String = _arg_5;
            var register3:String = _arg_6;
            var register4:String = _arg_7;
            if (!this.isValidOpcode(opcode)){
                trace((("Invalid opcode. Opcode " + opcode) + " is not a valid opcode."));
                return (0);
            };
            var d:Date = new Date();
            var time:Number = Number(Math.round((d.getTime() / 1000)));
            if (__learnerID == ""){
                __learnerID = "-1";
            };
            if (opcode == ""){
                opcode = "no_opcode_given";
            };
            var url:String = (((((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + time) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.learner = __learnerID;
            loader.opcode = opcode;
            loader.target = guid;
            loader.callback = callback;
            var cookie:int = int(this.__URLLoaderCookieId++);
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
            if (((__learnerID == "-1") || (__learnerID == "Penguin"))){
                this.__lc.sendMessage("API", url);
            };
            try {
                loader.load(request);
            } catch(error:Error) {
            };
            return (cookie);
        }

        private function isValidOpcode(_arg_1:String):Boolean{
            var _local_2:String = _arg_1.toLowerCase();
            if (((((((((_local_2 == LEARNER_SCORE.toLowerCase()) || (_local_2 == GAME_SCORE.toLowerCase())) || (_local_2 == START.toLowerCase())) || (_local_2 == STOP.toLowerCase())) || (_local_2 == SELECTED.toLowerCase())) || (_local_2 == PRESENTED.toLowerCase())) || (_local_2 == NOTIFY.toLowerCase())) || (_local_2 == USED.toLowerCase()))){
                return (true);
            };
            return (false);
        }

        public function pushOpcodeToHost(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Function, _arg_5:String="100", _arg_6:String="null", _arg_7:String="null", _arg_8:String="null"):int{
            var host:String = _arg_1;
            var opcode:String = _arg_2;
            var guid:String = _arg_3;
            var callback:Function = _arg_4;
            var register1:String = _arg_5;
            var register2:String = _arg_6;
            var register3:String = _arg_7;
            var register4:String = _arg_8;
            if (!this.isValidOpcode(opcode)){
                trace((("Invalid opcode. Opcode " + opcode) + " is not a valid opcode."));
                return (0);
            };
            var d:Date = new Date();
            var time:Number = Number(Math.round((d.getTime() / 1000)));
            if (__learnerID == ""){
                __learnerID = "-1";
            };
            if (opcode == ""){
                opcode = "no_opcode_given";
            };
            if (host == ""){
                host = "k.api.dlsnetwork.com";
            };
            var url:String = (((((((((((((((((("http://" + host) + "/v1/opcode/pushOpcode/") + opcode) + "/") + __learnerID) + "/") + time) + "/") + guid) + "/") + register1) + "/") + register2) + "/") + register3) + "/") + register4) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.learner = __learnerID;
            loader.opcode = opcode;
            loader.target = guid;
            loader.callback = callback;
            var cookie:int = int(this.__URLLoaderCookieId++);
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
            if (((__learnerID == "-1") || (__learnerID == "Penguin"))){
                this.__lc.sendMessage("API", url);
            };
            try {
                loader.load(request);
            } catch(error:Error) {
            };
            return (cookie);
        }

        public function getAvailableContent(_arg_1:String, _arg_2:Function, _arg_3:String="depth"):int{
            var guid:String = _arg_1;
            var callback:Function = _arg_2;
            var sortingOrder:String = _arg_3;
            var cookie:int = int(this.__URLLoaderCookieId++);
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
            var time:Number = Number(Math.round((d.getTime() / 1000)));
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
            try {
                loader.load(request);
            } catch(error:Error) {
            };
            return (cookie);
        }

        public function getLearnerScores(_arg_1:Function):int{
            var callback:Function = _arg_1;
            var cookie:int = int(this.__URLLoaderCookieId++);
            this.__URLCallbacks[cookie] = callback;
            var url:String = (((("http://" + __host) + "/v1/reports/getLearnerScores/") + __learnerID) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.id = cookie;
            this.configureListeners(loader);
            var request:URLRequest = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = "";
            var d:Date = new Date();
            var time:Number = Number(Math.round((d.getTime() / 1000)));
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
            try {
                loader.load(request);
            } catch(error:Error) {
            };
            return (cookie);
        }

        public function getLearnerScoreByNode(_arg_1:String, _arg_2:Function):int{
            var guid:String = _arg_1;
            var callback:Function = _arg_2;
            var cookie:int = int(this.__URLLoaderCookieId++);
            this.__URLCallbacks[cookie] = callback;
            var url:String = (((((("http://" + __host) + "/v1/reports/getLearnerScoreByNode/") + __learnerID) + "/") + guid) + "/");
            var loader:DLSManagerURLLoader = new DLSManagerURLLoader();
            loader.id = cookie;
            this.configureListeners(loader);
            var request:URLRequest = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = "";
            var d:Date = new Date();
            var time:Number = Number(Math.round((d.getTime() / 1000)));
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
            try {
                loader.load(request);
            } catch(error:Error) {
            };
            return (cookie);
        }

        private function configureListeners(_arg_1:IEventDispatcher):void{
            _arg_1.addEventListener(Event.COMPLETE, this.completeHandler);
            _arg_1.addEventListener(Event.OPEN, this.openHandler);
            _arg_1.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
            _arg_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            _arg_1.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            _arg_1.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
        }

        private function completeHandler(_arg_1:Event):void{
            var e:DLSEvent;
            var event:Event = _arg_1;
            var loader:DLSManagerURLLoader = DLSManagerURLLoader(event.target);
            var cookie:int = int(loader.id);
            var rValue:* = null;
            try {
                rValue = this.__URLCallbacks[cookie](loader.data);
            } catch(error:Error) {
                trace("Unable to invoke callback.");
            };
            try {
                this.__lc.sendMessage("RESULT", loader.data);
                e = new DLSEvent(loader.opcode, loader.learner, loader.target, loader.data, cookie);
                this.dispatchEvent(e);
            } catch(error:Error) {
                trace("Unable to dispatch DLS Event");
            };
        }

        private function openHandler(_arg_1:Event):void{
            trace(("openHandler: " + _arg_1));
        }

        private function progressHandler(_arg_1:ProgressEvent):void{
            trace(((("progressHandler loaded:" + _arg_1.bytesLoaded) + " total: ") + _arg_1.bytesTotal));
        }

        private function securityErrorHandler(_arg_1:SecurityErrorEvent):void{
            trace(("securityErrorHandler: " + _arg_1));
        }

        private function httpStatusHandler(_arg_1:HTTPStatusEvent):void{
            trace(("httpStatusHandler: " + _arg_1));
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void{
            trace(("ioErrorHandler: " + _arg_1));
            this.reload(DLSManagerURLLoader(_arg_1.target));
        }

        private function reload(_arg_1:DLSManagerURLLoader):void{
            _arg_1.reloadCount++;
            if (_arg_1.reloadCount < 10){
                _arg_1.load(_arg_1.request);
            };
        }

        private function encryptURL(_arg_1:String, _arg_2:String, _arg_3:String):String{
            var _local_4:* = (((_arg_1 + _arg_2) + _arg_3) + "_Salt");
            var _local_5:String = MD5.hash(_local_4);
            return (_local_5);
        }

        private function encryptTime(_arg_1:String):String{
            return (_arg_1);
        }


    }
}//package com.disney.disneylearning.managers

import flash.net.URLLoader;
import flash.net.URLRequest;

class DLSManagerURLLoader extends URLLoader {

    public var id:int = 0;
    public var opcode:String = "";
    public var learner:String = "";
    public var target:String = "";
    public var callback:Function = null;
    public var reloadCount:int = 0;
    public var request:URLRequest = null;


}

