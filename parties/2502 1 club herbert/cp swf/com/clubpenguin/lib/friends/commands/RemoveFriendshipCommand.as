//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;

    public class RemoveFriendshipCommand extends SignalCommand 
    {

        [Inject]
        public var swid:String;
        [Inject]
        public var removeAfterIgnore:Boolean;
        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.friendsService.removeFriendship(this.swid, this.removeAfterIgnore);
        }


    }
}//package com.clubpenguin.lib.friends.commands
