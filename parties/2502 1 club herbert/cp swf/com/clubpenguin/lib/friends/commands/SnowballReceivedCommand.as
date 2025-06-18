//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.friends.model.FriendsSnowballQueue;

    public class SnowballReceivedCommand extends SignalCommand 
    {

        [Inject]
        public var swid:String;
        [Inject]
        public var friendsSnowballQueue:FriendsSnowballQueue;


        override public function execute():void
        {
            this.friendsSnowballQueue.push(this.swid);
        }


    }
}//package com.clubpenguin.lib.friends.commands
