//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.data
{
    public dynamic class SimpleCollectionItem 
    {

        [Inspectable]
        public var label:String;
        [Inspectable]
        public var data:String;


        public function toString():String
        {
            return (((("[SimpleCollectionItem: " + this.label) + ",") + this.data) + "]");
        }


    }
}//package fl.data
