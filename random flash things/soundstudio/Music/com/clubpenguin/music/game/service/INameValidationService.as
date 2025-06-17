//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.service
{
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.services.socket.IConnection;

    public interface INameValidationService 
    {

        function get initialized():Boolean;
        function get nameValidationResult():Signal;
        function checkName(_arg_1:String):void;
        function init(_arg_1:IConnection):void;
        function destroy():void;

    }
}//package com.clubpenguin.music.game.service
