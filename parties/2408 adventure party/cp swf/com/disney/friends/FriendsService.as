//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.friends
{
    import org.osflash.signals.Signal;
    import flash.utils.Timer;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.model.IMetricsModel;
    import flash.events.TimerEvent;
    import com.clubpenguin.lib.enums.metrics.MetricsConstant;

    public class FriendsService 
    {

        public static const JUMP_TYPE_RESERVATION:Number = 1;
        public static const JUMP_TYPE_JUMP:Number = 2;
        public static const JUMP_TYPE_RESERVATION_AND_JUMP:Number = 3;

        public const connected:Signal = new Signal(String);
        public const disconnected:Signal = new Signal();
        public const friendsUpdated:Signal = new Signal(Array);
        public const playerCardRequested:Signal = new Signal(String);
        public const characterCardRequested:Signal = new Signal(int);
        public const findPlayerRequested:Signal = new Signal(String);
        public const friendshipRequested:Signal = new Signal(String);
        public const presenceUpdated:Signal = new Signal(Presence);
        public const friendshipAccepted:Signal = new Signal(Friend);
        public const friendshipRemoved:Signal = new Signal(String);
        public const ignoredUpdated:Signal = new Signal(Array);
        public const jumpCrossServerRequested:Signal = new Signal(Friend, int);
        public const snowballRecieved:Signal = new Signal(String);
        public const ignoreLimitReached:Signal = new Signal();
        public const jumpRequested:Signal = new Signal(Object, Boolean, Friend);
        public const closedNotification:Signal = new Signal();
        public const showingNotification:Signal = new Signal();
        private const _FPS:Number = 24;
        private const _MAX_MESSAGES:Number = 3;

        private var _isConnected:Boolean = false;
        private var _connection:FriendsAPIConnection;
        private var _commandQueue:Array;
        private var _queueTimer:Timer;
        private var _commandQueueActive:Boolean;
        [Inject]
        public var appModel:IAppModel;
        [Inject]
        public var metricsModel:IMetricsModel;

        public function FriendsService(connection:FriendsAPIConnection)
        {
            this._connection = connection;
            this.setupEventListeners();
            this._commandQueue = [];
            this._queueTimer = new Timer(Math.ceil((1000 / this._FPS)));
            this._queueTimer.addEventListener(TimerEvent.TIMER, this.onQueueTimer);
            this._queueTimer.start();
        }

        public function get connection():FriendsAPIConnection
        {
            return (this._connection);
        }

        private function onQueueTimer(event:TimerEvent):void
        {
            var spliceCount:int;
            var executeList:Array;
            var commandObj:Object;
            var command:String;
            var params:Array;
            if (this._commandQueueActive)
            {
                spliceCount = ((this._commandQueue.length < this._MAX_MESSAGES) ? this._commandQueue.length : this._MAX_MESSAGES);
                executeList = this._commandQueue.splice(0, spliceCount);
                while (executeList.length > 0)
                {
                    commandObj = executeList.shift();
                    command = commandObj.command;
                    params = commandObj.params;
                    this.metricsModel.counters.incrementCounter(MetricsConstant.COUNT_FRIENDS_EI_CALLS);
                    this._connection.sendCommand(command, params);
                };
            };
        }

        private function queueCommand(command:String, params:Array):void
        {
            if (!this.isCommandInQueue(command, params))
            {
                this._commandQueue.push({
                    "command":command,
                    "params":params
                });
            };
        }

        private function isCommandInQueue(command:String, params:Array):Boolean
        {
            var commandObj:Object;
            var i:int;
            var j:int;
            for each (commandObj in this._commandQueue)
            {
                if (commandObj.command == command)
                {
                    if (((params.length > 0) && (commandObj.params.length == params.length)))
                    {
                        i = 0;
                        while (i < commandObj.params.length)
                        {
                            j = 0;
                            while (j < params.length)
                            {
                                if (commandObj.params[i] == params[j])
                                {
                                    return (true);
                                };
                                j++;
                            };
                            i++;
                        };
                    }
                    else
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        private function setupEventListeners():void
        {
            this._connection.addEventListener(FriendsEvent.CONNECTED, this.onConnected);
            this._connection.addEventListener(FriendsEvent.DISCONNECTED, this.onDisconnect);
            this._connection.addEventListener(FriendsEvent.FRIENDS_UPDATED, this.onFriendsUpdated);
            this._connection.addEventListener(FriendsEvent.SHOW_PLAYER_CARD, this.onPlayerCardRequested);
            this._connection.addEventListener(FriendsEvent.SHOW_CHARACTER_CARD, this.onCharacterCardRequested);
            this._connection.addEventListener(FriendsEvent.FIND_PLAYER, this.onFindPlayerRequested);
            this._connection.addEventListener(FriendsEvent.PENDING_UPDATE, this.onPendingUpdateReceived);
            this._connection.addEventListener(FriendsEvent.USER_PRESENCE_UPDATE, this.onUserPresenceUpdated);
            this._connection.addEventListener(FriendsEvent.FRIENDS_NEW, this.onFriendshipAccepted);
            this._connection.addEventListener(FriendsEvent.FRIENDS_REMOVE, this.onFriendshipRemoved);
            this._connection.addEventListener(FriendsEvent.IGNORED_UPDATE, this.onIgnoredUpdate);
            this._connection.addEventListener(FriendsEvent.FRIENDS_JUMP, this.onJumpRequested);
            this._connection.addEventListener(FriendsEvent.CLOSED_NOTIFICATION, this.onClosedNotification);
            this._connection.addEventListener(FriendsEvent.SHOWING_NOTIFICATION, this.onShowingNotification);
            this._connection.addEventListener(FriendsEvent.IGNORE_LIMIT, this.onIgnoreLimit);
            this._connection.addEventListener(FriendsEvent.SNOWBALL_RECEIVED, this.onSnowballReceived);
        }

        public function connectAndLogin(swid:String, loginKey:String):void
        {
            this.metricsModel.counters.registerCounter(MetricsConstant.COUNT_FRIENDS_EI_CALLS);
            if (this._connection.connectToJavaScriptAPI())
            {
                this._connection.sendCommand("connect", [swid, loginKey]);
                this.metricsModel.counters.incrementCounter(MetricsConstant.COUNT_FRIENDS_EI_CALLS);
            };
        }

        public function disconnect():void
        {
            this._connection.sendCommand("disconnect", ["gameTimeout"]);
            this.metricsModel.counters.incrementCounter(MetricsConstant.COUNT_FRIENDS_EI_CALLS);
        }

        public function toggleUIVisibility(mode:int=-1):void
        {
            var args:Array = [];
            if (mode != -1)
            {
                args.push(mode);
            };
            this.queueCommand("toggle", args);
        }

        public function updateStatus(status:String):void
        {
            this.queueCommand("updateStatus", [status]);
        }

        public function activityHeartbeat():void
        {
            this.queueCommand("activityHeartbeat", []);
        }

        public function updatePresence(presence:Presence):void
        {
            this.queueCommand("updatePresence", [presence]);
        }

        public function playerFound(credentials:CredentialsVO):void
        {
            this.queueCommand("foundPlayer", [credentials]);
        }

        public function requestFriendship(swid:String):void
        {
            this.queueCommand("requestFriendship", [swid]);
        }

        public function addMascotFriend(id:int):void
        {
            this.queueCommand("addCharacter", [id]);
        }

        public function removeMascotFriend(id:int):void
        {
            this.queueCommand("removeCharacter", [id]);
        }

        public function acceptFriendship(swid:String):void
        {
            this.queueCommand("acceptFriendship", [swid]);
        }

        public function rejectFriendship(swid:String):void
        {
            this.queueCommand("rejectFriendship", [swid]);
        }

        public function removeFriendship(swid:String, removeAfterIgnore:Boolean):void
        {
            this.queueCommand("removeFriendship", [swid, removeAfterIgnore]);
        }

        public function addIgnored(swid:String):void
        {
            this.queueCommand("addIgnored", [swid]);
        }

        public function removeIgnored(swid:String):void
        {
            this.queueCommand("removeIgnored", [swid]);
        }

        public function jumpFailure(targetPlayerSwid:String):void
        {
            this.queueCommand("jumpFailure", [targetPlayerSwid]);
        }

        public function reservationReady(targetPlayerSwid:String):void
        {
            this.queueCommand("reservationReady", [targetPlayerSwid]);
        }

        public function hudVisibilityChanged(isVisible:Boolean):void
        {
            this.queueCommand("hudVisibilityChanged", [isVisible, 573, 439]);
        }

        public function idlePlayerTimeout():void
        {
            this.queueCommand("disconnect", ["gameTimeout"]);
        }

        public function addInteraction(swid:String, interactionPoints:int):void
        {
            this.queueCommand("addInteraction", [swid, interactionPoints]);
        }

        public function respondToSnowballs(throwSWIDs:Array, ignoreSWIDs:Array):void
        {
            this.queueCommand("respondToSnowballs", [throwSWIDs, ignoreSWIDs]);
        }

        private function onConnected(event:FriendsEvent):void
        {
            var sid:String = event.data[0].sid;
            this._isConnected = true;
            this.connected.dispatch(sid);
            this._commandQueueActive = true;
        }

        private function onDisconnect(event:FriendsEvent):void
        {
            this._isConnected = false;
            this.disconnected.dispatch();
        }

        private function onFriendsUpdated(event:FriendsEvent):void
        {
            var friend:Friend;
            var key:String;
            var friends:Array = [];
            if (((event.data[0].swid) || (event.data[0].character)))
            {
                friend = Friend.fromRaw(event.data[0]);
                friends.push(friend);
            }
            else
            {
                for (key in event.data[0])
                {
                    friend = Friend.fromRaw(event.data[0][key]);
                    friends.push(friend);
                };
            };
            if (friends.length)
            {
                this.friendsUpdated.dispatch(friends);
            };
        }

        private function onFriendshipAccepted(event:FriendsEvent):void
        {
            this.friendshipAccepted.dispatch(Friend.fromRaw(event.data[0]));
        }

        private function onFriendshipRemoved(event:FriendsEvent):void
        {
            this.friendshipRemoved.dispatch(event.data[0]);
        }

        private function onPendingUpdateReceived(event:FriendsEvent):void
        {
            this.friendshipRequested.dispatch(event.data[0].swid);
        }

        public function onIgnoreLimit(event:FriendsEvent):void
        {
            this.ignoreLimitReached.dispatch();
        }

        private function onUserPresenceUpdated(event:FriendsEvent):void
        {
            var key:String;
            for (key in event.data[1])
            {
            };
        }

        private function onPlayerCardRequested(event:FriendsEvent):void
        {
            var swid:String = String(event.data[0]);
            this.playerCardRequested.dispatch(swid);
        }

        private function onCharacterCardRequested(event:FriendsEvent):void
        {
            var characterId:int = parseInt(event.data[0]);
            this.characterCardRequested.dispatch(characterId);
        }

        private function onFindPlayerRequested(event:FriendsEvent):void
        {
            var name:String = String(event.data[0]);
            this.findPlayerRequested.dispatch(name);
        }

        private function onSnowballReceived(event:FriendsEvent):void
        {
            this.snowballRecieved.dispatch(event.data[0]);
        }

        private function onIgnoredUpdate(event:FriendsEvent):void
        {
            var key:String;
            var credentialsVO:CredentialsVO;
            var data:Object = event.data[0];
            var ignoredCredentials:Array = [];
            for (key in data)
            {
                credentialsVO = CredentialsVO.fromRaw(data[key]);
                ignoredCredentials.push(credentialsVO);
            };
            this.ignoredUpdated.dispatch(ignoredCredentials);
        }

        private function onJumpRequested(event:FriendsEvent):void
        {
            var data:Object = event.data[0];
            var targetPlayerId:String = data.id;
            var worldId:int = data.location.world;
            var jumpType:int = data.type;
            var rawFriend:Object = {};
            rawFriend.swid = data.swid;
            rawFriend.name = "";
            rawFriend.presence = {
                "id":targetPlayerId,
                "status":"",
                "location":{"world":worldId}
            };
            var friend:Friend = Friend.fromRaw(rawFriend);
            if (this.appModel.getCurrentWorldData().id != worldId)
            {
                if (((jumpType == JUMP_TYPE_RESERVATION_AND_JUMP) || (jumpType == JUMP_TYPE_RESERVATION)))
                {
                    this.jumpCrossServerRequested.dispatch(friend, jumpType);
                }
                else
                {
                    if (jumpType == JUMP_TYPE_JUMP)
                    {
                        this.jumpRequested.dispatch(this.appModel.getCurrentWorldData(), true, friend);
                    };
                };
            }
            else
            {
                this.jumpRequested.dispatch(this.appModel.getCurrentWorldData(), false, friend);
            };
        }

        private function onClosedNotification(event:FriendsEvent):void
        {
            if (!this.appModel.getOverrideBlockAllNotifications())
            {
                this.closedNotification.dispatch();
            };
        }

        private function onShowingNotification(event:FriendsEvent):void
        {
            this.showingNotification.dispatch();
        }


    }
}//package com.disney.friends
