package com.clubpenguin.game{
    import flash.display.DisplayObject;

    public interface ICPGameHost extends ICPHost {

        function localizeString(_arg_1:String):String;
        function localizeImage(_arg_1:String):DisplayObject;

    }
}//package com.clubpenguin.game
