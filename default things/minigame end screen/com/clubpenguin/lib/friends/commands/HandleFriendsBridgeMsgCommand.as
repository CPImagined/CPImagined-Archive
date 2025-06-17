//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.friends.FriendsSignalBus;
    import com.disney.friends.CredentialsVO;

    public class HandleFriendsBridgeMsgCommand extends SignalCommand 
    {

        private static const MSG_CONNECT_TO_FRIENDS:String = "connectToFriends";
        private static const MSG_DISCONNECT_FROM_FRIENDS:String = "disconnectFromFriends";
        private static const MSG_UPDATE_PRESENCE:String = "updatePresence";
        private static const MSG_TOGGLE_FRIENDS_UI:String = "toggleFriendsUI";
        private static const MSG_PLAYER_FOUND:String = "playerFound";
        private static const MSG_SEND_FRIEND_REQUEST:String = "sendFriendRequest";
        private static const MSG_REMOVE_FRIENDSHIP:String = "removeFriendship";
        private static const MSG_ADD_IGNORED:String = "addIgnored";
        private static const MSG_REMOVE_IGNORED:String = "removeIgnored";
        private static const MSG_ADD_MASCOT_FRIEND:String = "addMascotFriend";
        private static const MSG_REMOVE_MASCOT_FRIEND:String = "removeMascotFriend";
        private static const MSG_HUD_VISIBILITY_CHANGED:String = "hudVisibilityChanged";
        private static const MSG_ADD_INTERACTION:String = "addInteraction";

        [Inject]
        public var message:Object;
        [Inject]
        public var friendsSignalBus:FriendsSignalBus;


        override public function execute():void
        {
            switch (this.message.type)
            {
                case MSG_CONNECT_TO_FRIENDS:
                    this.friendsSignalBus.connectToFriends.dispatch(this.message);
                    break;
                case MSG_DISCONNECT_FROM_FRIENDS:
                    this.friendsSignalBus.disconnectFromFriends.dispatch(this.message);
                    break;
                case MSG_UPDATE_PRESENCE:
                    this.friendsSignalBus.updatePresence.dispatch(this.message.presence);
                    break;
                case MSG_TOGGLE_FRIENDS_UI:
                    this.friendsSignalBus.toggleFriendsUI.dispatch(-1);
                    break;
                case MSG_PLAYER_FOUND:
                    this.friendsSignalBus.playerFound.dispatch(CredentialsVO.fromRaw(this.message.credentials));
                    break;
                case MSG_SEND_FRIEND_REQUEST:
                    this.friendsSignalBus.sendFriendRequest.dispatch(this.message.swid);
                    break;
                case MSG_REMOVE_FRIENDSHIP:
                    this.friendsSignalBus.removeFriendship.dispatch(this.message.swid, this.message.removeAfterIgnore);
                    break;
                case MSG_ADD_IGNORED:
                    this.friendsSignalBus.addIgnored.dispatch(this.message.swid);
                    break;
                case MSG_REMOVE_IGNORED:
                    this.friendsSignalBus.removeIgnored.dispatch(this.message.swid);
                    break;
                case MSG_ADD_MASCOT_FRIEND:
                    this.friendsSignalBus.addMascotFriend.dispatch(this.message.id);
                    break;
                case MSG_REMOVE_MASCOT_FRIEND:
                    this.friendsSignalBus.removeMascotFriend.dispatch(this.message.id);
                    break;
                case MSG_HUD_VISIBILITY_CHANGED:
                    this.friendsSignalBus.hudVisibilityChanged.dispatch(this.message.isVisibile);
                    break;
                case MSG_ADD_INTERACTION:
                    if (this.message.swid != null)
                    {
                        this.friendsSignalBus.addInteraction.dispatch(this.message.swid, this.message.points);
                    };
                    break;
            };
        }


    }
}//package com.clubpenguin.lib.friends.commands
