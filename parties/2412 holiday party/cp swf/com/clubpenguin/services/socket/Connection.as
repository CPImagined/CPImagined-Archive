//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket
{
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.services.AVMBridgeService;
    import org.osflash.signals.Signal;
    import org.osflash.signals.ISignal;

    public class Connection implements IConnection 
    {

        private static const SOCKET_MESSAGE_DELIMITER:String = "%";

        private var _bridge:AVMBridgeService = null;
        private var _socketBuffer:String = null;
        private var _responded:Signal = new Signal(String, Array);

        public function Connection():void
        {
        }

        public function init(bridge:AVMBridgeService):void
        {
            this._bridge = bridge;
            this._bridge.airTowerEventReceived.add(this.onAirtowerEventReceived);
        }

        public function getResponded():ISignal
        {
            return (this._responded);
        }

        public function sendMessage(category:String, messageType:String, args:Array=null, extension:String="s"):void
        {
            var argumentString:String;
            if (((this._bridge) && (this._bridge.isConnected())))
            {
                argumentString = "";
                if (args)
                {
                    argumentString = (args.join(SOCKET_MESSAGE_DELIMITER) + SOCKET_MESSAGE_DELIMITER);
                };
                this._bridge.sendServerCommand(((((((extension + SOCKET_MESSAGE_DELIMITER) + category) + SOCKET_MESSAGE_DELIMITER) + messageType) + SOCKET_MESSAGE_DELIMITER) + argumentString));
            };
        }

        public function onAirtowerEventReceived(event:String):void
        {
            var eventCommand:String;
            var eventData:Array;
            if (this._socketBuffer == null)
            {
                this._socketBuffer = event;
            }
            else
            {
                this._socketBuffer = (this._socketBuffer + event);
            };
            var indexOfEndChunking:int = this._socketBuffer.search(AVMBridgeService.END_OF_CHUNKING_DELIMITER);
            if (indexOfEndChunking != -1)
            {
                this._socketBuffer = this._socketBuffer.substring(0, indexOfEndChunking);
                eventData = this._socketBuffer.split(SOCKET_MESSAGE_DELIMITER);
                eventData.pop();
                eventCommand = eventData.shift();
                this._socketBuffer = null;
                Signal(this._responded).dispatch(eventCommand, eventData);
            };
        }


    }
}//package com.clubpenguin.services.socket
