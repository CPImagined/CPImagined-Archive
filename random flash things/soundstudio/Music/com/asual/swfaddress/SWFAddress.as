//Created by Action Script Viewer - https://www.buraks.com/asv
package com.asual.swfaddress
{
    import flash.utils.Timer;
    import flash.external.ExternalInterface;
    import flash.events.EventDispatcher;
    import flash.errors.IllegalOperationError;
    import flash.events.TimerEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.system.Capabilities;
    import flash.events.Event;

    public class SWFAddress 
    {

        private static var _init:Boolean = false;
        private static var _initChange:Boolean = false;
        private static var _initChanged:Boolean = false;
        private static var _strict:Boolean = true;
        private static var _autoUpdate:Boolean = true;
        private static var _updating:Boolean = false;
        private static var _value:String = "";
        private static var _queue:Array = new Array();
        private static var _queueTimer:Timer = new Timer(10);
        private static var _initTimer:Timer = new Timer(10);
        private static var _availability:Boolean = ExternalInterface.available;
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        public static var onInit:Function;
        public static var onChange:Function;
        private static var _initializer:Boolean = _initialize();

        public function SWFAddress()
        {
            throw (new IllegalOperationError("SWFAddress cannot be instantiated."));
        }

        private static function _initialize():Boolean
        {
            if (_availability)
            {
                try
                {
                    _availability = (ExternalInterface.call('function() { return (typeof SWFAddress != "undefined"); }') as Boolean);
                    ExternalInterface.addCallback("getSWFAddressValue", function ():String
                    {
                        return (_value);
                    });
                    ExternalInterface.addCallback("setSWFAddressValue", _setValue);
                }
                catch(e:Error)
                {
                    _availability = false;
                };
            };
            _queueTimer.addEventListener(TimerEvent.TIMER, _callQueue);
            _initTimer.addEventListener(TimerEvent.TIMER, _check);
            _initTimer.start();
            return (true);
        }

        private static function _check(event:TimerEvent):void
        {
            if ((((typeof(SWFAddress["onInit"]) == "function") || (_dispatcher.hasEventListener(SWFAddressEvent.INIT))) && (!(_init))))
            {
                _setValueInit(_getValue());
                _init = true;
            };
            if (((((typeof(SWFAddress["onChange"]) == "function") || (_dispatcher.hasEventListener(SWFAddressEvent.CHANGE))) || (typeof(SWFAddress["onExternalChange"]) == "function")) || (_dispatcher.hasEventListener(SWFAddressEvent.EXTERNAL_CHANGE))))
            {
                _initTimer.stop();
                _init = true;
                _setValueInit(_getValue());
            };
        }

        private static function _strictCheck(value:String, force:Boolean):String
        {
            if (SWFAddress.getStrict())
            {
                if (force)
                {
                    if (value.substr(0, 1) != "/")
                    {
                        value = ("/" + value);
                    };
                }
                else
                {
                    if (value == "")
                    {
                        value = "/";
                    };
                };
            };
            return (value);
        }

        private static function _getValue():String
        {
            var value:String;
            var arr:Array;
            var ids:String;
            if (_availability)
            {
                value = (ExternalInterface.call("SWFAddress.getValue") as String);
                arr = (ExternalInterface.call("SWFAddress.getIds") as Array);
                if (arr != null)
                {
                    ids = arr.toString();
                };
            };
            if ((((ids == null) || (!(_availability))) || (_initChanged)))
            {
                value = _value;
            }
            else
            {
                if (((value == "undefined") || (value == null)))
                {
                    value = "";
                };
            };
            return (_strictCheck(((value) || ("")), false));
        }

        private static function _setValueInit(value:String):void
        {
            _value = value;
            if (!_init)
            {
                _dispatchEvent(SWFAddressEvent.INIT);
            }
            else
            {
                _dispatchEvent(SWFAddressEvent.CHANGE);
                _dispatchEvent(SWFAddressEvent.EXTERNAL_CHANGE);
            };
            _initChange = true;
        }

        private static function _setValue(value:String, _internal:Boolean):void
        {
            if (((value == "undefined") || (value == null)))
            {
                value = "";
            };
            if (((_value == value) && (_init)))
            {
                return;
            };
            if (!_initChange)
            {
                return;
            };
            _value = value;
            if (!_init)
            {
                _init = true;
                if (((typeof(SWFAddress["onInit"]) == "function") || (_dispatcher.hasEventListener(SWFAddressEvent.INIT))))
                {
                    _dispatchEvent(SWFAddressEvent.INIT);
                };
            };
            _dispatchEvent(SWFAddressEvent.CHANGE);
            _dispatchEvent(((_internal) ? SWFAddressEvent.INTERNAL_CHANGE : SWFAddressEvent.EXTERNAL_CHANGE));
        }

        private static function _dispatchEvent(_arg_1:String):void
        {
            if (_dispatcher.hasEventListener(_arg_1))
            {
                _dispatcher.dispatchEvent(new SWFAddressEvent(_arg_1));
            };
            _arg_1 = (_arg_1.substr(0, 1).toUpperCase() + _arg_1.substring(1));
            if (typeof(SWFAddress[("on" + _arg_1)]) == "function")
            {
                var _local_2:* = SWFAddress;
                (_local_2[("on" + _arg_1)]());
            };
        }

        private static function _callQueue(event:TimerEvent):void
        {
            var script:String;
            var i:int;
            var obj:Object;
            if (_queue.length != 0)
            {
                script = "";
                i = 0;
                while ((obj = _queue[i]))
                {
                    if ((obj.param is String))
                    {
                        obj.param = (('"' + obj.param) + '"');
                    };
                    script = (script + (((obj.fn + "(") + obj.param) + ");"));
                    i++;
                };
                _queue = new Array();
                navigateToURL(new URLRequest((("javascript:" + script) + "void(0);")), "_self");
            }
            else
            {
                _queueTimer.stop();
            };
        }

        private static function _call(fn:String, param:Object=""):void
        {
            if (_availability)
            {
                if (Capabilities.os.indexOf("Mac") != -1)
                {
                    if (_queue.length == 0)
                    {
                        _queueTimer.start();
                    };
                    _queue.push({
                        "fn":fn,
                        "param":param
                    });
                }
                else
                {
                    ExternalInterface.call(fn, param);
                };
            };
        }

        public static function back():void
        {
            _call("SWFAddress.back");
        }

        public static function forward():void
        {
            _call("SWFAddress.forward");
        }

        public static function up():void
        {
            var path:String = SWFAddress.getPath();
            SWFAddress.setValue(path.substr(0, (path.lastIndexOf("/", (path.length - 2)) + ((path.substr((path.length - 1)) == "/") ? 1 : 0))));
        }

        public static function go(delta:int):void
        {
            _call("SWFAddress.go", delta);
        }

        public static function href(url:String, target:String="_self"):void
        {
            if (((_availability) && (Capabilities.playerType == "ActiveX")))
            {
                ExternalInterface.call("SWFAddress.href", url, target);
                return;
            };
            navigateToURL(new URLRequest(url), target);
        }

        public static function popup(url:String, name:String="popup", options:String='""', handler:String=""):void
        {
            if (((_availability) && ((Capabilities.playerType == "ActiveX") || (ExternalInterface.call("asual.util.Browser.isSafari")))))
            {
                ExternalInterface.call("SWFAddress.popup", url, name, options, handler);
                return;
            };
            navigateToURL(new URLRequest((((((((('javascript:popup=window.open("' + url) + '","') + name) + '",') + options) + ");") + handler) + ";void(0);")), "_self");
        }

        public static function addEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _dispatcher.addEventListener(_arg_1, listener, useCapture, priority, useWeakReference);
        }

        public static function removeEventListener(_arg_1:String, listener:Function, useCapture:Boolean=false):void
        {
            _dispatcher.removeEventListener(_arg_1, listener, useCapture);
        }

        public static function dispatchEvent(event:Event):Boolean
        {
            return (_dispatcher.dispatchEvent(event));
        }

        public static function hasEventListener(_arg_1:String):Boolean
        {
            return (_dispatcher.hasEventListener(_arg_1));
        }

        public static function getBaseURL():String
        {
            var url:String;
            if (_availability)
            {
                url = String(ExternalInterface.call("SWFAddress.getBaseURL"));
            };
            return ((((url == null) || (url == "null")) || (!(_availability))) ? "" : url);
        }

        public static function getStrict():Boolean
        {
            var strict:String;
            if (_availability)
            {
                strict = (ExternalInterface.call("SWFAddress.getStrict") as String);
            };
            return ((strict == null) ? _strict : (strict == "true"));
        }

        public static function setStrict(strict:Boolean):void
        {
            _call("SWFAddress.setStrict", strict);
            _strict = strict;
        }

        public static function getAutoUpdate():Boolean
        {
            var autoUpdate:String = "null";
            if (_availability)
            {
                autoUpdate = (ExternalInterface.call("SWFAddress.getAutoUpdate") as String);
            };
            return ((autoUpdate == null) ? _autoUpdate : (autoUpdate == "true"));
        }

        public static function setAutoUpdate(autoUpdate:Boolean):void
        {
            _call("SWFAddress.setAutoUpdate", autoUpdate);
            _autoUpdate = autoUpdate;
        }

        public static function update():void
        {
            _updating = true;
            SWFAddress.setValue(_value);
            _call("SWFAddress.update");
            _updating = false;
        }

        public static function getHistory():Boolean
        {
            return ((_availability) ? ((ExternalInterface.call("SWFAddress.getHistory") as Boolean)) : false);
        }

        public static function setHistory(history:Boolean):void
        {
            _call("SWFAddress.setHistory", history);
        }

        public static function getTracker():String
        {
            return ((_availability) ? ((ExternalInterface.call("SWFAddress.getTracker") as String)) : "");
        }

        public static function setTracker(tracker:String):void
        {
            _call("SWFAddress.setTracker", tracker);
        }

        public static function getTitle():String
        {
            var title:String = ((_availability) ? ((ExternalInterface.call("SWFAddress.getTitle") as String)) : "");
            if (((title == "undefined") || (title == null)))
            {
                title = "";
            };
            return (decodeURI(title));
        }

        public static function setTitle(title:String):void
        {
            _call("SWFAddress.setTitle", encodeURI(decodeURI(title)));
        }

        public static function getStatus():String
        {
            var status:String = ((_availability) ? ((ExternalInterface.call("SWFAddress.getStatus") as String)) : "");
            if (((status == "undefined") || (status == null)))
            {
                status = "";
            };
            return (decodeURI(status));
        }

        public static function setStatus(status:String):void
        {
            _call("SWFAddress.setStatus", encodeURI(decodeURI(status)));
        }

        public static function resetStatus():void
        {
            _call("SWFAddress.resetStatus");
        }

        public static function getValue():String
        {
            return (decodeURI(_strictCheck(((_value) || ("")), false)));
        }

        public static function setValue(value:String):void
        {
            if (((value == "undefined") || (value == null)))
            {
                value = "";
            };
            value = encodeURI(decodeURI(_strictCheck(value, true)));
            if (((_value == value) && (!(_updating))))
            {
                return;
            };
            _value = value;
            _call("SWFAddress.setValue", value);
            if (_init)
            {
                if (((_autoUpdate) || (_updating)))
                {
                    _dispatchEvent(SWFAddressEvent.CHANGE);
                    _dispatchEvent(SWFAddressEvent.INTERNAL_CHANGE);
                };
            }
            else
            {
                _initChanged = true;
            };
        }

        public static function getPath():String
        {
            var value:String = SWFAddress.getValue();
            if (value.indexOf("?") != -1)
            {
                return (value.split("?")[0]);
            };
            if (value.indexOf("#") != -1)
            {
                return (value.split("#")[0]);
            };
            return (value);
        }

        public static function setPath(value:String):void
        {
            var qs:String = SWFAddress.getQueryString();
            SWFAddress.setValue((value + ((qs) ? ("?" + qs) : "")));
        }

        public static function getPathNames():Array
        {
            var path:String = SWFAddress.getPath();
            var names:Array = path.split("/");
            if (((path.substr(0, 1) == "/") || (path.length == 0)))
            {
                names.splice(0, 1);
            };
            if (path.substr((path.length - 1), 1) == "/")
            {
                names.splice((names.length - 1), 1);
            };
            return (names);
        }

        public static function getQueryString():String
        {
            var value:String = SWFAddress.getValue();
            var index:Number = value.indexOf("?");
            if (((!(index == -1)) && (index < value.length)))
            {
                return (value.substr((index + 1)));
            };
            return (null);
        }

        public static function setQueryString(value:String):void
        {
            SWFAddress.setValue((SWFAddress.getPath() + ((value) ? ("?" + value) : "")));
        }

        public static function getParameter(param:String):Object
        {
            var params:Array;
            var p:Array;
            var r:Array;
            var i:int;
            var value:String = SWFAddress.getValue();
            var index:Number = value.indexOf("?");
            if (index != -1)
            {
                value = value.substr((index + 1));
                params = value.split("&");
                r = new Array();
                i = 0;
                while (i < params.length)
                {
                    p = params[i].split("=");
                    if (p[0] == param)
                    {
                        r.push(p[1]);
                    };
                    i++;
                };
                if (r.length != 0)
                {
                    return ((r.length != 1) ? r : r[0]);
                };
            };
            return (null);
        }

        public static function setParameter(name:String, value:Object, append:Boolean=false):void
        {
            var n:String;
            var v:Object;
            var j:Number;
            var names:Array = SWFAddress.getParameterNames();
            var params:Array = [];
            var i:Number = 0;
            while (i < names.length)
            {
                n = names[i];
                v = SWFAddress.getParameter(n);
                if (typeof(v) == "string")
                {
                    v = [v];
                };
                if (n == name)
                {
                    v = (((value === null) || (value == "")) ? [] : (((append) ? v.concat([value]) : [value])));
                };
                j = 0;
                while (j < v.length)
                {
                    params.push(((n + "=") + v[j]));
                    j++;
                };
                i++;
            };
            if (names.indexOf(name) == -1)
            {
                params.push(((name + "=") + value));
            };
            SWFAddress.setQueryString(params.join("&"));
        }

        public static function getParameterNames():Array
        {
            var params:Array;
            var i:int;
            var name:String;
            var value:String = SWFAddress.getValue();
            var index:Number = value.indexOf("?");
            var names:Array = new Array();
            if (index != -1)
            {
                value = value.substr((index + 1));
                if (((!(value == "")) && (!(value.indexOf("=") == -1))))
                {
                    params = value.split("&");
                    i = 0;
                    while (i < params.length)
                    {
                        name = params[i].split("=")[0];
                        if (names.indexOf(name) == -1)
                        {
                            names.push(name);
                        };
                        i++;
                    };
                };
            };
            return (names);
        }


    }
}//package com.asual.swfaddress
