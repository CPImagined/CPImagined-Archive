//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.notifications
{
    public interface INotificationService 
    {

        function getStampNotificationService():IStampNotificationService;
        function init():void;
        function start(_arg_1:Boolean=true):void;
        function stop(_arg_1:Boolean=true):void;

    }
}//package com.clubpenguin.lib.services.notifications
