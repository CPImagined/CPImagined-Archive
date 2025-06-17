//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.disneylearning.managers
{
    import flash.events.EventDispatcher;
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
    import com.adobe.crypto.*;
    import flash.net.*;

    public class NewsPaperDLSManager extends EventDispatcher 
    {

        private static var __instance:NewsPaperDLSManager;
        private static var __learnerID:String;
        private static var __host:String;

        private var __URLLoaderCookieId:int = 0;
        private var __URLCallbacks:Array = new Array();
        private var __sequenceID:int = 0;


        public static function init(_arg_1:String="Penguin", _arg_2:String="api.dlsnetwork.com"):void
        {
            __learnerID = _arg_1;
            __host = _arg_2;
        }

        public static function get instance():NewsPaperDLSManager
        {
            if (__instance == null)
            {
                __instance = new (NewsPaperDLSManager)();
            };
            return (__instance);
        }


        public function set learnerID(_arg_1:String):void
        {
            __learnerID = _arg_1;
        }

        public function set host(_arg_1:String):void
        {
            __host = _arg_1;
        }

        public function pushOpcode(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:String="100", _arg_5:String="null", _arg_6:String="null"):int
        {
            var _local_7:Date = new Date();
            var _local_8:Number = Math.round((_local_7.getTime() / 1000));
            if (__learnerID == "")
            {
                __learnerID = "-1";
            };
            if (_arg_1 == "")
            {
                _arg_1 = "no_opcode_given";
            };
            var _local_9:* = (((((((((((((((("http://" + __host) + "/v1/opcode/pushOpcode/") + _arg_1) + "/") + __learnerID) + "/") + _local_8) + "/") + _arg_2) + "/") + _arg_4) + "/") + _arg_5) + "/") + _arg_6) + "/");
            var _local_10:DLSManagerURLLoader = new DLSManagerURLLoader();
            _local_10.learner = __learnerID;
            _local_10.opcode = _arg_1;
            _local_10.target = _arg_2;
            _local_10.callback = _arg_3;
            var _local_11:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[_local_11] = _arg_3;
            _local_10.id = _local_11;
            this.configureListeners(_local_10);
            var _local_12:URLRequest = new URLRequest(_local_9);
            _local_12.method = URLRequestMethod.POST;
            _local_12.data = "";
            var _local_13:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var _local_14:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(_local_9, _local_8.toString(), "ClubPenguin") + "|") + this.encryptTime(_local_8.toString())));
            var _local_15:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            _local_12.requestHeaders.push(_local_13);
            _local_12.requestHeaders.push(_local_14);
            _local_12.requestHeaders.push(_local_15);
            _local_10.request = _local_12;
            try
            {
                _local_10.load(_local_12);
            }
            catch(error:Error)
            {
            };
            return (_local_11);
        }

        public function getAvailableContent(_arg_1:String, _arg_2:Function, _arg_3:String="depth"):int
        {
            var _local_4:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[_local_4] = _arg_2;
            var _local_5:* = (((((((("http://" + __host) + "/v1/content/getAvailableContent/") + __learnerID) + "/") + _arg_1) + "/") + _arg_3) + "/");
            var _local_6:DLSManagerURLLoader = new DLSManagerURLLoader();
            _local_6.id = _local_4;
            _local_6.learner = __learnerID;
            _local_6.callback = _arg_2;
            this.configureListeners(_local_6);
            var _local_7:URLRequest = new URLRequest(_local_5);
            _local_7.method = URLRequestMethod.POST;
            _local_7.data = "";
            var _local_8:Date = new Date();
            var _local_9:Number = Math.round((_local_8.getTime() / 1000));
            var _local_10:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var _local_11:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(_local_5, _local_9.toString(), "ClubPenguin") + "|") + this.encryptTime(_local_9.toString())));
            var _local_12:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            _local_7.requestHeaders.push(_local_10);
            _local_7.requestHeaders.push(_local_11);
            _local_7.requestHeaders.push(_local_12);
            var _local_13:URLVariables = new URLVariables();
            _local_13.noCache = Number(new Date().getTime());
            _local_7.data = _local_13;
            try
            {
                _local_6.load(_local_7);
            }
            catch(error:Error)
            {
            };
            return (_local_4);
        }

        public function getLearnerScores(_arg_1:Function):int
        {
            var _local_2:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[_local_2] = _arg_1;
            var _local_3:* = (((("http://" + __host) + "/v1/reports/getLearnerScores/") + __learnerID) + "/");
            var _local_4:DLSManagerURLLoader = new DLSManagerURLLoader();
            _local_4.id = _local_2;
            this.configureListeners(_local_4);
            var _local_5:URLRequest = new URLRequest(_local_3);
            _local_5.method = URLRequestMethod.POST;
            _local_5.data = "";
            var _local_6:Date = new Date();
            var _local_7:Number = Math.round((_local_6.getTime() / 1000));
            var _local_8:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var _local_9:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(_local_3, _local_7.toString(), "ClubPenguin") + "|") + this.encryptTime(_local_7.toString())));
            var _local_10:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            _local_5.requestHeaders.push(_local_8);
            _local_5.requestHeaders.push(_local_9);
            _local_5.requestHeaders.push(_local_10);
            var _local_11:URLVariables = new URLVariables();
            _local_11.learner = __learnerID;
            _local_5.data = _local_11;
            try
            {
                _local_4.load(_local_5);
            }
            catch(error:Error)
            {
            };
            return (_local_2);
        }

        public function getLearnerScoreByNode(_arg_1:String, _arg_2:Function):int
        {
            var _local_3:int = this.__URLLoaderCookieId++;
            this.__URLCallbacks[_local_3] = _arg_2;
            var _local_4:* = (((((("http://" + __host) + "/v1/reports/getLearnerScoreByNode/") + __learnerID) + "/") + _arg_1) + "/");
            var _local_5:DLSManagerURLLoader = new DLSManagerURLLoader();
            _local_5.id = _local_3;
            this.configureListeners(_local_5);
            var _local_6:URLRequest = new URLRequest(_local_4);
            _local_6.method = URLRequestMethod.POST;
            _local_6.data = "";
            var _local_7:Date = new Date();
            var _local_8:Number = Math.round((_local_7.getTime() / 1000));
            var _local_9:URLRequestHeader = new URLRequestHeader("DLSNetwork-Developer-ID", "ClubPenguin");
            var _local_10:URLRequestHeader = new URLRequestHeader("DLSNetwork-Request-Key", ((this.encryptURL(_local_4, _local_8.toString(), "ClubPenguin") + "|") + this.encryptTime(_local_8.toString())));
            var _local_11:URLRequestHeader = new URLRequestHeader("DLSNetwork-Sequence-ID", String(this.__sequenceID++));
            _local_6.requestHeaders.push(_local_9);
            _local_6.requestHeaders.push(_local_10);
            _local_6.requestHeaders.push(_local_11);
            var _local_12:URLVariables = new URLVariables();
            _local_12.noCache = Number(new Date().getTime());
            _local_6.data = _local_12;
            try
            {
                _local_5.load(_local_6);
            }
            catch(error:Error)
            {
            };
            return (_local_3);
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

        private function openHandler(_arg_1:Event):void
        {
            trace(("openHandler: " + _arg_1));
        }

        private function progressHandler(_arg_1:ProgressEvent):void
        {
            trace(((("progressHandler loaded:" + _arg_1.bytesLoaded) + " total: ") + _arg_1.bytesTotal));
        }

        private function securityErrorHandler(_arg_1:SecurityErrorEvent):void
        {
            trace(("securityErrorHandler: " + _arg_1));
        }

        private function httpStatusHandler(_arg_1:HTTPStatusEvent):void
        {
            trace(("httpStatusHandler: " + _arg_1));
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            trace(("ioErrorHandler: " + _arg_1));
            this.reload(DLSManagerURLLoader(_arg_1.target));
        }

        private function reload(_arg_1:DLSManagerURLLoader):void
        {
            _arg_1.reloadCount++;
            if (_arg_1.reloadCount < 10)
            {
                _arg_1.load(_arg_1.request);
            };
        }

        private function encryptURL(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            var _local_4:* = (((_arg_1 + _arg_2) + _arg_3) + "_Salt");
            var _local_5:String = MD5.hash(_local_4);
            return (_local_5);
        }

        private function encryptTime(_arg_1:String):String
        {
            return (_arg_1);
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

