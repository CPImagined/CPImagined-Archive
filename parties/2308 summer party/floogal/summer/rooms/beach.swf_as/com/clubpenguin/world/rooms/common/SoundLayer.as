dynamic class com.clubpenguin.world.rooms.common.SoundLayer
{
    var id;
    var maxConcurrent;
    var name;
    var numSoundsPlaying;

    function SoundLayer(id, name, maxConcurrent)
    {
        this.id = id;
        this.name = name;
        this.maxConcurrent = maxConcurrent;
        this.numSoundsPlaying = 0;
    }

    function canPlaySound()
    {
        return this.numSoundsPlaying < this.maxConcurrent || this.maxConcurrent == -1;
    }

    function toString()
    {
        return "SoundLayer{name:" + this.name + ", maxConcurrent:" + this.maxConcurrent + ", numSoundsPlaying:" + this.numSoundsPlaying + "}";
    }

}
