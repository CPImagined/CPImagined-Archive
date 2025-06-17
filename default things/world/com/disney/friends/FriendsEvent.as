//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.friends
{
    import flash.events.Event;
    import flash.external.ExternalInterface;

    public class FriendsEvent extends Event 
    {

        public static const CONNECTED:String = "connected";
        public static const DISCONNECTED:String = "disconnected";
        public static const FRIENDS_UPDATED:String = "friendsUpdate";
        public static const SHOW_PLAYER_CARD:String = "showPlayerCard";
        public static const SHOW_CHARACTER_CARD:String = "showCharacterCard";
        public static const FIND_PLAYER:String = "findPlayer";
        public static const PENDING_UPDATE:String = "pendingUpdate";
        public static const USER_PRESENCE_UPDATE:String = "userPresenceUpdate";
        public static const FRIENDS_NEW:String = "friendsNew";
        public static const FRIENDS_REMOVE:String = "friendsRemove";
        public static const IGNORED_UPDATE:String = "ignoredUpdate";
        public static const FRIENDS_JUMP:String = "friendsJump";
        public static const CLOSED_NOTIFICATION:String = "closedNotification";
        public static const SHOWING_NOTIFICATION:String = "showingNotification";
        public static const IGNORE_LIMIT:String = "ignoreLimit";
        public static const SNOWBALL_RECEIVED:String = "receivedSnowball";
        private static const API_PACKAGE:String = "Disney.Friends.Event";
        private static const ADD_LISTENER_FUNC:String = "addGameListener";
        private static const FRIENDS_HANDLER_NAME:String = "friendsEventHandler";

        private var _data:Array;

        public function FriendsEvent(_arg_1:String, data:Array)
        {
            super(_arg_1);
            this._data = data;
        }

        public static function registerExternalEventHandler(handler:Function, nameSpace:String):void
        {
            ExternalInterface.addCallback(FRIENDS_HANDLER_NAME, handler);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), CONNECTED, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), DISCONNECTED, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), FRIENDS_UPDATED, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), SHOW_PLAYER_CARD, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), SHOW_CHARACTER_CARD, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), FIND_PLAYER, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), PENDING_UPDATE, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), USER_PRESENCE_UPDATE, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), FRIENDS_NEW, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), FRIENDS_REMOVE, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), IGNORED_UPDATE, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), FRIENDS_JUMP, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), SHOWING_NOTIFICATION, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), CLOSED_NOTIFICATION, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), IGNORE_LIMIT, nameSpace);
            ExternalInterface.call(((FriendsEvent.API_PACKAGE + ".") + ADD_LISTENER_FUNC), SNOWBALL_RECEIVED, nameSpace);
        }


        public function get data():Array
        {
            return (this._data);
        }


    }
}//package com.disney.friends
