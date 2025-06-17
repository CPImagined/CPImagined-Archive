package fl.data
{

    dynamic public class SimpleCollectionItem extends Object
    {
        public var label:String;
        public var data:String;

        public function SimpleCollectionItem()
        {
            return;
        }// end function

        public function toString() : String
        {
            return "[SimpleCollectionItem: " + this.label + "," + this.data + "]";
        }// end function

    }
}
