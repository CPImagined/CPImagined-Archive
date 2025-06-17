//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.resource
{
    public class ResourceTypeEnum 
    {

        public static const CLOTHING:ResourceTypeEnum = new ResourceTypeEnum("clothing", 1);
        public static const FURNITURE:ResourceTypeEnum = new ResourceTypeEnum("furniture", 2);

        public var value:String;
        public var ordinal:int;

        public function ResourceTypeEnum(value:String, ordinal:int)
        {
            this.value = value;
            this.ordinal = ordinal;
        }

        public function toString():String
        {
            return ((("value = " + this.value) + ", ordinal = ") + this.ordinal);
        }


    }
}//package com.clubpenguin.lib.enums.resource
