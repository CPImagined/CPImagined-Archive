//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.newspaper.models.vo
{
    public class ContentActionVO 
    {

        public var action:String;
        public var target:String;
        public var category:String;
        public var buttonInstanceName:String;


        public function toString():String
        {
            return (((((((("[ContentActionVO] -> (action: " + this.action) + ", target: ") + this.target) + ", category: ") + this.category) + ", buttonInstanceName: ") + this.buttonInstanceName) + ")");
        }

        public function getTarget():String
        {
            return (this.target);
        }


    }
}//package com.clubpenguin.newspaper.models.vo
