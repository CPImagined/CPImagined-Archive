//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.puffles
{
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;
    import com.clubpenguin.lib.services.socket.ConnectionConstants;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.lib.enums.puffle.PuffleSubTypeEnum;
    import com.clubpenguin.managers.resource.ResourceManager;
    import com.clubpenguin.lib.vo.puffle.StatsVO;

    public class PuffleDataParser 
    {

        private static const MILLISECONDS:int = 1000;


        public static function getPuffles(responseData:Array, puffleCollection:Bag, resourceManager:ResourceManager):void
        {
            var numPuffles:int;
            var i:int;
            var puffleData:Array;
            var puffleVO:PuffleVO;
            var adoptionDate:Number;
            var hatID:int;
            var masterInventoryCollection:Bag;
            var careItemVO:CareItemVO;
            if (responseData.length > 0)
            {
                responseData.shift();
                numPuffles = responseData.length;
                i = 0;
                while (i < numPuffles)
                {
                    puffleData = String(responseData[i]).split(ConnectionConstants.RESPONSE_DATA_DELIMITER);
                    if (puffleData.length > 1)
                    {
                        puffleVO = new PuffleVO();
                        adoptionDate = (Number(puffleData[4]) * MILLISECONDS);
                        puffleVO.statsVO.food = uint(puffleData[5]);
                        puffleVO.statsVO.play = uint(puffleData[6]);
                        puffleVO.statsVO.rest = uint(puffleData[7]);
                        puffleVO.statsVO.clean = uint(puffleData[8]);
                        hatID = int(puffleData[9]);
                        masterInventoryCollection = resourceManager.getPuffleCareItemCollection();
                        careItemVO = ((hatID == 0) ? (CareItemVO.getEmptyHatVO()) : ((masterInventoryCollection.getItem(hatID) as CareItemVO)));
                        puffleVO.hatVO = careItemVO;
                        puffleVO.id = int(puffleData[0]);
                        puffleVO.type = PuffleTypeEnum.getPuffleTypeEnumByID(int(puffleData[1]));
                        puffleVO.subType = PuffleSubTypeEnum.getPuffleSubTypeEnumByID(int(puffleData[2]));
                        puffleVO.name = puffleData[3];
                        puffleVO.adoptionDate = ((adoptionDate == 0) ? null : new Date(adoptionDate));
                        puffleCollection.add(puffleVO);
                    };
                    i++;
                };
            }
            else
            {
                throw (new Error("[PuffleDataParser] -> getPuffles(): ERROR!!! responseData is NULL!"));
            };
        }

        public static function getMyPufflesStats(responseData:Array, puffleCollection:Bag):void
        {
            var puffleDetails:Array;
            var i:uint;
            var puffleData:Array;
            var puffleVO:PuffleVO;
            var statsVO:StatsVO;
            if (responseData.length > 0)
            {
                puffleDetails = String(responseData[1]).split(",");
                i = 0;
                while (i < puffleDetails.length)
                {
                    puffleData = String(puffleDetails[i]).split(ConnectionConstants.RESPONSE_DATA_DELIMITER);
                    puffleVO = (puffleCollection.getItem(int(puffleData[0])) as PuffleVO);
                    if (puffleVO)
                    {
                        statsVO = new StatsVO();
                        statsVO.food = uint(puffleData[1]);
                        statsVO.play = uint(puffleData[2]);
                        statsVO.rest = uint(puffleData[3]);
                        statsVO.clean = uint(puffleData[4]);
                        puffleVO.statsVO.update(statsVO);
                    };
                    i++;
                };
            }
            else
            {
                throw (new Error("[PuffleDataParser] -> getMyPufflesStats(): ERROR!!! responseData is NULL!"));
            };
        }

        public static function puffleCareItemDelivered(responseData:Array, puffleCollection:Bag):void
        {
            var i:int;
            var puffleData:Array;
            var puffleVO:PuffleVO;
            var statsVO:StatsVO;
            var fullStats:Boolean;
            if (responseData.length > 0)
            {
                i = 0;
                puffleData = String(responseData[2]).split(ConnectionConstants.RESPONSE_DATA_DELIMITER);
                puffleVO = (puffleCollection.getItem(int(puffleData[i++])) as PuffleVO);
                if (puffleVO)
                {
                    statsVO = new StatsVO();
                    statsVO.food = uint(puffleData[i++]);
                    statsVO.play = uint(puffleData[i++]);
                    statsVO.rest = uint(puffleData[i++]);
                    statsVO.clean = uint(puffleData[i++]);
                    fullStats = ((uint(puffleData[i++]) == 1) ? true : false);
                    puffleVO.statsVO.setCelebrateFullStats(fullStats);
                    puffleVO.statsVO.update(statsVO);
                };
            }
            else
            {
                throw (new Error("[PuffleDataParser] -> puffleCareItemDelivered(): ERROR!!! responseData is NULL!"));
            };
        }

        public static function getPufflesStats(responseData:Array, puffleCollection:Bag):void
        {
            var puffleData:Array;
            var puffleVO:PuffleVO;
            var statsVO:StatsVO;
            if (responseData.length > 0)
            {
                puffleData = String(responseData[1]).split(ConnectionConstants.RESPONSE_DATA_DELIMITER);
                puffleVO = (puffleCollection.getItem(int(puffleData[0])) as PuffleVO);
                if (puffleVO)
                {
                    statsVO = new StatsVO();
                    statsVO.food = uint(puffleData[1]);
                    statsVO.play = uint(puffleData[2]);
                    statsVO.rest = uint(puffleData[3]);
                    statsVO.clean = uint(puffleData[4]);
                    puffleVO.statsVO.update(statsVO);
                };
            }
            else
            {
                throw (new Error("[PuffleDataParser] -> getPufflesStats(): ERROR!!! responseData is NULL!"));
            };
        }


    }
}//package com.clubpenguin.services.socket.puffles
