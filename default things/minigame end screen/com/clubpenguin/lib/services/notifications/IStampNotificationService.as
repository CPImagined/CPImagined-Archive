//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.notifications
{
    import org.osflash.signals.Signal;

    public interface IStampNotificationService 
    {

        function showStampEarned(_arg_1:int, _arg_2:int):void;
        function getStampEarnedNotificationShown():Signal;

    }
}//package com.clubpenguin.lib.services.notifications
