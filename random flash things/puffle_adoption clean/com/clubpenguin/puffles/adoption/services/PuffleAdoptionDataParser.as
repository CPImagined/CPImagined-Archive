//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.services
{
    public class PuffleAdoptionDataParser 
    {


        public static function getAdoptionStatus(responseData:Array):Boolean
        {
            if (responseData.length > 0)
            {
                responseData.shift();
                return (Boolean(int(responseData[0])));
            };
            throw (new Error("[PuffleAdoptionDataParser] -> getAdoptionStatus(): ERROR!!! responseData is NULL!"));
        }

        public static function getAdoptedPuffleID(responseData:Array):int
        {
            var puffleResponse:String;
            var splicedResponse:Array;
            if (responseData.length > 0)
            {
                puffleResponse = responseData[2];
                splicedResponse = puffleResponse.split("|");
                return (int(splicedResponse[0]));
            };
            throw (new Error("[PuffleAdoptionDataParser] -> getAdoptedPuffleID(): ERROR!!! responseData is NULL!"));
        }


    }
}//package com.clubpenguin.puffles.adoption.services
