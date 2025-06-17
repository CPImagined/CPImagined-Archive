//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands.jump
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.friends.FriendsSignalBus;
    import com.disney.friends.Friend;

    public class GetReservationKeyCommand extends SignalCommand 
    {

        private static const HANDLER:String = "q";
        private static const GET_RESERVATION_KEY:String = "rkey";

        [Inject]
        public var connection:IConnection;
        [Inject]
        public var signalBus:FriendsSignalBus;
        [Inject]
        public var friend:Friend;
        [Inject]
        public var jumpType:int;


        override public function execute():void
        {
            this.connection.getResponded().add(this.onConnectionResponded);
            this.connection.sendMessage(HANDLER, GET_RESERVATION_KEY, []);
        }

        private function onConnectionResponded(commandName:String, params:Array):void
        {
            if (commandName != GET_RESERVATION_KEY)
            {
                return;
            };
            this.connection.getResponded().remove(this.onConnectionResponded);
            if (params[1] == "failed")
            {
                return;
            };
            var reservationKey:String = params[1];
            this.signalBus.requestReservation.dispatch(this.friend, reservationKey, this.jumpType);
        }


    }
}//package com.clubpenguin.lib.friends.commands.jump
