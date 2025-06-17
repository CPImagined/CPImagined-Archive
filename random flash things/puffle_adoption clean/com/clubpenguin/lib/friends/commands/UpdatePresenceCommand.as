//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;
    import com.disney.friends.Presence;

    public class UpdatePresenceCommand extends SignalCommand 
    {

        [Inject]
        public var rawPresence:Object;
        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.rawPresence.location.land = this.friendsService.connection.nameSpace;
            var presence:Presence = Presence.fromRaw(this.rawPresence);
            this.friendsService.updatePresence(presence);
        }


    }
}//package com.clubpenguin.lib.friends.commands
