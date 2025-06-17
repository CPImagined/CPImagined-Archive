//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.services.notifications.INotificationService;

    public class ShowingNotificationCommand extends SignalCommand 
    {

        [Inject]
        public var notificationService:INotificationService;


        override public function execute():void
        {
            this.notificationService.stop(false);
        }


    }
}//package com.clubpenguin.lib.friends.commands
