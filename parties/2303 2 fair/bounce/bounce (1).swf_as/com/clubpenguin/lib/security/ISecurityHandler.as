package com.clubpenguin.lib.security{
    import flash.display.DisplayObject;
    import org.osflash.signals.ISignal;

    public interface ISecurityHandler {

        function doSecurityCheck(_arg_1:DisplayObject):void;
        function getSecurityCheckSuccess():ISignal;

    }
}//package com.clubpenguin.lib.security
