//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.friends
{
    import flash.events.EventDispatcher;
    import flash.external.ExternalInterface;

    public class FriendsAPIConnection extends EventDispatcher 
    {

        private static const API_PACKAGE:String = "Disney.Friends.API";

        private var _silentFailure:Boolean;
        private var _nameSpace:String;
        private var _connectedToAPI:Boolean = false;

        public function FriendsAPIConnection(nameSpace:String, silentFailure:Boolean=false)
        {
            this._silentFailure = silentFailure;
            this._nameSpace = nameSpace;
        }

        public function connectToJavaScriptAPI():Boolean
        {
            this._connectedToAPI = this.isAPIAvailable();
            FriendsEvent.registerExternalEventHandler(this.friendsEventHandler, this._nameSpace);
            return (this._connectedToAPI);
        }

        private function isAPIAvailable():Boolean
        {
            if (!ExternalInterface.available)
            {
                if (!this._silentFailure)
                {
                    throw (new Error("The Friends AS3 API uses ExternalInterface and must be run within a web browser."));
                };
                return (false);
            };
            if (!ExternalInterface.call((API_PACKAGE + ".toString")))
            {
                if (!this._silentFailure)
                {
                    throw (new Error((("External container does not have reference to " + API_PACKAGE) + ".  Please make sure the JavaScript API URL is correct.")));
                };
                return (false);
            };
            return (true);
        }

        private function friendsEventHandler(eventType:String, ... args):void
        {
            var eventData:Array = args[0].concat();
            dispatchEvent(new FriendsEvent(eventType, eventData));
        }

        public function sendCommand(cmdName:String, params:Array):Object
        {
            if (!this._connectedToAPI)
            {
                if (!this._silentFailure)
                {
                    throw (new Error(("FriendsAPIConnection must first connect to JavaScript API." + "  Call connectToJavaScriptAPI() before calling sendCommand()")));
                };
                return (null);
            };
            var applyParams:Array = params.concat();
            applyParams.unshift(((API_PACKAGE + ".") + cmdName));
            return (ExternalInterface.call.apply(null, applyParams));
        }

        public function get nameSpace():String
        {
            return (this._nameSpace);
        }


    }
}//package com.disney.friends
