dynamic class com.clubpenguin.lib.event.Event extends Object
{
    var __eventData;
    var __eventDispatcher;
    var __eventType;

    function Event(_source, _type, _data)
    {
        super();
        this.__eventDispatcher = _source;
        this.__eventType = _type;
        this.__eventData = _data;
    }

    function get target()
    {
        return this.__eventDispatcher;
    }

    function set target(_val)
    {
        this.__eventDispatcher = _val;
    }

    function get data()
    {
        return this.__eventData;
    }

    function set data(_val)
    {
        this.__eventData = _val;
    }

    function get type()
    {
        return this.__eventType;
    }

    function set type(_val)
    {
        this.__eventType = _val;
    }

    function clone()
    {
        var __reg2 = undefined;
        __reg2 = this.createEvent();
        return __reg2;
    }

    function createEvent()
    {
        return new com.clubpenguin.lib.event.Event(this.__eventDispatcher, this.__eventType, this.__eventData);
    }

    function toString()
    {
        var __reg1 = undefined;
        __reg1 = "Event";
        return __reg1;
    }

}
