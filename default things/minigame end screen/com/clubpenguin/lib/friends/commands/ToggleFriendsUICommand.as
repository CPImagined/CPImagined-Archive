//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;

    public class ToggleFriendsUICommand extends SignalCommand 
    {

        [Inject]
        public var friendsService:FriendsService;
        [Inject]
        public var mode:int;


        override public function execute():void
        {
            this.friendsService.toggleUIVisibility(this.mode);
        }


    }
}//package com.clubpenguin.lib.friends.commands
