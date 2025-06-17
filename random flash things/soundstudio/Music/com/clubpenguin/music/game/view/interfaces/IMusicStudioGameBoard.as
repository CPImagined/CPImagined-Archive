//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.interfaces
{
    public interface IMusicStudioGameBoard 
    {

        function recordingPermissionUpdate(_arg_1:Boolean):void;
        function setGenre(_arg_1:int):void;
        function getGenre():int;
        function recordingStarted():void;
        function recordingStopped():void;
        function updateRecordingTime(_arg_1:Number):void;

    }
}//package com.clubpenguin.music.game.view.interfaces
