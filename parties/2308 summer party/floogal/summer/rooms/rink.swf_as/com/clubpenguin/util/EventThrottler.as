dynamic class com.clubpenguin.util.EventThrottler
{
    static var EVENT_TYPE_FUNCTION: Number = 0;
    var _maxQueueSize: Number = 0;
    var _intervalId: Number = -1;
    var _delayBetweenEvents;
    var _eventQueue;

    function EventThrottler()
    {
        this._eventQueue = [];
        this.__set__delayBetweenEvents(0);
    }

    function set delayBetweenEvents(delay)
    {
        this._delayBetweenEvents = delay;
        if (this._delayBetweenEvents < 0) 
        {
            this._delayBetweenEvents = 0;
        }
        if (this._intervalId != -1) 
        {
            this.disableInterval();
            if (this._delayBetweenEvents > 0) 
            {
                this.enableInterval();
            }
        }
        if (this._delayBetweenEvents == 0 && this._eventQueue.length > 0) 
        {
            this.processNextEvent();
        }
    }

    function set maxQueueSize(size)
    {
        this._maxQueueSize = size == undefined ? 0 : size;
    }

    function queueFunction(callback)
    {
        if (this._maxQueueSize > 0 && this._eventQueue.length >= this._maxQueueSize) 
        {
            return undefined;
        }
        this._eventQueue.push({type: com.clubpenguin.util.EventThrottler.EVENT_TYPE_FUNCTION, callback: callback});
        if (this._delayBetweenEvents <= 0) 
        {
            this.processNextEvent();
            return;
        }
        if (this._intervalId == -1) 
        {
            this.enableInterval();
            if (this._eventQueue.length == 1) 
            {
                this.processNextEvent();
            }
        }
    }

    function clearQueue()
    {
        this._eventQueue.length = 0;
        this.disableInterval();
    }

    function processNextEvent()
    {
        if (this._eventQueue.length > 0) 
        {
            var __reg2 = this._eventQueue.shift();
            this.invokeEvent(__reg2);
            if (this._delayBetweenEvents <= 0) 
            {
                this.processNextEvent();
            }
            return;
        }
        this.disableInterval();
    }

    function invokeEvent(event)
    {
        if (event.type == com.clubpenguin.util.EventThrottler.EVENT_TYPE_FUNCTION) 
        {
            event.callback();
        }
    }

    function enableInterval()
    {
        clearInterval(this._intervalId);
        this._intervalId = setInterval(this, "processNextEvent", this._delayBetweenEvents);
    }

    function disableInterval()
    {
        clearInterval(this._intervalId);
        this._intervalId = -1;
    }

}
