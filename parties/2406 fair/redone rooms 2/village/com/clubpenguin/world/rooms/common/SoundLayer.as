﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.SoundLayer
    {
        var id, name, maxConcurrent, numSoundsPlaying;
        function SoundLayer (id, name, maxConcurrent) {
            this.id = id;
            this.name = name;
            this.maxConcurrent = maxConcurrent;
            numSoundsPlaying = 0;
        }
        function canPlaySound() {
            return((numSoundsPlaying < maxConcurrent) || (maxConcurrent == -1));
        }
        function toString() {
            return(((((("SoundLayer{name:" + name) + ", maxConcurrent:") + maxConcurrent) + ", numSoundsPlaying:") + numSoundsPlaying) + "}");
        }
    }
