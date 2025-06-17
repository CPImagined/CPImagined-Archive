//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends
{
    import com.disney.friends.FriendsAPIConnection;
    import com.disney.friends.FriendsService;
    import com.clubpenguin.lib.security.SecurityHandler;
    import com.clubpenguin.lib.friends.model.FriendsSnowballQueue;
    import com.clubpenguin.lib.friends.commands.ShowPlayerCardCommand;
    import com.clubpenguin.lib.friends.commands.ShowCharacterCardCommand;
    import com.clubpenguin.lib.friends.commands.FindPlayerCommand;
    import com.clubpenguin.lib.friends.commands.FriendsUpdatedCommand;
    import com.clubpenguin.lib.friends.commands.FriendshipRemovedCommand;
    import com.clubpenguin.lib.friends.commands.IgnoredUpdatedCommand;
    import com.clubpenguin.lib.friends.commands.jump.GetReservationKeyCommand;
    import com.clubpenguin.lib.friends.commands.jump.JumpToServerCommand;
    import com.clubpenguin.lib.friends.commands.ClosedNotificationCommand;
    import com.clubpenguin.lib.friends.commands.ShowingNotificationCommand;
    import com.clubpenguin.lib.friends.commands.IgnoreLimitReachedCommand;
    import com.clubpenguin.lib.friends.commands.SnowballReceivedCommand;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.ISignalCommandMap;

    public class FriendsMappings 
    {

        private const FREINDS_NAMESPACE:String = "disney:land:clubpenguin";

        public function FriendsMappings(injector:IInjector, signalCommandMap:ISignalCommandMap)
        {
            var friendsConnection:FriendsAPIConnection = new FriendsAPIConnection(this.FREINDS_NAMESPACE, true);
            var friendsService:FriendsService = new FriendsService(friendsConnection);
            injector.mapValue(FriendsService, friendsService);
            injector.injectInto(friendsService);
            injector.mapValue(SecurityHandler, new SecurityHandler());
            injector.mapSingleton(FriendsSnowballQueue);
            injector.mapSingleton(FriendsSignalBus);
            signalCommandMap.mapSignal(friendsService.playerCardRequested, ShowPlayerCardCommand);
            signalCommandMap.mapSignal(friendsService.characterCardRequested, ShowCharacterCardCommand);
            signalCommandMap.mapSignal(friendsService.findPlayerRequested, FindPlayerCommand);
            signalCommandMap.mapSignal(friendsService.friendsUpdated, FriendsUpdatedCommand);
            signalCommandMap.mapSignal(friendsService.friendshipRemoved, FriendshipRemovedCommand);
            signalCommandMap.mapSignal(friendsService.ignoredUpdated, IgnoredUpdatedCommand);
            signalCommandMap.mapSignal(friendsService.jumpCrossServerRequested, GetReservationKeyCommand);
            signalCommandMap.mapSignal(friendsService.jumpRequested, JumpToServerCommand);
            signalCommandMap.mapSignal(friendsService.closedNotification, ClosedNotificationCommand);
            signalCommandMap.mapSignal(friendsService.showingNotification, ShowingNotificationCommand);
            signalCommandMap.mapSignal(friendsService.ignoreLimitReached, IgnoreLimitReachedCommand);
            signalCommandMap.mapSignal(friendsService.snowballRecieved, SnowballReceivedCommand);
        }

    }
}//package com.clubpenguin.lib.friends
