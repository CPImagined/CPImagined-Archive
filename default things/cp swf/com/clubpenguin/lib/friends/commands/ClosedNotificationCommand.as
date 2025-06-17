//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.notifications.INotificationService;

    public class ClosedNotificationCommand extends SignalCommand 
    {

        [Inject]
        public var notificationService:INotificationService;


        override public function execute():void
        {
            this.notificationService.start(false);
        }


    }
}//package com.clubpenguin.lib.friends.commands
