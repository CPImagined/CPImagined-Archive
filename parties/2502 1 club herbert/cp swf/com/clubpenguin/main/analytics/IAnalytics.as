//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.analytics
{
    public interface IAnalytics 
    {

        function track(_arg_1:String, _arg_2:Array=null):Boolean;
        function getContext():AnalyticsContext;
        function setContext(_arg_1:AnalyticsContext):void;

    }
}//package com.clubpenguin.main.analytics
