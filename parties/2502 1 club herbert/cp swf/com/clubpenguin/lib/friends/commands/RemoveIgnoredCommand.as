//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;

    public class RemoveIgnoredCommand extends SignalCommand 
    {

        [Inject]
        public var swid:String;
        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.friendsService.removeIgnored(this.swid);
        }


    }
}//package com.clubpenguin.lib.friends.commands
