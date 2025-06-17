package fl.managers
{

    public interface IFocusManagerGroup
    {

        public function IFocusManagerGroup();

        function get groupName() : String;

        function set groupName(param1:String) : void;

        function get selected() : Boolean;

        function set selected(param1:Boolean) : void;

    }
}
