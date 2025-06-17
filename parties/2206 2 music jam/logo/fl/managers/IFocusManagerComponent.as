//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.managers
{
    public interface IFocusManagerComponent 
    {

        function get focusEnabled():Boolean;
        function set focusEnabled(_arg_1:Boolean):void;
        function get mouseFocusEnabled():Boolean;
        function get tabEnabled():Boolean;
        function get tabIndex():int;
        function setFocus():void;
        function drawFocus(_arg_1:Boolean):void;

    }
}//package fl.managers
