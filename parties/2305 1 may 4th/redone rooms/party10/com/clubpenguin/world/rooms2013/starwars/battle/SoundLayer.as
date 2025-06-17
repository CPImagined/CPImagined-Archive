//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.SoundLayer
    {
        var name, maxConcurrent, numSoundsPlaying;
        function SoundLayer (name, maxConcurrent) {
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
