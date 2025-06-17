//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;

    public class HudVisibilityChangedCommand extends SignalCommand 
    {

        [Inject]
        public var isVisible:Boolean;
        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.friendsService.hudVisibilityChanged(this.isVisible);
        }


    }
}//package com.clubpenguin.lib.friends.commands
