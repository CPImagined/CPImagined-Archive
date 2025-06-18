//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.disney.friends.Friend;
    import com.adobe.serialization.json.JSON;

    public class FriendsUpdatedCommand extends SignalCommand 
    {

        private static const MSG_FRIENDS_UPDATED:String = "friendsUpdate";

        [Inject]
        public var friends:Array;
        [Inject]
        public var bridge:IAVMBridgeService;


        override public function execute():void
        {
            var friend:Friend;
            var jsonStr:String;
            var rawFriends:Array = [];
            for each (friend in this.friends)
            {
                rawFriends.push(friend.toRaw());
            };
            jsonStr = com.adobe.serialization.json.JSON.encode(rawFriends);
            this.bridge.sendStringInChunks(jsonStr, MSG_FRIENDS_UPDATED);
        }


    }
}//package com.clubpenguin.lib.friends.commands
