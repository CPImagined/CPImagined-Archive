//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.puffles
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.managers.resource.ResourceManager;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.services.socket.ConnectionConstants;

    public class PuffleService extends Actor 
    {

        private static const MESSSAGE_TYPE_GET_MY_PUFFLES:String = "pgu";
        private static const MESSSAGE_TYPE_GET_PLAYER_PUFFLES:String = "pg";
        private static const MESSSAGE_TYPE_GET_MY_PUFFLES_STATS:String = "pgmps";
        private static const MESSSAGE_TYPE_REST_PUFFLE:String = "pr";
        private static const MESSSAGE_TYPE_PUFFLE_INTERACTION_REST:String = "ir";
        private static const MESSSAGE_TYPE_PUFFLE_CARE_ITEM_DELIVERED:String = "pcid";
        private static const MESSAGE_TYPE_RETURN_PUFFLE:String = "prp";
        private static const MESSAGE_TYPE_PUFFLE_PLAYED_GAME:String = "ppg";
        private static const MESSAGE_TYPE_PUFFLE_PLAYED:String = "pp";

        private var _connection:IConnection;
        private var _mainModel:MainModel;
        private var _resourceManager:ResourceManager;

        public function PuffleService():void
        {
        }

        public function init(connection:IConnection, mainModel:MainModel):void
        {
            this._connection = connection;
            this._mainModel = mainModel;
            this._resourceManager = this._mainModel.resourceManager;
            Signal(this._connection.getResponded()).add(this.onResponded);
        }

        public function destroy():void
        {
            Signal(this._connection.getResponded()).remove(this.onResponded);
        }

        public function onResponded(messageType:String, responseData:Array):void
        {
            var puffleVO:PuffleVO;
            switch (messageType)
            {
                case MESSSAGE_TYPE_GET_MY_PUFFLES:
                    if (this._mainModel.myPlayerVO.puffles)
                    {
                        this._mainModel.myPlayerVO.puffles.clear(true);
                    }
                    else
                    {
                        this._mainModel.myPlayerVO.puffles = new Bag(PuffleVO);
                    };
                    this._mainModel.myPlayerVO.puffles.clear(true);
                    PuffleDataParser.getPuffles(responseData, this._mainModel.myPlayerVO.puffles, this._resourceManager);
                    break;
                case MESSSAGE_TYPE_GET_PLAYER_PUFFLES:
                    if (this._mainModel.roomPuffles)
                    {
                        this._mainModel.roomPuffles.clear(true);
                    }
                    else
                    {
                        this._mainModel.roomPuffles = new Bag(PuffleVO);
                    };
                    PuffleDataParser.getPuffles(responseData, this._mainModel.roomPuffles, this._resourceManager);
                    break;
                case MESSSAGE_TYPE_GET_MY_PUFFLES_STATS:
                    PuffleDataParser.getMyPufflesStats(responseData, this._mainModel.myPlayerVO.puffles);
                    break;
                case MESSSAGE_TYPE_PUFFLE_CARE_ITEM_DELIVERED:
                    PuffleDataParser.puffleCareItemDelivered(responseData, this._mainModel.myPlayerVO.puffles);
                    break;
                case MESSAGE_TYPE_PUFFLE_PLAYED_GAME:
                case MESSSAGE_TYPE_REST_PUFFLE:
                case MESSSAGE_TYPE_PUFFLE_INTERACTION_REST:
                case MESSAGE_TYPE_PUFFLE_PLAYED:
                    PuffleDataParser.getPufflesStats(responseData, this._mainModel.myPlayerVO.puffles);
                    PuffleDataParser.getPufflesStats(responseData, this._mainModel.roomPuffles);
                    break;
                case MESSAGE_TYPE_RETURN_PUFFLE:
                    puffleVO = (this._mainModel.myPlayerVO.puffles.getItem(int(responseData[1])) as PuffleVO);
                    if (!puffleVO)
                    {
                        throw (new Error((("[PuffleService] -> onResponded(): ERROR!!! Return Puffle message: no puffle with id = " + responseData[1]) + " found in my puffle collection!")));
                    };
                    this._mainModel.myPlayerVO.puffles.removeItem(puffleVO);
                    break;
                default:
                    return;
            };
        }

        public function getMyPufflesStats():void
        {
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSSAGE_TYPE_GET_MY_PUFFLES_STATS);
        }


    }
}//package com.clubpenguin.services.socket.puffles
