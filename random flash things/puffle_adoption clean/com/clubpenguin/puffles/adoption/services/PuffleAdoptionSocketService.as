//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.services
{
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.playdom.tracker.Tracker;
    import org.osflash.signals.Signal;
    import com.playdom.baseactors.BaseMoney;
    import com.clubpenguin.lib.services.socket.ConnectionConstants;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;

    public class PuffleAdoptionSocketService 
    {

        private static const MESSAGE_TYPE_ADOPT_PUFFLE:String = "pn";
        private static const MESSAGE_TYPE_CHECK_PUFFLE_NAME:String = "pcn";
        private static const MESSAGE_TYPE_INVALID_NAME:String = "441";
        private static const MESSAGE_TYPE_ADOPT_NOT_ENOUGH_COINS:String = "401";
        private static const MESSAGE_TYPE_WALK_PUFFLE:String = "pw";
        private static const MESSAGE_TYPE_PUFFLE_ADOPTION_BI:String = "bipa";
        private static const MESSAGE_TYPE_REQUEST_NAME_SUGGESTION:String = "recommendpufflenames";
        private static const MESSAGE_TYPE_CHECK_PUFFLE_NAME_WITH_RESPONSE:String = "checkpufflename";

        private var _connection:IConnection;
        private var _adoptionModel:AdoptionModel;
        private var _appSignalBus:SignalBus;
        private var _tracker:Tracker;


        public function init(connection:IConnection, adoptionModel:AdoptionModel, appSignalBus:SignalBus, tracker:Tracker):void
        {
            this._connection = connection;
            this._adoptionModel = adoptionModel;
            this._appSignalBus = appSignalBus;
            this._tracker = tracker;
            Signal(this._connection.getResponded()).add(this.onResponded);
        }

        public function destroy():void
        {
            Signal(this._connection.getResponded()).remove(this.onResponded);
        }

        public function onResponded(messageType:String, responseData:Array):void
        {
            var payload:Object;
            var puffleCost:BaseMoney;
            var typeName:String;
            var subtypeID:Number;
            var newBalance:int;
            var i:int;
            switch (messageType)
            {
                case MESSAGE_TYPE_CHECK_PUFFLE_NAME:
                    this._adoptionModel.validNameSelected.dispatch();
                    break;
                case MESSAGE_TYPE_CHECK_PUFFLE_NAME_WITH_RESPONSE:
                    if (responseData[2] == 0)
                    {
                        this._adoptionModel.setSelectedNameAsInvalid(responseData[1]);
                    }
                    else
                    {
                        if (responseData[2] == 1)
                        {
                            this._adoptionModel.setSelectedNameAsValid(responseData[1]);
                        };
                    };
                    break;
                case MESSAGE_TYPE_REQUEST_NAME_SUGGESTION:
                    this._adoptionModel.handleNameSuggestions(responseData[2]);
                    break;
                case ConnectionConstants.ERROR_MESSAGE:
                    i = 0;
                    while (i < responseData.length)
                    {
                        if (responseData[i] == MESSAGE_TYPE_INVALID_NAME)
                        {
                            this._adoptionModel.invalidNameSelected.dispatch();
                        }
                        else
                        {
                            if (responseData[i] == MESSAGE_TYPE_ADOPT_NOT_ENOUGH_COINS)
                            {
                                this._adoptionModel.notEnoughCoins.dispatch();
                            };
                        };
                        i++;
                    };
                    break;
                case MESSAGE_TYPE_ADOPT_PUFFLE:
                    this._adoptionModel.selectedPuffle.id = PuffleAdoptionDataParser.getAdoptedPuffleID(responseData);
                    this._adoptionModel.selectedPuffle.adoptionDate = new Date();
                    this._adoptionModel.selectedPuffle.sendUpdate();
                    this._adoptionModel.playerVO.puffles.add(this._adoptionModel.selectedPuffle);
                    this._adoptionModel.puffleAdopted.dispatch();
                    payload = new Object();
                    payload.message = this._adoptionModel.selectedPuffle.type.colorName;
                    if (this._adoptionModel.selectedPuffle.isWild)
                    {
                        payload.puffleType = this._adoptionModel.selectedPuffle.subType.baseTypeId;
                    };
                    payload.n_puffles = this._adoptionModel.playerVO.puffles.getSize();
                    if (((((this._adoptionModel.selectedPuffle.type == PuffleTypeEnum.RAINBOW) || (this._adoptionModel.selectedPuffle.type == PuffleTypeEnum.GOLD)) || (this._adoptionModel.selectedPuffle.type.price == 0)) || (this._adoptionModel.selectedPuffle.subType.price == 0)))
                    {
                        puffleCost = new BaseMoney("coins", -1);
                    }
                    else
                    {
                        puffleCost = new BaseMoney("coins", (-1 * this._adoptionModel.selectedPuffle.price));
                    };
                    typeName = this._adoptionModel.selectedPuffle.typeName;
                    if (this._adoptionModel.selectedPuffle.isWild)
                    {
                        subtypeID = this._adoptionModel.selectedPuffle.subType.id;
                    }
                    else
                    {
                        subtypeID = -1;
                    };
                    newBalance = (this._adoptionModel.playerVO.coins - this._adoptionModel.selectedPuffle.price);
                    break;
                default:
                    return;
            };
        }

        public function sendPuffleAdoptionBI(bIDataString:String):void
        {
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_PUFFLE_ADOPTION_BI, [bIDataString]);
        }

        public function checkPuffleName(name:String):void
        {
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_CHECK_PUFFLE_NAME, [name]);
        }

        public function adoptPuffle(puffleVO:PuffleVO):void
        {
            var puffleTypeId:Number = 0;
            var puffleSubType:Number = 0;
            if (puffleVO.subType != null)
            {
                puffleSubType = puffleVO.subType.id;
                puffleTypeId = puffleVO.subType.baseTypeId;
            }
            else
            {
                puffleTypeId = puffleVO.type.value;
            };
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_ADOPT_PUFFLE, [puffleTypeId, puffleVO.name, puffleSubType]);
        }

        public function walkPuffle(puffleID:int):void
        {
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_WALK_PUFFLE, [puffleID, 1]);
        }

        public function requestNameSuggestion(_arg_1:uint, subType:uint):void
        {
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_REQUEST_NAME_SUGGESTION, [_arg_1, subType]);
        }

        public function checkPuffleNameWithResponse(name:String):void
        {
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_CHECK_PUFFLE_NAME_WITH_RESPONSE, [name]);
        }


    }
}//package com.clubpenguin.puffles.adoption.services
