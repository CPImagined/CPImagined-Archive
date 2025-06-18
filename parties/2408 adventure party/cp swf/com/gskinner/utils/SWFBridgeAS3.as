//Created by Action Script Viewer - https://www.buraks.com/asv
package com.gskinner.utils
{
    import flash.events.EventDispatcher;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.ErrorVO;
    import flash.net.LocalConnection;
    import flash.events.StatusEvent;
    import flash.events.AsyncErrorEvent;
    import flash.events.SecurityErrorEvent;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import flash.events.Event;

    public class SWFBridgeAS3 extends EventDispatcher 
    {

        public const error:Signal = new Signal(ErrorVO);

        private var baseID:String;
        private var myID:String;
        private var extID:String;
        private var lc:LocalConnection;
        private var _connected:Boolean;
        private var host:Boolean = true;
        private var clientObj:Object;

        public function SWFBridgeAS3(p_id:String, p_clientObj:Object, allowedDomains:Array)
        {
            var domain:String;
            super();
            this.baseID = p_id.split(":").join("");
            this.lc = new LocalConnection();
            for each (domain in allowedDomains)
            {
                this.lc.allowDomain(domain);
            };
            this.lc.client = this;
            this.clientObj = p_clientObj;
            this.lc.addEventListener(StatusEvent.STATUS, this.handleLocalConnectionStatus);
            this.lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, dispatchEvent);
            this.lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
            this.connect();
        }

        private function connect():void
        {
            try
            {
                this.lc.connect((this.baseID + "_host"));
            }
            catch(e:ArgumentError)
            {
                host = false;
            };
            this.myID = (this.baseID + ((this.host) ? "_host" : "_guest"));
            this.extID = (this.baseID + ((this.host) ? "_guest" : "_host"));
            if (!this.host)
            {
                this.lc.connect(this.myID);
                this.lc.send(this.extID, "com_gskinner_utils_SWFBridge_init");
            };
        }

        public function handleLocalConnectionStatus(statusEvent:StatusEvent):void
        {
            if (statusEvent.level == "error")
            {
                if (this._connected)
                {
                    this._connected = false;
                    this.error.dispatch(new ErrorVO(((statusEvent.code + " ") + statusEvent.type), ErrorCodeEnum.BRIDGE_DISCONNECT.getId()));
                };
            };
        }

        public function send(p_method:String, ... p_args):void
        {
            if (!this._connected)
            {
                throw (new ArgumentError("Send failed because the object is not connected."));
            };
            p_args.unshift(p_method);
            p_args.unshift("com_gskinner_utils_SWFBridge_receive");
            p_args.unshift(this.extID);
            this.lc.send.apply(this.lc, p_args);
        }

        public function close():void
        {
            try
            {
                this.lc.close();
            }
            catch(e)
            {
            };
            this.lc = null;
            this.clientObj = null;
            if (!this._connected)
            {
                throw (new ArgumentError("Close failed because the object is not connected."));
            };
            this._connected = false;
        }

        public function get id():String
        {
            return (this.baseID);
        }

        public function get connected():Boolean
        {
            return (this._connected);
        }

        public function com_gskinner_utils_SWFBridge_receive(p_method:String, ... p_args):void
        {
            try
            {
                this.clientObj[p_method].apply(this.clientObj, p_args);
            }
            catch(e)
            {
                throw (new Error(((("SWFBridge ERROR:  " + e) + "\n") + e.getStackTrace())));
            };
        }

        public function com_gskinner_utils_SWFBridge_init():void
        {
            if (this.host)
            {
                this.lc.send(this.extID, "com_gskinner_utils_SWFBridge_init");
            };
            this._connected = true;
            dispatchEvent(new Event(Event.CONNECT));
        }


    }
}//package com.gskinner.utils
