
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.SoundLayer
    {
        var id, name, maxConcurrent, numSoundsPlaying;
        function SoundLayer (_arg_3, _arg_2, _arg_4) {
            id = _arg_3;
            name = _arg_2;
            maxConcurrent = _arg_4;
            numSoundsPlaying = 0;
        }
        function canPlaySound() {
            return((numSoundsPlaying < maxConcurrent) || (maxConcurrent == -1));
        }
        function toString() {
            return(((((("SoundLayer{name:" + name) + ", maxConcurrent:") + maxConcurrent) + ", numSoundsPlaying:") + numSoundsPlaying) + "}");
        }
    }
