//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.core
{
    import org.osflash.signals.ISignal;

    public interface ISignalCommandMap 
    {

        function mapSignal(_arg_1:ISignal, _arg_2:Class, _arg_3:Boolean=false):void;
        function mapSignalClass(_arg_1:Class, _arg_2:Class, _arg_3:Boolean=false):ISignal;
        function hasSignalCommand(_arg_1:ISignal, _arg_2:Class):Boolean;
        function unmapSignal(_arg_1:ISignal, _arg_2:Class):void;
        function unmapSignalClass(_arg_1:Class, _arg_2:Class):void;

    }
}//package org.robotlegs.core
