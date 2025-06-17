//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;

    public class IdlePlayerTimeoutCommand extends SignalCommand 
    {

        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.friendsService.idlePlayerTimeout();
        }


    }
}//package com.clubpenguin.main.command
