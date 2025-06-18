dynamic class com.clubpenguin.util.LogChannel
{
    static var _numMasks: Number = 0;
    var _name: String = "";
    var _bitMask: Number = 0;

    function LogChannel(name)
    {
        this._name = name;
        this._bitMask = 1 << com.clubpenguin.util.LogChannel._numMasks;
        ++com.clubpenguin.util.LogChannel._numMasks;
        com.clubpenguin.util.Log.ALL._bitMask = com.clubpenguin.util.Log.ALL._bitMask + this.bitMask;
    }

    function get name()
    {
        return this._name;
    }

    function get bitMask()
    {
        return this._bitMask;
    }

}
