//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.model
{
    public class StampVO 
    {

        public static const ICON_URL:String = "iconURL";
        public static const STAMP_LOADER_DATA:Object = {"iconURL":""};
        public static const STAMP_SUBDIRECTORY:String = "global/stampbook/stamps/";
        public static const STAMP_STATE_DEFAULT:String = "default";
        public static const STAMP_STATE_OWNED:String = "owned";
        public static const STAMP_STATE_JUST_EARNED:String = "justEarned";
        public static const EASY:int = 1;
        public static const MEDIUM:int = 2;
        public static const HARD:int = 3;
        public static const EXTREME:int = 4;
        public static const SORT_LEFT:int = 1;
        public static const SORT_MIDDLE:int = 2;
        public static const SORT_RIGHT:int = 3;

        public var id:int;
        public var sortPriority:int;
        public var state:String;
        public var title:String;
        public var description:String;
        public var member:Boolean;
        public var rank:int;


    }
}//package com.clubpenguin.endscreens.model
