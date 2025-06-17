//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.puffles
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.managers.resource.ResourceManager;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.services.socket.ConnectionConstants;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;
    import com.clubpenguin.lib.enums.puffle.CareItemInventoryTypeEnum;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.vo.PlayerVO;

    public class PuffleCareItemsService extends Actor 
    {

        private static const MESSAGE_TYPE_GET_CARE_INVENTORY:String = "pgpi";
        private static const MESSAGE_TYPE_ADD_PUFFLE_CARE_ITEM:String = "papi";

        [Inject]
        public var appModel:MainModel;
        [Inject]
        public var resourceManager:ResourceManager;
        public var receivedCareInventory:Signal = new Signal();
        private var connection:IConnection;

        public function PuffleCareItemsService(connection:IConnection)
        {
            this.connection = connection;
            connection.getResponded().add(this.onResponded);
        }

        public static function parseInventory(responseData:Array):Array
        {
            var item:String;
            var itemArr:Array;
            var itemObj:Object;
            responseData.shift();
            var itemList:Array = new Array();
            for each (item in responseData)
            {
                if (item)
                {
                    itemArr = item.split(ConnectionConstants.RESPONSE_DATA_DELIMITER);
                    itemObj = {
                        "id":int(itemArr[0]),
                        "quantity":int(itemArr[1])
                    };
                    itemList.push(itemObj);
                };
            };
            return (itemList);
        }


        public function requestInventory():void
        {
            this.connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_GET_CARE_INVENTORY);
        }

        public function onResponded(messageType:String, responseData:Array):void
        {
            var itemList:Array;
            var id:int;
            var quantity:int;
            switch (messageType)
            {
                case MESSAGE_TYPE_GET_CARE_INVENTORY:
                    itemList = parseInventory(responseData);
                    if (itemList.length <= 0)
                    {
                        this.receivedCareInventory.dispatch();
                        return;
                    };
                    this.populateCareItemInventory(itemList);
                    this.receivedCareInventory.dispatch();
                    break;
                case MESSAGE_TYPE_ADD_PUFFLE_CARE_ITEM:
                    responseData.shift();
                    id = int(responseData[1]);
                    quantity = int(responseData[2]);
                    this.appModel.addPuffleCareItem(id, quantity, false);
                    this.updatePuffleHatInventory();
                    break;
                default:
                    return;
            };
        }

        private function populateCareItemInventory(itemList:Array):void
        {
            var item:Object;
            var id:int;
            var quantity:int;
            var existsInCollection:Boolean;
            var careItemVO:CareItemVO;
            var category:CareItemInventoryTypeEnum;
            var inventory:Bag;
            var careItemPossessed:CareItemVO;
            var isHat:Boolean;
            var masterCollection:Bag = ResourceManager(this.resourceManager).getPuffleCareItemCollection();
            for each (item in itemList)
            {
                try
                {
                    id = item.id;
                    quantity = item.quantity;
                    existsInCollection = ((masterCollection.getItem(id) != null) ? true : false);
                    if (!existsInCollection)
                    {
                        continue;
                    };
                    careItemVO = CareItemVO(masterCollection.getItem(id));
                    category = careItemVO.category;
                    inventory = this.appModel.myPlayerVO.getCareItemInventoryByCategory(category);
                    careItemVO.quantity = quantity;
                    if (inventory)
                    {
                        careItemPossessed = (inventory.getItem(id) as CareItemVO);
                        if (!careItemPossessed)
                        {
                            inventory.add(careItemVO);
                            isHat = ((careItemVO.category == CareItemInventoryTypeEnum.HEAD) ? true : false);
                            if (isHat)
                            {
                                careItemVO.totalHatQuantity = careItemVO.quantity;
                            };
                        }
                        else
                        {
                            careItemPossessed.quantity = quantity;
                        };
                    };
                }
                catch(error:Error)
                {
                };
            };
            this.updatePuffleHatInventory();
        }

        private function updatePuffleHatInventory():void
        {
            var puffle:PuffleVO;
            var puffleHatVO:CareItemVO;
            var id:int;
            var hatToAdjustVO:CareItemVO;
            var existingQuantity:int;
            var quantityCandidate:int;
            var updatedQuantity:int;
            var playerVO:PlayerVO = this.appModel.myPlayerVO;
            var playerPuffles:Bag = playerVO.puffles;
            var puffleArray:Array = playerPuffles.getAllItems();
            var puffleHeadInventory:Bag = playerVO.puffleHeadInventory;
            for each (puffle in puffleArray)
            {
                try
                {
                    puffleHatVO = puffle.hatVO;
                    id = puffleHatVO.id;
                    if (id != CareItemVO.getEmptyHatVO().id)
                    {
                        hatToAdjustVO = (puffleHeadInventory.getItem(id) as CareItemVO);
                        existingQuantity = hatToAdjustVO.quantity;
                        quantityCandidate = (existingQuantity - 1);
                        updatedQuantity = ((quantityCandidate > 0) ? quantityCandidate : 0);
                        hatToAdjustVO.quantity = updatedQuantity;
                    };
                }
                catch(error:Error)
                {
                };
            };
        }


    }
}//package com.clubpenguin.services.socket.puffles
