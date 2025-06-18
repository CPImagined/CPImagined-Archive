//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;

    public class AddMascotFriendCommand extends SignalCommand 
    {

        [Inject]
        public var id:int;
        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.friendsService.addMascotFriend(this.id);
        }


    }
}//package com.clubpenguin.lib.friends.commands
