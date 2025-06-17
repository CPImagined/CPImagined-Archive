//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.world
{
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.main.model.MainModel;
    import org.osflash.signals.Signal;

    public class WorldService 
    {

        private static const IGLOO_ROOM_START_ID:uint = 1000;
        private static const MESSSAGE_TYPE_WORLD_JOINED:String = "js";
        private static const MESSSAGE_TYPE_JOIN_ROOM:String = "jr";

        private var _connection:IConnection;
        private var _mainModel:MainModel;


        public function init(connection:IConnection, mainModel:MainModel):void
        {
            this._connection = connection;
            this._mainModel = mainModel;
            Signal(this._connection.getResponded()).add(this.onResponded);
        }

        public function onResponded(messageType:String, responseData:Array):void
        {
            switch (messageType)
            {
                case MESSSAGE_TYPE_WORLD_JOINED:
                    this._mainModel.signalBus.joinedWorld.dispatch();
                    break;
                case MESSSAGE_TYPE_JOIN_ROOM:
                    if (((int(responseData[1]) <= IGLOO_ROOM_START_ID) && (this._mainModel.roomPuffles)))
                    {
                        this._mainModel.roomPuffles.destroy(true);
                    };
                    break;
            };
        }

        public function destroy():void
        {
            Signal(this._connection.getResponded()).remove(this.onResponded);
        }


    }
}//package com.clubpenguin.services.socket.world
