//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;

    public class AddInteractionCommand extends SignalCommand 
    {

        [Inject]
        public var swid:String;
        [Inject]
        public var interactionPoints:int;
        [Inject]
        public var friendsService:FriendsService;


        override public function execute():void
        {
            this.friendsService.addInteraction(this.swid, this.interactionPoints);
        }


    }
}//package com.clubpenguin.lib.friends.commands
