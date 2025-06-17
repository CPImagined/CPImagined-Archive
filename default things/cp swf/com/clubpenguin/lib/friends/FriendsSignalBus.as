//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends
{
    import org.osflash.signals.Signal;
    import com.disney.friends.CredentialsVO;
    import com.disney.friends.Friend;
    import org.robotlegs.core.ISignalCommandMap;
    import com.clubpenguin.lib.friends.commands.HandleFriendsBridgeMsgCommand;
    import com.clubpenguin.lib.friends.commands.ConnectToFriendsCommand;
    import com.clubpenguin.lib.friends.commands.DisconnectFromFriendsCommand;
    import com.clubpenguin.lib.friends.commands.UpdatePresenceCommand;
    import com.clubpenguin.lib.friends.commands.ToggleFriendsUICommand;
    import com.clubpenguin.lib.friends.commands.PlayerFoundCommand;
    import com.clubpenguin.lib.friends.commands.RequestFriendshipCommand;
    import com.clubpenguin.lib.friends.commands.RemoveFriendshipCommand;
    import com.clubpenguin.lib.friends.commands.AddIgnoredCommand;
    import com.clubpenguin.lib.friends.commands.RemoveIgnoredCommand;
    import com.clubpenguin.lib.friends.commands.AddMascotFriendCommand;
    import com.clubpenguin.lib.friends.commands.RemoveMascotFriendCommand;
    import com.clubpenguin.lib.friends.commands.jump.RequestReservationCommand;
    import com.clubpenguin.lib.friends.commands.jump.JumpToServerCommand;
    import com.clubpenguin.lib.friends.commands.HudVisibilityChangedCommand;
    import com.clubpenguin.lib.friends.commands.AddInteractionCommand;

    public class FriendsSignalBus 
    {

        public const handleFriendsBridgeMessage:Signal = new Signal(Object);
        public const connectToFriends:Signal = new Signal(Object);
        public const disconnectFromFriends:Signal = new Signal(Object);
        public const updatePresence:Signal = new Signal(Object);
        public const toggleFriendsUI:Signal = new Signal(int);
        public const playerFound:Signal = new Signal(CredentialsVO);
        public const sendFriendRequest:Signal = new Signal(String);
        public const acceptFriendship:Signal = new Signal(String);
        public const rejectFriendship:Signal = new Signal(String);
        public const removeFriendship:Signal = new Signal(String, Boolean);
        public const addIgnored:Signal = new Signal(String);
        public const removeIgnored:Signal = new Signal(String);
        public const addMascotFriend:Signal = new Signal(int);
        public const removeMascotFriend:Signal = new Signal(int);
        public const requestReservation:Signal = new Signal(Friend, String, int);
        public const jumpToServer:Signal = new Signal(Object, Boolean, Friend);
        public const hudVisibilityChanged:Signal = new Signal(Boolean);
        public const addInteraction:Signal = new Signal(String, int);

        private var _signalCommandMap:ISignalCommandMap;

        public function FriendsSignalBus(signalCommandMap:ISignalCommandMap)
        {
            this._signalCommandMap = signalCommandMap;
            this.mapCommands();
        }

        private function mapCommands():void
        {
            this._signalCommandMap.mapSignal(this.handleFriendsBridgeMessage, HandleFriendsBridgeMsgCommand);
            this._signalCommandMap.mapSignal(this.connectToFriends, ConnectToFriendsCommand);
            this._signalCommandMap.mapSignal(this.disconnectFromFriends, DisconnectFromFriendsCommand);
            this._signalCommandMap.mapSignal(this.updatePresence, UpdatePresenceCommand);
            this._signalCommandMap.mapSignal(this.toggleFriendsUI, ToggleFriendsUICommand);
            this._signalCommandMap.mapSignal(this.playerFound, PlayerFoundCommand);
            this._signalCommandMap.mapSignal(this.sendFriendRequest, RequestFriendshipCommand);
            this._signalCommandMap.mapSignal(this.removeFriendship, RemoveFriendshipCommand);
            this._signalCommandMap.mapSignal(this.addIgnored, AddIgnoredCommand);
            this._signalCommandMap.mapSignal(this.removeIgnored, RemoveIgnoredCommand);
            this._signalCommandMap.mapSignal(this.addMascotFriend, AddMascotFriendCommand);
            this._signalCommandMap.mapSignal(this.removeMascotFriend, RemoveMascotFriendCommand);
            this._signalCommandMap.mapSignal(this.requestReservation, RequestReservationCommand);
            this._signalCommandMap.mapSignal(this.jumpToServer, JumpToServerCommand);
            this._signalCommandMap.mapSignal(this.hudVisibilityChanged, HudVisibilityChangedCommand);
            this._signalCommandMap.mapSignal(this.addInteraction, AddInteractionCommand);
        }


    }
}//package com.clubpenguin.lib.friends
