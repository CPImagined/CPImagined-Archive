dynamic class com.disney.dlearning.debug.DLSLocalConnectionProducer extends Object
{
    var conn;

    function DLSLocalConnectionProducer()
    {
        super();
        this.conn = new LocalConnection();
        this.conn.onStatus = this.onStatus;
    }

    function sendMessage(type, message)
    {
        var __reg2 = new Object();
        __reg2.type = type;
        __reg2.message = message;
        var __reg3 = new com.disney.dlearning.serialization.JSON();
        this.conn.send("DLS.CONNECTION", "DLSlcHandler", __reg3.stringify(__reg2));
    }

    function onStatus(event)
    {
        if ((__reg0 = event.level) === "status") 
        {
            return;
        }
        else if (__reg0 !== "error") 
        {
            return;
        }
        return;
    }

}
