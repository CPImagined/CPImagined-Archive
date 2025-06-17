//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.service
{
    import com.clubpenguin.lib.services.http.LoadSWFService;
    import com.clubpenguin.lib.enums.resource.CacheTypeEnum;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;

    public class LoadAS2ClubPenguinService extends LoadSWFService 
    {

        public static const AS2_CLUB_PENGUIN_LIVE_URL:String = "load.swf";

        public function LoadAS2ClubPenguinService(environment:EnvironmentDataVO)
        {
            useCacheBusting = false;
            var cacheParam:CacheTypeEnum = CacheTypeEnum.getCacheTypeByType("client");
            url = ((cacheParam.cacheValue != "") ? ((((environment.clientPath + AS2_CLUB_PENGUIN_LIVE_URL) + CacheTypeEnum.getCacheAsStringByType("client")) + "&connectionID=") + environment.connectionID) : ((((environment.clientPath + AS2_CLUB_PENGUIN_LIVE_URL) + "?connectionID=") + environment.connectionID)));
        }

    }
}//package com.clubpenguin.world.service
