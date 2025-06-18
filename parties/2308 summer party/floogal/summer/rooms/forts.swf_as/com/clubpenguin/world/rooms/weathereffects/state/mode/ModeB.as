dynamic class com.clubpenguin.world.rooms.weathereffects.state.mode.ModeB extends com.clubpenguin.world.rooms.weathereffects.state.mode.Mode implements com.clubpenguin.world.rooms.weathereffects.state.mode.IMode
{
    var _mode;

    function ModeB()
    {
        super();
        this._mode = "B";
    }

    function getMode()
    {
        return this._mode;
    }

    function toModeA()
    {
    }

    function toModeB()
    {
    }

    function toModeC()
    {
    }

}
