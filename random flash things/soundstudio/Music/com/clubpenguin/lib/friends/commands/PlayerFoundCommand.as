//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.CredentialsVO;
    import com.disney.friends.FriendsService;

    public class PlayerFoundCommand extends SignalCommand 
    {

        [Inject]
        public var credentials:CredentialsVO;
        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.friendsService.playerFound(this.credentials);
        }


    }
}//package com.clubpenguin.lib.friends.commands
