//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import org.osflash.signals.Signal;
    import com.clubpenguin.managers.resource.ResourceManager;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.main.service.webservice.WebServiceManagerProxy;
    import flash.net.URLLoader;
    import com.clubpenguin.main.service.webservice.WebServiceType;
    import com.clubpenguin.main.vo.WebServiceDataVO;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;
    import com.clubpenguin.lib.enums.puffle.CareItemInventoryTypeEnum;
    import com.clubpenguin.lib.enums.puffle.ConsumptionTypeEnum;
    import com.clubpenguin.lib.enums.puffle.PlayExternalEnum;
    import com.clubpenguin.lib.vo.puffle.StatsVO;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.lib.enums.puffle.CareItemReactionTypeEnum;

    public class LoadPuffleCareItemsCommand extends SignalCommand 
    {

        [Inject]
        public var _onLoaded:Signal;
        [Inject]
        public var resourceManager:ResourceManager;
        [Inject]
        public var environmentDataVO:EnvironmentDataVO;
        [Inject]
        public var webServiceManager:WebServiceManagerProxy;
        private var loader:URLLoader = new URLLoader();


        override public function execute():void
        {
            var wsdVO:WebServiceDataVO = this.webServiceManager.getDataByName(WebServiceType.PUFFLE_ITEMS.name);
            var puffleItemsCollection:Bag = this.getMasterPuffleItemsCollection(wsdVO.data);
            this.resourceManager.setPuffleCareItemCollection(puffleItemsCollection);
            this._onLoaded.dispatch();
        }

        private function getMasterPuffleItemsCollection(puffleItems:Object):Bag
        {
            var careItemInventory:Object;
            var categoryType:String;
            var myCareItemVO:CareItemVO;
            var reactions:Array;
            var categoryTypeEnum:CareItemInventoryTypeEnum;
            var consumptionTypeEnum:ConsumptionTypeEnum;
            var playExternalEnum:PlayExternalEnum;
            var statsVO:StatsVO;
            var puffleTypeToReactionType:Dictionary;
            var puffleItemsCollection:Bag = new Bag(CareItemVO);
            for each (careItemInventory in puffleItems)
            {
                categoryType = careItemInventory.type;
                try
                {
                    categoryTypeEnum = CareItemInventoryTypeEnum.getEnumByInstanceName(categoryType);
                }
                catch(error:Error)
                {
                };
                if (categoryTypeEnum === CareItemInventoryTypeEnum.GAME)
                {
                }
                else
                {
                    myCareItemVO = new CareItemVO();
                    myCareItemVO.category = categoryTypeEnum;
                    myCareItemVO.id = int(careItemInventory.puffle_item_id);
                    myCareItemVO.name = careItemInventory.name;
                    myCareItemVO.label = careItemInventory.label;
                    myCareItemVO.prompt = careItemInventory.prompt;
                    myCareItemVO.class_name = careItemInventory.class_name;
                    myCareItemVO.assetPath = careItemInventory.asset;
                    myCareItemVO.quantity = int(careItemInventory.quantity);
                    myCareItemVO.quantityPerCost = int(careItemInventory.quantity);
                    myCareItemVO.cost = uint(careItemInventory.cost);
                    myCareItemVO.rootItemID = int(careItemInventory.root_item_id);
                    if (careItemInventory.is_member_only != undefined)
                    {
                        myCareItemVO.isMemberOnly = (int(careItemInventory.is_member_only) == 1);
                    };
                    try
                    {
                        consumptionTypeEnum = this.getConsumptionTypeEnum(careItemInventory.consumption);
                    }
                    catch(error:Error)
                    {
                    };
                    myCareItemVO.consumption = consumptionTypeEnum;
                    try
                    {
                        playExternalEnum = this.getPlayExternalEnum(careItemInventory.play_external);
                    }
                    catch(error:Error)
                    {
                    };
                    myCareItemVO.play_external = playExternalEnum;
                    if (careItemInventory.effect)
                    {
                        statsVO = this.getCareItemEffects(careItemInventory.effect);
                        myCareItemVO.effect = statsVO;
                    };
                    reactions = careItemInventory.reaction;
                    if (reactions)
                    {
                        puffleTypeToReactionType = this.getPuffleCareItemReactions(reactions);
                        myCareItemVO.puffleTypeToReactionType = puffleTypeToReactionType;
                    };
                    puffleItemsCollection.add(myCareItemVO);
                };
            };
            return (puffleItemsCollection);
        }

        private function getConsumptionTypeEnum(consumptionType:String):ConsumptionTypeEnum
        {
            var consumptionEnum:ConsumptionTypeEnum;
            switch (consumptionType)
            {
                case CareItemVO.EAT:
                    consumptionEnum = ConsumptionTypeEnum.EAT;
                    break;
                case CareItemVO.BATHE:
                    consumptionEnum = ConsumptionTypeEnum.BATHE;
                    break;
                case CareItemVO.BRUSH:
                    consumptionEnum = ConsumptionTypeEnum.BRUSH;
                    break;
                case CareItemVO.WEAR:
                    consumptionEnum = ConsumptionTypeEnum.WEAR;
                    break;
                case CareItemVO.NONE:
                default:
                    consumptionEnum = ConsumptionTypeEnum.NONE;
            };
            return (consumptionEnum);
        }

        private function getPlayExternalEnum(playExternalType:String):PlayExternalEnum
        {
            var playExternalTypeEnum:PlayExternalEnum;
            switch (playExternalType)
            {
                case CareItemVO.SLEEP:
                    playExternalTypeEnum = PlayExternalEnum.SLEEP;
                    break;
                case CareItemVO.LEASH:
                    playExternalTypeEnum = PlayExternalEnum.LEASH;
                    break;
                case CareItemVO.BUBBLEGUM:
                    playExternalTypeEnum = PlayExternalEnum.BUBBLEGUM;
                    break;
                case CareItemVO.PLAY:
                    playExternalTypeEnum = PlayExternalEnum.PLAY;
                    break;
                case CareItemVO.SUPERPLAY:
                    playExternalTypeEnum = PlayExternalEnum.SUPERPLAY;
                    break;
                case CareItemVO.NONE:
                default:
                    playExternalTypeEnum = PlayExternalEnum.NONE;
            };
            return (playExternalTypeEnum);
        }

        private function getPuffleCareItemReactions(reactions:Array):Dictionary
        {
            var puffleEnumType:PuffleTypeEnum;
            var reactionID:int;
            var careItemReactionTypeEnum:CareItemReactionTypeEnum;
            var puffleTypeToReactionType:Dictionary = new Dictionary();
            var arrLength:int = reactions.length;
            var i:int;
            while (i < arrLength)
            {
                puffleEnumType = PuffleTypeEnum.getPuffleTypeEnumByID(i);
                reactionID = int(reactions[i]);
                careItemReactionTypeEnum = this.getCareItemReactionTypeEnum(reactionID);
                puffleTypeToReactionType[puffleEnumType] = careItemReactionTypeEnum;
                i++;
            };
            return (puffleTypeToReactionType);
        }

        private function getCareItemReactionTypeEnum(reactionID:int):CareItemReactionTypeEnum
        {
            var careItemReactionTypeEnum:CareItemReactionTypeEnum;
            switch (reactionID)
            {
                case CareItemVO.DISLIKES:
                    careItemReactionTypeEnum = CareItemReactionTypeEnum.DISLIKES;
                    break;
                case CareItemVO.LIKES:
                    careItemReactionTypeEnum = CareItemReactionTypeEnum.LIKES;
                    break;
                case CareItemVO.FAVOURITE:
                    careItemReactionTypeEnum = CareItemReactionTypeEnum.FAVOURITE;
                    break;
                case CareItemVO.NEUTRAL:
                default:
                    careItemReactionTypeEnum = CareItemReactionTypeEnum.NEUTRAL;
            };
            return (careItemReactionTypeEnum);
        }

        private function getCareItemEffects(effect:Object):StatsVO
        {
            var puffleStats:StatsVO = new StatsVO();
            puffleStats.food = int(effect.food);
            puffleStats.play = int(effect.play);
            puffleStats.rest = int(effect.rest);
            puffleStats.clean = int(effect.clean);
            return (puffleStats);
        }


    }
}//package com.clubpenguin.main.command
