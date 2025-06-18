//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.managers
{
    import fl.controls.Button;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObjectContainer;

    public interface IFocusManager 
    {

        function get defaultButton():Button;
        function set defaultButton(_arg_1:Button):void;
        function get defaultButtonEnabled():Boolean;
        function set defaultButtonEnabled(_arg_1:Boolean):void;
        function get nextTabIndex():int;
        function get showFocusIndicator():Boolean;
        function set showFocusIndicator(_arg_1:Boolean):void;
        function getFocus():InteractiveObject;
        function setFocus(_arg_1:InteractiveObject):void;
        function showFocus():void;
        function hideFocus():void;
        function activate():void;
        function deactivate():void;
        function findFocusManagerComponent(_arg_1:InteractiveObject):InteractiveObject;
        function getNextFocusManagerComponent(_arg_1:Boolean=false):InteractiveObject;
        function get form():DisplayObjectContainer;
        function set form(_arg_1:DisplayObjectContainer):void;

    }
}//package fl.managers
