//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services.socket
{
    import org.osflash.signals.ISignal;

    public interface IConnection 
    {

        function getResponded():ISignal;
        function sendMessage(_arg_1:String, _arg_2:String, _arg_3:Array=null, _arg_4:String="s"):void;

    }
}//package com.clubpenguin.lib.services.socket
